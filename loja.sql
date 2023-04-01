DROP TABLE pessoa, funcionario_vendedor, cliente, cliente_parcelas_pendentes, funcionario_vendedor_conta,
venda, loja, funcionario_gerente, funcionario_gerente_conta, funcionario_vendedor_comissao, estoque,
estoque_historico, estoque_historico_resp, produto, venda_garantia, produto_estoque, parcelas;

CREATE TABLE public.pessoa(
CPF VARCHAR(11),
nome VARCHAR(30),
telefone VARCHAR(11),
endereco VARCHAR(100),
data_de_nascimento DATE,
PRIMARY KEY (CPF)
);

CREATE TABLE public.funcionario_vendedor(
CPF_pessoa VARCHAR(11),
data_contrato DATE,
FOREIGN KEY(CPF_pessoa) REFERENCES pessoa(CPF),
PRIMARY KEY(CPF_pessoa)
);

CREATE TABLE public.cliente(
CPF_pessoa VARCHAR(11),
CPF_vendedor_responsavel VARCHAR(11),
FOREIGN KEY(CPF_pessoa) REFERENCES pessoa(CPF),
FOREIGN KEY(CPF_vendedor_responsavel) REFERENCES funcionario_vendedor(CPF_pessoa),
PRIMARY KEY(CPF_pessoa)
);


CREATE TABLE public.funcionario_vendedor_conta(
CPF_vendedor VARCHAR(11),
login VARCHAR (20),
senha VARCHAR (20),
FOREIGN KEY(CPF_vendedor) REFERENCES funcionario_vendedor(CPF_pessoa),
PRIMARY KEY(CPF_vendedor)
);

CREATE TABLE public.venda(
CPF_cliente VARCHAR(11),
numero_NF INT,
forma_pagamento VARCHAR (20),
data DATE,
CPF_vendedor VARCHAR (11),
FOREIGN KEY(CPF_cliente) REFERENCES cliente(CPF_pessoa),
FOREIGN KEY(CPF_vendedor) REFERENCES funcionario_vendedor(CPF_pessoa),
PRIMARY KEY(numero_NF)
);

CREATE TABLE public.parcelas(
numero_NF_venda INT,
valor REAL,
numero_parcela INT,
FOREIGN KEY(numero_NF_venda) REFERENCES venda(numero_NF),
PRIMARY KEY(numero_NF_venda,numero_parcela)
);

CREATE TABLE public.cliente_parcelas_pendentes(
CPF_cliente VARCHAR(11),
parcelas_pendetes INT,
numero_parcela INT,
FOREIGN KEY(CPF_cliente) REFERENCES cliente(CPF_pessoa),
FOREIGN KEY(parcelas_pendetes,numero_parcela) REFERENCES parcelas(numero_NF_venda,numero_parcela),
PRIMARY KEY(parcelas_pendetes,numero_parcela)
);

CREATE TABLE public.loja(
CNPJ VARCHAR(14),
nome VARCHAR(100),
endereco VARCHAR(100),
CPF_gerente VARCHAR(11),
PRIMARY KEY(CNPJ),
FOREIGN KEY(CPF_gerente) REFERENCES pessoa(CPF)
);

CREATE TABLE public.funcionario_gerente(
CPF_pessoa VARCHAR(11),
CNPJ_trabalha VARCHAR(14),
data_contrato DATE,
data_promocao DATE,
PRIMARY KEY(CPF_pessoa),
FOREIGN KEY(CPF_pessoa) REFERENCES pessoa(CPF),
FOREIGN KEY(CNPJ_trabalha) REFERENCES loja(CNPJ)
);

CREATE TABLE public.funcionario_gerente_conta(
CPF_pessoa VARCHAR(11),
login VARCHAR(15),
senha VARCHAR(12),
PRIMARY KEY(CPF_pessoa),
FOREIGN KEY(CPF_pessoa) REFERENCES funcionario_gerente(CPF_pessoa)
);

CREATE TABLE public.funcionario_vendedor_comissao(
CPF_vendedor VARCHAR(11),
comissao REAL,
CNPJ_trabalha VARCHAR(14),
PRIMARY KEY(CPF_vendedor),
FOREIGN KEY(CPF_vendedor) REFERENCES funcionario_vendedor(CPF_Pessoa),
FOREIGN KEY(CNPJ_trabalha) REFERENCES loja(CNPJ)
);

CREATE TABLE public.estoque(
CNPJ_loja VARCHAR(14),
status VARCHAR(5),
CPF_gerente VARCHAR(11),
PRIMARY KEY(CNPJ_loja),
FOREIGN KEY(CNPJ_loja) REFERENCES loja(CNPJ),
FOREIGN KEY(CPF_gerente) REFERENCES funcionario_gerente(CPF_pessoa)
);

CREATE TABLE public.estoque_historico(
CNPJ_loja VARCHAR(14),
protocolo VARCHAR(20),
data DATE,
PRIMARY KEY(protocolo),
FOREIGN KEY(CNPJ_loja) REFERENCES loja(CNPJ)
);

