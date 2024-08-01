#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <inttypes.h>

#include "../include/parameters.h"
#include "../include/input1.h"


fmap_dtype ReceptiveFieldConvolution(uint16_t fmap_in_cols, fmap_dtype *receptive_field, const int8_t *kernel, uint8_t kernel_order, uint8_t mult_shift) {

    fmap_dtype acc;
    int8_t weight;
    uint8_t kernel_lin, kernel_col;
    uint16_t next_line; // Offset to the beginning of the next feature map line
    
    next_line = fmap_in_cols - kernel_order;
    acc = 0;
    
    for (kernel_lin = 0; kernel_lin < kernel_order; kernel_lin++, receptive_field += next_line)       
        for (kernel_col = 0; kernel_col < kernel_order; kernel_col++, kernel++, receptive_field++) {

            //if (*receptive_field == 0)
            //    continue;
            
            weight = *kernel;
            
            //if (weight > 0)
                acc += (*receptive_field * weight) >> mult_shift;
            
            //else if (weight < 0)
            //    acc -= (*receptive_field * -weight) >> mult_shift;
        }
    
    return acc;
}


/*** Convolve the input 
*       Input and output feature maps are in different memory areas
*           - Input feature map: in
*           - Output feature map: shared_fmap 
***/
void FirstConvolutionLayer(input_dtype *in, fmap_dtype *shared_fmap, struct Parameters *layer, uint8_t mult_shift) {
    
    fmap_dtype *fmap_wr;
    input_dtype *fmap_rd, *fmap_in_line_start, *receptive_field;
    uint16_t fmap_out_lin, fmap_out_col, f;
    const int8_t *current_kernel, *kernel;
    fmap_dtype acc;
    int8_t weight;
    uint8_t kernel_lin, kernel_col;// Used to scan the kernel
    uint16_t next_line_on_receptive_field; // Offset to the beginning of the next receptive field line
    int16_t rf_col, rf_lin;         // Used to scan the receptive field
    int16_t fmap_in_l0, fmap_in_c0; // Receptive field top-left coordinate

    
    // Convolution
    // Convolve the input channel by channel, from left to right, 
    // starting at top left up to botton right.
    // Input has no padding. When the first convolution layer has padding, it its emulated.
    fmap_wr = shared_fmap;
    for (f = 0, current_kernel = layer->filters; f < layer->fmap_out_channels; f++, current_kernel += layer->kernel_size) {
        fmap_in_line_start = in;    // Point the begining of the first input line
        for (fmap_out_lin = 0, fmap_in_l0 = -layer->pad; fmap_out_lin < layer->fmap_out_lines; fmap_out_lin++, fmap_in_l0 += layer->stride) {
            fmap_rd = fmap_in_line_start;   // Point the begining of the current processing line
            for (fmap_out_col = 0, fmap_in_c0 = -layer->pad; fmap_out_col < layer->fmap_out_cols; fmap_out_col++, fmap_in_c0 += layer->stride) { 
                
                receptive_field = fmap_rd;  // Point the begining of the current processing receptive field (top-left corner)
                kernel = current_kernel;               
                next_line_on_receptive_field = layer->fmap_in_cols - layer->kernel_order;
                acc = 0;    
                // Receptive field convolution
                for (kernel_lin = 0, rf_lin = fmap_in_l0; kernel_lin < layer->kernel_order; kernel_lin++, rf_lin++) {       
                    for (kernel_col = 0, rf_col = fmap_in_c0; kernel_col < layer->kernel_order; kernel_col++, rf_col++) {

                        // Multiply and accumulate only when out of padding area        
                        if (rf_lin >= 0 && rf_lin < layer->fmap_in_lines &&
                            rf_col >= 0 && rf_col < layer->fmap_in_cols) { // Out of padding area ?
                                                    
                            weight = *kernel;
                                        
                            //if (weight > 0)
                                acc += (*receptive_field * weight) >> mult_shift;
                            
                            //else if (weight < 0)
                            //    acc -= (*receptive_field * -weight) >> mult_shift;
                        
                            receptive_field++;   
                        }

                        kernel++;
                    }
                    
                    // receptive_field points the next line only when out of padding area
                    if (rf_lin >= 0 && rf_lin < layer->fmap_in_lines) { // Line out of padding area ?
                        if (fmap_in_c0 < 0 || rf_col > layer->fmap_in_cols)
                            receptive_field += next_line_on_receptive_field + layer->pad;
                        else
                            receptive_field += next_line_on_receptive_field;
                    }
                }
                
                acc += layer->bias[f];
                
                // Write the receptive_field convolution result to the output feature map
                *fmap_wr = (layer->apply_relu) ? RELU(acc) : acc;
                fmap_wr++;
                                    
                if (fmap_in_c0 >= 0)    // Padding support
                    fmap_rd += layer->stride;
            }
            
            if (fmap_in_l0 >= 0)    // Padding support
                fmap_in_line_start += layer->next_fmap_in_line;
        }
    }
}

