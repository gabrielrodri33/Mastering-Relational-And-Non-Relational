CREATE OR REPLACE PACKAGE teste1
AS
disciplina VARCHAR2(20) := 'DB Application';
unidade VARCHAR2(30) := 'FIAP - Paulista - Manhã';
END teste1;

DECLARE
concatena VARCHAR2(100);
BEGIN
	concatena := teste1.disciplina || ', on FIAP';
	dbms_output.put_line(concatena);
END;



CREATE OR REPLACE PACKAGE rh
AS 
	FUNCTION descobrir_salario (p_id IN emp.empno%TYPE)
		RETURN NUMBER;
	PROCEDURE reajuste(v_codigo_emp IN emp.empno%TYPE,
						v_porcentagem IN NUMBER DEFAULT 25);
END rh;

/

DROP TABLE emp CASCADE CONSTRAINTS;3
 
CREATE TABLE emp (
    empno NUMBER(3),
    sal NUMBER(8,2)
);
 
INSERT INTO emp VALUES (1, 1000);

CREATE OR REPLACE PACKAGE BODY rh
AS 
	FUNCTION descobrir_salario(p_id IN emp.empno%TYPE)
		RETURN NUMBER 
		IS 
			v_salario emp.sal%TYPE := 0;
		BEGIN
			SELECT sal INTO v_salario FROM emp WHERE empno = p_id;
			RETURN v_salario;
		END descobrir_salario;
	PROCEDURE reajuste(v_codigo_emp IN emp.empno%TYPE,
						v_porcentagem IN NUMBER DEFAULT 25)
	IS
		BEGIN
			UPDATE emp SET sal = sal + (sal * (v_porcentagem / 100))
			WHERE empno = v_codigo_emp;
		COMMIT;
	END reajuste;
END rh;

DECLARE
	v_sal NUMBER(8,2);
BEGIN
	v_sal := rh.descobrir_salario(1);
	dbms_output.put_line(v_sal);
END;

SELECT rh.descobrir_salario (1) FROM dual;

DECLARE
	v_sal NUMBER(8,2);
BEGIN
	v_sal := rh.descobrir_salario(1);
	dbms_output.put_line('Salario atual - ' || v_sal);
	rh.reajuste(1);
	v_sal := rh.descobrir_salario(1);
	dbms_output.put_line('Salario atualizado - ' || v_sal);
END;
