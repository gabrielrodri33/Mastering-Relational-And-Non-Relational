SET SERVEROUTPUT ON

/*
Gabriel Siqueira Rodrigues RM98626
Mateus Mantovani Araújo RM98524
*/

--Ex 1
DECLARE
    v_valor NUMBER(10,2) := &v_valor;
    v_cem NUMBER(3) := 0;
    v_dez v_cem%type := 0;
    v_cinco v_cem%type := 0;
    v_dois v_cem%type := 0;
    v_um v_cem%type := 0;
BEGIN
    v_valor := ROUND(v_valor);
    WHILE v_valor != 0 LOOP
        WHILE v_valor >= 100 LOOP
            v_valor := v_valor - 100;
            v_cem := v_cem + 1;
        END LOOP;
        
        WHILE v_valor >= 10 LOOP
            v_valor := v_valor - 10;
            v_dez := v_dez + 1;
        END LOOP;
        
        WHILE v_valor >= 5 LOOP
            v_valor := v_valor - 5;
            v_cinco := v_cinco + 1;
        END LOOP;
        
        WHILE v_valor >= 2 LOOP
            v_valor := v_valor - 2;
            v_dois := v_dois + 1;
        END LOOP;
        
        WHILE v_valor >= 1 LOOP
            v_valor := v_valor - 1;
            v_um := v_um + 1;
        END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cédulas de 100: ' || v_cem ||' | Cédulas de 10: ' || v_dez || ' | Cédulas de 5: ' || v_cinco || ' | Cédulas de 2: ' || v_dois || ' | Cédulas de 1: ' || v_um);
END;
/

--Ex 2
DROP TABLE tbl_apostador CASCADE CONSTRAINTS;
CREATE TABLE tbl_apostador(
    id_apostador INTEGER PRIMARY KEY,
    nome_apostador VARCHAR2(30),
    gols_time_1 INTEGER,
    gols_time_2 INTEGER,
    pontos NUMBER(6,2)
);

BEGIN
    INSERT INTO tbl_apostador (id_apostador, nome_apostador, gols_time_1, gols_time_2) VALUES (1, 'Marcel', 0, 1);
    INSERT INTO tbl_apostador (id_apostador, nome_apostador, gols_time_1, gols_time_2) VALUES (2, 'Rafael', 2, 0);
    INSERT INTO tbl_apostador (id_apostador, nome_apostador, gols_time_1, gols_time_2) VALUES (3, 'Denis', 1, 1);
    INSERT INTO tbl_apostador (id_apostador, nome_apostador, gols_time_1, gols_time_2) VALUES (4, 'Vanessa', 3, 2);
END; 
/

DECLARE
    CURSOR my_cursor IS SELECT id_apostador, nome_apostador, Gols_time_1, Gols_time_2 FROM tbl_apostador;
    c_cursor my_cursor%ROWTYPE;
    v_gols1 NUMBER(3) := 3;
    v_gols2 v_gols1%type := 2;
    --v_AcertoVencedor NUMBER(6,2):= 10;
    --v_AcertoPlacar NUMBER(6,2):= 5;
    v_total NUMBER(3) := 0;
BEGIN
    FOR c_cursor IN my_cursor LOOP
        v_total := 0;
        IF c_cursor.gols_time_1 > c_cursor.gols_time_2 THEN
            v_total := v_total + 10;
            
        ELSIF c_cursor.gols_time_1 = c_cursor.gols_time_2 THEN
            v_total := v_total + 10;
        END IF;
        
        IF c_cursor.gols_time_1 = v_gols1 THEN
            v_total := v_total + 5;
        END IF;
        
        IF c_cursor.gols_time_2 = v_gols2 THEN
            v_total := v_total + 5;
        END IF;
    
        
        UPDATE tbl_apostador SET pontos = v_total WHERE id_apostador = c_cursor.id_apostador;
        
    END LOOP;
END;
/

SELECT * FROM tbl_apostador;