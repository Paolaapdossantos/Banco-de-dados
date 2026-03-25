---desenvolver uma procedure que receba um id de funcionario e um numero que represente o porcentual de aumento do
-- salario do funcionario, para realizar o auamneto do id do funcionario Se existir, o
--porcentual deve estar ebtre maior que 0 e menor que 10. retornarl 0 para indicar que deu certo o processo e
--o salario do funcionario aumentou. se der erro, retornar -999,-999, etc (documente). O teto de salario 
--max 10000,cehegou a 10000nao aumenta mais o salario 




CREATE OR REPLACE
PROCEDURE PROC_AUMENTAR_SALARIO(P_ID IN HR.PESSOA.ID%TYPE,
                                P_PORCENT IN NUMBER,
                                P_SAIDA OUT NUMBER) ----- TRES PARAMETROS, 3 DE ENTRADA 1 SAIDA-----------
IS 
    V_QTDE NUMBER (1);
    V_SALARIO PESSOA.SALARIO%TYPE;
    V_NOVO_SALARIO PESSOA.SALARIO%TYPE;
    
BEGIN 
                 IF P_PORCENT >0 AND P_PORCENT  <=10  THEN    
                        SELECT COUNT(*) INTO V_QTDE FROM PESSOA WHERE ID = P_ID AND SALARIO<10000;
                        IF V_QTDE = 0 THEN 
                        SELECT SALARIO INTO 
                        FROM PESSOA
                        WHERE ID=P_ID AND SALARIO <10000;
                        (V_SALARIO_ATUAL= SALARIO /)
                        V_SALARIO_NOVO= (SALARIO*P_PORCENT/100 )
                        IF CONDICAO AQUI 
                      IF V_QTDE = 0 THEN 
                        UPDATE 
                        P_SAIDA :=0; --INSERIDO COM SUCESSO
                 ELSE 
                    P_SAIDA:=-999; --JÁ EXISTE NA TABELA
                 END IF
        

   COMMIT;
EXCEPTION  
WHEN OTHERS THEN 
    ROLLBACK;
    P_SAIDA:=SQLCODE;
    DBMS_OUTPUT.PUT_LINE('CODIGO DO ERRO  É: ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('DESCRICAO DO ERRO  É: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('LINHA DO ERROÉ: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
