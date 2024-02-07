SET SERVEROUTPUT ON

--Declare é utilizado para declarar variáveis (não obrigatório)
DECLARE
    v_date DATE;
--Begin é utilizado para fazer os selects dentro dele(obrigatório)
BEGIN
    SELECT sysdate 
    INTO v_date 
    FROM dual;
    DBMS_OUTPUT.PUT_LINE('A data atual é ' || v_date);
--End utilizado para finalizar o código (obrigatório)
END;
/

DECLARE
    v_myName VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Meu nome é: ' || v_myName);
    v_myName := 'John';
    DBMS_OUTPUT.PUT_LINE('Meu nome é: ' || v_myName);
END;
/

DECLARE
    v_myName VARCHAR2(20) := 'John';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Meu nome é: ' || v_myName);
    v_myName := 'Steven';
    DBMS_OUTPUT.PUT_LINE('Meu nome é: ' || v_myName);
END;
/

DECLARE
    v_myName VARCHAR2(55);
BEGIN
    v_myName := 'Gabriel';
    v_myName := v_myName || ' Siqueira';
    DBMS_OUTPUT.PUT_LINE('Meu nome é: ' || v_myName);
END;
/

DECLARE
    v_event VARCHAR2(15);
BEGIN
    --o "q" é utilizado para delimitar o o texto, ! e [ também, o print não quebra no 's
    v_event := q'!Father's day!';
    DBMS_OUTPUT.PUT_LINE('3rd Sunday in June is: ' || v_event);
    v_event := q'[Mother's day]';
    DBMS_OUTPUT.PUT_LINE('2nd Sunday in May: ' || v_event);
END;
/

