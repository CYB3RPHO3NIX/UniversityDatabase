CREATE TABLE [Identity].[UsersRolesMap] (
    [UserId] BIGINT NOT NULL,
    [RoleId] BIGINT NOT NULL,
    CONSTRAINT PK_UsersRoles PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_UsersRoles_Users FOREIGN KEY (UserId) REFERENCES [Identity].[Users](UserId) ON DELETE CASCADE,
    CONSTRAINT FK_UsersRoles_Roles FOREIGN KEY (RoleId) REFERENCES [Identity].[Roles](RoleId) ON DELETE CASCADE
);
