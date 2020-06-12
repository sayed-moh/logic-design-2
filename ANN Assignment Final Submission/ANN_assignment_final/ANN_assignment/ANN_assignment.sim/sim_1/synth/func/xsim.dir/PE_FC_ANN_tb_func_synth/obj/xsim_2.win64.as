	.def	 _main;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	_main
	.align	16, 0x90
_main:                                  # @_main
# BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rsi
	pushq	%rdi
	subq	$64, %rsp
	movq	%rdx, %rsi
	movl	%ecx, %edi
	callq	*__imp__isimBridge_getWdbWriter(%rip)
	movq	%rsi, 56(%rsp)
	movl	%edi, 48(%rsp)
	movq	%rax, 32(%rsp)
	movl	$0, 40(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	_relocate(%rip), %rdx
	leaq	_sensitize(%rip), %r8
	leaq	_simulate(%rip), %r9
	callq	*__imp__iki_create_design(%rip)
	leaq	.L.str1(%rip), %rcx
	callq	*__imp__iki_set_sv_type_file_path_name(%rip)
	leaq	.L.str2(%rip), %rcx
	leaq	.L.str3(%rip), %rdx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	*__imp__iki_heap_initialize(%rip)
	callq	*__imp__iki_simulate_design(%rip)
	addq	$64, %rsp
	popq	%rdi
	popq	%rsi
	popq	%rbp
	ret

	.section	.rdata,"r"
.L.str:                                 # @.str
	.asciz	"xsim.dir/PE_FC_ANN_tb_func_synth/xsim.mem"

.L.str1:                                # @.str1
	.asciz	"xsim.dir/PE_FC_ANN_tb_func_synth/xsim.svtype"

.L.str2:                                # @.str2
	.asciz	"ms"

.L.str3:                                # @.str3
	.asciz	"isimmm"


