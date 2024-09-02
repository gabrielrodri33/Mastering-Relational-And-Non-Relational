 

DROP TABLE movimento_estoque CASCADE CONSTRAINTS;

CREATE TABLE movimento_estoque (
       SEQ_MOVIMENTO_ESTOQUE NUMBER(15) NOT NULL,
       COD_PRODUTO          NUMBER(10) NULL,
       DAT_MOVIMENTO_ESTOQUE DATE NULL,
       QTD_MOVIMENTACAO_ESTOQUE INTEGER NULL,
       COD_TIPO_MOVIMENTO_ESTOQUE NUMBER(2) NULL
);

CREATE UNIQUE INDEX XPKmovimento_estoque ON movimento_estoque
(
       SEQ_MOVIMENTO_ESTOQUE          ASC
);

CREATE INDEX XIF1movimento_estoque ON movimento_estoque
(
       COD_PRODUTO                    ASC
);

CREATE INDEX XIF2movimento_estoque ON movimento_estoque
(
       COD_TIPO_MOVIMENTO_ESTOQUE     ASC
);


ALTER TABLE movimento_estoque
       ADD CONSTRAINT XPKmovimento_estoque PRIMARY KEY (
              SEQ_MOVIMENTO_ESTOQUE);


DROP TABLE produto_composto CASCADE CONSTRAINTS;

CREATE TABLE produto_composto (
       COD_PRODUTO_RELACIONADO NUMBER(10) NOT NULL,
       COD_PRODUTO          NUMBER(10) NOT NULL,
       QTD_PRODUTO          NUMBER(6) NULL,
       QTD_PRODUTO_RELACIONADO NUMBER(6) NULL,
       STA_ATIVO            CHAR(1) NULL,
       DAT_CADASTRO         DATE NULL,
       DAT_CANCELAMENTO     DATE NULL
);

CREATE UNIQUE INDEX XPKproduto_composto ON produto_composto
(
       COD_PRODUTO_RELACIONADO        ASC,
       COD_PRODUTO                    ASC
);

CREATE INDEX XIF1produto_composto ON produto_composto
(
       COD_PRODUTO                    ASC
);

CREATE INDEX XIF2produto_composto ON produto_composto
(
       COD_PRODUTO_RELACIONADO        ASC
);


ALTER TABLE produto_composto
       ADD CONSTRAINT XPKproduto_composto PRIMARY KEY (
              COD_PRODUTO_RELACIONADO, COD_PRODUTO);


DROP TABLE historico_pedido CASCADE CONSTRAINTS;

CREATE TABLE historico_pedido (
       SEQ_HISTORICO_PEDIDO INTEGER NOT NULL,
       COD_PEDIDO           NUMBER(10) NOT NULL,
       COD_CLIENTE          NUMBER(10) NULL,
       DAT_PEDIDO           DATE NULL,
       DAT_CANCELAMENTO     DATE NULL,
       DAT_ENTREGA          DATE NULL,
       VAL_TOTAL_PEDIDO     NUMBER(12,2) NULL,
       VAL_DESCONTO         NUMBER(12,2) NULL,
       SEQ_ENDERECO_CLIENTE NUMBER(10) NULL,
       COD_VENDEDOR         NUMBER(4) NULL
);

CREATE UNIQUE INDEX XPKhistorico_pedido ON historico_pedido
(
       SEQ_HISTORICO_PEDIDO           ASC
);

CREATE INDEX XIF1historico_pedido ON historico_pedido
(
       SEQ_ENDERECO_CLIENTE           ASC
);

CREATE INDEX XIF2historico_pedido ON historico_pedido
(
       COD_CLIENTE                    ASC
);

CREATE INDEX XIF4historico_pedido ON historico_pedido
(
       COD_PEDIDO                     ASC
);

CREATE INDEX XIF5historico_pedido ON historico_pedido
(
       COD_VENDEDOR                   ASC
);


ALTER TABLE historico_pedido
       ADD CONSTRAINT XPKhistorico_pedido PRIMARY KEY (
              SEQ_HISTORICO_PEDIDO);


DROP TABLE item_pedido CASCADE CONSTRAINTS;

