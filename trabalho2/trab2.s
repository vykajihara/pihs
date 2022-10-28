/*
 	CAMPOS REGISTRO 				TIPO 				QTD BYTES		POSICAO
 	
 	Nome completo					100 caracteres		100 			0
 	CPF								14 caracteres		16 				100
 	Celular proprietário	 		14 caracteres 		16  			116
 	Tipo de imóvel (casa ou apt)  	1 caracter 			4 				132
 	Endereço	
 		Cidade						20 caracteres  		20				136
 		Bairro						20 caracteres 		20 				156
 		Rua	 						20 caracteres		20 				176
 		Número 						inteiro				4  				196
 	Número de quartos simples  		inteiro				4 				200
 	Número de suítes 				inteiro				4 				204
 	Possui banheiro social			1 caracter 			4 				208
 	Possui cozinha 					1 caracter 			4 				212
 	Possui sala 					1 caracter			4	 			216
 	Possui garagem 					1 caracter 			4 				220
 	Área total 						double 				8 				224
 	Valor aluguel 					double	 			8   			232

 	Prox (endereço de memória do prox registro) 		4 				240

 												TOTAL: 	244 
*/

.section .data
	txtAbertura: 		.asciz 	"\n*** CONTROLE DE CADASTRO IMOBILIARIO ***\n"

	txtMenu: 			.asciz 	"Menu de opcoes:\n<1> Insercao\n<2> Remocao\n<3> Consulta\n<4> Gravar cadastro\n<5> Recuperar cadastro\n<6> Relatorio de registros\n<7> Sair\nEscolha uma opcao => "

	txtPedeNome:		.asciz	"\nNome: "
	txtPedeCPF:			.asciz	"\nCPF: " 
	txtPedeCel:			.asciz  "\nCelular: "
	txtPedeTipoIm: 		.asciz	"\nTipo de imovel <C>asa/<A>partamento: "
	txtPedeCidade:		.asciz	"\nEndereco\nCidade: "
	txtPedeBairro:		.asciz	"Bairro: "
	txtPedeRua:			.asciz	"Rua: "
	txtPedeNumero: 		.asciz 	"Numero: "
	txtPedeQuarto: 		.asciz 	"\nQuantidade de quartos simples: " 
	txtPedeSuites:		.asciz 	"\nQuantidade de suites: " 
	txtPedeBanheiro:	.asciz	"\nPossui banheiro social? <S>/<N>: "
	txtPedeCozinha:		.asciz	"\nPossui cozinha? <S>/<N>: "
	txtPedeSala:		.asciz	"\nPossui sala? <S>/<N>: "
	txtPedeGaragem: 	.asciz	"\nPossui garagem? <S>/<N>: "
	txtPedeArea:		.asciz	"\nArea total: "
	txtPedeAluguel:		.asciz	"\nValor do aluguel: "

	txtMostraReg:		.asciz	"\n\n\n\n\n\n\n\n\n\n\n\n 	*** REGISTRO LIDO ***"
	txtMostraNome:		.asciz	"\nNome: %s"
	txtMostraCPF:		.asciz	"\nCPF: %s" 
	txtMostraCel:		.asciz  "\nCelular: %s"
	txtMostraTipoIm: 	.asciz	"\nTipo de imovel <C>asa/<A>partamento: %s"
	txtMostraCidade:	.asciz	"\nEndereco\nCidade: %s"
	txtMostraBairro:	.asciz	"Bairro: %s"
	txtMostraRua:		.asciz	"Rua: %s"
	txtMostraNumero: 	.asciz 	"Numero: %d\n"
	txtMostraQuartos:	.asciz 	"\nQuantidade de quartos simples: %d\n" 
	txtMostraSuites:	.asciz 	"\nQuantidade de suites: %d\n" 
	txtMostraBanheiro:	.asciz	"\nPossui banheiro social? <S>/<N>: %c\n"
	txtMostraCozinha:	.asciz	"\nPossui cozinha? <S>/<N>: %c\n"
	txtMostraSala:		.asciz	"\nPossui sala? <S>/<N>: %c\n"
	txtMostraGaragem: 	.asciz	"\nPossui garagem? <S>/<N>: %c\n"
	txtMostraArea:		.asciz	"\nArea total: %.2lf\n"
	txtMostraAluguel:	.asciz	"\nValor do aluguel: R$ %.2lf\n"

	pulaLinha: 	.asciz 	"\n"
	
	tipoInt: 	.asciz 	"%d"
	tipoChar:	.asciz	" %c"
	tipoDouble: .asciz 	"%lf"
	
	opcao: 		.int 	0
	tamReg:  	.int 	244

	# ponteiros
	listaPtr: 	.space 	4 	# ponteiro para o primeiro elemento da lista de registros
	regPtr:		.space	4 	# ponteiro para o registro que será lido
	auxPtr: 	.space 	4 	# ponteiro auxiliar para operacoes na lista 
	NULL:		.space 	4 	
	
