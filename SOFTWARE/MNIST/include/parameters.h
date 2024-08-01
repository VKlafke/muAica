#ifndef PARAMETERS_H
#define PARAMETERS_H

#include <inttypes.h>

#define INPUT_CHANNELS	1
#define INPUT_LINES	28
#define INPUT_COLS	28

#define LAYERS	5

#define MAX_FILTERS	4

#define MAX_NEURONS	10

#define FC_OUT_SIZE	10

#define WEIGHT_SHIFT	6

#define SHARED_FMAP_SIZE	2704


#define RELU(x)	((x < 0) ? 0 : x)
#define APPLY_RELU	1
#define NO_RELU	0

#define CONV            1
#define MAX_POOL        2
#define FULL_CONNECTED  3

typedef int16_t fmap_dtype;

const int8_t filters_conv0[4][1][3][3] = {
	{
		{{1, -5, 6}, {5, 6, 6}, {-6, -6, -6}}
	},
	{
		{{-7, -5, -4}, {-1, 4, 5}, {7, 3, 3}}
	},
	{
		{{5, 4, -5}, {2, 6, -4}, {0, 5, 5}}
	},
	{
		{{0, -5, 4}, {-6, -5, 7}, {-5, 4, 6}}
	}
};
const int16_t bias_conv0[4] = {-31, -29, -8, -64};

const int8_t filters_conv1[4][4][3][3] = {
	{
		{{2, 3, 3}, {4, 5, 4}, {3, 5, 5}},
		{{-2, 2, 4}, {-5, 2, 3}, {-5, 3, 4}},
		{{-4, 5, 5}, {4, 5, 5}, {-1, -3, -5}},
		{{1, 0, 2}, {-3, -3, -5}, {-5, -6, -6}}
	},
	{
		{{-3, -4, 3}, {-2, -3, -5}, {4, 3, -5}},
		{{5, 5, -4}, {4, -5, -1}, {5, -5, -3}},
		{{-5, -6, -6}, {5, 5, -5}, {3, 6, 6}},
		{{-6, -6, -4}, {-5, -5, -7}, {5, 5, -4}}
	},
	{
		{{3, -4, 3}, {0, -5, 3}, {2, -3, -4}},
		{{4, -6, -4}, {-6, -4, -5}, {4, -3, -5}},
		{{5, 5, -5}, {-4, 3, 7}, {-7, -5, 7}},
		{{4, 4, 5}, {3, -5, -5}, {-5, 3, -4}}
	},
	{
		{{-5, 0, -4}, {-3, -6, -5}, {-1, -6, -6}},
		{{-4, -4, -6}, {-4, -5, -5}, {-5, -7, -3}},
		{{6, 4, -5}, {6, 4, 0}, {5, -5, -3}},
		{{3, -6, -5}, {3, -5, -3}, {-3, 1, 6}}
	}
};
const int16_t bias_conv1[4] = {6, -7, -97, 2};

