CREATE PROCEDURE [Identity].[AddRoleToUser]
    @UserId BIGINT,
    @RoleId BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ResultData NVARCHAR(MAX);
    DECLARE @ResultError VARCHAR(MAX);
    DECLARE @IsSuccess BIT;
    -- Check if the user and role exist
    IF EXISTS (SELECT 1 FROM [Identity].[Users] WHERE UserId = @UserId) AND EXISTS (SELECT 1 FROM [Identity].[Roles] WHERE RoleId = @RoleId)
    BEGIN
        -- Check if the role is already assigned to the user
        IF NOT EXISTS (SELECT 1 FROM [Identity].[UsersRolesMap] WHERE UserId = @UserId AND RoleId = @RoleId)
        BEGIN
            -- Insert the role assignment
            INSERT INTO [Identity].[UsersRolesMap] (UserId, RoleId)
            VALUES (@UserId, @RoleId);

            SET @IsSuccess = 1;
            SET @ResultData = (SELECT 'Role added to user successfully.' AS Message
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);
        END
        ELSE
        BEGIN
            SET @IsSuccess = 0;
            SET @ResultError = 'Role is already assigned to the user.';
        END
    END
    ELSE
    BEGIN
        SET @IsSuccess = 0;
        SET @ResultError = 'User or Role does not exist.';
    END
    SELECT @IsSuccess as [Is Success], @ResultData as [Data], @ResultError as [Error]; 
END;