/*** 
*   Defragmente the shared_fmap memory area after a convolution 
*   when the output feature map is smaller than the input feature map
***/
void Defragmentation(fmap_dtype *shared_fmap, uint32_t fmap_in_channel_size, uint32_t fmap_out_channel_size, uint16_t fmap_out_channels) {
    
    fmap_dtype *fmap_rd, *fmap_wr;
    uint16_t fmap_out_ch;
    uint32_t next_channel;  // Offset to the beginning of the next output feature map channel
    uint32_t i;
    
    next_channel = fmap_in_channel_size - fmap_out_channel_size;
    
    fmap_wr = shared_fmap + fmap_out_channel_size;
    for (fmap_out_ch = 0, fmap_rd = shared_fmap + fmap_in_channel_size; fmap_out_ch < fmap_out_channels - 1; fmap_out_ch++, fmap_rd += next_channel)
        for(i = 0; i < fmap_out_channel_size; i++)
            *fmap_wr++ = *fmap_rd++;
     
}

/*** Insert padding in all input feature map channels ***/
void InsertPadding(fmap_dtype *shared_fmap, struct Parameters *layer) {
    
    fmap_dtype *fmap_wr, *fmap_rd;
    uint32_t write_offset, read_offset;
    uint16_t fmap_in_ch, fmap_in_lin, fmap_in_col, i;
    
    write_offset = (layer->fmap_in_lines + 2 * layer->pad) * (layer->fmap_in_cols + 2 * layer->pad) * (layer->fmap_in_channels);
        
    fmap_wr = shared_fmap + write_offset - 1;
    
    read_offset = (layer->fmap_in_lines) * (layer->fmap_in_cols) * (layer->fmap_in_channels);
    
    fmap_rd = shared_fmap + read_offset - 1;
    
    // Insert 0 padding
    for(fmap_in_ch = 0; fmap_in_ch < layer->fmap_in_channels; fmap_in_ch++) {
        
        // Last line padding 
        for (i = 0; i < (layer->fmap_in_cols + 2 * layer->pad); i++, fmap_wr--)
            *fmap_wr = 0;
        
        for (fmap_in_lin = 0; fmap_in_lin < layer->fmap_in_lines; fmap_in_lin++) {
            
            // Last column padding
            *fmap_wr = 0;
            fmap_wr--;
            
            for (fmap_in_col = 0; fmap_in_col < layer->fmap_in_cols; fmap_in_col++, fmap_rd--, fmap_wr--){
                *fmap_wr = *fmap_rd;
            }
            
            // First column padding
            *fmap_wr = 0;
            fmap_wr--;
        }
        
        // First line padding 
        for (i = 0; i < (layer->fmap_in_cols + 2 * layer->pad); i++, fmap_wr--)
            *fmap_wr = 0;        
    }
    
    // Update input fmap dimensions considering the padding
    layer->fmap_in_lines = layer->fmap_in_lines + 2 * layer->pad;
    layer->fmap_in_cols = layer->fmap_in_cols + 2 * layer->pad;
    layer->fmap_in_channel_size = layer->fmap_in_lines * layer->fmap_in_cols;
    layer->next_fmap_in_line = layer->fmap_in_cols * layer->stride;
}

/*** In depth feature map convolution 
*       Input and output feature maps share the same memory area (shared_fmap)
***/
void LayerConvolution(fmap_dtype *shared_fmap, struct Parameters *layer, uint8_t mult_shift) {
    
    uint16_t fmap_out_line, fmap_out_col, fmap_in_col, f, k;
    fmap_dtype acc[MAX_FILTERS];
    fmap_dtype *receptive_field, *fmap_wr;
    uint32_t fmap_in_line_offset, fmap_out_line_offset; // Offset to the begin of a feature map line
    const int8_t *kernel;
    
    if (layer->pad > 0)
        InsertPadding(shared_fmap, layer);
          
    // Layer convolutions
    for (fmap_out_line = 0, fmap_out_line_offset = 0, fmap_in_line_offset = 0; fmap_out_line < layer->fmap_out_lines; fmap_out_line++, fmap_out_line_offset+=layer->fmap_out_cols, fmap_in_line_offset+=layer->next_fmap_in_line)        
        for (fmap_out_col = 0, fmap_in_col = 0; fmap_out_col < layer->fmap_out_cols; fmap_out_col++, fmap_in_col+=layer->stride) {
            kernel = layer->filters;
            for (f = 0; f < layer->fmap_out_channels; f++) { 
                acc[f] = layer->bias[f];   // Initialize accumulator
                              
                // In depth convolutions
                for (k = 0, receptive_field = shared_fmap + fmap_in_line_offset + fmap_in_col; k < layer->fmap_in_channels; k++, receptive_field += layer->fmap_in_channel_size){ 
                    acc[f] += ReceptiveFieldConvolution(layer->fmap_in_cols, receptive_field, kernel, layer->kernel_order, mult_shift);                              
                    kernel += layer->kernel_size;
                }
            }
            
            // Update in depth output feature map
            for (f = 0, fmap_wr = shared_fmap + fmap_out_line_offset + fmap_out_col; f < layer->fmap_out_channels; f++, fmap_wr += layer->fmap_in_channel_size)            
                *fmap_wr = (layer->apply_relu) ?  RELU(acc[f]) : acc[f];             
        }  
     
    // Defragmentation when output feature map is smaller than the input
    if (layer->fmap_out_channel_size < layer->fmap_in_channel_size)
        Defragmentation(shared_fmap, layer->fmap_in_channel_size, layer->fmap_out_channel_size, layer->fmap_out_channels);
}

