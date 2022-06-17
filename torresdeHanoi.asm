# practica 1 Torres de Hanoi
# Armando Cabrales

.eqv discos 3
.data
.text

main:
	lui s11, 0x10010
	addi s1, zero, discos
	addi t6, zero, 1	 	# valor para comparar
	addi a1, s1, 0
	
crear_torres:				# s11 torre 1		s1 torre 2	s2 torre 3
	addi t1, t1, 1
	sw t1, 0(s11)
	addi s11, s11, 32		# se usan 32 por el acomodo de las torres
	bne t1, s1, crear_torres
	
	addi s11, s11, -32
	addi s1, s11, 4			# acomodo de la torre 1 y 2
	addi s2, s11, 8
	
	addi s11, zero, 0
	lui s11, 0x10010
	addi s11, s11, -32
	
	jal, ra, hanoi
	jal zero, exit


hanoi:
	addi sp, sp -4		
	sw ra, 0(sp)
	bne a1, t6, else	# salta si a1 no es igual a 1
	
	# caso base
	addi s11, s11, 32		
	sw zero, 0(s11)		# remueve el disco de arriba de la torre de origen
	sw a1, 0(s2)		# añade el disco a la torre destino actual
	addi s2, s2, -32
	
	jal zero, return_hanoi	# carga a ra el valor de retorno
	
else:
	add t2, zero, s1	# intercambia la direccion de memoria de las torres
	add s1, zero, s2	# torre auxiliar = torre destino
	add s2, zero, t2	# torre destino = torre auxiliar
	
	addi a1, a1, -1
	jal ra, hanoi		# vuelve a llamar con n - 1
				
	addi a1, a1, 1		
	add t2, zero, s1	# intercambia la direccion de memoria de las torres
	add s1, zero, s2	# torre auxiliar = torre destino
	add s2, zero, t2	# torre destino = torre auxiliar
				
	# regresa a la normalidad
	
	addi s11, s11, 32
	sw zero, 0(s11)		# remueve el disco de arriba de la torre de origen
	sw a1, 0(s2)		# añade el disco a la torre auxiliar actual
	addi s2, s2, -32
	
	
	add t0, zero, s11	# intercambia la direccion de memoria de las torres
	add s11, zero, s1	# torre inicial = torre auxiliar
	add s1, zero, t0	# torre auxiliar = torre inicial
	
	addi a1, a1, -1
	jal ra, hanoi		# vuelve a llamar con n - 1
	
	addi a1, a1, 1
	add t0, zero, s11	# intercambia la direccion de memoria de las torres
	add s11, zero, s1	# torre inicial = torre auxiliar
	add s1, zero, t0	# torre auxiliar = torre inicial
	
	# regresa a la normalidad

return_hanoi:
	lw ra, 0(sp)		# carga a ra el valor de retorno almacenado en el stack
	addi sp, sp, 4		
	jalr zero, ra, 0

exit:
	
	
	