.section .text
.globl _start
_start:

	movl  	$NULL, listaPtr 	# incializa listaPtr (lista vazia)

_menu:

	call leReg
	call mostraReg

/*	pushl	$txtAbertura
	call	printf
	pushl 	$txtMenu
	call 	printf
	addl	$8, %esp

	pushl 	$opcao
	pushl  	$tipoInt
	call  	scanf
	addl 	$8, %esp

	call  	trataOpcao

	jmp 	_menu*/

_end:

	pushl 	$0
	call 	exit

trataOpcao:

	cmpl 	$1, opcao
	je  	insercao

	cmpl 	$2, opcao
	je  	remocao

	cmpl 	$3, opcao
	je  	consulta

	cmpl 	$4, opcao
	je  	gravar

	cmpl 	$5, opcao
	je  	recuperar

	cmpl 	$6, opcao
	je  	relatorio
	
	cmpl 	$7, opcao
	je  	_end

	RET
	
/***************************************************************
	INSERÇÃO
  **************************************************************/

insercao: 

	call  	leReg

	cmpl  	$NULL, listaPtr
	je  	insereLista

	movl 	regPtr, %eax
	movl 	%eax, listaPtr

	RET

leReg:

	pushl	tamReg
	call	malloc
	movl	%eax, regPtr	
	addl 	$4, %esp

	# edi -> ponteiro que percorre os campos
	
	pushl	$txtPedeNome		# NOME   
	call	printf 				
	addl	$4, %esp
	movl	regPtr, %edi 	
	pushl	stdin		# entrada padrão
	pushl	$100		# tamanho string
	pushl	%edi 		# endereço para armazenar
	call	fgets
	popl  	%edi 		# desempilha ptr		
	addl 	$8, %esp	# limpa stack
	addl  	$100, %edi 	# move ptr

	pushl	$txtPedeCPF			# CPF   
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$16			
	pushl	%edi 		
	call	fgets    
	popl  	%edi
	addl 	$8, %esp
	addl  	$16, %edi

	pushl	$txtPedeCel			# Celular
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$16			
	pushl	%edi 		
	call	fgets
	popl  	%edi
	addl 	$8, %esp
	addl  	$16, %edi

	pushl	$txtPedeTipoIm		# Tipo de imovel
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$4			
	pushl	%edi 		
	call	fgets
	popl  	%edi
	addl 	$8, %esp
	addl  	$4, %edi
	
	pushl	$txtPedeCidade		# Cidade
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$20			
	pushl	%edi 		
	call	fgets
	popl  	%edi
	addl 	$8, %esp
	addl  	$20, %edi
	
	pushl	$txtPedeBairro		# Bairro
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$20			
	pushl	%edi 		
	call	fgets
	popl  	%edi
	addl 	$8, %esp
	addl  	$20, %edi
	
	pushl	$txtPedeRua			# Rua
	call	printf 				
	addl	$4, %esp
	pushl	stdin		
	pushl	$20			
	pushl	%edi 		
	call	fgets
	popl  	%edi
	addl 	$8, %esp
	addl  	$20, %edi
	
	pushl	$txtPedeNumero		# Numero
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoInt
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeQuarto		# Quartos simples
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoInt
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeSuites 		# Suites
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoInt
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeBanheiro 	# Banheiro
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoChar
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeCozinha 	# Cozinha
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoChar
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeSala 		# Sala
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoChar
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeGaragem		# Garagem
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoChar
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$4, %edi
	
	pushl	$txtPedeArea		# Area
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoDouble
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$8, %edi

	pushl	$txtPedeAluguel		# Aluguel
	call	printf 				
	addl	$4, %esp
	pushl 	%edi
	pushl	$tipoDouble
	call	scanf
	addl	$4, %esp
	popl  	%edi
	addl  	$8, %edi

	movl 	$NULL, (%edi)  		# Seta campo prox como NULL

	RET


