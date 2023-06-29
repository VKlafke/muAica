/*----------------------------------------
----------------------------------------
	MACROS so we can use trap handlers in C
	with attributes that define the section
	and type (interrupt) of the function,
	also start the vector table

----------------------------------------
----------------------------------------*/

#ifndef _AICA_IO_H_
#  error "<aica_io.h> should be included before <trap_handler.h> file."
#endif
#ifndef _CSR_H
#  error "<csr.h> should be included before <trap_handler.h> file."
#endif

#ifndef _TRAP_HANDLER_H
#define _TRAP_HANDLER_H

/* --------------------------------------------------
	MAIN TRAP HANDLER
-------------------------------------------------- */
#define MAIN_HANDLER();																							\
	void _main_trap_() __attribute__((section(".m_trap_handler"))) __attribute__((interrupt("machine")));		\
	void _main_trap_()																							\
	{																											\
		int _trap_target_ = _TVEC_SEC_;																			\
		int _trap_cause_;																						\
																												\
		_trap_cause_ = csr_r(mcause);																			\
																												\
		if (_trap_cause_ >= 0)																					\
		{																										\
			_trap_cause_ = _trap_cause_ << 2;																	\
		}																										\
		else																									\
		{																										\
			_trap_cause_ = _trap_cause_ << 2;																	\
			_trap_cause_ = _trap_cause_ + 0;																	\
		}																										\
																												\
		_trap_target_ = _trap_target_ + _trap_cause_;															\
		__asm__ __volatile__																					\
		(																										\
			"jalr	%0"																							\
			: : "r" (_trap_target_)																				\
		);																										\
	}

/* --------------------------------------------------
	EXCEPTION/INTERRUPT VECTOR TABLE DEFINE
-------------------------------------------------- */

#define EXCP_VECT( __excp_handler__ , __excp_vect_num__ )	\
	void __excp_handler__();								\
	__asm__													\
	(														\
		".section	._m_excp_vect_"#__excp_vect_num__" \n\t"\
		"j	"#__excp_handler__" "							\
	);

#define INTR_VECT( __intr_handler__ , __intr_vect_num__ )	\
	void __intr_handler__();								\
	__asm__													\
	(														\
		".section	._m_intr_vect_"#__intr_vect_num__" \n\t"\
		"j	"#__intr_handler__" "							\
	);

/* --------------------------------------------------
-------------------------------------------------- */
#endif