CREATE TABLE public.estoque_historico_resp(
protocolo VARCHAR(14),
descricao_atividade VARCHAR(100),
responsavel VARCHAR(30),
PRIMARY KEY(protocolo),
FOREIGN KEY(protocolo) REFERENCES estoque_historico(protocolo)
);


CREATE TABLE public.produto(
codigo_produto INT,
nome VARCHAR(30),
marca VARCHAR(30),
preco REAL,
descricao VARCHAR(100),
PRIMARY KEY(codigo_produto)
);

CREATE TABLE public.venda_garantia(
codigo_produto INT,
numero_NF INT,
comprovante_garantia VARCHAR(100),
PRIMARY KEY(codigo_produto, numero_NF),
FOREIGN KEY(codigo_produto) REFERENCES produto(codigo_produto),
FOREIGN KEY(numero_NF) REFERENCES venda(numero_NF)
);

CREATE TABLE public.produto_estoque(
codigo_produto INT,
quantidade_estoque INT,
CNPJ_estoque VARCHAR(14),
PRIMARY KEY(codigo_produto),
FOREIGN KEY(codigo_produto) REFERENCES produto(codigo_produto),
FOREIGN KEY(CNPJ_estoque) REFERENCES estoque(CNPJ_loja)
);

--pessoa
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('74589632104','Ricardo Ferreira','999999999','Rua 39, n°965',TO_DATE('07/08/1952', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('99989632105','Catarina Silva','877888885','Rua 40,n°741',TO_DATE('18/12/1972', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('34652652106','Fabiano Barbosa','966665552','Av. Brasil, n°7856',TO_DATE('24/02/1980', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('94645352133','Maria Oliveira','632253322','Chácara Recanto do sol, saída inhumas',TO_DATE('01/10/1974', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('49600003562','Carlos Brandão','114522223','Rua florença, n°004',TO_DATE('30/01/2000', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento) 
values ('88852463223','Juliana Pereira','888866655','Rua 98, n°1112',TO_DATE('28/09/1994', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento)
values ('44416823010','Bruno Feliciano', '46857965', 'Rua 52, nº250', TO_DATE('03/04/1972', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento)
values ('46302756065', 'Jean Rodrigues', '35648742', 'Residencial Flamboyant', TO_DATE('09/08/1976', 'DD/MM/YYYY'));
INSERT INTO pessoa(CPF, nome, telefone, endereco,data_de_nascimento)
values ('45150634050', 'Gabriel Martinelli', '61984587632', 'Av Jose Martins, nº 555', TO_DATE('11/07/1986', 'DD/MM/YYYY'));

--funcionário_vendedor
INSERT INTO funcionario_vendedor(CPF_pessoa, data_contrato) 
values('88852463223',TO_DATE('22/04/2019', 'DD/MM/YYYY'));
INSERT INTO funcionario_vendedor(CPF_pessoa, data_contrato) 
values('49600003562',TO_DATE('10/12/2021', 'DD/MM/YYYY'));

--cliente
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('74589632104','88852463223');
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('99989632105','88852463223');
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('34652652106','49600003562');
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('44416823010','49600003562');
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('46302756065','49600003562');
INSERT INTO cliente(CPF_pessoa, CPF_vendedor_responsavel)
values('45150634050','88852463223');

--funcio_vended_conta
INSERT INTO funcionario_vendedor_conta(CPF_vendedor, login, senha)
values('88852463223','JuP321','pereira123');
INSERT INTO funcionario_vendedor_conta(CPF_vendedor, login, senha)
values('49600003562','CaB123','brandao123');

--venda
INSERT INTO venda(CPF_cliente, numero_NF, forma_pagamento, data, CPF_vendedor)
values('74589632104',1111,'cartão credito',TO_DATE('01/02/2021', 'DD/MM/YYYY'),'88852463223');
INSERT INTO venda(CPF_cliente, numero_NF, forma_pagamento, data, CPF_vendedor)
values('99989632105',2222,'a vista',TO_DATE('02/02/2021', 'DD/MM/YYYY'),'88852463223');
INSERT INTO venda(CPF_cliente, numero_NF, forma_pagamento, data, CPF_vendedor)
values('34652652106',3333,'crediario',TO_DATE('05/02/2021', 'DD/MM/YYYY'),'49600003562');
INSERT INTO venda(CPF_cliente, numero_NF, forma_pagamento, data, CPF_vendedor)
values('74589632104',4444,'a vista',TO_DATE('22/05/2021', 'DD/MM/YYYY'),'88852463223');
INSERT INTO venda(CPF_cliente, numero_NF, forma_pagamento, data, CPF_vendedor)
values('99989632105',5555,'crediario',TO_DATE('10/11/2021', 'DD/MM/YYYY'),'49600003562');

--parcelas
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(1111,150.50,1);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(2222,82.25,1);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(3333,99.00,1);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(3333,99.00,2);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(4444,10.50,1);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(5555,55.00,1);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(5555,55.00,2);
INSERT INTO parcelas(numero_NF_venda,valor,numero_parcela)
values(5555,55.00,3);

--parcelas pendentes
INSERT INTO cliente_parcelas_pendentes(CPF_cliente,parcelas_pendetes,numero_parcela)
values('34652652106',3333,2);
INSERT INTO cliente_parcelas_pendentes(CPF_cliente,parcelas_pendetes,numero_parcela)
values('99989632105',5555,2);
INSERT INTO cliente_parcelas_pendentes(CPF_cliente,parcelas_pendetes,numero_parcela)
values('99989632105',5555,3);

--loja
INSERT INTO loja(CNPJ,nome,endereco,CPF_gerente)
values ('9632587412541','Lojas Eletrônicos','Av. João Correia, n°123, Centro','94645352133');

--funcionario_gerente
INSERT INTO funcionario_gerente(CPF_pessoa,CNPJ_trabalha,data_contrato,data_promocao)
values ('94645352133','9632587412541',TO_DATE('14/12/2016', 'DD/MM/YYYY'),TO_DATE('27/04/2019', 'DD/MM/YYYY'));

--funcionario_gerente_conta
INSERT INTO funcionario_gerente_conta(CPF_pessoa, login, senha)
values('94645352133','MOliv741','MariOli965');

--funcionario_vendedor_comissao
INSERT INTO funcionario_vendedor_comissao(CPF_vendedor,comissao,CNPJ_trabalha)
values ('88852463223',100.00,'9632587412541');
INSERT INTO funcionario_vendedor_comissao(CPF_vendedor,comissao,CNPJ_trabalha)
values ('49600003562',200.00,'9632587412541');

--estoque
INSERT INTO estoque(CNPJ_loja,status,CPF_gerente)
values('9632587412541','cheio','94645352133');

--estoque_historico
INSERT INTO estoque_historico(CNPJ_loja,protocolo,data)
values ('9632587412541','MU100',TO_DATE('01/10/2021', 'DD/MM/YYYY'));
INSERT INTO estoque_historico(CNPJ_loja,protocolo,data)
values ('9632587412541','ADD101',TO_DATE('02/10/2021', 'DD/MM/YYYY'));
INSERT INTO estoque_historico(CNPJ_loja,protocolo,data)
values ('9632587412541','REM102',TO_DATE('22/10/2021', 'DD/MM/YYYY'));
INSERT INTO estoque_historico(CNPJ_loja,protocolo,data)
values ('9632587412541','ADD103',TO_DATE('10/11/2021', 'DD/MM/YYYY'));

--estoque_historico_resp
INSERT INTO estoque_historico_resp(protocolo,descricao_atividade,responsavel)
values ('MU100','mudança de preço','94645352133');
INSERT INTO estoque_historico_resp(protocolo,descricao_atividade,responsavel)
values ('ADD101','adição quantidade produto','94645352133');
INSERT INTO estoque_historico_resp(protocolo,descricao_atividade,responsavel)
values ('REM102','remoção de produto do estoque','94645352133');
INSERT INTO estoque_historico_resp(protocolo,descricao_atividade,responsavel)
values ('ADD103','adição de produto','94645352133');

--produto
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111111,'Cabo usb','Samsung',39.99,'Cabo de Dados usb tipo C Galaxy s8/note 8 Original, pode confiar!');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111112,'Fonte Carregador Note','Assus',99.50,'Para Asus Zenbook X556u 19v 3.42a 65w 816');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111113,'Monitor','HQ',359.10,'17.1 polegadas HD, VGA, HDMI 1.4, Ajuste De  ngulo');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111114,'Smartphone','Moto E20',100.00,'32GB, 2GB RAM, Octa Core, Câmera 13MP');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111115,'mousepad','Havit',49.99,'Extra Grande, Multispandex, Preto');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111116,'Cadeira gamer','Prizi',538.77,'Com Almofadas na lombar e pescoço, Azul');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111117,'Mouse','Logitech',31.99,'Design Ambidestro e Facilidade Plug and Play');
INSERT INTO produto(codigo_produto,nome,marca,preco,descricao)
values(11111118,'Teclado mecanico','HyperX',399.99,'Liga a luzinha(RGB)');

--venda_garantia
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111111,1111,'cabo garantia de 1 mês');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111115,2222,'mousepad garantia 6 meses');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111113,3333,'monitor garantia 1 anos');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111115,3333,'mousepad garantia 6 meses');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111117,3333,'mouse garantia de 6 meses');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111112,4444,'fonte carregador assus garantia 9 meses');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111116,5555,'cadeira gamer garantia de 2 anos');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111111,5555,'cabo garantia de 1 mês');
INSERT INTO venda_garantia(codigo_produto,numero_NF,comprovante_garantia)
values (11111118,5555,'teclado mecanico garantia de 7 meses');

--produto-estoque
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111111,80,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111112,50,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111113,44,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111114,20,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111115,15,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111116,10,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111117,55,'9632587412541');
INSERT INTO produto_estoque(codigo_produto,quantidade_estoque,CNPJ_estoque)
values (11111118,38,'9632587412541');

-- Desconto de 20%
UPDATE produto SET preco = preco * 0.8;

-- Deletar um cliente
DELETE FROM cliente
WHERE cpf_pessoa = '45150634050'