insereLista:
	
	


	RET

contaComodos:

	# comodos = quartos + suites + outros comodos
	# comodos marcados com <S> => add1 comodos
	# 					   <N> ou qualquer outra coisa => nao soma
	# FIX ME -> COLOCAR VERIFICAÇÃO DE CAMPO

	movl 	regPtr, %edi
	addl 	196, %edi 		# 196 = posição da qtd de quartos no reg

	

	RET


/***************************************************************
	REMOÇÃO
  **************************************************************/

remocao:

	RET

/***************************************************************
	CONSULTA
  **************************************************************/

consulta:

	RET


/***************************************************************
	GRAVAR 
  **************************************************************/

gravar:

	RET


/***************************************************************
	RECUPERAR
  **************************************************************/

recuperar:

	RET


/***************************************************************
	RELATÓRIO
  **************************************************************/

relatorio:
	
	RET


mostraReg:

	# edi -> ponteiro que percorre os campos

	pushl	$txtMostraReg
	call	printf
	addl	$4, %esp

	movl	regPtr, %edi

	pushl	%edi
	pushl	$txtMostraNome		# NOME 
	call	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$100, %edi 	# desloca tam do campo
	
	pushl 	%edi
	pushl 	$txtMostraCPF 		# CPF
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$16, %edi 	
	
	pushl 	%edi
	pushl 	$txtMostraCel		# Celular
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$16, %edi 	
	
	pushl 	%edi
	pushl 	$txtMostraTipoIm  	# Tipo imovel
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$4, %edi 	

	pushl 	%edi
	pushl 	$txtMostraCidade  	# Cidade
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$20, %edi 	
	
	pushl 	%edi
	pushl 	$txtMostraBairro  	# Bairro
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$20, %edi 	
	
	pushl 	%edi
	pushl 	$txtMostraRua  		# Rua
	call 	printf
	addl	$4, %esp
	popl 	%edi  		
	addl 	$20, %edi 	
	
	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraNumero  	# Numero
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 	
	
	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraQuartos  	# Quartos simples
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 	

	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraSuites  	# Suites
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 		

	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraBanheiro 	# Banheiro
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 		
	
	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraCozinha  	# Cozinha
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 		

	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraSala   	# Sala
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi 		

	movl 	(%edi), %eax
	pushl 	%eax
	pushl 	$txtMostraGaragem  	# Garagem
	call 	printf
	addl	$8, %esp
	addl 	$4, %edi

	fldl 	(%edi)
	subl 	$8, %esp 		
	fstl 	(%esp)
	pushl 	$txtMostraArea   	# Area
	call 	printf
	addl	$12, %esp
	addl 	$8, %edi 		

	fldl 	(%edi)
	subl 	$8, %esp 		
	fstl 	(%esp)
	pushl 	$txtMostraAluguel  	# Aluguel
	call 	printf
	addl	$12, %esp

	RET
