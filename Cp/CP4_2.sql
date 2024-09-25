SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*
Gabriel Siqueira Rodrigues RM98626
Juan de Godoy RM551408
*/

-- DROPs DAS TABELAS
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE produto CASCADE CONSTRAINTS;
DROP TABLE pedido CASCADE CONSTRAINTS;

-- CREATEs DAS TABELAS
CREATE TABLE cliente (
	cd_clie INTEGER PRIMARY KEY,
	nm_clie VARCHAR2(40),
	fone_clie VARCHAR2(20)
);
 
CREATE TABLE produto (
	cd_prod INTEGER PRIMARY KEY,
	ds_prod VARCHAR2(255),
	val_unit NUMBER(10,2),
	qtd_estoque NUMBER(10)
);
 
CREATE TABLE pedido (
	num_ped NUMBER(10) PRIMARY KEY,
	fk_clie INTEGER,
	fk_prod INTEGER,
	qtde_ped NUMBER(5),
	dt_ped DATE
);

-- Criação do relacionamento - FKs
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (fk_clie) REFERENCES cliente (cd_clie);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_produto FOREIGN KEY (fk_prod) REFERENCES produto (cd_prod);

-- INSERTs das tabelas
BEGIN
	INSERT INTO cliente VALUES(1, 'Gabriel', '(11) 12345-6789');
	INSERT INTO cliente VALUES(2, 'Juan', '(11) 12345-6789');
	INSERT INTO cliente VALUES(3, 'Gustavo', '(11) 12345-6789');
	INSERT INTO cliente VALUES(4, 'Isabella', '(11) 12345-6789');
	INSERT INTO cliente VALUES(5, 'Mateus', '(11) 12345-6789');
 
	INSERT INTO produto VALUES(1, 'Produto 1', 10, 20);
	INSERT INTO produto VALUES(2, 'Produto 2', 5, 10);
	INSERT INTO produto VALUES(3, 'Produto 3', 7.5, 12);
	INSERT INTO produto VALUES(4, 'Produto 4', 22, 23);
	INSERT INTO produto VALUES(5, 'Produto 5', 19, 81);
 
	INSERT INTO pedido VALUES(1, 1, 1, 3, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
	INSERT INTO pedido VALUES(2, 2, 2, 7, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
	INSERT INTO pedido VALUES(3, 3, 3, 86, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
	INSERT INTO pedido VALUES(4, 4, 4, 21, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
	INSERT INTO pedido VALUES(5, 5, 5, 12, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
END;
/

--Function
CREATE OR REPLACE FUNCTION calcular_valor_total_pedido(num_pedido IN NUMBER)
RETURN NUMBER IS
    v_valor_total NUMBER(10,2) := 0;
BEGIN
    SELECT SUM(p.qtde_ped * pr.val_unit)
    INTO v_valor_total
    FROM pedido p
    JOIN produto pr ON p.fk_prod = pr.cd_prod
    WHERE p.num_ped = num_pedido;
    RETURN NVL(v_valor_total, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END calcular_valor_total_pedido;
/

--Uso da Function
SELECT calcular_valor_total_pedido(1) AS valor_total FROM dual;
--Procedure
CREATE OR REPLACE PROCEDURE inserir_pedido (
    p_num_ped IN NUMBER,
    p_fk_clie IN INTEGER,
    p_fk_prod IN INTEGER,
    p_qtde_ped IN NUMBER,
    p_dt_ped IN DATE
) IS
    v_valor_total NUMBER(10,2);
BEGIN
    INSERT INTO pedido (num_ped, fk_clie, fk_prod, qtde_ped, dt_ped)
    VALUES (p_num_ped, p_fk_clie, p_fk_prod, p_qtde_ped, p_dt_ped);
    v_valor_total := calcular_valor_total_pedido(p_num_ped);
    DBMS_OUTPUT.PUT_LINE('Valor total do pedido ' || p_num_ped || ': R$ ' || v_valor_total);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: O número do pedido já existe.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END inserir_pedido;
/

--Uso da Procedure
BEGIN
    inserir_pedido(6, 5, 5, 19, TO_DATE('2024-09-25', 'YYYY-MM-DD'));
END;
/
 
--Trigger
CREATE OR REPLACE TRIGGER update_estoque
BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
    UPDATE produto
    SET qtd_estoque = qtd_estoque - :NEW.qtde_ped
    WHERE produto.cd_prod = :NEW.fk_prod;
END;
/

--Teste do Trigger
SELECT * FROM produto;
INSERT INTO pedido VALUES(7, 3, 3, 3, TO_DATE('2024-10-10', 'YYYY-mm-dd'));
SELECT * FROM produto;