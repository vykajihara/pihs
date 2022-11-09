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

	txtNovoCadastro: 	.asciz 	"\n\n- NOVO CADASTRO -\n"
	txtRelatorio:	 	.asciz 	"\n\n- RELATORIO DE REGISTROS -\n"
	txtListaVazia: 		.asciz 	"\nNAO EXISTEM IMOVEIS CADASTRADOS!\n"
	txtMostraReg:	 	.asciz 	"\n\n\n\n	---> REGISTRO NUMERO #%d\n"
	txtRemocao:		 	.asciz 	"\n\n- REMOCAO DE REGISTROS -\n"
	txtRemoveReg: 		.asciz 	"\n 	REMOVENDO REGISTRO N.%d COM %d COMODOS ...\n"
	txtConsulta: 		.asciz 	"\n\n- CONSULTA REGISTROS -\n"
	txtRecupera: 		.asciz 	"\n\n- RECUPERA REGISTROS -\n"
	txtGrava: 			.asciz 	"\n\n- GRAVA REGISTROS -\n"
	txtPronto: 			.asciz 	"	... pronto! \n\n" 

	txtPedeComodos: 	.asciz 	"\nInforme a quantidade de comodos => "

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
	txtPedeBanheiro:	.asciz	"\nPossui banheiro social? <s>/<n>: "
	txtPedeCozinha:		.asciz	"\nPossui cozinha? <s>/<n>: "
	txtPedeSala:		.asciz	"\nPossui sala? <s>/<n>: "
	txtPedeGaragem: 	.asciz	"\nPossui garagem? <s>/<n>: "
	txtPedeArea:		.asciz	"\nArea total: "
	txtPedeAluguel:		.asciz	"\nValor do aluguel: "

	txtMostraNome:		.asciz	"\n 	Nome: %s"
	txtMostraCPF:		.asciz	"\n 	CPF: %s" 
	txtMostraCel:		.asciz  "\n 	Celular: %s"
	txtMostraTipoIm: 	.asciz	"\n 	Tipo de imovel <C>asa/<A>partamento: %s"
	txtMostraCidade:	.asciz	"\n 	Endereco\n 	Cidade: %s"
	txtMostraBairro:	.asciz	" 	Bairro: %s"
	txtMostraRua:		.asciz	" 	Rua: %s"
	txtMostraNumero: 	.asciz 	" 	Numero: %d\n"
	txtMostraQuartos:	.asciz 	"\n 	Quantidade de quartos simples: %d\n" 
	txtMostraSuites:	.asciz 	"\n 	Quantidade de suites: %d\n" 
	txtMostraBanheiro:	.asciz	"\n 	Possui banheiro social? <s>/<n>: %c\n"
	txtMostraCozinha:	.asciz	"\n 	Possui cozinha? <s>/<n>: %c\n"
	txtMostraSala:		.asciz	"\n 	Possui sala? <s>/<n>: %c\n"
	txtMostraGaragem: 	.asciz	"\n 	Possui garagem? <s>/<n>: %c\n"
	txtMostraArea:		.asciz	"\n 	Area total: %.2lf\n"
	txtMostraAluguel:	.asciz	"\n 	Valor do aluguel: R$ %.2lf\n"

	nomeArq: 			.asciz 	"registros.txt"
	descritor: 	.int 0
	O_RDONLY: 	.int 0x0000 # somente leitura
	O_WRONLY: 	.int 0x0001 # somente escrita
#	O_RDWR:   	.int 0x0002 # leitura e escrita
	O_CREAT:  	.int 0x0040 # cria o arquivo na abertura, caso ele não exista
#	O_EXCL:   	.int 0x0080 # força a criação
#	O_APPEND: 	.int 0x0400 # posiciona o cursor do arquivo no final, para adição
	O_TRUNC:  	.int 0x0200 # reseta o arquivo aberto, deixando com tamanho 0 (zero)
#	S_IRWXU: 	.int 0x01C0 # user (file owner) has read, write and execute permission
	S_IRUSR: 	.int 0x0100 # user has read permission
	S_IWUSR: 	.int 0x0080 # user has write permission
