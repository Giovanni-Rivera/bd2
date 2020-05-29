/**********************************************************/
GRANT READ ON DIRECTORY DIR_TEST TO proyecto;
grant read on DIRECTORY DIR_TEST TO PUBLIC;
create or replace directory DIR_TEST as 'C:\prueba';
select * from dba_directories;
/*
set serveroutput on; 
declare
descriptor utl_file.file_type;
fichero_cont varchar2(100);
begin
 descriptor := utl_file.fopen('DIR_TEST','fichero_oracle_denegados.txt','w');
 fichero_cont := 'Creando el nuevo fichero ';
 utl_file.put_line(descriptor,fichero_cont);
 utl_file.fclose(descriptor);
end;*/
commit;

set serveroutput on; 
declare
fichero_cont varchar2(100);
fichero_rut varchar2(100);
begin
    fichero_cont:='fichero_oracle.txt';
    fichero_rut:='DIR_TEST';
    P_SPLIT (fichero_rut,fichero_cont);
end;