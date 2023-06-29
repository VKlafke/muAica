
/*----------------------------------------
----------------------------------------
	C header:

		1) CSRRW and CSRRWI MACROS;
	
		2) CSRRS and CSRRSI MACROS;

		3) CSRRC and CSRRCI MACROS;

		4) Flags enable MACROS (like interrupt enable).

----------------------------------------
----------------------------------------*/

#ifndef _CSR_H
#define _CSR_H

/*----------------------------------
----------------------------------
1) CSRRW / CSRRWI
*/
#define csr_rw(_csr_ , _write_)				\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrw	%0," #_csr_ ", %1"			\
		: "=r" (_read_) : "r" (_write_)		\
	);										\
	_read_;									\
})

#define csr_r(_csr_)			\
({								\
	int	_read_;					\
	__asm__ __volatile__ 		\
	(							\
		"csrr	%0," #_csr_ ""	\
		: "=r" (_read_)			\
	);							\
	_read_;						\
})

#define csr_w(_csr_ , _int_write_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrw	" #_csr_ ", %0"		\
		: : "r" (_int_write_)		\
	);

	// ---------------

#define csr_rwi(_csr_ , _write_)			\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrwi	%0," #_csr_ ", %1"			\
		: "=r" (_read_) : "rK" (_write_)	\
	);										\
	_read_;									\
})

#define csr_wi(_csr_ , _int_write_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrwi	" #_csr_ ", %0"		\
		: : "rK" (_int_write_)		\
	);

/*----------------------------------
----------------------------------
2) CSRRS / CSRRSI
*/
#define csr_rs(_csr_ , _int_set_)			\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrs	%0," #_csr_ ", %1"			\
		: "=r" (_read_) : "r" (_int_set_)	\
	);										\
	_read_;									\
})

#define csr_s(_csr_ , _int_set_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrs	" #_csr_ ", %0"		\
		: : "r" (_int_set_)			\
	);

	// ---------------

#define csr_rsi(_csr_ , _int_set_)			\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrsi	%0," #_csr_ ",  %1 "		\
		: "=r" (_read_) : "rK" (_int_set_)	\
	);										\
	_read_;									\
})

#define csr_si(_csr_ , _int_set_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrsi	" #_csr_ ", %0  "	\
		: : "rK" (_int_set_)		\
	);

/*----------------------------------
----------------------------------
3) CSRRC / CSRRCI
*/
#define csr_rc(_csr_ , _int_clear_)			\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrc	%0," #_csr_ ", %1"			\
		: "=r" (_read_) : "rK" (_int_clear_)\
	);										\
	_read_;									\
})

#define csr_c(_csr_ , _int_clear_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrc	" #_csr_ ", %0"		\
		: : "r" (_int_clear_)		\
	);

	// ---------------

#define csr_rci(_csr_ , _int_clear_)		\
({											\
	int _read_;								\
	__asm__ __volatile__ 					\
	(										\
		"csrrci	%0," #_csr_ ", %1"			\
		: "=r" (_read_) : "rK" (_int_clear_)\
	);										\
	_read_;									\
})

#define csr_ci(_csr_ , _int_clear_)	\
	__asm__ __volatile__ 			\
	(								\
		"csrci	" #_csr_ ", %0"		\
		: : "rK" (_int_clear_)		\
	);

/*----------------------------------
----------------------------------
4) Flags MACRO
*/

// global interrupt/exception enable/disable
#define mtrap_en()		\
	csr_si(mstatus , 8);

#define mtrap_dis()		\
	csr_ci(mstatus , 8);	

// exception enable/disable
#define mexcp_en()		\
	csr_si(mie, 8);

#define mexcp_dis()		\
	csr_ci(mie, 8);

// interrupt enable/disable
#define mintr_en()			\
	int _val_ = 0x00000800;	\
	csr_s(mie, _val_);

#define mintr_dis()			\
	int _val_ = 0x00000800;	\
	csr_c(mie, _val_);

// vector table mode
#define mtvec_mode(_val_)	\
	csr_w(mtvec, _val_);


#endif