CREATE TABLE item_pedido (
       COD_PEDIDO           NUMBER(10) NOT NULL,
       COD_ITEM_PEDIDO      INTEGER NOT NULL,
       COD_PRODUTO          NUMBER(10) NULL,
       QTD_ITEM             NUMBER(10) NULL,
       VAL_UNITARIO_ITEM    NUMBER(12,2) NULL,
       VAL_DESCONTO_ITEM    NUMBER(12,2) NULL
);

CREATE UNIQUE INDEX XPKitem_pedido ON item_pedido
(
       COD_PEDIDO                     ASC,
       COD_ITEM_PEDIDO                ASC
);

CREATE INDEX XIF1item_pedido ON item_pedido
(
       COD_PEDIDO                     ASC
);

CREATE INDEX XIF2item_pedido ON item_pedido
(
       COD_PRODUTO                    ASC
);


ALTER TABLE item_pedido
       ADD CONSTRAINT XPKitem_pedido PRIMARY KEY (COD_PEDIDO, 
              COD_ITEM_PEDIDO);


DROP TABLE pedido CASCADE CONSTRAINTS;

CREATE TABLE pedido (
       COD_PEDIDO           NUMBER(10) NOT NULL,
       COD_PEDIDO_RELACIONADO NUMBER(10) NULL,
       COD_CLIENTE          NUMBER(10) NULL,
       COD_USUARIO          NUMBER(5) NULL,
       COD_VENDEDOR         NUMBER(4) NULL,
       DAT_PEDIDO           DATE NULL,
       DAT_CANCELAMENTO     DATE NULL,
       DAT_ENTREGA          DATE NULL,
       VAL_TOTAL_PEDIDO     NUMBER(12,2) NULL,
       VAL_DESCONTO         NUMBER(12,2) NULL,
       SEQ_ENDERECO_CLIENTE NUMBER(10) NULL
);

CREATE UNIQUE INDEX XPKpedido ON pedido
(
       COD_PEDIDO                     ASC
);

CREATE INDEX XIF1pedido ON pedido
(
       COD_CLIENTE                    ASC
);

CREATE INDEX XIF2pedido ON pedido
(
       SEQ_ENDERECO_CLIENTE           ASC
);

CREATE INDEX XIF3pedido ON pedido
(
       COD_PEDIDO_RELACIONADO         ASC
);

CREATE INDEX XIF4pedido ON pedido
(
       COD_VENDEDOR                   ASC
);

CREATE INDEX XIF5pedido ON pedido
(
       COD_USUARIO                    ASC
);


ALTER TABLE pedido
       ADD CONSTRAINT XPKpedido PRIMARY KEY (COD_PEDIDO);


DROP TABLE usuario CASCADE CONSTRAINTS;

CREATE TABLE usuario (
       COD_USUARIO          NUMBER(5) NOT NULL,
       NOM_USUARIO          VARCHAR2(50) NULL,
       STA_ATIVO            CHAR(1) NULL
);

CREATE UNIQUE INDEX XPKusuario ON usuario
(
       COD_USUARIO                    ASC
);


ALTER TABLE usuario
       ADD CONSTRAINT XPKusuario PRIMARY KEY (COD_USUARIO);


DROP TABLE cliente_vendedor CASCADE CONSTRAINTS;

CREATE TABLE cliente_vendedor (
       COD_CLIENTE          NUMBER(10) NOT NULL,
       COD_VENDEDOR         NUMBER(4) NOT NULL,
       DAT_INICIO           DATE NOT NULL,
       DAT_TERMINO          DATE NULL
);

CREATE UNIQUE INDEX XPKcliente_vendedor ON cliente_vendedor
(
       COD_CLIENTE                    ASC,
       COD_VENDEDOR                   ASC,
       DAT_INICIO                     ASC
);

CREATE INDEX XIF1cliente_vendedor ON cliente_vendedor
(
       COD_CLIENTE                    ASC
);

CREATE INDEX XIF2cliente_vendedor ON cliente_vendedor
(
       COD_VENDEDOR                   ASC
);


ALTER TABLE cliente_vendedor
       ADD CONSTRAINT XPKcliente_vendedor PRIMARY KEY (COD_CLIENTE, 
              COD_VENDEDOR, DAT_INICIO);


DROP TABLE vendedor CASCADE CONSTRAINTS;

CREATE TABLE vendedor (
       COD_VENDEDOR         NUMBER(4) NOT NULL,
       NOM_VENDEDOR         VARCHAR2(50) NULL,
       STA_ATIVO            CHAR(1) NULL
);

