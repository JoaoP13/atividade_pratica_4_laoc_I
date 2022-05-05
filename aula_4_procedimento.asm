	# Declara main como uma função global
	.globl main

	# Todo o código do programa é colocado após a diretiva .text
	.text

# O label 'main' representa o ponto de início
main:
	addi $a0, $zero, 32
 	jal function_f
 	j exit
 	
function_f:
	sub $sp, $sp, 136 		# Abre espaço na pilha para receber 
	sw $t1, 12($sp)		# Guarda os valores para poder usar e retornar depois com segurança
	sw $t2, 4($sp)			# Guarda os valores para poder usar e retornar depois com segurança
	sw $t3, 8($sp)			# Guarda os valores para poder usar e retornar depois com segurança
	sw $t4, 0($sp) 			# $t4 guarda o endereço-base do array a
    li $t1, -1				# Guarda em $t1 o valor -1 para inicializar os primeiros valores de a
    sw $t1, 0($t4)			# Seta -1 no primeiro elemento de a 
    sw $t1, 4($t4)			# Seta -1 no segundo elemento de a
    add $t1, $zero, 2		# Torna o registrador $t1 no controlador 1 e o inicializa com 2
    
loop:
    slt $t3, $t1, $a0		# Seta 0 em $t3 se o y não for maior do que i
    bne $t3, 1, exit_loop 	# Se $t3 for 0, saia do loop
    add $t3, $t1, $t1		# Guarda 2 * i
    add $t3, $t3, $t3		# Guarda 4 * i
    add $t3, $t4, $t3		# Guarda o valor do endereço base de a mais o i	
    lw $t2, -4($t3)			# Guarda em $t2 o valor de a[i - 1]
    lw $t3, -8($t3)			# Guarda em $t2 o valor de a[i - 2]
    add $t2, $t2, $t3		# Guardando em $t2 o valor de a[i - 1] + a[i - 2]
    sw $t2, 0($t3)			# Guardando na memória o valor de $t2 na posição a[i]
 	addi $t1, $t1, 1		# Atualizando o valor de i
 	j loop					# Continua o loop
    
exit_loop:
	add $t1, $a0, $sp
	lw $t1, $t1($t4)
	
	j $ra

exit:
	li $v0, 10
	syscall
