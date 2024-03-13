SET SERVEROUTPUT ON

DECLARE
    v_salario NUMBER(14,2) := &salario;
BEGIN
    IF v_salario <= 1513.69 THEN
        DBMS_OUTPUT.PUT_LINE('Seu salário é livre de descontos.');
    
    ELSIF v_salario >1513.69 AND v_salario <= 2725.12 THEN
        DBMS_OUTPUT.PUT_LINE('Seu salário tem 16% de desconto. Bruto: R$' || v_salario || ' Líquido: R$' || v_salario * 0.84);
        
    ELSIF v_salario > 2725.12 THEN
        DBMS_OUTPUT.PUT_LINE('Seu salário tem 28% de desconto. Bruto: R$' || v_salario || ' Líquido: R$' || v_salario * 0.715);
        
    END IF;
END;
/

CREATE TABLE tbl_aluno_cp1 (
    ra VARCHAR2(25),
    nome VARCHAR(25),
    media NUMBER(3,2),
    situacao VARCHAR2(25)
);

BEGIN
    INSERT INTO tbl_aluno_cp1 (ra, nome) VALUES('551001', 'Juan');
    INSERT INTO tbl_aluno_cp1 (ra, nome) VALUES('55100', 'Gabriel');
    INSERT INTO tbl_aluno_cp1 (ra, nome) VALUES('12345','Gustavo');
END
COMMIT;

--Ra do aluno, nota1, nota2 e nota3
DECLARE
    v_ra VARCHAR2(25) := &ra;
    n1 NUMBER(3,1) := &nota1;
    n2 n1%type := &nota2;
    n3 n1%type := &nota3;
    v_media NUMBER(3,2);
BEGIN
    v_media := (n1 + n2 + n3)/3;
    UPDATE tbl_aluno_cp1 SET media = v_media WHERE ra = v_ra;
    
    IF v_media >= 6.0 THEN
        UPDATE tbl_aluno_cp1 SET situacao = 'Aprovado' WHERE ra = v_ra;
    ELSE 
        UPDATE tbl_aluno_cp1 SET situacao = 'Reprovado' WHERE ra = v_ra;
    END IF;
END;
/

SELECT * FROM tbl_aluno_cp1;