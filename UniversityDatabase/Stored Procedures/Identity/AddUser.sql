CREATE PROCEDURE [Identity].[AddUser]
    @Username VARCHAR(100),
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @PlainTextPassword VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ResultData NVARCHAR(MAX);
    DECLARE @ResultError VARCHAR(MAX);
    DECLARE @IsSuccess BIT;
    -- Check if the username is available
    IF NOT EXISTS (SELECT 1 FROM [Identity].[Users] WHERE Username = @Username)
    BEGIN
        DECLARE @PasswordSalt VARCHAR(1000);
        DECLARE @PasswordHash VARCHAR(MAX);

        -- Generate a random password salt
        SET @PasswordSalt = CAST(CRYPT_GEN_RANDOM(32) AS VARCHAR(1000));

        -- Hash the password using SHA-256 algorithm
        SET @PasswordHash = HASHBYTES('SHA2_256', @PlainTextPassword + @PasswordSalt);

        -- Add the new user with hashed password
        INSERT INTO [Identity].[Users] 
        (
            Username, 
            FirstName, 
            LastName, 
            PasswordHash, 
            PasswordSalt,
            CreatedBy,
            CreatedOn
        )
        VALUES (@Username, @FirstName, @LastName, @PasswordHash, @PasswordSalt, SYSTEM_USER, GETDATE());
        
        SET @IsSuccess = 1;

        SET @ResultData = (SELECT 'User added successfully.' AS Message
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    END
    ELSE
    BEGIN
        SET @IsSuccess = 0;
        SET @ResultError = 'Username already exists. Please choose a different username.';
    END

    SELECT @IsSuccess as [Is Success], @ResultData as [Data], @ResultError as [Error]; 
END;