CREATE UNIQUE INDEX XPKvendedor ON vendedor
(
       COD_VENDEDOR                   ASC
);


ALTER TABLE vendedor
       ADD CONSTRAINT XPKvendedor PRIMARY KEY (COD_VENDEDOR);


DROP TABLE endereco_cliente CASCADE CONSTRAINTS;

CREATE TABLE endereco_cliente (
       SEQ_ENDERECO_CLIENTE NUMBER(10) NOT NULL,
       COD_TIPO_ENDERECO    NUMBER(2) NULL,
       COD_CLIENTE          NUMBER(10) NULL,
       DES_ENDERECO         VARCHAR2(80) NULL,
       NUM_ENDERECO         VARCHAR2(10) NULL,
       DES_COMPLEMENTO      VARCHAR2(20) NULL,
       NUM_CEP              NUMBER(9) NULL,
       DES_BAIRRO           VARCHAR2(50) NULL,
       COD_CIDADE           NUMBER(6) NULL,
       STA_ATIVO            CHAR(1) NULL,
       DAT_CADASTRO         DATE NULL,
       DAT_CANCELAMENTO     VARCHAR2(20) NULL
);

CREATE UNIQUE INDEX XPKendereco_cliente ON endereco_cliente
(
       SEQ_ENDERECO_CLIENTE           ASC
);

CREATE INDEX XIF1endereco_cliente ON endereco_cliente
(
       COD_CLIENTE                    ASC
);

CREATE INDEX XIF2endereco_cliente ON endereco_cliente
(
       COD_TIPO_ENDERECO              ASC
);

CREATE INDEX XIF3endereco_cliente ON endereco_cliente
(
       COD_CIDADE                     ASC
);


ALTER TABLE endereco_cliente
       ADD CONSTRAINT XPKendereco_cliente PRIMARY KEY (
              SEQ_ENDERECO_CLIENTE);


DROP TABLE tipo_endereco CASCADE CONSTRAINTS;

CREATE TABLE tipo_endereco (
       COD_TIPO_ENDERECO    NUMBER(2) NOT NULL,
       DES_TIPO_ENDERECO    VARCHAR2(50) NULL
);

CREATE UNIQUE INDEX XPKtipo_endereco ON tipo_endereco
(
       COD_TIPO_ENDERECO              ASC
);


ALTER TABLE tipo_endereco
       ADD CONSTRAINT XPKtipo_endereco PRIMARY KEY (COD_TIPO_ENDERECO);


DROP TABLE estoque_produto CASCADE CONSTRAINTS;

CREATE TABLE estoque_produto (
       COD_PRODUTO          NUMBER(10) NOT NULL,
       COD_ESTOQUE          NUMBER(4) NOT NULL,
       DAT_ESTOQUE          DATE NOT NULL,
       QTD_PRODUTO          NUMBER(10) NULL
);

CREATE UNIQUE INDEX XPKestoque_produto ON estoque_produto
(
       COD_PRODUTO                    ASC,
       COD_ESTOQUE                    ASC,
       DAT_ESTOQUE                    ASC
);

CREATE INDEX XIF1estoque_produto ON estoque_produto
(
       COD_PRODUTO                    ASC
);

CREATE INDEX XIF2estoque_produto ON estoque_produto
(
       COD_ESTOQUE                    ASC
);


ALTER TABLE estoque_produto
       ADD CONSTRAINT XPKestoque_produto PRIMARY KEY (COD_PRODUTO, 
              COD_ESTOQUE, DAT_ESTOQUE);


DROP TABLE produto CASCADE CONSTRAINTS;

CREATE TABLE produto (
       COD_PRODUTO          NUMBER(10) NOT NULL,
       NOM_PRODUTO          VARCHAR2(20) NULL,
       COD_BARRA            VARCHAR2(20) NULL,
       STA_ATIVO            VARCHAR2(20) NULL,
       DAT_CADASTRO         DATE NULL,
       DAT_CANCELAMENTO     DATE NULL
);

CREATE UNIQUE INDEX XPKproduto ON produto
(
       COD_PRODUTO                    ASC
);


ALTER TABLE produto
       ADD CONSTRAINT XPKproduto PRIMARY KEY (COD_PRODUTO);


DROP TABLE cliente CASCADE CONSTRAINTS;

