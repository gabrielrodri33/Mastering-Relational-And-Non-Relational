SET SERVEROUTPUT ON

BEGIN
    dbms_output.put_line('Hello World!');
    dbms_output.put_line('Hello World!');

END;
/

--Usando variaveis de memória

DECLARE
    v_nome VARCHAR(10) := 'Fiap';
    v_nota NUMBER(2) := 10;
BEGIN
    dbms_output.put_line(v_nome);
    --pipe pipe || Concactena a msg estática com variável de memória
    dbms_output.put_line('Mostrando conteúdo: ' || v_nome || 'Nota: ' || v_nota);
END;
/

DECLARE
    --& abre uma caixa de msg para digitação via teclado de dados
    v_nome VARCHAR(10) := '&Nome';
    v_nota NUMBER(2) := &valor_nota;
BEGIN
    dbms_output.put_line(v_nome);
    --pipe pipe || Concactena a msg estática com variável de memória
    dbms_output.put_line('Mostrando conteúdo: ' || v_nome || 'Nota: ' || v_nota);
END;
/

--Processamento
DECLARE
    v_1 NUMBER(4,2) := &Valor1;
    v_2 v_1%type := &Valor2;
    v_res v_1%type;
BEGIN
    v_res := v_1 + v_2;
    dbms_output.put_line('Soma de '||v_1|| ' com '||v_2||' = '||v_res);
END;
/

--Ex1
/*
EXERCICIO 01 – Criar um bloco PL-SQL para calcular o valor do novo 
salário mínimo que deverá ser de 25% em cima do atual, que é de R$
???.
*/
DECLARE
    salario NUMBER(10,2) := &Salario;
    salario_res salario%type;
BEGIN
    salario_res := salario * 1.25;
    dbms_output.put_line(salario_res);
END;
/

--Ex2
/*
EXERCÍCIO 02 – Criar um bloco PL-SQL para calcular o valor em 
REAIS de 45 dólares, sendo que o valor do câmbio a ser considerado 
é de R$ ??? no qual estes valores deverão ser constantes dentro do 
bloco.
*/
DECLARE
    dolar INTEGER := 45;
    reais dolar%type := 4.93;
    convertido dolar%type;
BEGIN
    convertido := dolar * reais;
    dbms_output.put_line(convertido);
END;
/

--Ex3
/*
EXERCÍCIO 03 – Criar um bloco PL-SQL para converter em REAIS os 
dólares informados, sendo que o valor do Câmbio a ser considerado é 
de ????.
*/
DECLARE
    dolar NUMBER(6,2) := &Doleta;
    reais dolar%type := 4.93;
BEGIN
    dbms_output.put_line(dolar * reais);
END;
/

--Ex4
/* 
EXERCÍCIO 04 – Criar um bloco PL-SQL para calcular o valor das 
parcelas de uma compra de um carro, nas seguintes condições: 
OBSERVAÇÃO: 
 - Parcelas para aquisição em 10 pagamentos. 
 - O valor total dos juros é de 3% e deverá ser aplicado sobre o 
montante financiado 
 – No final informar o valor de cada parcela
*/
DECLARE
    valor NUMBER(8,2) := &Valor;
    res_juros valor%type;
    res_parcela valor%type;
BEGIN
    res_juros := valor * 1.03;
    res_parcela := res_juros / 10;
    dbms_output.put_line('Valor de cada parcela: ' || res_parcela);
END;
/

--Ex5
/*
EXERCÍCIO 05 – Criar um bloco PL-SQL para calcular o valor de cada 
parcela de uma compra de um carro, nas seguintes condições:
- Parcelas para aquisição em 6 pagamentos. 
- Parcelas para aquisição em 12 pagamentos. 
- Parcelas para aquisição em 8 pagamentos. 
OBSERVAÇÃO: 
1 – Deverá ser dada uma entrada de 20% do valor da compra. 
 – Deverá ser aplicada uma taxa juros, no saldo restante, nas 
seguintes condições: 
 – No final informar o valor das parcelas para as 3 formas de 
pagamento, com o Valor de aquisição de 10.000.
A – Pagamento em 6 parcelas: 10%. 
B – Pagamento em 12 parcelas: 15%. 
C – Pagamento em 18 parcelas: 20%. 
*/
DECLARE
    v_carro number(10,2) := 10000 * 0.8;
    v_presta v_carro%type;
BEGIN
    v_presta := (v_carro * 1.1)/6;
    dbms_output.put_line('Valor da prestação em 6x: ' || v_presta);
    v_presta := (v_carro * 1.15)/6;
    dbms_output.put_line('Valor da prestação em 12x: ' || v_presta);
    v_presta := (v_carro * 1.2)/6;
    dbms_output.put_line('Valor da prestação em 18x: ' || v_presta);
END;
/
