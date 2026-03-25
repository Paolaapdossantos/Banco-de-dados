CREATE OR ALTER PROCEDURE PROC_INSERIR_PESSOA
(
    @P_ID INT,
    @P_NOME VARCHAR(60),
    @P_SALARIO DECIMAL(10,2),
    @P_SAIDA INT OUTPUT
)
AS
BEGIN
    DECLARE @V_QTDE INT; --colocar sempre um arroba na variavel ---

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @P_ID >= 1 AND @P_ID <= 99999
        BEGIN
            IF LEN(@P_NOME) >= 1 AND LEN(@P_NOME) <= 60
            BEGIN
                IF @P_SALARIO > 0 AND @P_SALARIO <= 99999999.99
                BEGIN
                    SELECT @V_QTDE = COUNT(*)
                    FROM PESSOA
                    WHERE ID = @P_ID;

                    IF @V_QTDE = 0
                    BEGIN
                        INSERT INTO PESSOA (ID, NOME, SALARIO)
                        VALUES (@P_ID, @P_NOME, @P_SALARIO);

                        SET @P_SAIDA = 0; -- Inserido com sucesso
                    END
                    ELSE
                    BEGIN
                        SET @P_SAIDA = -1; -- Já existe na tabela
                    END
                END
                ELSE
                BEGIN
                    SET @P_SAIDA = -4; -- Salário fora da faixa
                END
            END
            ELSE
            BEGIN
                SET @P_SAIDA = -3; -- Nome fora do tamanho permitido
            END
        END
        ELSE
        BEGIN
            SET @P_SAIDA = -2; -- ID fora da faixa
        END

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;

        SET @P_SAIDA = ERROR_NUMBER();

        PRINT 'CODIGO DO ERRO: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'DESCRICAO DO ERRO: ' + ERROR_MESSAGE();
        PRINT 'LINHA DO ERRO: ' + CAST(ERROR_LINE() AS VARCHAR);
    END CATCH
END