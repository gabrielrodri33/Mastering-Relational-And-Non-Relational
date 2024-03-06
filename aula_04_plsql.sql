SET SERVEROUTPUT ON

CREATE TABLE aluno (
    RA CHAR(9),
    NOME VARCHAR(50),
    CONSTRAINT ALUNO_PK PRIMARY KEY(RA));

SELECT * FROM aluno;
--DROP TABLE aluno;

INSERT INTO aluno (RA, NOME) VALUES ('111222333','Antonio Alves');
INSERT INTO aluno (RA, NOME) VALUES ('222333444','Beatriz Bernardes');
INSERT INTO aluno (RA, NOME) VALUES ('333444555','Cláudio Cardoso');

--Tbl do primeiro ex
CREATE TABLE notas(
    rm_aluno NUMBER(1),
    nm_disc VARCHAR(30),
    cp1 NUMBER(3,1),
    cp2 NUMBER(3,1),
    cp3 NUMBER(3,1),
    media NUMBER(3,1)
);

SELECT * FROM notas;
--DROP TABLE notas;
TRUNCATE TABLE notas;

BEGIN
    INSERT INTO notas (rm_aluno, nm_disc, cp1, cp2, cp3) VALUES (1, 'PLSQL', 10, 7.5, 7.5);
    INSERT INTO notas (rm_aluno, nm_disc, cp1, cp2, cp3) VALUES (1, 'POO', 4.5, 10, 7.5);
    INSERT INTO notas (rm_aluno, nm_disc, cp1, cp2, cp3) VALUES (1, 'IA', 7.5, 6.5, 10);
    INSERT INTO notas (rm_aluno, nm_disc, cp1, cp2, cp3) VALUES (1, 'JAVA', 8, 2.5, 2.5);
    COMMIT;
END;
/

--Tbl do segundo ex
CREATE TABLE nota(
    rm_aluno NUMBER(1),
    nm_disc VARCHAR(30),
    cp1 NUMBER(3,1),
    cp2 NUMBER(3,1),
    cp3 NUMBER(3,1),
    media NUMBER(3,1),
    carga_hora NUMBER(3),
    num_faltas NUMBER(3),
    situacao VARCHAR2(15)
);

SELECT * FROM nota;
--DROP TABLE nota;
TRUNCATE TABLE nota;

BEGIN
    INSERT INTO nota (rm_aluno, nm_disc, cp1, cp2, cp3, media, carga_hora, num_faltas) VALUES (1, 'PLSQL', 10, 7.5, 7.5, 8.3, 100, 0);
    INSERT INTO nota (rm_aluno, nm_disc, cp1, cp2, cp3, media, carga_hora, num_faltas) VALUES (1, 'POO', 4.5, 10, 7.5, 7.3, 100, 90);
    INSERT INTO nota (rm_aluno, nm_disc, cp1, cp2, cp3, media, carga_hora, num_faltas) VALUES (1, 'IA', 1.5, 1.5, 1.0, 1.5, 80, 10);
    INSERT INTO nota (rm_aluno, nm_disc, cp1, cp2, cp3, media, carga_hora, num_faltas) VALUES (1, 'JAVA', 8, 2.5, 2.5, 4.3, 80, 70);
    INSERT INTO nota (rm_aluno, nm_disc, cp1, cp2, cp3, media, carga_hora, num_faltas) VALUES (1, 'IOT', 5, 5, 5, 5, 80, 20);
    COMMIT;
END;
/

DECLARE
    v_ra CHAR(9) := '333444555';
    v_nome VARCHAR2(50);
BEGIN
    SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = V_RA;
    DBMS_OUTPUT.PUT_LINE('O nome do aluno é: ' || v_nome);
END;
/

DECLARE
    v_ra CHAR(9) := '444555666';
    v_nome VARCHAR2(50) := 'Daniela Dorneles';
BEGIN
    INSERT INTO ALUNO (RA, NOME) VALUES (v_ra, v_nome);
END;
/

DECLARE
    v_ra CHAR(9) := '111222333';
    v_nome VARCHAR2(50) := 'Antonio Rodrigues';
BEGIN
    UPDATE ALUNO SET NOME = v_nome WHERE RA = v_ra;
END;
/

DECLARE
    v_ra CHAR(9) := '444555666';
BEGIN
    DELETE FROM ALUNO WHERE RA = v_ra;
END;
/

--Ex: Calcular a média da tabela "notas"
DECLARE
    v_rm NUMBER(1) := 1;
    v_disc VARCHAR(30) := '&Diciplina';
    v_cp1 NUMBER (3,1);
    v_cp2 v_cp1%type;
    v_cp3 v_cp1%type;
    v_media v_cp1%type;
BEGIN
    SELECT cp1 INTO v_cp1 FROM notas WHERE nm_disc = v_disc;
    SELECT cp2 INTO v_cp2 FROM notas WHERE nm_disc = v_disc;
    SELECT cp3 INTO v_cp3 FROM notas WHERE nm_disc = v_disc;
    v_media := (v_cp1 + v_cp2 + v_cp3) / 3;
    UPDATE notas SET media = v_media WHERE nm_disc = v_disc AND rm_aluno = v_rm;
END;
/

/*Ex:
incluir as colunas: carga_hora - N - 3
                    num_falta - N - 3
                    situacao - A - 40
 
criar um bloco pl para inclusão dos valores de acordo com a tabela
a seguir:
 
Tabela: Notas
    rm_aluno - nm_disc - cp1 - cp2 - cp3 - media - carga_hora - num_faltas - situacao
    1        - PLSQL   - 10   - 7.5  - 7.5          - 100          - 0
    1        - POO     - 4.5   - 10   - 7.5         - 100          - 90
    1        - IA      - 1.5   - 1.5  - 1.0         - 80           - 10
    1        - JAVA    - 8     - 2.5  - 2.5         - 80           - 70
    1        - IOT     - 5.0 - 5.0 - 5.0            - 80           - 20
    
Gravar a situação de acordo com as regras a seguir:
 
Média >= 6.0 e faltas < 25% da carga horária, situação: Aprovado
Média >= 6.0 e faltas >= 25% da carga horária, situação: Rep. por faltas
Média >= 4.5 e < 6.0 e faltas < 25% da carga horária, situação: DP
Média < 4.5 e faltas < 25% da carga horária, situação: Rep. por nota
Média < 4.5 e faltas >= 25% da carga horária, situação: Rep. por nota e faltas
*/ 
DECLARE
    v_rm NUMBER(1) := 1;
    v_disc VARCHAR(30) := '&Diciplina';
    v_cp1 NUMBER(3,1);
    v_cp2 v_cp1%type;
    v_cp3 v_cp1%type;
    v_media v_cp1%type;
    v_carga_hora NUMBER(3);
    v_num_faltas v_carga_hora%type;
BEGIN
    SELECT cp1 INTO v_cp1 FROM nota WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    SELECT cp2 INTO v_cp2 FROM nota WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    SELECT cp3 INTO v_cp3 FROM nota WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    SELECT media INTO v_media FROM nota WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    SELECT carga_hora INTO v_carga_hora WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    SELECT num_faltas INTO v_num_faltas WHERE nm_disc = v_disc AND rm_aluno = v_rm;
    
    
END;
/
