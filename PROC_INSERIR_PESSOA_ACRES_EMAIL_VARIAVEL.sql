
CREATE TABLE PESSOA (
 ID INT PRIMARY KEY,
 NOME VARCHAR(60) NOT NULL,
 SALARIO NUMBER(10,2) NOT NULL,
 EMAIL VARCHAR(240) NULL
);
ALTER TABLE PESSOA ADD  EMAIL VARCHAR(240);

CREATE OR REPLACE
PROCEDURE PROC_INSERIR_PESSOA(P_ID IN HR.PESSOA.ID%TYPE,
                                P_NOME IN HR.PESSOA.NOME%TYPE,
                                P_SALARIO IN HR.PESSOA.SALARIO%TYPE,
                                P_EMAIL IN HR.PESSOA.EMAIL%TYPE,
                                P_SAIDA OUT NUMBER) ----- TRES PARAMETROS, 3 DE ENTRADA 1 SAIDA-----------
IS 
    V_QTDE NUMBER;
BEGIN 
    IF P_ID>=1 AND P_ID<= 99999 THEN
        IF LENGTH(P_NOME) >=1 AND LENGTH (P_NOME) <=60 THEN
            IF P_SALARIO >0 AND P_SALARIO  <=99999999.99  THEN 
              IF P_EMAIL IS NULL OR  ( LENGTH(P_EMAIL) >=1 AND LENGTH (P_EMAIL) <=240) THEN
                        SELECT COUNT(*) INTO V_QTDE
                        FROM PESSOA
                        WHERE ID=P_ID;
                        IF V_QTDE = 0 THEN 
                                INSERT INTO PESSOA (ID,NOME, SALARIO, EMAIL)
                                    VALUES (P_ID, P_NOME,P_SALARIO,P_EMAIL);
                                P_SAIDA :=0; --INSERIDO COM SUCESSO
                        ELSE 
                            P_SAIDA:=-1; --JÁ EXISTE NA TABELA
                        END IF;

                ELSE 
                      P_SAIDA:=-5;----EMAIL INVALIDO---
                END IF;

            ELSE 
                P_SAIDA :=-4; -- SALARIO FORA DA FAIXA DE VALOR ACEITAVEL
            END IF;

        ELSE 
            P_SAIDA:=-3; ---NOME TEM QUE TER ENTRE 1 E 60 CARACTER DE TAMANHO--
        END IF;
    ELSE
        P_SAIDA :=-2 ; --ID FORA DA FAIXA DE VALOR ACEITAVEL 
        
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


---------------testes-------------
INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (1, 'Carlos Silva', 4500.50, 'carlos@email.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (2, 'Maria Souza', 7200.00, 'maria@gmail.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (3, 'Joao Pereira', 3800.75, 'joao@yahoo.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (4, 'Ana Costa', 6100.00, 'ana.costa@email.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (5, 'Pedro Lima', 5200.40, 'pedro.lima@gmail.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (6, 'Lucas Rocha', 8900.00, 'lucas@email.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (7, 'Fernanda Alves', 4700.30, 'fernanda@email.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (8, 'Ricardo Martins', 9500.00, 'ricardo@gmail.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (9, 'Juliana Ramos', 6400.20, 'juliana@email.com');

INSERT INTO PESSOA (ID, NOME, SALARIO, EMAIL) VALUES (10, 'Bruno Carvalho', 7100.90, NULL);