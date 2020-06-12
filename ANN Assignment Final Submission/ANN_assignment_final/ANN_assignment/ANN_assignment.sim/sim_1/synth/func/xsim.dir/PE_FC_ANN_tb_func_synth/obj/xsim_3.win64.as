	.def	 _relocate;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	_relocate
	.align	16, 0x90
_relocate:                              # @_relocate
# BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	leaq	.L.str(%rip), %rdx
	leaq	.L.str1(%rip), %r8
	leaq	_relocate(%rip), %r9
	callq	*__imp__iki_relocate(%rip)
	addq	$32, %rsp
	popq	%rbp
	ret

	.def	 _sensitize;
	.scl	2;
	.type	32;
	.endef
	.globl	_sensitize
	.align	16, 0x90
_sensitize:                             # @_sensitize
# BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	leaq	.L.str(%rip), %rdx
	callq	*__imp__iki_sensitize(%rip)
	addq	$32, %rsp
	popq	%rbp
	ret

	.def	 _simulate;
	.scl	2;
	.type	32;
	.endef
	.globl	_simulate
	.align	16, 0x90
_simulate:                              # @_simulate
# BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	leaq	.L.str(%rip), %rdx
	callq	*__imp__iki_schedule_processes_at_time_zero(%rip)
	callq	*__imp__iki_execute_processes(%rip)
	addq	$32, %rsp
	popq	%rbp
	ret

	.section	.rdata,"r"
.L.str:                                 # @.str
	.asciz	"xsim.dir/PE_FC_ANN_tb_func_synth/xsim.reloc"

.L.str1:                                # @.str1
	.asciz	"xsim.dir/PE_FC_ANN_tb_func_synth/xsimk.exe"


