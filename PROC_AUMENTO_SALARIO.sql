CREATE TABLE PESSOA (
 ID INT PRIMARY KEY,
 NOME VARCHAR(60) NOT NULL,
 SALARIO NUMBER(10,2) NOT NULL,
 EMAIL VARCHAR(240) NULL
);



CREATE OR REPLACE
PROCEDURE PROC_AUMENTOSALARIOPESSOA(P_ID IN PESSOA.ID%TYPE,
                                    P_PERC IN NUMBER,
                                    P_SAIDA OUT NUMBER)
IS
    V_QTDE NUMBER(1);
    V_SALARIO PESSOA.SALARIO%TYPE;
    V_NOVO_SALARIO PESSOA.SALARIO%TYPE;
BEGIN
    IF P_PERC > 0 AND P_PERC <= 10 THEN
            SELECT COUNT(*) INTO V_QTDE FROM PESSOA WHERE ID = P_ID ;
            IF V_QTDE = 1 THEN
                    SELECT SALARIO INTO V_SALARIO FROM PESSOA WHERE ID = P_ID;
                    IF V_SALARIO <=10000 THEN 
                        V_NOVO_SALARIO = V_SALARIO + (V_SALARIO * (P_PERC/100));
                            IF V_NOVO_SALARIO > 10000 THEN
                                V_NOVO_SALARIO := 10000;
                            END IF;
                        UPDATE PESSOA SET SALARIO = V_NOVO_SALARIO WHERE ID = P_ID;
                    P_SAIDA := 0;
                    ELSE 
                        P_SAIDA :=-997;--SALARIO FORA DA FAIXA
            ELSE
                P_SAIDA := -999; /* FUNCIONÁRIO NÃO EXISTE */
            END IF;
    ELSE
        P_SAIDA := -998; /* PERCENTUAL FORA DA FAIXA DE VALOR */
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        P_SAIDA := SQLCODE;
END;

 DECLARE 
        RET NUMBER ;
   BEGIN
         PROC_AUMENTOSALARIOPESSOA(1,10,RET);
        DBMS_OUTPUT.PUT_LINE('RETORNOU  ' || RET);
   END;