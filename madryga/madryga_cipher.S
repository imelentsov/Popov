	.file	"madryga_cipher.S"
	.globl	_keyRandomConstant
	.section .rdata,"dr"
	.align 8
_keyRandomConstant:
	.long	1264216440
	.long	253635900
	.globl	_keyRotationBits
_keyRotationBits:
	.byte	3
	.text
	.globl	_encrypt
	.def	_encrypt;	.scl	2;	.type	32;	.endef
_encrypt:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movw	%dx, -36(%ebp)
	movb	%al, -40(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	24(%ebp), %eax
	movl	%eax, -44(%ebp)
	movzwl	-36(%ebp), %eax
	subl	$1, %eax
	movw	%ax, -22(%ebp)
	movb	$0, -19(%ebp)
	jmp	L2
L5:
	movw	$0, -18(%ebp)
	jmp	L3
L4:
	movl	-48(%ebp), %ecx
	movl	-44(%ebp), %ebx
	movl	$1264216440, %eax
	movl	$253635900, %edx
	movl	%ecx, %edi
	xorl	%eax, %edi
	movl	%edi, -56(%ebp)
	movl	%ebx, %edi
	xorl	%edx, %edi
	movl	%edi, -52(%ebp)
	movl	-56(%ebp), %eax
	movl	-52(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	movl	-48(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	$3, %ecx
	movsbl	%cl, %ecx
	shldl	%cl, %eax, %edx
	sall	%cl, %eax
	testb	$32, %cl
	je	L6
	movl	%eax, %edx
	xorl	%eax, %eax
L6:
	movl	%eax, -72(%ebp)
	movl	%edx, -68(%ebp)
	movl	-48(%ebp), %ebx
	movl	-44(%ebp), %esi
	movl	$3, %eax
	movsbl	%al, %edx
	movl	$64, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	shrdl	%cl, %esi, %ebx
	shrl	%cl, %esi
	testb	$32, %cl
	je	L7
	movl	%esi, %ebx
	xorl	%esi, %esi
L7:
	movl	%ebx, %eax
	movl	%esi, %edx
	movl	-72(%ebp), %esi
	movl	-68(%ebp), %edi
	movl	%esi, %ebx
	orl	%eax, %ebx
	movl	%ebx, -64(%ebp)
	movl	%edx, %eax
	orl	%edi, %eax
	movl	%eax, -60(%ebp)
	movl	-64(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	andl	$7, %eax
	movb	%al, -23(%ebp)
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	leal	-48(%ebp), %eax
	movzbl	(%eax), %eax
	xorl	%edx, %eax
	movb	%al, (%ecx)
	movzwl	-18(%ebp), %eax
	subl	$2, %eax
	movl	%eax, %edx
	movzwl	-22(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -26(%ebp)
	movzwl	-18(%ebp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	movzwl	-22(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -28(%ebp)
	movzwl	-26(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzwl	-28(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -30(%ebp)
	movzwl	-30(%ebp), %eax
	movzwl	%ax, %edx
	movsbl	-23(%ebp), %eax
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %ebx
	movzwl	-30(%ebp), %eax
	movzwl	%ax, %esi
	movsbl	-23(%ebp), %edx
	movl	$16, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	sarl	%cl, %esi
	movl	%esi, %eax
	orl	%ebx, %eax
	movw	%ax, -30(%ebp)
	movzwl	-26(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	leal	-30(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	movzwl	-28(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movzbl	-29(%ebp), %eax
	movb	%al, (%edx)
	addw	$1, -18(%ebp)
L3:
	movzwl	-18(%ebp), %eax
	cmpw	-36(%ebp), %ax
	jb	L4
	addb	$1, -19(%ebp)
L2:
	movzbl	-19(%ebp), %eax
	cmpb	-40(%ebp), %al
	jb	L5
	addl	$60, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
	.globl	_decrypt
	.def	_decrypt;	.scl	2;	.type	32;	.endef
_decrypt:
LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$76, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movw	%dx, -36(%ebp)
	movb	%al, -40(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	24(%ebp), %eax
	movl	%eax, -44(%ebp)
	movzwl	-36(%ebp), %eax
	subl	$1, %eax
	movw	%ax, -22(%ebp)
	movzwl	-36(%ebp), %edx
	movzbl	-40(%ebp), %eax
	imull	%edx, %eax
	movl	%eax, %ecx
	movl	$3, %eax
	movsbl	%al, %eax
	sall	$6, %eax
	movl	%eax, %esi
	movl	%ecx, %eax
	movl	$0, %edx
	divl	%esi
	movl	%edx, %ecx
	movl	%ecx, %eax
	movb	%al, -23(%ebp)
	movw	$0, -18(%ebp)
	jmp	L9
L10:
	movl	-48(%ebp), %ecx
	movl	-44(%ebp), %ebx
	movl	$1264216440, %eax
	movl	$253635900, %edx
	movl	%ecx, %edi
	xorl	%eax, %edi
	movl	%edi, -56(%ebp)
	movl	%ebx, %edi
	xorl	%edx, %edi
	movl	%edi, -52(%ebp)
	movl	-56(%ebp), %eax
	movl	-52(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	movl	-48(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	$3, %ecx
	movsbl	%cl, %ecx
	shldl	%cl, %eax, %edx
	sall	%cl, %eax
	testb	$32, %cl
	je	L17
	movl	%eax, %edx
	xorl	%eax, %eax
L17:
	movl	%eax, -88(%ebp)
	movl	%edx, -84(%ebp)
	movl	-48(%ebp), %ebx
	movl	-44(%ebp), %esi
	movl	$3, %eax
	movsbl	%al, %edx
	movl	$64, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	shrdl	%cl, %esi, %ebx
	shrl	%cl, %esi
	testb	$32, %cl
	je	L18
	movl	%esi, %ebx
	xorl	%esi, %esi
L18:
	movl	%ebx, %eax
	movl	%esi, %edx
	movl	-88(%ebp), %esi
	movl	-84(%ebp), %edi
	movl	%esi, %ebx
	orl	%eax, %ebx
	movl	%ebx, -64(%ebp)
	movl	%edx, %eax
	orl	%edi, %eax
	movl	%eax, -60(%ebp)
	movl	-64(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	addw	$1, -18(%ebp)
L9:
	movzbl	-23(%ebp), %eax
	cmpw	-18(%ebp), %ax
	ja	L10
	movb	$0, -19(%ebp)
	jmp	L11
L14:
	movzwl	-22(%ebp), %eax
	movw	%ax, -18(%ebp)
	jmp	L12
L13:
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movl	%eax, %edx
	leal	-48(%ebp), %eax
	movzbl	(%eax), %eax
	xorl	%edx, %eax
	movb	%al, (%ecx)
	movzwl	-18(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	andl	$7, %eax
	movb	%al, -24(%ebp)
	movzwl	-18(%ebp), %eax
	subl	$2, %eax
	movl	%eax, %edx
	movzwl	-22(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -26(%ebp)
	movzwl	-18(%ebp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	movzwl	-22(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -28(%ebp)
	movzwl	-26(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzwl	-28(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -30(%ebp)
	movzwl	-30(%ebp), %eax
	movzwl	%ax, %edx
	movsbl	-24(%ebp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %ebx
	movzwl	-30(%ebp), %eax
	movzwl	%ax, %esi
	movsbl	-24(%ebp), %edx
	movl	$16, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	sall	%cl, %esi
	movl	%esi, %eax
	orl	%ebx, %eax
	movw	%ax, -30(%ebp)
	movzwl	-26(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	leal	-30(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	movzwl	-28(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movzbl	-29(%ebp), %eax
	movb	%al, (%edx)
	movl	-48(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	$3, %ecx
	movsbl	%cl, %ecx
	shrdl	%cl, %edx, %eax
	shrl	%cl, %edx
	testb	$32, %cl
	je	L15
	movl	%edx, %eax
	xorl	%edx, %edx
L15:
	movl	%eax, -56(%ebp)
	movl	%edx, -52(%ebp)
	movl	-48(%ebp), %ebx
	movl	-44(%ebp), %esi
	movl	$3, %eax
	movsbl	%al, %edx
	movl	$64, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	shldl	%cl, %ebx, %esi
	sall	%cl, %ebx
	testb	$32, %cl
	je	L16
	movl	%ebx, %esi
	xorl	%ebx, %ebx
L16:
	movl	%ebx, %eax
	movl	%esi, %edx
	movl	-56(%ebp), %esi
	movl	-52(%ebp), %edi
	movl	%esi, %ebx
	orl	%eax, %ebx
	movl	%ebx, -72(%ebp)
	movl	%edx, %eax
	orl	%edi, %eax
	movl	%eax, -68(%ebp)
	movl	-72(%ebp), %eax
	movl	-68(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	movl	-48(%ebp), %ecx
	movl	-44(%ebp), %ebx
	movl	$1264216440, %eax
	movl	$253635900, %edx
	movl	%ecx, %edi
	xorl	%eax, %edi
	movl	%edi, -80(%ebp)
	movl	%ebx, %edi
	xorl	%edx, %edi
	movl	%edi, -76(%ebp)
	movl	-80(%ebp), %eax
	movl	-76(%ebp), %edx
	movl	%eax, -48(%ebp)
	movl	%edx, -44(%ebp)
	subw	$1, -18(%ebp)
L12:
	cmpw	$254, -18(%ebp)
	jbe	L13
	addb	$1, -19(%ebp)
L11:
	movzbl	-19(%ebp), %eax
	cmpb	-40(%ebp), %al
	jb	L14
	addl	$76, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE1:
	.globl	_encrypt_weak
	.def	_encrypt_weak;	.scl	2;	.type	32;	.endef
_encrypt_weak:
LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$24, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movw	%dx, -24(%ebp)
	movb	%al, -28(%ebp)
	movzwl	-24(%ebp), %eax
	subl	$1, %eax
	movw	%ax, -10(%ebp)
	movb	$0, -7(%ebp)
	jmp	L20
L23:
	movw	$0, -6(%ebp)
	jmp	L21
L22:
	movzwl	-6(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	andl	$7, %eax
	movb	%al, -11(%ebp)
	movzwl	-6(%ebp), %eax
	subl	$2, %eax
	movl	%eax, %edx
	movzwl	-10(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -14(%ebp)
	movzwl	-6(%ebp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	movzwl	-10(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -16(%ebp)
	movzwl	-14(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzwl	-16(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -18(%ebp)
	movzwl	-18(%ebp), %eax
	movzwl	%ax, %edx
	movsbl	-11(%ebp), %eax
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movzwl	-18(%ebp), %eax
	movzwl	%ax, %ebx
	movsbl	-11(%ebp), %eax
	movl	$16, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %ecx
	sarl	%cl, %ebx
	movl	%ebx, %eax
	orl	%edx, %eax
	movw	%ax, -18(%ebp)
	movzwl	-14(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	leal	-18(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	movzwl	-16(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movzbl	-17(%ebp), %eax
	movb	%al, (%edx)
	addw	$1, -6(%ebp)
L21:
	movzwl	-6(%ebp), %eax
	cmpw	-24(%ebp), %ax
	jb	L22
	addb	$1, -7(%ebp)
L20:
	movzbl	-7(%ebp), %eax
	cmpb	-28(%ebp), %al
	jb	L23
	addl	$24, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2:
	.globl	_decrypt_weak
	.def	_decrypt_weak;	.scl	2;	.type	32;	.endef
_decrypt_weak:
LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$24, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movw	%dx, -24(%ebp)
	movb	%al, -28(%ebp)
	movzwl	-24(%ebp), %eax
	subl	$1, %eax
	movw	%ax, -10(%ebp)
	movb	$0, -7(%ebp)
	jmp	L25
L28:
	movzwl	-10(%ebp), %eax
	movw	%ax, -6(%ebp)
	jmp	L26
L27:
	movzwl	-6(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	andl	$7, %eax
	movb	%al, -11(%ebp)
	movzwl	-6(%ebp), %eax
	subl	$2, %eax
	movl	%eax, %edx
	movzwl	-10(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -14(%ebp)
	movzwl	-6(%ebp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	movzwl	-10(%ebp), %eax
	andl	%edx, %eax
	movw	%ax, -16(%ebp)
	movzwl	-14(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzwl	-16(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -18(%ebp)
	movzwl	-18(%ebp), %eax
	movzwl	%ax, %edx
	movsbl	-11(%ebp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movzwl	-18(%ebp), %eax
	movzwl	%ax, %ebx
	movsbl	-11(%ebp), %eax
	movl	$16, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %ecx
	sall	%cl, %ebx
	movl	%ebx, %eax
	orl	%edx, %eax
	movw	%ax, -18(%ebp)
	movzwl	-14(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	leal	-18(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	movzwl	-16(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movzbl	-17(%ebp), %eax
	movb	%al, (%edx)
	subw	$1, -6(%ebp)
L26:
	cmpw	$254, -6(%ebp)
	jbe	L27
	addb	$1, -7(%ebp)
L25:
	movzbl	-7(%ebp), %eax
	cmpb	-28(%ebp), %al
	jb	L28
	addl	$24, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc