SET SERVEROUTPUT ON;
SET VERIFY OFF;

DROP TABLE funcionarios_tbl CASCADE CONSTRAINTS;

CREATE TABLE funcionarios_tbl(
    primeiro_nome VARCHAR(30),
    ID NUMBER (2)
);

INSERT INTO funcionarios_tbl VALUES ('Marcel',10);
INSERT INTO funcionarios_tbl VALUES ('Andrea',20);
INSERT INTO funcionarios_tbl VALUES ('Marcel',90);

CREATE OR REPLACE FUNCTION primeiro_nome_func
RETURN VARCHAR
IS
    emp_name VARCHAR(20);
BEGIN
    SELECT primeiro_nome INTO emp_name FROM funcionarios_tbl
    WHERE ID = 90;
    RETURN emp_name;
END;

SELECT primeiro_nome_func FROM dual;
SELECT* FROM funcionarios_tbl;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

CREATE OR REPLACE FUNCTION teste_soma (p1 IN NUMBER, p2 IN NUMBER)
RETURN NUMBER
IS
    soma NUMBER(4);
BEGIN
    soma := p1 + p2;
    RETURN soma;
END;

SELECT teste_soma(10, 15) FROM dual;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

DECLARE
    n1 NUMBER(4) := &valor1;
    n2 n1%type := &valor2;
    re n1%type;
BEGIN
    re := teste_soma(n1, n2);
    dbms_output.put_line(re);
END;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

DECLARE
    n1 NUMBER(4) := &valor1;
    n2 n1%type := &valor2;
BEGIN
    IF n1 > n2 THEN
        dbms_output.put_line(n1);
    ELSE
        dbms_output.put_line(n2);
    END IF;
END; 

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

DROP TABLE aluno CASCADE CONSTRAINTS;
CREATE TABLE aluno (
    ra CHAR(2) PRIMARY KEY,
    nome VARCHAR(20)
);

INSERT INTO aluno VALUES(1, 'Gabriel');
INSERT INTO aluno VALUES(2, 'Marcel');

/*
CREATE OR REPLACE PROCEDURE nome_procedure
(argumento1 IN | OUT | IN OUT tipo_de_dados,
argumento1 IN | OUT | IN OUT tipo_de_dados
*/
CREATE OR REPLACE PROCEDURE proc_nome_aluno (p_ra IN CHAR)
IS
    v_nome VARCHAR2(50);
BEGIN
    SELECT nome INTO v_nome FROM aluno WHERE ra = p_ra;
    dbms_output.put_line(v_nome);
END proc_nome_aluno;
    
EXEC proc_nome_aluno(1);