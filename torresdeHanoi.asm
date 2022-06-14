.data
.text
.eqv discos 3
main:
	lui s11, 0x10010
	addi s1, zero, discos
	addi t6, zero, 1	 	# valor para comparar
	addi a1, s1, 0
	
crear_torres:				# s11 torre 1		s1 torre 2	s2 torre 3
	addi t1, t1, 1
	sw t1, 0(s11)
	addi s11, s11, 32
	bne t1, s1, crear_torres
	
	addi s11, s11, -32
	addi s1, s11, 4
	addi s2, s11, 8
	addi s11, zero, 0
	lui s11, 0x10010
	
	jal, ra, hanoi
	jal zero, end

hanoi:
	addi sp, sp -4
	sw ra, 0(sp)
	bne a1, t6, else
	
	#caso base
	
	
	sw zero, 0(s11)
	sw a1, 0(s2)
	addi s11, s11, 32
	addi s2, s2, -32
	
	jalr, zero, ra, 0
	
	
else:
	addi a1, a1, -1		#intercambio
	add t2, s1, zero
	add s1, s2, zero
	add s2, t2, zero
	
	jal ra, hanoi
	
	
	sw zero, 0(s11)
	sw a1, 0(s2)
	addi s11, s11, 32
	addi s2, s2, -32
	
	addi a1, a1, -1
	add t2, s1, zero
	add s1, s11, zero
	add s11, t2, zero
	
	jal ra, hanoi
	
return_hanoi:
	lw ra, 0(sp)
	addi sp, sp, 4
	addi a1, a1, 1
	jalr zero, ra, 0
	
end: add zero, zero, zero
	
	
	
	