#	S_IXUSR: 	.int 0x0040 # user has execute permission
#	S_IRWXG: 	.int 0x0038 # group has read, write and execute permission
#	S_IRGRP: 	.int 0x0020 # group has read permission
#	S_IWGRP: 	.int 0x0010 # group has write permission
#	S_IXGRP: 	.int 0x0008 # group has execute permission
#	S_IRWXO: 	.int 0x0007 # others have read, write and execute permission
#	S_IROTH: 	.int 0x0004 # others have read permission
#	S_IWOTH: 	.int 0x0002 # others have write permission
#	S_IXOTH: 	.int 0x0001 # others have execute permission
#	S_NADA:  	.int 0x0000 # não altera a situação
#	SYS_EXIT: 	.int 1
#	SYS_FORK: 	.int 2
	SYS_READ: 	.int 3
	SYS_WRITE: 	.int 4
	SYS_OPEN: 	.int 5
	SYS_CLOSE: 	.int 6
#	SYS_CREAT: 	.int 8

	txtLimpaTela:		.asciz	"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	pulaLinha: 			.asciz 	"\n"
	
	tipoInt: 	.asciz 	"%d"
	tipoChar:	.asciz	" %c"
	tipoDouble: .asciz 	"%lf"

	limpaBuf: 	.asciz 	"%*c"
	
	opcao: 		.int 	0
	tamReg:  	.int 	244
	tamCampos: 	.int 	240
	qtdComodos:	.int 	0 	

	# ponteiros
	listaPtr: 	.space 	4 	# ponteiro para o primeiro elemento da lista de registros
	regPtr:		.space	4 	# ponteiro para o registro que será lido
	auxPtr:	 	.space 	4 	# ponteiro auxiliar
	NULL:		.space 	4 	
	
.section .text
.globl _start
_start:

	movl  	$NULL, listaPtr 	# incializa listaPtr (lista vazia)

_menu:
	finit

	pushl	$txtAbertura
	call	printf
	pushl 	$txtMenu
	call 	printf
	addl	$8, %esp

	pushl 	$opcao
	pushl  	$tipoInt
	call  	scanf
	addl 	$8, %esp

	call  	trataOpcao

	jmp 	_menu

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
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtNovoCadastro
	call 	printf
	addl 	$8, %esp

	call  	alocaMemoria
	call  	leReg

	cmpl  	$NULL, listaPtr
	jne  	insereLista

	movl 	regPtr, %eax
	movl 	%eax, listaPtr

	RET

alocaMemoria:		
	pushl	tamReg
	call	malloc
	movl	%eax, regPtr	
	addl 	$4, %esp

	RET

leReg:
	pushl 	$limpaBuf
	call 	scanf
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

	movl 	$NULL, (%edi)  		# proxPtr := NULL
	
	RET

insereLista:
	# insere ordenadamente o elemento lido na lista
	movl 	regPtr, %esi 	# esi é usado na func contaComodos
	call 	contaComodos 	# calcula comodos do reg a ser inserido
	movl 	%eax, %ebx  	# ebx guarda qtd de comodos do reg a ser inserido

	movl 	listaPtr, %edi
	movl 	%edi, %esi 		# atualiza esi para o primeiro da lista
	call  	contaComodos

	cmpl 	%eax, %ebx
	jl  	insereInicio

volta2:	
	movl 	%edi, auxPtr # guarda o valor do registro anterior

	addl 	tamCampos, %edi # atualiza edi para o 	
	movl 	(%edi), %edi  	# prox elem
	cmpl 	$NULL, %edi
	je 		insereFim  	
	
	movl 	%edi, %esi 		
	call  	contaComodos

	cmpl 	%eax, %ebx
	jge  	volta2
	
	movl 	auxPtr, %ecx # recupera o valor do reg anterior em ecx

	movl 	regPtr, %eax
	addl 	tamCampos, %ecx
	movl 	%eax, (%ecx)
	addl 	tamCampos, %eax
	movl 	%edi, (%eax)
	
	RET

insereInicio:
	movl 	regPtr, %eax
	movl 	%eax, listaPtr 	
	addl 	tamCampos, %eax 	
	movl 	%edi, (%eax)
	
	RET

insereFim:
	movl 	auxPtr, %edi
	addl 	tamCampos, %edi
	movl 	regPtr, %eax
	movl 	%eax, (%edi)
	
	RET

contaComodos:
	# cômodos = quartos + suítes + outros cômodos
	# cômodos marcados com <s> => incl cômodos
	# 					   <n> (ou qualquer outra coisa) => não soma
	
	# Usa os registradores -> esi, eax, ecx, edx

	# esi caminha pelos campos do reg
	# ESI DEVE SER INICIALIZADO ONDE contaComodos É CHAMADA
	addl 	$200, %esi  	# 200 -> posição do campo "número de quartos"

	movl 	$0, %eax 		# RESULTADO RETORNARÁ EM EAX
	addl 	(%esi), %eax	# + quartos
	addl 	$4, %esi

	addl 	(%esi), %eax 	# + suites
	addl 	$4, %esi

	movl 	$4, %ecx  		# 4 campos s/n

