SET SERVEROUTPUT ON

CREATE TABLE tb_salario(
    CD_FUN INTEGER GENERATED ALWAYS AS IDENTITY,
    NM_FUN VARCHAR2(40),
    SALARIO NUMBER(10,2),
    DT_ADM DATE
);

SELECT * FROM tb_salario;

BEGIN
    INSERT INTO tb_salario (nm_fun, salario, dt_adm) VALUES ('Marcel', 10000, TO_DATE('17/01/2000', 'dd/mm/yyyy'));
    INSERT INTO tb_salario (nm_fun, salario, dt_adm) VALUES ('Claudia', 16000, TO_DATE('02/10/1998', 'dd/mm/yyyy'));
    INSERT INTO tb_salario (nm_fun, salario, dt_adm) VALUES ('Joaquim', 5500, TO_DATE('10/07/2010', 'dd/mm/yyyy'));
    INSERT INTO tb_salario (nm_fun, salario, dt_adm) VALUES ('Valéria', 7300, TO_DATE('08/06/2015', 'dd/mm/yyyy'));
END;
COMMIT;
/

--Ex1: Utilizando cursor imprimir na tela os nomes, salarios e datas
DECLARE
    CURSOR v_cursor IS SELECT cd_fun FROM tb_salario;
    myvar v_cursor%ROWTYPE;
    v_nome VARCHAR2(40);
    v_salario NUMBER(10,2);
    v_data DATE;
BEGIN
    FOR myvar IN v_cursor LOOP
        SELECT nm_fun, salario, dt_adm INTO v_nome, v_salario, v_data FROM tb_salario WHERE cd_fun = myvar.cd_fun;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ' Salário: R$' || v_salario || ' Data: '|| v_data);
    END LOOP;
END;
/

--Ex2: Add uma coluna tempo com a diferença de dias dos funcionarios

ALTER TABLE tb_salario ADD tempo NUMERIC(8);
DECLARE
    CURSOR v_cursor IS SELECT cd_fun FROM tb_salario;
    myvar v_cursor%ROWTYPE;
    v_data DATE;
    v_tempo NUMERIC(8);
    v_sysdate DATE := SYSDATE;
BEGIN
    FOR myvar IN v_cursor LOOP
        SELECT dt_adm INTO v_data FROM tb_salario WHERE cd_fun = myvar.cd_fun;
        v_tempo := FLOOR(v_sysdate - v_data);
        UPDATE tb_salario SET tempo = v_tempo WHERE cd_fun = myvar.cd_fun;
    END LOOP;
END;
/