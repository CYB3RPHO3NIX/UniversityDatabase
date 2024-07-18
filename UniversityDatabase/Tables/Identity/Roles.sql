CREATE TABLE [Identity].[Roles](
	[RoleId] [bigint] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[RoleName] [varchar](100) UNIQUE NOT NULL,
	[Description] [varchar](1000) NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[UpdatedBy] [varchar](100) NULL,
	[UpdatedOn] [datetime2](7) NULL
)