loop1:
	movb  	(%esi), %dl 
	cmpb	$'s', %dl
	je 		respostaSim

volta1: 
	addl 	$4, %esi
	loop 	loop1
	
	RET

respostaSim:
	incl  	%eax
	jmp 	volta1


/***************************************************************
	
	REMOÇÃO

		Remove todos os registro com um determinado numero de 
	comodos (informado pelo usuario)

  **************************************************************/

remocao:
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtRemocao
	call 	printf
	addl 	$8, %esp

	movl 	listaPtr, %eax
	cmpl 	$NULL, %eax
	je  	informaListaVazia

	call 	pedeComodos

	# inicializacoes
	movl 	listaPtr, %edi 		# edi -> iterar na lista
	movl 	%edi, auxPtr 		# auxPtr guarda o endereco do anterior ao edi
	movl 	$1, %esi 			# esi -> variavel para controle (print)

loopRemocao:
	pushl	%esi
	movl 	%edi, %esi 
	call  	contaComodos
	popl	%esi

	cmpl 	%eax, qtdComodos
	jg  	atualizaPtrRemocao
	je  	removeRegistro

	RET

atualizaPtrRemocao:
	movl 	%edi, auxPtr
	addl 	tamCampos, %edi
	movl 	(%edi), %edi
	cmpl 	$NULL, %edi 		# se for igual -> fim da lista
	jne		loopRemocao

	RET

removeRegistro:
	pushl 	qtdComodos
	pushl 	%esi
	pushl	$txtRemoveReg
	call 	printf
	addl 	$12, %esp
	incl 	%esi

	cmpl 	listaPtr, %edi
	je  	removePrimeiro

	movl 	auxPtr, %eax 		
	addl 	tamCampos, %eax
	movl 	%edi, %ebx
	addl 	tamCampos, %ebx
	movl 	(%ebx), %ebx 		# endereco do prox
	movl 	%ebx, (%eax) 		# atribui prox edereco ao campo prox do reg anterior

letItGo:
	pushl 	%ebx
	pushl 	%edi 
	call  	free
	addl 	$4, %esp
	popl 	%ebx

	cmpl 	$NULL, %ebx
	je 		retorno

	addl 	tamCampos, %edi
	movl 	(%edi), %edi
	cmpl 	$NULL, %edi 		
	jne		loopRemocao

removePrimeiro:
	movl 	%edi, %eax
	addl 	tamCampos, %eax
	movl 	(%eax), %eax
	movl 	%eax, listaPtr
	cmpl 	$NULL, %eax
	jne  	letItGo

	RET


/***************************************************************
	
	CONSULTA

		Imprime todos os registros com um determinado numero de 
	comodos (informado pelo usuario)

  **************************************************************/

consulta:   
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtConsulta
	call 	printf
	addl 	$8, %esp

	movl 	listaPtr, %eax
	movl 	%eax, regPtr 		# regPtr é usado p/ mostrar o registro
	cmpl 	$NULL, %eax
	je  	informaListaVazia

	call 	pedeComodos

	movl 	$1, %esi 			# contador de registros p/ impressao

buscaRegConsulta:	
	cmpl 	$NULL, regPtr 	
	je  	retorno
	pushl 	%esi 				# backup
	movl 	regPtr, %esi
	call 	contaComodos
	popl 	%esi

	cmpl 	%eax, qtdComodos 	# a lista esta ordenada, entao
	jg 		contBuscaConsulta 	# 	se o atual é menor -> continua iteracao
	je 		imprimeRegConsulta	# 	se o atual é igual -> imprime

retorno:
	RET 						# 	se o atual é maior -> retorna ao menu

contBuscaConsulta:
	movl 	regPtr, %eax
	addl 	tamCampos, %eax 	
	movl  	(%eax), %eax
	movl 	%eax, regPtr

	jmp 	buscaRegConsulta

imprimeRegConsulta:
	pushl  	%esi
	pushl 	$txtMostraReg
	call  	printf
	addl  	$8, %esp

	call  	mostraReg

	incl 	%esi

	jmp 	contBuscaConsulta

pedeComodos:	
	pushl 	$txtPedeComodos
	call 	printf
	addl 	$4, %esp

	pushl 	$qtdComodos
	pushl 	$tipoInt
	call 	scanf
	addl 	$8, %esp

	cmpl 	$0, qtdComodos
	jle  	pedeComodos  	# verificacao: qtdComodos > 0

	RET

