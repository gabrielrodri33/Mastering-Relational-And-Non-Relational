SET SERVEROUTPUT ON

/*
Criar um bloco PL/SQL para analisar a entrada de dados do sexo de um cliente,
o bloco deverá receber o dado sobre o sexo: para Masculino - M ou m, para feminino
F ou f, qualquer dado fora desta configuração deverá ser exibido 'Outros', para
M ou m 'Masculino', para F ou f 'Feminino'.
*/

DECLARE
    v_sexo CHAR(1) := UPPER('&Sexo');   
BEGIN
    IF v_sexo = 'F' THEN
        dbms_output.put_line('Feminino');
    ELSIF  v_sexo = 'M' THEN
        dbms_output.put_line('Masculino');
    ELSE
        dbms_output.put_line('Outros');
    END IF;
END;
/

/*
Escreva	um programa para ler 2 valores (considere que não serão informados valores iguais) e escrever o	maior deles.
*/
DECLARE
    v_n1 NUMBER(10,2) := &n1;
    v_n2 v_n1%type := &n2;
BEGIN
    IF v_n1 = v_n2 THEN
        dbms_output.put_line('Os valores são iguais');
    ELSIF v_n1 > v_n2 THEN
        dbms_output.put_line(v_n1 || ' é maior que ' || v_n2);
    ELSE
        dbms_output.put_line(v_n2 || ' é maior que ' || v_n1);
    END IF;
END;
/

/*
Escreva	um programa para ler o ano de nascimento de uma	pessoa e escrever uma mensagem que diga	se ela poderá ou não votar este ano	
(não é necessário considerar o mês em que ela nasceu).
*/
DECLARE
    v_nasc NUMBER(5) := &nasc;
    v_anoatual NUMBER(5);
BEGIN
    SELECT
    EXTRACT (YEAR FROM sysdate)
    INTO v_anoatual 
    FROM dual;
    IF v_anoatual - v_nasc >= 16 THEN
        dbms_output.put_line('Pode votar');
    ELSE 
        dbms_output.put_line('Não pode votar');
    END IF;
END;
/

/*
Escreva	um programa que verifique a validade de uma senha fornecida pelo usuário. A senha válida é o número 1234.Devem ser impressas as	
seguintes mensagens:	
	ACESSO PERMITIDO caso a senha seja válida.	
	ACESSO NEGADO caso a senha seja	inválida.
*/

DECLARE
    v_senha VARCHAR(18) := '&senha';
BEGIN
    IF v_senha = '1234' THEN
        dbms_output.put_line('Acesso permitido');
    ELSE
        dbms_output.put_line('Acesso negado');
    END IF;
END;
/

/*
As maçãs custam R$ 0,30 cada se forem compradas	menos do que uma dúzia, e R$ 0,25 se forem compradas pelo menos doze. Escreva um programa que
leia o número de maçãs compradas, calcule e escreva o valor total da compra.
*/

DECLARE
    v_maca NUMBER(5) := &macas;
BEGIN
    IF v_maca < 12 THEN
        dbms_output.put_line('R$' || v_maca * 0.25);
    ELSE
       dbms_output.put_line('R$' || v_maca * 0.3); 
    END IF;
END;
/