const int8_t weights_fc0[10][100] = {
	{-3, -5, -2, -4, 3, -5, -2, 0, 3, -3, -5, -5, -4, -4, -4, 4, -4, -5, 0, 5, 4, 4, 5, 5, -3, -2, -4, -2, 3, 4, 4, 0, 5, 5, 4, -6, -4, -5, 2, -3, -6, -4, 5, 5, -6, -5, 4, 4, -4, -6, -3, -4, -3, -2, 3, -4, -3, 0, 4, 5, 3, 2, -2, 3, 4, 4, 5, -3, -4, 3, 5, 5, 0, -6, -5, 2, -4, -2, -5, -5, -3, 4, -4, 0, 1, 0, -1, 5, -3, -2, 0, 0, 5, -3, 4, -3, -2, -4, -6, -4},
	{3, -4, 2, -4, -3, 0, -4, 0, 4, 2, -3, -4, -4, 3, 2, -2, -4, 2, 3, 0, 3, -2, 4, 3, 5, 5, 3, -3, -5, -2, 4, 3, -3, 0, -5, 0, -5, 5, 3, -5, 3, 5, -5, -5, 1, 5, 5, 3, 5, 5, 4, 4, 4, 4, 0, 2, -2, -2, -3, -3, -5, -6, -3, 3, -3, -5, -6, 5, 4, 0, -5, -3, 1, 4, 2, -4, 3, 5, 5, 0, -3, -4, 5, 4, 3, -4, 4, 2, 6, 4, -3, 4, 6, 4, -5, 4, 4, 5, -1, -4},
	{3, 5, -2, 4, -4, 3, 4, 5, -5, -6, 3, 2, -4, -4, 4, -3, -3, 0, -3, 6, 4, 4, 3, 5, 5, -3, -2, 3, 4, 4, 4, 4, 5, 4, -4, 6, 5, 5, 0, -5, 3, -4, 0, 4, -2, -5, -3, -4, 5, 4, -5, -4, 4, 4, 2, -4, -3, 3, 5, 3, -6, -6, -5, -4, -4, -3, 4, -4, -4, 0, 4, 4, 1, 4, 5, 2, -2, 0, -4, -2, -4, -5, 4, 4, 3, -4, -3, -4, -1, -3, 5, 4, 3, 4, -2, 4, 4, -4, -6, -5},
	{2, 4, 4, 4, -5, 5, 3, 3, -3, -3, -4, 0, 5, 5, -2, -5, 0, 5, -3, -5, -5, 3, 4, -5, -3, 1, 5, 5, 4, 4, 3, 4, -3, 1, 2, 6, 4, -4, 4, 4, 6, 5, 3, 5, 5, 6, 5, 0, 5, -2, 4, 2, 0, 0, 4, -5, -6, -4, -1, -5, -5, -3, 3, 0, -2, -2, -3, 4, 3, 0, 3, -3, -5, -4, -3, 0, -5, -6, 2, 0, -4, -5, 2, 2, 5, -4, 5, -4, -4, 3, -5, -4, -5, 0, 2, -4, 1, -6, 3, 5},
	{-2, -5, -6, -5, -2, -4, -5, -6, -5, 4, 4, 5, 5, -3, 4, 5, 5, 1, 5, 5, 2, -4, -5, 0, 4, 0, 4, 4, -3, -5, 4, 0, -4, -5, -5, -5, -4, 2, -5, -3, -4, -3, 4, -6, 0, -3, -4, -4, -3, 5, -2, 5, 5, 4, 4, 3, 5, -2, 0, 4, 4, 5, 3, 4, 5, 2, 3, -3, -3, -4, -4, -4, -3, 5, 5, -3, 4, 5, 6, 1, -2, 5, 4, 4, 3, 5, 0, -3, -4, 3, 0, 3, -5, -3, 4, -4, -3, 4, 5, 0},
	{-4, -3, 5, 5, 0, -5, -2, 4, 6, 6, 4, 4, 4, -3, 0, 0, 4, 0, -5, -6, -4, 3, 4, -5, -5, 2, 0, -5, -5, -6, -5, -3, -4, 3, -3, 6, 0, 4, 5, 6, 6, 4, 3, 5, 5, 5, 5, 4, 4, -3, 4, 4, 0, -3, -5, 5, 4, 3, 2, -6, 4, 4, 3, 1, -3, -2, 2, 2, 3, 3, 0, 0, -5, -5, -4, 3, 3, 3, -4, 5, 2, 4, 2, -5, -5, 4, -4, 3, 4, -3, -3, -5, -2, 0, -5, 2, 2, 3, 4, 4},
	{2, 2, -4, 4, 5, -3, -4, -3, 3, 4, -5, -6, 0, -4, -2, 3, -5, 4, 4, -3, 0, 4, 4, 5, -3, -4, -5, -5, -5, -4, -4, -5, -4, 2, 5, -5, -4, 4, 6, 5, -5, -4, 3, 5, -3, -3, -4, 3, -2, -4, 5, 0, 4, 0, -4, 3, 0, -5, -5, 0, 4, 3, -4, -4, -4, 5, 5, 3, -2, 3, 4, 5, 4, -4, -5, 4, 4, 6, 3, 4, 5, 5, 5, -4, -4, -2, 5, 3, -2, -5, -4, 2, 4, -4, 0, -4, -4, -5, -2, -3},
	{4, 5, 5, -4, -4, 4, 5, 4, -2, 4, -4, 5, -4, 4, -3, -5, 3, -4, 5, 4, -5, -5, -5, -3, 0, 5, 4, 4, -2, 3, 6, 6, 3, 1, 4, 4, 5, -4, -5, -3, 4, 5, 0, -5, 3, 2, -6, -5, -5, -4, 5, 5, -2, -5, 3, -3, -4, 0, -2, -4, -3, -5, -3, 4, 5, -4, -5, -5, -3, -5, -5, -5, 4, 5, -3, -3, -3, -5, 0, 4, -4, -5, -6, 3, 4, -4, 2, 6, -3, 2, -2, 5, 4, -3, 2, 3, 5, 5, 5, 2},
	{0, 3, 4, -3, 5, 5, 0, 1, 0, -4, 5, 3, -4, 4, 4, 5, -4, -3, -3, -5, 5, 3, 4, -5, -4, -4, 0, 1, 5, 4, -4, -3, 3, -4, 2, 3, 2, 0, -4, 0, -5, -6, -4, 4, 5, -5, -5, 0, 4, 3, -4, -5, -3, 0, 4, 4, 5, 5, 0, 4, 5, 5, 5, -3, -5, -3, 4, 4, 4, 4, 5, 5, 2, -4, -4, 4, 3, -4, -2, -3, 5, -3, -5, -4, -4, -3, -5, -6, -5, -3, 5, 0, -4, -2, -5, 0, -5, -3, 3, 5},
	{-4, 2, 3, 4, 4, -2, 4, 0, 4, -2, 5, 5, 4, 4, -2, 0, 5, -3, -5, -3, -4, -1, -5, -5, 0, -4, -4, 3, 5, 4, -5, -5, -3, 0, 3, -6, 0, -5, 0, -3, -2, 4, -4, -5, -4, 0, 5, 4, -6, 2, -5, -6, -6, -5, -5, 0, 5, 4, 0, 4, 5, 6, 4, -2, -3, 5, 3, -5, 2, 2, -5, -5, 1, 5, 6, -4, -3, -5, -5, -4, 4, 4, -5, -3, 0, 3, -4, -5, 4, 4, -4, -5, -6, 4, 5, 3, 3, 2, 3, -4}
};
const int16_t bias_fc0[10] = {-113, 41, 116, -99, -6, 63, -74, 82, 26, -60};