/***************************************************************
	
	GRAVAR 

		Grava no arquivo a lista de registros que esta na memoria,
	sobrescrevendo o que esta no arquivo.

  **************************************************************/

gravar:
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtGrava
	call 	printf
	addl 	$8, %esp

	call 	abreArqGravar
	call  	gravaLista
	call  	fechaArquivo

	pushl 	$txtPronto
	call  	printf
	addl 	$4, %esp

	RET

abreArqGravar:
	movl 	SYS_OPEN, %eax 		# system call OPEN: retorna o descritor em %eax
	movl 	$nomeArq, %ebx 		
	movl 	O_WRONLY, %ecx 		# somente escrita
	orl 	O_CREAT, %ecx 		# cria o arquivo na abertura, caso nao exista
	orl 	O_TRUNC, %ecx 		# "reinicia" o arquivo
	movl 	S_IRUSR, %edx
	orl 	S_IWUSR, %edx
	int 	$0x80
	movl 	%eax, descritor 	# guarda o descritor

	RET

gravaLista:
	movl 	listaPtr, %edi
proxReg:
	movl 	%edi, regPtr
	call  	gravaReg
	addl 	tamCampos, %edi
	movl 	(%edi), %edi
	cmpl 	$NULL, %edi
	jne  	proxReg

	RET

gravaReg:	
	movl 	SYS_WRITE, %eax
	movl 	descritor, %ebx 
	movl 	regPtr, %ecx
	movl 	tamCampos, %edx
	int 	$0x80

	RET

fechaArquivo:
	movl 	SYS_CLOSE, %eax
	movl 	descritor, %ebx # recupera o descritor
	int 	$0x80

	RET


/***************************************************************
	
	RECUPERAR

		Recupera todos os registros do arquivo, inserindo-os 
	na lista que se encontra na memoria.

  **************************************************************/

recuperar:
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtRecupera
	call 	printf
	addl 	$8, %esp

	call 	abreArqRecuperar
	call 	recuperaRegs
	call 	fechaArquivo

	pushl 	$txtPronto
	call  	printf
	addl 	$4, %esp

	RET

abreArqRecuperar:
	movl 	SYS_OPEN, %eax 	
	movl 	$nomeArq, %ebx
	movl 	O_RDONLY, %ecx
	int 	$0x80
	movl 	%eax, descritor 

	RET

recuperaRegs:
	call 	alocaMemoria
	movl 	SYS_READ, %eax 		# %eax retorna numero de bytes lidos
	movl 	descritor, %ebx 
	movl 	regPtr, %ecx
	movl 	tamCampos, %edx
	int 	$0x80 				# le registro do arquivo
	movl 	regPtr, %edi

	cmpl 	$0, %eax
	je	 	retorno

	addl 	tamCampos, %edi
	movl 	$NULL, (%edi)

	cmpl  	$NULL, listaPtr
	jne  	callInsereLista

	movl 	regPtr, %eax
	movl 	%eax, listaPtr

	jmp 	recuperaRegs

callInsereLista:
	call  	insereLista
	jmp  	recuperaRegs


/***************************************************************
	
	RELATÓRIO

		Mostra todos os registros na tela

  **************************************************************/

relatorio:
	movl 	$0, %esi # contador de registros
	
	pushl 	$txtLimpaTela
	call 	printf
	pushl 	$txtRelatorio
	call 	printf
	addl 	$8, %esp

	cmpl 	$NULL, listaPtr
	je  	informaListaVazia

	movl 	listaPtr, %eax
	movl 	%eax, regPtr 		# aqui regPtr sera usado
								# para iterar os elem da lista
checkRegPtr:	
	cmpl 	$NULL, regPtr 	
	jne  	imprimeReg

	RET

imprimeReg:
	incl 	%esi
	pushl	%esi
	pushl 	$txtMostraReg
	call  	printf
	addl 	$8, %esp

	call  	mostraReg
	movl 	tamCampos, %eax 	
	movl 	regPtr, %ebx 
	addl 	%eax, %ebx  		# desloca tamCampos do endereco do registro
								# para ler o endereco do proximo
	movl 	(%ebx), %eax
	movl  	%eax,  regPtr
	jmp  	checkRegPtr

informaListaVazia:
	pushl 	$txtListaVazia
	call 	printf
	addl 	$4, %esp

	RET

mostraReg:
	# edi -> ponteiro que percorre os campos
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
