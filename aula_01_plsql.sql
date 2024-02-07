SET SERVEROUTPUT ON

--Declare � utilizado para declarar vari�veis (n�o obrigat�rio)
DECLARE
    v_date DATE;
--Begin � utilizado para fazer os selects dentro dele(obrigat�rio)
BEGIN
    SELECT sysdate 
    INTO v_date 
    FROM dual;
    DBMS_OUTPUT.PUT_LINE('A data atual � ' || v_date);
--End utilizado para finalizar o c�digo (obrigat�rio)
END;
/

DECLARE
    v_myName VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Meu nome �: ' || v_myName);
    v_myName := 'John';
    DBMS_OUTPUT.PUT_LINE('Meu nome �: ' || v_myName);
END;
/

DECLARE
    v_myName VARCHAR2(20) := 'John';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Meu nome �: ' || v_myName);
    v_myName := 'Steven';
    DBMS_OUTPUT.PUT_LINE('Meu nome �: ' || v_myName);
END;
/

DECLARE
    v_myName VARCHAR2(55);
BEGIN
    v_myName := 'Gabriel';
    v_myName := v_myName || ' Siqueira';
    DBMS_OUTPUT.PUT_LINE('Meu nome �: ' || v_myName);
END;
/

DECLARE
    v_event VARCHAR2(15);
BEGIN
    --o "q" � utilizado para delimitar o o texto, ! e [ tamb�m, o print n�o quebra no 's
    v_event := q'!Father's day!';
    DBMS_OUTPUT.PUT_LINE('3rd Sunday in June is: ' || v_event);
    v_event := q'[Mother's day]';
    DBMS_OUTPUT.PUT_LINE('2nd Sunday in May: ' || v_event);
END;
/

