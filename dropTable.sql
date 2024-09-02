begin
 for deleta in (select table_name, 'DROP TABLE '||table_name||' cascade constraints' AS dropar from user_tables) loop
 BEGIN
  EXECUTE IMMEDIATE deleta.dropar;
  dbms_output.put_line('DROP TABLE '||deleta.table_name||' cascade constraints;');
  EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('Erro ao tentar dropar a tabela:'||deleta.table_name);
 END;
 end loop;
end;
