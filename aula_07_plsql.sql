SET SERVEROUTPUT ON;

--%FOUND RETORNA SE EXISTE A PRÓXIMA LINHA (TRUE OR FALSE)

--%NOTFOUND É O CONTRÁRIO

--%ROWCOUNT RETORNA QUANTAS LINHAS PROCESSADAS DENTRO DO CURSOR

--%ISOPEN RETORNA SE O CURSOR ESTÁ ABERTO

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
    COMMIT;
END;
/

DECLARE
    CURSOR cs_exibe IS SELECT nm_fun, salario FROM tb_salario;
    v_exibe cs_exibe%ROWTYPE;
BEGIN
    OPEN cs_exibe;
    LOOP
        FETCH cs_exibe INTO v_exibe;
    EXIT WHEN cs_exibe%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nome:  ' || v_exibe.nm_fun  ||  '   -  Salário: R$'  ||  v_exibe.salario);
    END LOOP;
CLOSE cs_exibe;
END;
/

DECLARE
    CURSOR cs_exibe IS SELECT nm_fun, salario FROM tb_salario;
    v_exibe cs_exibe%ROWTYPE;
BEGIN
    FOR v_exibe IN cs_exibe LOOP
        DBMS_OUTPUT.PUT_LINE('Nome:  ' || v_exibe.nm_fun  ||  '   -  Salário: R$'  ||  v_exibe.salario);
    END LOOP;
END;
/

--Add coluna tempo na tabela
ALTER TABLE tb_salario  ADD tempo NUMBER(5);

--Add a quantidade de tempo do funcionário na empresa
DECLARE
    CURSOR cs_exibe IS SELECT dt_adm, cd_fun FROM tb_salario;
    v_exibe cs_exibe%ROWTYPE;
    v_tempo NUMERIC(8);
    v_sysdate DATE := SYSDATE;
BEGIN
    FOR v_exibe IN cs_exibe LOOP
        v_tempo := FLOOR(v_sysdate - v_exibe.dt_adm);
        UPDATE tb_salario SET tempo = v_tempo WHERE cd_fun = v_exibe.cd_fun;
    END LOOP;
END;
/

--Para funcionarios com tempo de serviço a mais de 150 meses add 10% e para o restante 5%
DECLARE
    CURSOR cs_exibe IS SELECT  cd_fun, tempo, salario FROM tb_salario;
    v_exibe cs_exibe%ROWTYPE;
    v_meses NUMERIC(4);
BEGIN
    FOR v_exibe IN cs_exibe LOOP
        v_meses := ROUND(v_exibe.tempo / 30);
        IF v_meses >= 150 THEN
            UPDATE tb_salario SET salario = v_exibe.salario * 1.1 WHERE cd_fun = v_exibe.cd_fun;
        ELSE
             UPDATE tb_salario SET salario = v_exibe.salario * 1.05 WHERE cd_fun = v_exibe.cd_fun;
            END IF;
        END LOOP;
END;