CREATE TABLE cliente (
       COD_CLIENTE          NUMBER(10) NOT NULL,
       NOM_CLIENTE          VARCHAR2(50) NULL,
       DES_RAZAO_SOCIAL     VARCHAR2(80) NULL,
       TIP_PESSOA           CHAR(1) NULL,
       NUM_CPF_CNPJ         NUMBER(15) NULL,
       DAT_CADASTRO         DATE NULL,
       DAT_CANCELAMENTO     DATE NULL,
       STA_ATIVO            CHAR(1) NULL
);

CREATE UNIQUE INDEX XPKcliente ON cliente
(
       COD_CLIENTE                    ASC
);


ALTER TABLE cliente
       ADD CONSTRAINT XPKcliente PRIMARY KEY (COD_CLIENTE);


DROP TABLE estoque CASCADE CONSTRAINTS;

CREATE TABLE estoque (
       COD_ESTOQUE          NUMBER(4) NOT NULL,
       NOM_ESTOQUE          VARCHAR2(50) NULL
);

CREATE UNIQUE INDEX XPKestoque ON estoque
(
       COD_ESTOQUE                    ASC
);


ALTER TABLE estoque
       ADD CONSTRAINT XPKestoque PRIMARY KEY (COD_ESTOQUE);


DROP TABLE cidade CASCADE CONSTRAINTS;

CREATE TABLE cidade (
       COD_CIDADE           NUMBER(6) NOT NULL,
       NOM_CIDADE           VARCHAR2(20) NULL,
       COD_ESTADO           CHAR(3) NULL
);

CREATE UNIQUE INDEX XPKcidade ON cidade
(
       COD_CIDADE                     ASC
);

CREATE INDEX XIF1cidade ON cidade
(
       COD_ESTADO                     ASC
);


ALTER TABLE cidade
       ADD CONSTRAINT XPKcidade PRIMARY KEY (COD_CIDADE);


DROP TABLE estado CASCADE CONSTRAINTS;

CREATE TABLE estado (
       COD_ESTADO           CHAR(3) NOT NULL,
       NOM_ESTADO           VARCHAR2(50) NULL,
       COD_PAIS             NUMBER(3) NULL
);

CREATE UNIQUE INDEX XPKestado ON estado
(
       COD_ESTADO                     ASC
);

CREATE INDEX XIF1estado ON estado
(
       COD_PAIS                       ASC
);


ALTER TABLE estado
       ADD CONSTRAINT XPKestado PRIMARY KEY (COD_ESTADO);


DROP TABLE pais CASCADE CONSTRAINTS;

CREATE TABLE pais (
       COD_PAIS             NUMBER(3) NOT NULL,
       NOM_PAIS             VARCHAR2(50) NULL
);

CREATE UNIQUE INDEX XPKpais ON pais
(
       COD_PAIS                       ASC
);


ALTER TABLE pais
       ADD CONSTRAINT XPKpais PRIMARY KEY (COD_PAIS);


DROP TABLE tipo_movimento_estoque CASCADE CONSTRAINTS;

CREATE TABLE tipo_movimento_estoque (
       COD_TIPO_MOVIMENTO_ESTOQUE NUMBER(2) NOT NULL,
       DES_TIPO_MOVIMENTO_ESTOQUE VARCHAR2(50) NULL,
       STA_SAIDA_ENTRADA    CHAR(1) NULL
);

CREATE UNIQUE INDEX XPKtipo_movimento_estoque ON tipo_movimento_estoque
(
       COD_TIPO_MOVIMENTO_ESTOQUE     ASC
);


ALTER TABLE tipo_movimento_estoque
       ADD CONSTRAINT XPKtipo_movimento_estoque PRIMARY KEY (
              COD_TIPO_MOVIMENTO_ESTOQUE);


ALTER TABLE movimento_estoque
       ADD CONSTRAINT R_24
              FOREIGN KEY (COD_TIPO_MOVIMENTO_ESTOQUE)
                             REFERENCES tipo_movimento_estoque  (
              COD_TIPO_MOVIMENTO_ESTOQUE);


ALTER TABLE movimento_estoque
       ADD CONSTRAINT R_17
              FOREIGN KEY (COD_PRODUTO)
                             REFERENCES produto  (COD_PRODUTO);


