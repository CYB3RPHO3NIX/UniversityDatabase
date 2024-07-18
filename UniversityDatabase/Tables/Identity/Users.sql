CREATE TABLE [Identity].[Users](
	[UserId] [bigint] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NOT NULL UNIQUE,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[PasswordHash] [varchar](max) NOT NULL,
	[PasswordSalt] [varchar](1000) NOT NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[UpdatedBy] [varchar](100) NULL,
	[UpdatedOn] [datetime2](7) NULL
)