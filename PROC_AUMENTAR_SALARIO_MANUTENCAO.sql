-- Desenvolver uma procedure que receba o ID de um funcionário e um percentual de aumento salarial.
-- A procedure deve verificar se o percentual está entre maior que 0 e menor ou igual a 10.
-- Verificar se o funcionário existe na tabela PESSOA e se seu salário é inferior a 10.000.
-- Caso exista, calcular o novo salário com base no percentual informado.
-- Se o novo salário ultrapassar 10.000, deve ser limitado a 10.000.
-- Atualizar o salário do funcionário na tabela.
-- Retornar 0 para indicar sucesso.
-- Caso o funcionário não exista, retornar -999.
-- Caso o percentual esteja fora da faixa permitida, retornar -998.
-- Caso o salário já seja igual ou superior a 10.000, retornar -997.
-- Em caso de erro, retornar o código do erro.

CREATE OR REPLACE
PROCEDURE PROC_AUMENTAR_SALARIO(P_ID IN HR.PESSOA.ID%TYPE,
                                P_PORCENT IN NUMBER,
                                P_SAIDA OUT NUMBER) ----- TRES PARAMETROS, 3 DE ENTRADA 1 SAIDA-----------
IS 
    V_QTDE NUMBER (1);
    V_SALARIO PESSOA.SALARIO%TYPE;
    V_NOVO_SALARIO PESSOA.SALARIO%TYPE; --Salario novo usa o mesmo tipo e tamanho da variavel Salario --
    
BEGIN 
                IF P_PORCENT >0 AND P_PORCENT <=10 THEN    
                        SELECT COUNT(*) INTO V_QTDE FROM PESSOA WHERE ID = P_ID;
                        IF V_QTDE = 1 THEN 
                            SELECT SALARIO INTO V_SALARIO
                            FROM PESSOA  
                                WHERE ID= P_ID;
                                IF V_SALARIO < 10000 THEN 
                                    V_NOVO_SALARIO= V_SALARIO +((V_SALARIO /100)*P_PORCENT);

                                    IF V_NOVO_SALARIO > 10000 THEN 
                                        V_NOVO_SALARIO:=10000;
                                    END IF;
                                    UPDATE PESSOA SET SALARIO = V_NOVO_SALARIO WHERE ID=P_ID;
                                    P_SAIDA :=0; --INSERIDO COM SUCESSO --
                                ELSE 
                                P_SAIDA :=-997;--SALARIO FORA DA FAIXA
                            END IF;
                        ELSE 
                            P_SAIDA:= -999;--O FUNCIONARIO NÃO EXISTE --
                        END IF;
                 ELSE 
                    P_SAIDA:=-998; --PORCENTUAL NÃO CORRESPONDE A FAIXA--
                END IF;
   COMMIT;
EXCEPTION  
WHEN OTHERS THEN 
    ROLLBACK;
    P_SAIDA:=SQLCODE;
    DBMS_OUTPUT.PUT_LINE('CODIGO DO ERRO  É: ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('DESCRICAO DO ERRO  É: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('LINHA DO ERROÉ: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;