void MaxPool2x2ReLU(fmap_dtype *shared_fmap, struct Parameters *layer) {
    
    fmap_dtype *fmap_rd, *fmap_wr;
    uint16_t fmap_out_lin, fmap_out_col, fmap_in_ch;
    fmap_dtype a, b;
    uint8_t fmap_in_odd_lines = layer->fmap_in_lines & 1;
    uint32_t next_line; // Offset to the beginning of the next input feature map line
    
    next_line = layer->fmap_in_lines + fmap_in_odd_lines;
    
    fmap_rd = fmap_wr = shared_fmap;
    for (fmap_in_ch = 0; fmap_in_ch < layer->fmap_in_channels; fmap_in_ch++) {
        for (fmap_out_lin = 0; fmap_out_lin < layer->fmap_out_lines; fmap_out_lin++) {
            for (fmap_out_col = 0; fmap_out_col < layer->fmap_out_cols; fmap_out_col++) {
                // a: greater in the fist line of the maxpool receptive field (2x2) 
                a = ((*fmap_rd) > *(fmap_rd + 1)) ? (*fmap_rd) : *(fmap_rd + 1);
                // b: greater in the second line of the maxpool receptive field (2x2)
                b = (*(fmap_rd + layer->fmap_in_lines) > *(fmap_rd + layer->fmap_in_lines + 1)) ? *(fmap_rd + layer->fmap_in_lines) : *(fmap_rd + layer->fmap_in_lines + 1);
                *fmap_wr = (a > b) ? RELU(a) : RELU(b);
                fmap_wr++;
                fmap_rd += 2;   // 2x2 stride on maxpool               
            }
            fmap_rd += next_line;
        }
        
        if (fmap_in_odd_lines) // Odd number of channel lines ?
            fmap_rd += layer->fmap_in_lines;
    }
}

/*** Compute a full connected layer ***/
void FullConnected(fmap_dtype *shared_fmap, struct Parameters *layer, uint8_t mult_shift) {
    
    fmap_dtype neurons[MAX_NEURONS];
    uint16_t fmap_in_lin, fmap_in_col, fmap_in_ch, n;
    int8_t weight;
    fmap_dtype *fmap_rd, *fmap_wr;
    
    for(n = 0; n < layer->neurons; n++) {
        neurons[n] = layer->bias[n];
        fmap_rd = shared_fmap;
        for (fmap_in_ch = 0; fmap_in_ch < layer->fmap_in_channels; fmap_in_ch++) 
            for (fmap_in_lin = 0; fmap_in_lin < layer->fmap_in_lines; fmap_in_lin++) 
                for (fmap_in_col = 0; fmap_in_col < layer->fmap_in_cols; fmap_in_col++, layer->filters++, fmap_rd++) {
                                        
                    //if (feature == 0) 
                    //    continue;
                    
                    weight = *layer->filters;
                    
                    //if (weight > 0) 
                        neurons[n] += (*fmap_rd * weight) >> mult_shift;
                    
                    //else if (weight < 0) 
                    //    neurons[n] -= (*fmap_rd << -weight) >> mult_shift;                   
                }   
    }  

    // Update the shared_fmap with the computed neurons
    fmap_wr = shared_fmap;
    for(n = 0; n < layer->neurons; n++) {
        *fmap_wr = neurons[n];
        fmap_wr++;
    }
}






int main(){
    
    fmap_dtype shared_fmap[SHARED_FMAP_SIZE];  
    fmap_dtype *fmap_rd;    
    uint16_t  i;
    struct Parameters *layer_params;
    
    layer_params = GetLayersParameters();
    
    FirstConvolutionLayer(input[0][0], shared_fmap, &layer_params[0], WEIGHT_SHIFT);
    
    /*** Remainig layers ***/
    for (i = 1; i < LAYERS; i++) {
        if (layer_params[i].type == CONV) 
            LayerConvolution(shared_fmap, &layer_params[i], WEIGHT_SHIFT);
        
        else if (layer_params[i].type == MAX_POOL) 
            MaxPool2x2ReLU(shared_fmap, &layer_params[i]);        

        else
            FullConnected(shared_fmap,&layer_params[i], WEIGHT_SHIFT);
     }  
    
    
    char strBuf[256];
    
    
    for (i = 0, fmap_rd = shared_fmap; i < FC_OUT_SIZE; i++, fmap_rd++)
    {
        muSprintf(strBuf, "cnn_out[%d] = %d\n", i, *fmap_rd); 
        
        UARTPrint(strBuf);
    }

    return 0;
}
