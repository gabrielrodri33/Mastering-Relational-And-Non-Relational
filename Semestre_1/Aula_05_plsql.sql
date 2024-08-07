SET SERVEROUTPU ON;

--Estrutura re repeti��o: loop
DECLARE
    v_contador NUMBER(2) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 20;
    END LOOP;
END;
/

--Estrutura re repeti��o: while
DECLARE
    v_contador NUMBER(2):=1;
BEGIN
    WHILE v_contador <= 20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
        v_contador := v_contador + 1;
    END LOOP;
END;
/

--Estrutura re repeti��o: for
BEGIN
    FOR v_contador IN 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
    END LOOP;
END;
/

--Estrutura re repeti��o: for - reverse
BEGIN
    FOR v_contador IN REVERSE 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
    END LOOP;
END;
/


--Exerc�cio de calcular tabuada de um certo n�mero
--Com loop
DECLARE
    v_contador NUMBER (2) := 1;
    v_num NUMBER (5) := &num;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || v_contador || ' = ' || v_num*v_contador);
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 10;
    END LOOP;
END;
/

--Com While
DECLARE
    v_contador NUMBER(2) := 1;
    v_num NUMBER(5) := &num;
BEGIN
    WHILE v_contador <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || v_contador || ' = ' || v_num*v_contador);
        v_contador := v_contador + 1;
    END LOOP;
END;
/

--Com for
DECLARE
    v_num NUMBER(5):=&num;
BEGIN
    FOR v_contador IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || v_contador || ' = ' || v_num*v_contador);
    END LOOP;
END;
/

--Com for -reverse
DECLARE
    v_num NUMBER(5) := &num;
BEGIN
    FOR v_contador IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || v_contador || ' = ' || v_num*v_contador);
    END LOOP;
END;
/

--Em um intervalo n�merico inteiro informar quantos pares e quantos impares
DECLARE
    v_contpar NUMBER(5) :=0;
    v_contimpar v_contpar%type := 0;
BEGIN
    FOR v_num IN 1..20 LOOP
        IF MOD(v_num, 2) = 0 THEN
            v_contpar := v_contpar + 1;
        ELSE
            v_contimpar := v_contimpar + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Quantidade de n�meros pares = ' || v_contpar);
    DBMS_OUTPUT.PUT_LINE('Quantidade de n�meros �mpares = ' || v_contimpar);
END;
/