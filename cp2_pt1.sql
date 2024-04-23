SET SERVEROUTPUT ON

--DROP das tabelas
DROP TABLE tbl_produto_rm98626 CASCADE CONSTRAINTS;
DROP TABLE tbl_produto1_rm98626 CASCADE CONSTRAINTS;
DROP TABLE tbl_produto2_rm98626 CASCADE CONSTRAINTS;

--CREATE das tabelas
CREATE TABLE tbl_produto_rm98626(
    cd_produto INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_produto VARCHAR2(15),
    preco NUMBER(5,2)
);

CREATE TABLE tbl_produto1_rm98626(
    cd_produto INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_produto VARCHAR2(15),
    preco NUMBER(5,2)
);

CREATE TABLE tbl_produto2_rm98626(
    cd_produto INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_produto VARCHAR2(15),
    preco NUMBER(5,2)
);

--SELECT das tabelas
SELECT * FROM tbl_produto_rm98626;
SELECT * FROM tbl_produto1_rm98626;
SELECT * FROM tbl_produto2_rm98626;

--INSERT tabela produto
BEGIN
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES('Água', 1.75);
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES('Peixe', 75);
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES('Feijão', 30);
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES('Vinho', 79.5);
COMMIT;
END;
/

--1- Migrar todos os dados para a tbl_produto1
DECLARE
    CURSOR my_cursor IS SELECT nm_produto, preco FROM tbl_produto_rm98626;
    v_cursor my_cursor%ROWTYPE;
BEGIN
    FOR v_cursor IN my_cursor LOOP
        INSERT INTO tbl_produto1_rm98626(nm_produto, preco) VALUES(v_cursor.nm_produto, v_cursor.preco);
    END LOOP;
END;
/


/*
2- Inserir os dados

Tabela: Produto
            5 - Macarrão  18.80
            6 - Óleo      14.60
           
Tabela: Produto1
            5 - Azeite  35.80
            6 - Carvão  40.60
*/

BEGIN
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES ('Macarrão', 18.8);
    INSERT INTO tbl_produto_rm98626(nm_produto, preco) VALUES ('Óleo', 14.6);
    
    INSERT INTO tbl_produto1_rm98626(nm_produto, preco) VALUES ('Azeite', 35.8);
    INSERT INTO tbl_produto1_rm98626(nm_produto, preco) VALUES ('Carvão', 40.6);
COMMIT;
END;
/

--Migrar os dados de produto e produto1 para produto2 sem repeição
DECLARE
    CURSOR my_cursor_p IS
        SELECT nm_produto, preco FROM tbl_produto_rm98626
        UNION
        SELECT nm_produto, preco FROM tbl_produto1_rm98626;
    cs_produto my_cursor_p%ROWTYPE;
    
    v_status_nm NUMBER(1);
    v_status_preco v_status_nm%type;
BEGIN
    FOR cs_produto IN my_cursor_p LOOP
        v_status_nm := 0;
        v_status_preco := 0;
        
        SELECT COUNT(*) INTO v_status_nm FROM tbl_produto2_rm98626 WHERE nm_produto = cs_produto.nm_produto;
        
        IF v_status_nm > 0 THEN
            SELECT COUNT(*) INTO v_status_preco FROM tbl_produto2_rm98626 WHERE nm_produto = cs_produto.nm_produto AND preco = cs_produto.preco;
            
            IF v_status_preco = 0 THEN
                INSERT INTO tbl_produto2_rm98626(nm_produto, preco) VALUES (cs_produto.nm_produto, cs_produto.preco);
            END IF;
        ELSE
            INSERT INTO tbl_produto2_rm98626(nm_produto, preco) VALUES (cs_produto.nm_produto, cs_produto.preco);
        END IF;
    END LOOP;
END;
/