ALTER TABLE produto_composto
       ADD CONSTRAINT R_16
              FOREIGN KEY (COD_PRODUTO_RELACIONADO)
                             REFERENCES produto  (COD_PRODUTO);


ALTER TABLE produto_composto
       ADD CONSTRAINT R_15
              FOREIGN KEY (COD_PRODUTO)
                             REFERENCES produto  (COD_PRODUTO);


ALTER TABLE historico_pedido
       ADD CONSTRAINT R_25
              FOREIGN KEY (COD_VENDEDOR)
                             REFERENCES vendedor  (COD_VENDEDOR);


ALTER TABLE historico_pedido
       ADD CONSTRAINT R_19
              FOREIGN KEY (COD_PEDIDO)
                             REFERENCES pedido  (COD_PEDIDO);


ALTER TABLE historico_pedido
       ADD CONSTRAINT R_9
              FOREIGN KEY (COD_CLIENTE)
                             REFERENCES cliente  (COD_CLIENTE);


ALTER TABLE historico_pedido
       ADD CONSTRAINT R_8
              FOREIGN KEY (SEQ_ENDERECO_CLIENTE)
                             REFERENCES endereco_cliente  (
              SEQ_ENDERECO_CLIENTE);


ALTER TABLE item_pedido
       ADD CONSTRAINT R_3
              FOREIGN KEY (COD_PRODUTO)
                             REFERENCES produto  (COD_PRODUTO);


ALTER TABLE item_pedido
       ADD CONSTRAINT R_2
              FOREIGN KEY (COD_PEDIDO)
                             REFERENCES pedido  (COD_PEDIDO);


ALTER TABLE pedido
       ADD CONSTRAINT R_14
              FOREIGN KEY (COD_USUARIO)
                             REFERENCES usuario  (COD_USUARIO);


ALTER TABLE pedido
       ADD CONSTRAINT R_12
              FOREIGN KEY (COD_VENDEDOR)
                             REFERENCES vendedor  (COD_VENDEDOR);


ALTER TABLE pedido
       ADD CONSTRAINT R_7
              FOREIGN KEY (COD_PEDIDO_RELACIONADO)
                             REFERENCES pedido  (COD_PEDIDO);


ALTER TABLE pedido
       ADD CONSTRAINT R_6
              FOREIGN KEY (SEQ_ENDERECO_CLIENTE)
                             REFERENCES endereco_cliente  (
              SEQ_ENDERECO_CLIENTE);


ALTER TABLE pedido
       ADD CONSTRAINT R_1
              FOREIGN KEY (COD_CLIENTE)
                             REFERENCES cliente  (COD_CLIENTE);


ALTER TABLE cliente_vendedor
       ADD CONSTRAINT R_11
              FOREIGN KEY (COD_VENDEDOR)
                             REFERENCES vendedor  (COD_VENDEDOR);


ALTER TABLE cliente_vendedor
       ADD CONSTRAINT R_10
              FOREIGN KEY (COD_CLIENTE)
                             REFERENCES cliente  (COD_CLIENTE);


ALTER TABLE endereco_cliente
       ADD CONSTRAINT R_22
              FOREIGN KEY (COD_CIDADE)
                             REFERENCES cidade  (COD_CIDADE);


ALTER TABLE endereco_cliente
       ADD CONSTRAINT R_5
              FOREIGN KEY (COD_TIPO_ENDERECO)
                             REFERENCES tipo_endereco  (
              COD_TIPO_ENDERECO);


ALTER TABLE endereco_cliente
       ADD CONSTRAINT R_4
              FOREIGN KEY (COD_CLIENTE)
                             REFERENCES cliente  (COD_CLIENTE);


ALTER TABLE estoque_produto
       ADD CONSTRAINT R_20
              FOREIGN KEY (COD_ESTOQUE)
                             REFERENCES estoque  (COD_ESTOQUE);


ALTER TABLE estoque_produto
       ADD CONSTRAINT R_18
              FOREIGN KEY (COD_PRODUTO)
                             REFERENCES produto  (COD_PRODUTO);


ALTER TABLE cidade
       ADD CONSTRAINT R_21
              FOREIGN KEY (COD_ESTADO)
                             REFERENCES estado  (COD_ESTADO);


ALTER TABLE estado
       ADD CONSTRAINT R_23
              FOREIGN KEY (COD_PAIS)
                             REFERENCES pais  (COD_PAIS);