struct Parameters {
    uint8_t type;
    
    /* Input feature map*/
    uint8_t fmap_in_lines;
    uint8_t fmap_in_cols;
    uint32_t fmap_in_channel_size;
    uint32_t fmap_in_channels;  /* Same as number of filter kernels */
    uint8_t pad;
    uint32_t padded_fmap;
    
    /* Output feature map*/
    uint8_t fmap_out_lines;
    uint8_t fmap_out_cols;
    uint32_t fmap_out_channel_size;
    uint32_t fmap_out_channels;
    uint32_t neurons;
    
    /* Filter features */
    const int8_t *filters;
    const int16_t *bias;
    uint8_t kernel_order;
    uint8_t kernel_size;
    uint8_t stride;
    uint16_t next_fmap_in_line;
    uint8_t apply_relu;    
};

struct Parameters parameters[LAYERS];

struct Parameters *GetLayersParameters() {
    
	/* Layer 0 */
	parameters[0].type = CONV;
	parameters[0].fmap_in_lines = 28;
	parameters[0].fmap_in_cols = 28;
	parameters[0].fmap_in_channels = 1;
	parameters[0].fmap_in_channel_size = 784;

	parameters[0].fmap_out_lines = 26;
	parameters[0].fmap_out_cols = 26;
	parameters[0].fmap_out_channels = 4;
	parameters[0].fmap_out_channel_size = 676;

	parameters[0].pad = 0;
	parameters[0].filters = (const int8_t *)filters_conv0;
	parameters[0].bias = (const int16_t *)bias_conv0;
	parameters[0].kernel_order = 3;
	parameters[0].kernel_size = 9;
	parameters[0].stride = 1;
	parameters[0].next_fmap_in_line = 28;
	parameters[0].apply_relu = 0;

	/* Layer 1 */
	parameters[1].type = MAX_POOL;
	parameters[1].fmap_in_lines = 26;
	parameters[1].fmap_in_cols = 26;
	parameters[1].fmap_in_channels = 4;
	parameters[1].fmap_in_channel_size = 676;

	parameters[1].fmap_out_lines = 13;
	parameters[1].fmap_out_cols = 13;
	parameters[1].fmap_out_channels = 4;
	parameters[1].fmap_out_channel_size = 169;


	/* Layer 2 */
	parameters[2].type = CONV;
	parameters[2].fmap_in_lines = 13;
	parameters[2].fmap_in_cols = 13;
	parameters[2].fmap_in_channels = 4;
	parameters[2].fmap_in_channel_size = 169;

	parameters[2].fmap_out_lines = 11;
	parameters[2].fmap_out_cols = 11;
	parameters[2].fmap_out_channels = 4;
	parameters[2].fmap_out_channel_size = 121;

	parameters[2].pad = 0;
	parameters[2].filters = (const int8_t *)filters_conv1;
	parameters[2].bias = (const int16_t *)bias_conv1;
	parameters[2].kernel_order = 3;
	parameters[2].kernel_size = 9;
	parameters[2].stride = 1;
	parameters[2].next_fmap_in_line = 13;
	parameters[2].apply_relu = 0;

	/* Layer 3 */
	parameters[3].type = MAX_POOL;
	parameters[3].fmap_in_lines = 11;
	parameters[3].fmap_in_cols = 11;
	parameters[3].fmap_in_channels = 4;
	parameters[3].fmap_in_channel_size = 121;

	parameters[3].fmap_out_lines = 5;
	parameters[3].fmap_out_cols = 5;
	parameters[3].fmap_out_channels = 4;
	parameters[3].fmap_out_channel_size = 25;


	/* Layer 4 */
	parameters[4].type = FULL_CONNECTED;
	parameters[4].fmap_in_lines = 5;
	parameters[4].fmap_in_cols = 5;
	parameters[4].fmap_in_channels = 4;
	parameters[4].fmap_in_channel_size = 25;

	parameters[4].filters = (const int8_t *)weights_fc0;
	parameters[4].bias = (const int16_t *)bias_fc0;
	parameters[4].neurons = 10;
	parameters[4].apply_relu = 0;
 
	return parameters;
}



#endif
