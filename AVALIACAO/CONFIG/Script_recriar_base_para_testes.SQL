-- Definir o nome do banco de dados
DECLARE @DatabaseName NVARCHAR(255) = 'POSENGDADOS';

-- Verificar se o banco de dados existe e eliminá-lo
IF EXISTS (SELECT * FROM sys.databases WHERE name = @DatabaseName)
BEGIN
    -- Alterar o contexto para o banco de dados master
    USE master;
    
    -- Definir o banco de dados como modo single_user para garantir a eliminação
    EXEC('ALTER DATABASE ' + @DatabaseName + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE');
    
    -- Eliminar o banco de dados
    EXEC('DROP DATABASE ' + @DatabaseName);
END

-- Recriar o banco de dados
EXEC('CREATE DATABASE ' + @DatabaseName);