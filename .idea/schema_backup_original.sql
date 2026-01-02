-- DROP SCHEMA BRD;

CREATE SCHEMA BRD;
-- InfinityRetailDB.BRD.Data_HO_SalesInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoiceItems;

CREATE TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoiceItems (
	SalesInvoiceItemID_PK bigint IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) NOT NULL,
	DiscountAmount decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	ItemNote nvarchar(250) COLLATE Arabic_CI_AS NULL,
	IsQYTDelivered bit NOT NULL,
	TotalSalesPoints int NOT NULL,
	SerialNo nvarchar(4000) COLLATE Arabic_CI_AS NULL,
	PackageUnitID_FK smallint NULL,
	PackageUnitBaseQYT decimal(10,3) NULL
);


-- InfinityRetailDB.BRD.Data_HO_SalesInvoicePayments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoicePayments;

CREATE TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoicePayments (
	SalesInvoicePaymentID_PK int IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	PaymentMethodID_FK smallint NOT NULL,
	CurrencyXchangeRate decimal(10,5) NOT NULL,
	PaymentAmount decimal(15,3) NOT NULL,
	LocCurrencyPaymentAmount decimal(15,3) NOT NULL,
	PaymentNote nvarchar(500) COLLATE Arabic_CI_AS NULL,
	EPaymentTerminalID_FK int NULL,
	EPaymentTransactionReference nvarchar(20) COLLATE Arabic_CI_AS NULL,
	EPaymentVoucherAmount decimal(15,3) NULL,
	EPaymentVoucherLocCurrencyAmount decimal(15,3) NULL,
	EPaymentVoucherNote nvarchar(25) COLLATE Arabic_CI_AS NULL,
);


-- InfinityRetailDB.BRD.Data_HO_SalesInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoices;

CREATE TABLE InfinityRetailDB.BRD.Data_HO_SalesInvoices (
	SalesInvoiceID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	WsID_FK tinyint NOT NULL,
	POSTerminalShiftID_FK int NULL,
	SalesInvoiceDate datetime NOT NULL,
	CustomerID_FK int NOT NULL,
	CashCustomerName nvarchar(75) COLLATE Arabic_CI_AS NULL,
	SalePersonID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	SalesInvoiceStateID_FK smallint NOT NULL,
	InvoiceNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceSubTotal decimal(15,3) NOT NULL,
	InvoiceDiscountTotal decimal(15,3) NOT NULL,
	InvoiceNetTotal decimal(15,3) NOT NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	PaymentCount tinyint NOT NULL,
	PaymentCaption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	Cash decimal(15,3) NOT NULL,
	[Change] decimal(15,3) NOT NULL,
	TransactionBarcode nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	OrderNumber int NOT NULL,
	OrderType nvarchar(10) COLLATE Arabic_CI_AS NULL,
	CustomerPriceTypeID_FK int NOT NULL,
	CustomerDiscountDefaultValue decimal(15,3) NOT NULL,
	CustomerDiscountUsedAsPersentage bit NOT NULL,
	LocationID_FK int NOT NULL,
	SourceInvoiceID_FK int NULL,
	DeliveryNotePrintCount int NOT NULL
);


-- InfinityRetailDB.BRD.Data_HO_StockTransferProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_HO_StockTransferProducts;

CREATE TABLE InfinityRetailDB.BRD.Data_HO_StockTransferProducts (
	StockTransferProductID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	StockOnHand decimal(10,3) NOT NULL,
	TransferredQYT decimal(10,3) NOT NULL,
	TransferredValue decimal(12,3) NOT NULL,
	IntransitQYT decimal(10,3) NOT NULL,
	ReceivedQYT decimal(10,3) NOT NULL,
	AddedToInventoryQYT decimal(10,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	ExpiryDate datetime NULL,
);


-- InfinityRetailDB.BRD.Data_HO_StockTransfers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_HO_StockTransfers;

CREATE TABLE InfinityRetailDB.BRD.Data_HO_StockTransfers (
	StockTransferID_PK int IDENTITY(1,1) NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NOT NULL,
	StockTransferNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	DocumentDate datetime NOT NULL,
	RequestedAtDate datetime NOT NULL,
	ReceivedDate datetime NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	StockTransferNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	StockTransferStateID_FK int NOT NULL,
	JournalEntryID_FK int NULL,
);


-- InfinityRetailDB.BRD.Data_SalesInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_SalesInvoiceItems;

CREATE TABLE InfinityRetailDB.BRD.Data_SalesInvoiceItems (
	SalesInvoiceItemID_PK bigint IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) NOT NULL,
	DiscountAmount decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	ItemNote nvarchar(250) COLLATE Arabic_CI_AS NULL,
	IsQYTDelivered bit NOT NULL,
	TotalSalesPoints int NOT NULL,
	SerialNo nvarchar(4000) COLLATE Arabic_CI_AS NULL
);


-- InfinityRetailDB.BRD.Data_SalesInvoicePayments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_SalesInvoicePayments;

CREATE TABLE InfinityRetailDB.BRD.Data_SalesInvoicePayments (
	SalesInvoicePaymentID_PK int IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	PaymentMethodID_FK smallint NOT NULL,
	CurrencyXchangeRate decimal(10,5) NOT NULL,
	PaymentAmount decimal(15,3) NOT NULL,
	LocCurrencyPaymentAmount decimal(15,3) NOT NULL,
	PaymentNote nvarchar(500) COLLATE Arabic_CI_AS NULL,
	EPaymentTerminalID_FK int NULL,
	EPaymentTransactionReference nvarchar(20) COLLATE Arabic_CI_AS NULL,
	EPaymentVoucherAmount decimal(15,3) NULL,
	EPaymentVoucherLocCurrencyAmount decimal(15,3) NULL,
	EPaymentVoucherNote nvarchar(25) COLLATE Arabic_CI_AS NULL,
);


-- InfinityRetailDB.BRD.Data_SalesInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_SalesInvoices;

CREATE TABLE InfinityRetailDB.BRD.Data_SalesInvoices (
	SalesInvoiceID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	WsID_FK tinyint NOT NULL,
	POSTerminalShiftID_FK int NULL,
	SalesInvoiceDate datetime NOT NULL,
	CustomerID_FK int NOT NULL,
	CashCustomerName nvarchar(75) COLLATE Arabic_CI_AS NULL,
	SalePersonID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	SalesInvoiceStateID_FK smallint NOT NULL,
	InvoiceNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceSubTotal decimal(15,3) NOT NULL,
	InvoiceDiscountTotal decimal(15,3) NOT NULL,
	InvoiceNetTotal decimal(15,3) NOT NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	PaymentCount tinyint NOT NULL,
	PaymentCaption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	Cash decimal(15,3) NOT NULL,
	[Change] decimal(15,3) NOT NULL,
	TransactionBarcode nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	CreatedByUserID smallint NOT NULL,
	CreatedByUserName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	Createddate datetime NOT NULL,
	modifiedByUserID smallint NULL,
	modifiedByUserName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	modifiedDate datetime NULL,
	OrderNumber int NOT NULL,
	OrderType nvarchar(10) COLLATE Arabic_CI_AS NULL,
	CustomerPriceTypeID_FK int NOT NULL,
	CustomerDiscountDefaultValue decimal(15,3) NOT NULL,
	CustomerDiscountUsedAsPersentage bit NOT NULL,
	LocationID_FK int NOT NULL,
	IsSynced bit NOT NULL,
	SourceInvoiceID_FK int NULL,
	DeliveryNotePrintCount int NOT NULL
);


-- InfinityRetailDB.BRD.Data_StockTransferProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_StockTransferProducts;

CREATE TABLE InfinityRetailDB.BRD.Data_StockTransferProducts (
	StockTransferProductID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	StockOnHand decimal(10,3) NOT NULL,
	TransferredQYT decimal(10,3) NOT NULL,
	TransferredValue decimal(12,3) NOT NULL,
	IntransitQYT decimal(10,3) NOT NULL,
	ReceivedQYT decimal(10,3) NOT NULL,
	AddedToInventoryQYT decimal(10,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	ExpiryDate datetime NULL,
);


-- InfinityRetailDB.BRD.Data_StockTransfers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.BRD.Data_StockTransfers;

CREATE TABLE InfinityRetailDB.BRD.Data_StockTransfers (
	StockTransferID_PK int IDENTITY(1,1) NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NOT NULL,
	StockTransferNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	DocumentDate datetime NOT NULL,
	RequestedAtDate datetime NOT NULL,
	ReceivedDate datetime NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	StockTransferNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	StockTransferStateID_FK int NOT NULL,
	JournalEntryID_FK int NULL,
);

-- DROP SCHEMA COREM;

CREATE SCHEMA COREM;

-- DROP SCHEMA db_accessadmin;

CREATE SCHEMA db_accessadmin;

-- DROP SCHEMA db_backupoperator;

CREATE SCHEMA db_backupoperator;

-- DROP SCHEMA db_datareader;

CREATE SCHEMA db_datareader;

-- DROP SCHEMA db_datawriter;

CREATE SCHEMA db_datawriter;

-- DROP SCHEMA db_ddladmin;

CREATE SCHEMA db_ddladmin;

-- DROP SCHEMA db_denydatareader;

CREATE SCHEMA db_denydatareader;

-- DROP SCHEMA db_denydatawriter;

CREATE SCHEMA db_denydatawriter;

-- DROP SCHEMA db_owner;

CREATE SCHEMA db_owner;

-- DROP SCHEMA db_securityadmin;

CREATE SCHEMA db_securityadmin;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- InfinityRetailDB.dbo.Log_DeletedItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.dbo.Log_DeletedItems;

CREATE TABLE InfinityRetailDB.dbo.Log_DeletedItems (
	LogID_PK bigint IDENTITY(1,1) NOT NULL,
	DeletedItemID bigint NOT NULL,
	ActionTableName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Log_DeletedItems PRIMARY KEY (LogID_PK)
);


-- InfinityRetailDB.dbo.RAG_Knowledge definition

-- Drop table

-- DROP TABLE InfinityRetailDB.dbo.RAG_Knowledge;

CREATE TABLE InfinityRetailDB.dbo.RAG_Knowledge (
	RAGID int IDENTITY(1,1) NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NULL,
	Title nvarchar(250) COLLATE Arabic_CI_AS NULL,
	Details nvarchar(MAX) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK__RAG_Know__4F4568DF150940AD PRIMARY KEY (RAGID)
);


-- InfinityRetailDB.dbo.dtproperties definition

-- Drop table

-- DROP TABLE InfinityRetailDB.dbo.dtproperties;

CREATE TABLE InfinityRetailDB.dbo.dtproperties (
	id int IDENTITY(1,1) NOT NULL,
	objectid int NULL,
	property varchar(64) COLLATE Arabic_CI_AS NOT NULL,
	value varchar(255) COLLATE Arabic_CI_AS NULL,
	uvalue nvarchar(255) COLLATE Arabic_CI_AS NULL,
	lvalue image NULL,
	version int DEFAULT 0 NOT NULL,
	CONSTRAINT pk_dtproperties PRIMARY KEY (id,property)
);


-- InfinityRetailDB.dbo.sysdiagrams definition

-- Drop table

-- DROP TABLE InfinityRetailDB.dbo.sysdiagrams;

CREATE TABLE InfinityRetailDB.dbo.sysdiagrams (
	name sysname COLLATE Arabic_CI_AS NOT NULL,
	principal_id int NOT NULL,
	diagram_id int IDENTITY(1,1) NOT NULL,
	version int NULL,
	definition varbinary(MAX) NULL,
	CONSTRAINT PK__sysdiagrams__4707859D PRIMARY KEY (diagram_id),
	CONSTRAINT UK_principal_name UNIQUE (principal_id,name)
);

-- DROP SCHEMA Financial;

CREATE SCHEMA Financial;
-- InfinityRetailDB.Financial.RefAccountClassifications definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefAccountClassifications;

CREATE TABLE InfinityRetailDB.Financial.RefAccountClassifications (
	AccountClassificationID_PK tinyint IDENTITY(1,1) NOT NULL,
	AccountClassification nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountsNature tinyint DEFAULT 0 NOT NULL,
	CONSTRAINT PK_RefAccountClassifications PRIMARY KEY (AccountClassificationID_PK)
);


-- InfinityRetailDB.Financial.RefAccountHeads definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefAccountHeads;

CREATE TABLE InfinityRetailDB.Financial.RefAccountHeads (
	AccountHeadID_PK tinyint IDENTITY(1,1) NOT NULL,
	AccountHeadCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountHeadClassification nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefAccountTypes PRIMARY KEY (AccountHeadID_PK)
);


-- InfinityRetailDB.Financial.RefCostCenters definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefCostCenters;

CREATE TABLE InfinityRetailDB.Financial.RefCostCenters (
	CostCenterID_PK int IDENTITY(1,1) NOT NULL,
	CostCenterName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefCostCenters PRIMARY KEY (CostCenterID_PK)
);


-- InfinityRetailDB.Financial.RefFinancialYears definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefFinancialYears;

CREATE TABLE InfinityRetailDB.Financial.RefFinancialYears (
	FinancialYear int NOT NULL,
	FinancialYearCaption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	StarDate datetime NOT NULL,
	EndDate datetime NOT NULL,
	IsClosed bit NOT NULL,
	IsCurrentYear bit NOT NULL,
	CONSTRAINT PK_RefFinancialYears PRIMARY KEY (FinancialYear)
);


-- InfinityRetailDB.Financial.RefJournalEntryTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefJournalEntryTypes;

CREATE TABLE InfinityRetailDB.Financial.RefJournalEntryTypes (
	JEntryType_ID_PK tinyint IDENTITY(1,1) NOT NULL,
	JEntryType_Code nvarchar(5) COLLATE Arabic_CI_AS NULL,
	JEntryType_Caption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefJournalEntryTypes PRIMARY KEY (JEntryType_ID_PK)
);


-- InfinityRetailDB.Financial.Data_JournalEntries definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Data_JournalEntries;

CREATE TABLE InfinityRetailDB.Financial.Data_JournalEntries (
	JournalEntryID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	JournalEntryTypeID_FK tinyint NOT NULL,
	JournalEntryNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	JournalEntryDate datetime NOT NULL,
	JournalEntryDecription nvarchar(500) COLLATE Arabic_CI_AS NOT NULL,
	IsPosted bit NOT NULL,
	IsCreatedBySystem bit DEFAULT 0 NOT NULL,
	FinancialYear int NULL,
	CONSTRAINT PK_Data_Transactions PRIMARY KEY (JournalEntryID_PK),
	CONSTRAINT FK_Data_JournalEntries_RefFinancialYears FOREIGN KEY (FinancialYear) REFERENCES InfinityRetailDB.Financial.RefFinancialYears(FinancialYear)
);
 CREATE NONCLUSTERED INDEX IX_Data_JournalEntries_JournalEntryDate ON InfinityRetailDB.Financial.Data_JournalEntries (  JournalEntryDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Financial.Log_DeletedJournalEntries definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Log_DeletedJournalEntries;

CREATE TABLE InfinityRetailDB.Financial.Log_DeletedJournalEntries (
	JournalEntryID_PK int NOT NULL,
	BranchID_FK int NOT NULL,
	JournalEntryTypeID_FK tinyint NOT NULL,
	JournalEntryNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	JournalEntryDate datetime NOT NULL,
	JournalEntryDecription nvarchar(500) COLLATE Arabic_CI_AS NOT NULL,
	IsCreatedBySystem bit DEFAULT 0 NOT NULL,
	DeletedByUserID int NOT NULL,
	DeletedByUserName nvarchar(60) COLLATE Arabic_CI_AS NOT NULL,
	DeletedDate datetime NOT NULL,
	FinancialYear int NULL,
	CONSTRAINT PK_Log_DeletedJournalEntries PRIMARY KEY (JournalEntryID_PK),
	CONSTRAINT FK_Log_DeletedJournalEntries_RefFinancialYears FOREIGN KEY (FinancialYear) REFERENCES InfinityRetailDB.Financial.RefFinancialYears(FinancialYear)
);


-- InfinityRetailDB.Financial.Log_DeletedJournalEntryDetails definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Log_DeletedJournalEntryDetails;

CREATE TABLE InfinityRetailDB.Financial.Log_DeletedJournalEntryDetails (
	JournalEntryDetailID_PK int NOT NULL,
	JournalEntryID_FK int NOT NULL,
	JEntryDate datetime NOT NULL,
	AccountNumber nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	JEntryDescription nvarchar(500) COLLATE Arabic_CI_AS NOT NULL,
	TransactionRef nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CreditAmount decimal(12,3) NOT NULL,
	DebitAmount decimal(12,3) NOT NULL,
	TransSourceID_FK tinyint NOT NULL,
	DocumentID_FK int NOT NULL,
	CONSTRAINT PK_Log_DeletedJournalEntryDetails PRIMARY KEY (JournalEntryDetailID_PK),
	CONSTRAINT FK_Log_DeletedJournalEntryDetails_Log_DeletedJournalEntries FOREIGN KEY (JournalEntryID_FK) REFERENCES InfinityRetailDB.Financial.Log_DeletedJournalEntries(JournalEntryID_PK)
);


-- InfinityRetailDB.Financial.RefAccountGroups definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefAccountGroups;

CREATE TABLE InfinityRetailDB.Financial.RefAccountGroups (
	AccountGroupID_PK tinyint IDENTITY(1,1) NOT NULL,
	AccountGroupNumber int NULL,
	AccountGroupCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountGroupCaptionEnglish nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountHeadID_FK tinyint NOT NULL,
	CONSTRAINT PK_RefAccountGroups PRIMARY KEY (AccountGroupID_PK),
	CONSTRAINT FK_RefAccountGroups_RefAccountHeads FOREIGN KEY (AccountHeadID_FK) REFERENCES InfinityRetailDB.Financial.RefAccountHeads(AccountHeadID_PK)
);


-- InfinityRetailDB.Financial.RefAccountSubGroups definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.RefAccountSubGroups;

CREATE TABLE InfinityRetailDB.Financial.RefAccountSubGroups (
	AccountSubGroupID_PK smallint IDENTITY(1,1) NOT NULL,
	AccountSubGroupNumber int NULL,
	AccountSubGroupCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountSubGroupCaptionEnglish nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	AccountGroupID_FK tinyint NOT NULL,
	AccountClassificationID_FK tinyint NULL,
	CONSTRAINT PK_RefAccountSubGroups PRIMARY KEY (AccountSubGroupID_PK),
	CONSTRAINT FK_RefAccountSubGroups_RefAccountClassifications FOREIGN KEY (AccountClassificationID_FK) REFERENCES InfinityRetailDB.Financial.RefAccountClassifications(AccountClassificationID_PK),
	CONSTRAINT FK_RefAccountSubGroups_RefAccountGroups FOREIGN KEY (AccountGroupID_FK) REFERENCES InfinityRetailDB.Financial.RefAccountGroups(AccountGroupID_PK)
);


-- InfinityRetailDB.Financial.Data_Accounts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Data_Accounts;

CREATE TABLE InfinityRetailDB.Financial.Data_Accounts (
	AccountID_PK int IDENTITY(1,1) NOT NULL,
	AccountSubGroupID_FK smallint NOT NULL,
	AccountNumber bigint NOT NULL,
	AccountName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	AccountDescription nvarchar(250) COLLATE Arabic_CI_AS NULL,
	AccountTotalDebit decimal(12,3) DEFAULT 0 NOT NULL,
	AccountTotalCredit decimal(12,3) NOT NULL,
	IsReadOnlyAccount bit NOT NULL,
	IsActiveAccount bit DEFAULT 1 NOT NULL,
	CostCenterID_FK int NULL,
	AccountOpenBalance decimal(13,3) DEFAULT 0 NOT NULL,
	MainAccountID_FK int NULL,
	CONSTRAINT PK_Data_Accounts PRIMARY KEY (AccountID_PK),
	CONSTRAINT FK_Data_Accounts_RefAccountSubGroups FOREIGN KEY (AccountSubGroupID_FK) REFERENCES InfinityRetailDB.Financial.RefAccountSubGroups(AccountSubGroupID_PK),
	CONSTRAINT FK_Data_Accounts_RefCostCenters FOREIGN KEY (CostCenterID_FK) REFERENCES InfinityRetailDB.Financial.RefCostCenters(CostCenterID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_Accounts_AccountSubGroupID_FK ON InfinityRetailDB.Financial.Data_Accounts (  AccountSubGroupID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Financial.Data_JournalEntryDetails definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Data_JournalEntryDetails;

CREATE TABLE InfinityRetailDB.Financial.Data_JournalEntryDetails (
	JournalEntryDetailID_PK int IDENTITY(1,1) NOT NULL,
	JournalEntryID_FK int NOT NULL,
	JEntryDate datetime NOT NULL,
	AccountID_FK int NOT NULL,
	JEntryDescription nvarchar(500) COLLATE Arabic_CI_AS NOT NULL,
	TransactionRef nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CreditAmount decimal(12,3) NOT NULL,
	DebitAmount decimal(12,3) NOT NULL,
	TransSourceID_FK tinyint NOT NULL,
	DocumentID_FK int NOT NULL,
	SalesPersonID_FK int NULL,
	CostCenterID_FK int NOT NULL,
	SystemAudit nvarchar(750) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_AccountTransactions PRIMARY KEY (JournalEntryDetailID_PK),
	CONSTRAINT FK_Data_AccountTransactions_Data_Accounts FOREIGN KEY (AccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK),
	CONSTRAINT FK_Data_JournalEntryDetails_Data_JournalEntries FOREIGN KEY (JournalEntryID_FK) REFERENCES InfinityRetailDB.Financial.Data_JournalEntries(JournalEntryID_PK),
	CONSTRAINT FK_Data_JournalEntryDetails_RefCostCenters FOREIGN KEY (CostCenterID_FK) REFERENCES InfinityRetailDB.Financial.RefCostCenters(CostCenterID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_JournalEntryDetails_AccountID_FK ON InfinityRetailDB.Financial.Data_JournalEntryDetails (  AccountID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_JournalEntryDetails_CostCenterID_FK ON InfinityRetailDB.Financial.Data_JournalEntryDetails (  CostCenterID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_JournalEntryDetails_JEntryDate ON InfinityRetailDB.Financial.Data_JournalEntryDetails (  JEntryDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_JournalEntryDetails_JournalEntryID_FK ON InfinityRetailDB.Financial.Data_JournalEntryDetails (  JournalEntryID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Financial.Data_UnPosted_JournalEntries definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Data_UnPosted_JournalEntries;

CREATE TABLE InfinityRetailDB.Financial.Data_UnPosted_JournalEntries (
	UnPosted_JournalEntryID_PK int IDENTITY(1,1) NOT NULL,
	JEntryDate datetime NOT NULL,
	AccountID_FK int NOT NULL,
	JEntryDescription nvarchar(500) COLLATE Arabic_CI_AS NULL,
	TransactionRef nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CreditAmount decimal(12,3) NOT NULL,
	DebitAmount decimal(12,3) NOT NULL,
	TransSourceID_FK tinyint NOT NULL,
	DocumentID_FK int NOT NULL,
	SystemAudit nvarchar(750) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_UnPosted_JournalEntryID_PK PRIMARY KEY (UnPosted_JournalEntryID_PK),
	CONSTRAINT FK_Data_UnPosted_JournalEntries_Data_Accounts FOREIGN KEY (AccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK)
);


-- InfinityRetailDB.Financial.Data_PaymentVouchers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Financial.Data_PaymentVouchers;

CREATE TABLE InfinityRetailDB.Financial.Data_PaymentVouchers (
	PaymentVoucherID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	PaymentMethodTypeID_FK smallint NOT NULL,
	VoucherDate datetime NOT NULL,
	VoucherNumber nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	VoucherAmount decimal(15,3) NOT NULL,
	DebitAccountID_FK int NOT NULL,
	CreditAccountID_FK int NOT NULL,
	PaymentDescriptionLine1 nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	PaymentDescriptionLine2 nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	IsPosted bit NOT NULL,
	SalesPersonID_FK int NULL,
	PaperPaymentVoucherNumber nvarchar(15) COLLATE Arabic_CI_AS NULL,
	ChecqueNumber nvarchar(15) COLLATE Arabic_CI_AS NULL,
	ChecqueBankName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	ChecqueDate datetime NULL,
	JournalEntryID_FK int NULL,
	POSTerminalShiftID_FK int NULL,
	CostCenterID_FK int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Data_PAymentVouchers PRIMARY KEY (PaymentVoucherID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_PaymentVouchers_CostCenterID_FK ON InfinityRetailDB.Financial.Data_PaymentVouchers (  CostCenterID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PaymentVouchers_CreditAccountID_FK ON InfinityRetailDB.Financial.Data_PaymentVouchers (  CreditAccountID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PaymentVouchers_DebitAccountID_FK ON InfinityRetailDB.Financial.Data_PaymentVouchers (  DebitAccountID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PaymentVouchers_VoucherDate ON InfinityRetailDB.Financial.Data_PaymentVouchers (  VoucherDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Financial.Data_PaymentVouchers foreign keys

ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_Config_SalePersons FOREIGN KEY (SalesPersonID_FK) REFERENCES InfinityRetailDB.SALES.Config_SalePersons(SalePersonID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_Data_Accounts_Credit FOREIGN KEY (CreditAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_Data_Accounts_Debit FOREIGN KEY (DebitAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_Data_POSTerminalShifts FOREIGN KEY (POSTerminalShiftID_FK) REFERENCES InfinityRetailDB.POS.Data_POSTerminalShifts(POSTerminalShiftID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_RefCostCenters FOREIGN KEY (CostCenterID_FK) REFERENCES InfinityRetailDB.Financial.RefCostCenters(CostCenterID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.Financial.Data_PaymentVouchers ADD CONSTRAINT FK_Data_PaymentVouchers_RefPaymentMethodTypes FOREIGN KEY (PaymentMethodTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefPaymentMethodTypes(PaymentMethodTypeID_PK);


-- Financial.Data_View_Account_UnPosted_JESummary source

ALTER VIEW [Financial].[Data_View_Account_UnPosted_JESummary]
AS
SELECT     AccountID_FK, SUM(CreditAmount) AS UnPostedCreditAmount, SUM(DebitAmount) AS UnPostedDebitAmount
FROM         Financial.Data_UnPosted_JournalEntries
GROUP BY AccountID_FK;


-- Financial.Data_View_Accounts source

ALTER VIEW [Financial].[Data_View_Accounts]
AS
SELECT     Financial.Data_Accounts.AccountID_PK, Financial.Data_Accounts.AccountSubGroupID_FK, Financial.Data_Accounts.AccountNumber, 
                      Financial.Data_Accounts.AccountName, Financial.Data_Accounts.AccountDescription, Financial.Data_Accounts.AccountTotalDebit, 
                      Financial.Data_Accounts.AccountTotalCredit, 
                      CASE Financial.RefAccountClassifications.AccountsNature WHEN 1 THEN Financial.Data_Accounts.AccountTotalDebit - Financial.Data_Accounts.AccountTotalCredit WHEN
                       2 THEN Financial.Data_Accounts.AccountTotalCredit - Financial.Data_Accounts.AccountTotalDebit END AS AccountBalance, 
                      Financial.Data_Accounts.IsReadOnlyAccount, Financial.Data_Accounts.CreatedByUserID, Financial.Data_Accounts.CreatedByUserName, 
                      Financial.Data_Accounts.CreatedDate, Financial.Data_Accounts.ModifiedByUserID, Financial.Data_Accounts.ModifiedByUserName, 
                      Financial.Data_Accounts.ModifiedDate, Financial.RefAccountSubGroups.AccountSubGroupNumber, Financial.RefAccountSubGroups.AccountSubGroupCaption, 
                      Financial.RefAccountSubGroups.AccountSubGroupCaptionEnglish, Financial.RefAccountSubGroups.AccountGroupID_FK, 
                      Financial.RefAccountGroups.AccountGroupNumber, Financial.RefAccountGroups.AccountGroupCaption, Financial.RefAccountGroups.AccountGroupCaptionEnglish, 
                      Financial.RefAccountGroups.AccountHeadID_FK, Financial.RefAccountHeads.AccountHeadClassification, Financial.RefAccountHeads.AccountHeadCaption, 
                      Financial.RefAccountSubGroups.AccountClassificationID_FK, Financial.RefAccountClassifications.AccountClassification, Financial.Data_Accounts.IsActiveAccount, 
                      Financial.Data_View_Account_UnPosted_JESummary.UnPostedCreditAmount, Financial.Data_View_Account_UnPosted_JESummary.UnPostedDebitAmount, 
                      Financial.RefAccountClassifications.AccountsNature, Financial.Data_Accounts.CostCenterID_FK, Financial.Data_Accounts.AccountOpenBalance, 
                      Financial.RefCostCenters.CostCenterName, Financial.Data_Accounts.MainAccountID_FK
FROM         Financial.RefAccountSubGroups INNER JOIN
                      Financial.RefAccountGroups ON Financial.RefAccountSubGroups.AccountGroupID_FK = Financial.RefAccountGroups.AccountGroupID_PK INNER JOIN
                      Financial.Data_Accounts ON Financial.RefAccountSubGroups.AccountSubGroupID_PK = Financial.Data_Accounts.AccountSubGroupID_FK INNER JOIN
                      Financial.RefAccountHeads ON Financial.RefAccountGroups.AccountHeadID_FK = Financial.RefAccountHeads.AccountHeadID_PK INNER JOIN
                      Financial.RefAccountClassifications ON 
                      Financial.RefAccountSubGroups.AccountClassificationID_FK = Financial.RefAccountClassifications.AccountClassificationID_PK LEFT OUTER JOIN
                      Financial.RefCostCenters ON Financial.Data_Accounts.CostCenterID_FK = Financial.RefCostCenters.CostCenterID_PK LEFT OUTER JOIN
                      Financial.Data_View_Account_UnPosted_JESummary ON Financial.Data_Accounts.AccountID_PK = Financial.Data_View_Account_UnPosted_JESummary.AccountID_FK;


-- Financial.Data_View_CustomersJournalEntryDetails source

ALTER VIEW [Financial].[Data_View_CustomersJournalEntryDetails]
AS
SELECT JournalEntryDetailID_PK,JournalEntryID_FK,JEntryDate,AccountID_FK,JEntryDescription,TransactionRef,CreditAmount,DebitAmount,TransSourceID_FK,DocumentID_FK,
       CreatedByUserID,CreatedByUserName,CreatedDate,ModifiedByUserID,ModifiedByUserName,ModifiedDate,CostCenterID_FK
FROM Financial.Data_JournalEntryDetails where accountID_FK in (SELECT     AccountID_PK FROM         Financial.Data_Accounts WHERE     (AccountSubGroupID_FK = 3))
union 
SELECT UnPosted_JournalEntryID_PK ,null,JEntryDate,AccountID_FK,JEntryDescription,TransactionRef,CreditAmount,DebitAmount,TransSourceID_FK,DocumentID_FK,
CreatedByUserID,CreatedByUserName,CreatedDate,ModifiedByUserID,ModifiedByUserName,ModifiedDate, 0 as CostCenterID_FK
from  Financial.Data_UnPosted_JournalEntries where accountID_FK in (SELECT     AccountID_PK FROM   Financial.Data_Accounts WHERE     (AccountSubGroupID_FK = 3));


-- Financial.Data_View_JournalEntries source

ALTER VIEW [Financial].[Data_View_JournalEntries]
AS
SELECT     Financial.Data_JournalEntries.JournalEntryID_PK, Financial.Data_JournalEntries.BranchID_FK, Financial.Data_JournalEntries.JournalEntryTypeID_FK, 
                      Financial.RefJournalEntryTypes.JEntryType_Code, Financial.RefJournalEntryTypes.JEntryType_Caption, Financial.Data_JournalEntries.JournalEntryNumber, 
                      Financial.Data_JournalEntries.JournalEntryDate, Financial.Data_JournalEntries.JournalEntryDecription, Financial.Data_JournalEntries.CreatedByUserID, 
                      Financial.Data_JournalEntries.CreatedByUserName, Financial.Data_JournalEntries.CreatedDate, Financial.Data_JournalEntries.ModifiedByUserID, 
                      Financial.Data_JournalEntries.ModifiedByUserName, Financial.Data_JournalEntries.ModifiedDate, Financial.Data_JournalEntries.IsPosted, 
                      Financial.Data_JournalEntries.PostedByUserID, Financial.Data_JournalEntries.PostedByUserName, Financial.Data_JournalEntries.PostedDate, 
                      Financial.Data_JournalEntries.UnPostedByUserID, Financial.Data_JournalEntries.UnPostedByUserName, Financial.Data_JournalEntries.UnPostedDate, 
                      Financial.Data_JournalEntries.IsCreatedBySystem, Financial.Data_JournalEntries.FinancialYear
FROM         Financial.Data_JournalEntries INNER JOIN
                      Financial.RefJournalEntryTypes ON Financial.Data_JournalEntries.JournalEntryTypeID_FK = Financial.RefJournalEntryTypes.JEntryType_ID_PK;


-- Financial.Data_View_JournalEntriesTotals source

ALTER VIEW [Financial].[Data_View_JournalEntriesTotals]
		AS
		SELECT     JournalEntryID_FK, COUNT(JournalEntryDetailID_PK) AS JEDCount, SUM(DebitAmount) AS TotalDebitAmount, SUM(CreditAmount) AS TotalCreditAmount
		FROM         Financial.Data_View_JournalEntryDetails
		GROUP BY JournalEntryID_FK;


-- Financial.Data_View_JournalEntryDetails source

ALTER VIEW [Financial].[Data_View_JournalEntryDetails]
AS
SELECT     Financial.Data_JournalEntryDetails.JournalEntryDetailID_PK, Financial.Data_JournalEntryDetails.JournalEntryID_FK, Financial.Data_JournalEntryDetails.JEntryDate, 
                      Financial.Data_JournalEntryDetails.AccountID_FK, Financial.Data_JournalEntryDetails.JEntryDescription, Financial.Data_JournalEntryDetails.TransactionRef, 
                      Financial.Data_JournalEntryDetails.CreditAmount, Financial.Data_JournalEntryDetails.DebitAmount, Financial.Data_JournalEntryDetails.TransSourceID_FK, 
                      Financial.Data_JournalEntryDetails.DocumentID_FK, Financial.Data_JournalEntryDetails.CreatedByUserID, Financial.Data_JournalEntryDetails.CreatedByUserName, 
                      Financial.Data_JournalEntryDetails.CreatedDate, Financial.Data_JournalEntryDetails.ModifiedByUserID, Financial.Data_JournalEntryDetails.ModifiedByUserName, 
                      Financial.Data_JournalEntryDetails.ModifiedDate, Financial.Data_View_Accounts.AccountNumber, Financial.Data_View_Accounts.AccountName, 
                      Financial.Data_View_Accounts.AccountClassificationID_FK, Financial.Data_View_Accounts.AccountClassification, 
                      Financial.Data_View_Accounts.AccountSubGroupCaption, Financial.Data_View_Accounts.AccountSubGroupID_FK, Financial.Data_JournalEntries.IsPosted, 
                      Financial.Data_JournalEntries.JournalEntryDate, Financial.Data_JournalEntryDetails.SalesPersonID_FK, Financial.Data_JournalEntryDetails.CostCenterID_FK, 
                      Financial.RefCostCenters.CostCenterName
FROM         Financial.Data_JournalEntryDetails INNER JOIN
                      Financial.Data_View_Accounts ON Financial.Data_JournalEntryDetails.AccountID_FK = Financial.Data_View_Accounts.AccountID_PK INNER JOIN
                      Financial.Data_JournalEntries ON Financial.Data_JournalEntryDetails.JournalEntryID_FK = Financial.Data_JournalEntries.JournalEntryID_PK INNER JOIN
                      Financial.RefCostCenters ON Financial.Data_JournalEntryDetails.CostCenterID_FK = Financial.RefCostCenters.CostCenterID_PK;


-- Financial.Data_View_PaymentVouchers source

ALTER VIEW [Financial].[Data_View_PaymentVouchers]
AS
SELECT     Financial.Data_PaymentVouchers.PaymentVoucherID_PK, Financial.Data_PaymentVouchers.BranchID_FK, Financial.Data_PaymentVouchers.DocumentTypeID_FK, 
                      Financial.Data_PaymentVouchers.PaymentMethodTypeID_FK, Financial.Data_PaymentVouchers.VoucherDate, Financial.Data_PaymentVouchers.VoucherNumber, 
                      Financial.Data_PaymentVouchers.VoucherAmount, Financial.Data_PaymentVouchers.DebitAccountID_FK, Financial.Data_PaymentVouchers.CreditAccountID_FK, 
                      Financial.Data_PaymentVouchers.PaymentDescriptionLine1, Financial.Data_PaymentVouchers.PaymentDescriptionLine2, Financial.Data_PaymentVouchers.IsPosted, 
                      Financial.Data_PaymentVouchers.SalesPersonID_FK, Financial.Data_PaymentVouchers.PaperPaymentVoucherNumber, 
                      Financial.Data_PaymentVouchers.ChecqueNumber, Financial.Data_PaymentVouchers.ChecqueBankName, Financial.Data_PaymentVouchers.ChecqueDate, 
                      Financial.Data_PaymentVouchers.CreatedByUserID, Financial.Data_PaymentVouchers.CreatedByUserName, Financial.Data_PaymentVouchers.CreatedDate, 
                      Financial.Data_PaymentVouchers.ModifiedByUserID, Financial.Data_PaymentVouchers.ModifiedByUserName, Financial.Data_PaymentVouchers.ModifiedDate, 
                      Financial.Data_PaymentVouchers.JournalEntryID_FK, MyCompany.RefPaymentMethodTypes.PaymentMethodTypeCaption, 
                      MyCompany.RefDocumentTypes.DocumentTypeCaption, Data_DebitAccount.AccountNumber AS DebitAccountNumber, 
                      Data_DebitAccount.AccountName AS DebitAccountName, Data_CreditAccount.AccountNumber AS CreditAccountNumber, 
                      Data_CreditAccount.AccountName AS CreditAccountName, Financial.Data_PaymentVouchers.POSTerminalShiftID_FK, 
                      Financial.Data_PaymentVouchers.CostCenterID_FK, Financial.RefCostCenters.CostCenterName, MyCompany.Config_Branchs.BranchName, 
                      Financial.Data_PaymentVouchers.IsSynced
FROM         Financial.Data_PaymentVouchers INNER JOIN
                      MyCompany.RefDocumentTypes ON Financial.Data_PaymentVouchers.DocumentTypeID_FK = MyCompany.RefDocumentTypes.DocumentTypeID_PK INNER JOIN
                      MyCompany.RefPaymentMethodTypes ON 
                      Financial.Data_PaymentVouchers.PaymentMethodTypeID_FK = MyCompany.RefPaymentMethodTypes.PaymentMethodTypeID_PK INNER JOIN
                      Financial.Data_Accounts AS Data_DebitAccount ON Financial.Data_PaymentVouchers.DebitAccountID_FK = Data_DebitAccount.AccountID_PK INNER JOIN
                      Financial.Data_Accounts AS Data_CreditAccount ON Financial.Data_PaymentVouchers.CreditAccountID_FK = Data_CreditAccount.AccountID_PK INNER JOIN
                      Financial.RefCostCenters ON Financial.Data_PaymentVouchers.CostCenterID_FK = Financial.RefCostCenters.CostCenterID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Financial.Data_PaymentVouchers.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Financial.Data_View_UnPosted_JournalEntries source

ALTER VIEW [Financial].[Data_View_UnPosted_JournalEntries]
AS
SELECT     Financial.Data_UnPosted_JournalEntries.UnPosted_JournalEntryID_PK, Financial.Data_UnPosted_JournalEntries.JEntryDate, 
                      Financial.Data_UnPosted_JournalEntries.AccountID_FK, Financial.Data_UnPosted_JournalEntries.JEntryDescription, 
                      Financial.Data_UnPosted_JournalEntries.TransactionRef, Financial.Data_UnPosted_JournalEntries.CreditAmount, 
                      Financial.Data_UnPosted_JournalEntries.DebitAmount, Financial.Data_UnPosted_JournalEntries.TransSourceID_FK, 
                      Financial.Data_UnPosted_JournalEntries.DocumentID_FK, Financial.Data_UnPosted_JournalEntries.CreatedByUserID, 
                      Financial.Data_UnPosted_JournalEntries.CreatedByUserName, Financial.Data_UnPosted_JournalEntries.CreatedDate, 
                      Financial.Data_UnPosted_JournalEntries.ModifiedByUserID, Financial.Data_UnPosted_JournalEntries.ModifiedByUserName, 
                      Financial.Data_UnPosted_JournalEntries.ModifiedDate, Financial.Data_View_Accounts.AccountNumber, Financial.Data_View_Accounts.AccountName, 
                      Financial.Data_View_Accounts.AccountDescription, Financial.Data_View_Accounts.AccountGroupCaption, Financial.Data_View_Accounts.AccountClassificationID_FK, 
                      Financial.Data_View_Accounts.AccountClassification
FROM         Financial.Data_UnPosted_JournalEntries INNER JOIN
                      Financial.Data_View_Accounts ON Financial.Data_UnPosted_JournalEntries.AccountID_FK = Financial.Data_View_Accounts.AccountID_PK;


-- Financial.Ref_View_AccountSubGroups source

ALTER VIEW [Financial].[Ref_View_AccountSubGroups]
AS
SELECT     Financial.RefAccountSubGroups.*, Financial.RefAccountClassifications.AccountClassification
FROM         Financial.RefAccountSubGroups INNER JOIN
                      Financial.RefAccountClassifications ON Financial.RefAccountSubGroups.AccountClassificationID_FK = Financial.RefAccountClassifications.AccountClassificationID_PK;


-- Financial.Statistic_View_AccountCountBySubGroup source

ALTER VIEW Financial.Statistic_View_AccountCountBySubGroup
AS
SELECT     Financial.RefAccountHeads.AccountHeadID_PK, MAX(Financial.RefAccountHeads.AccountHeadCaption) AS AccountHeadCaption, 
                      Financial.RefAccountGroups.AccountGroupID_PK, MAX(Financial.RefAccountGroups.AccountGroupCaption) AS AccountGroupCaption, 
                      Financial.RefAccountSubGroups.AccountSubGroupID_PK, MAX(Financial.RefAccountSubGroups.AccountSubGroupCaption) AS AccountSubGroupCaption, 
                      COUNT(Financial.Data_Accounts.AccountID_PK) AS AccountCount
FROM         Financial.RefAccountSubGroups LEFT OUTER JOIN
                      Financial.Data_Accounts ON 
                      Financial.RefAccountSubGroups.AccountSubGroupID_PK = Financial.Data_Accounts.AccountSubGroupID_FK RIGHT OUTER JOIN
                      Financial.RefAccountGroups ON 
                      Financial.RefAccountSubGroups.AccountGroupID_FK = Financial.RefAccountGroups.AccountGroupID_PK RIGHT OUTER JOIN
                      Financial.RefAccountHeads ON Financial.RefAccountGroups.AccountHeadID_FK = Financial.RefAccountHeads.AccountHeadID_PK
GROUP BY Financial.RefAccountHeads.AccountHeadID_PK, Financial.RefAccountGroups.AccountGroupID_PK, 
                      Financial.RefAccountSubGroups.AccountSubGroupID_PK;


-- Financial.Statistic_View_AccountMonthlyMovement source

ALTER VIEW [Financial].[Statistic_View_AccountMonthlyMovement]
AS
SELECT     AccountID_PK, AccountNumber, AccountName, AccountClassificationID_FK, Year, Month, Credit, Debit, ISNULL
                          ((SELECT     CASE AcMonthlyRepory.AccountsNature WHEN 1 THEN SUM(DebitAmount) - SUM(CreditAmount) WHEN 2 THEN SUM(CreditAmount) 
                                                     - SUM(DebitAmount) END AS Expr1
                              FROM          Financial.Data_JournalEntryDetails AS JED
                              WHERE      (AccountID_FK = AcMonthlyRepory.AccountID_PK) AND (JEntryDate < CONVERT(DATETIME, CONVERT(nvarchar, AcMonthlyRepory.Year) 
                                                     + '-' + CONVERT(nvarchar, AcMonthlyRepory.Month) + '-1'))), 0) AS beginningBalance, ISNULL
                          ((SELECT     CASE AcMonthlyRepory.AccountsNature WHEN 1 THEN SUM(DebitAmount) - SUM(CreditAmount) WHEN 2 THEN SUM(CreditAmount) 
                                                     - SUM(DebitAmount) END AS Expr1
                              FROM          Financial.Data_JournalEntryDetails AS JED
                              WHERE      (AccountID_FK = AcMonthlyRepory.AccountID_PK) AND (JEntryDate < CONVERT(DATETIME, CONVERT(nvarchar, AcMonthlyRepory.Year) 
                                                     + '-' + CONVERT(nvarchar, AcMonthlyRepory.Month) + '-1'))) + CASE AcMonthlyRepory.AccountsNature WHEN 1 THEN (Debit - Credit) 
                      WHEN 2 THEN (Credit - Debit) END, 0) AS ENDBalance
FROM         (SELECT     TOP (100) PERCENT Financial.Data_View_Accounts.AccountID_PK, Financial.Data_View_Accounts.AccountsNature, 
                                              Financial.Data_View_Accounts.AccountNumber, Financial.Data_View_Accounts.AccountName, Financial.Data_View_Accounts.AccountClassificationID_FK, 
                                              YEAR(Financial.Data_JournalEntryDetails.JEntryDate) AS Year, MONTH(Financial.Data_JournalEntryDetails.JEntryDate) AS Month, 
                                              SUM(Financial.Data_JournalEntryDetails.CreditAmount) AS Credit, SUM(Financial.Data_JournalEntryDetails.DebitAmount) AS Debit
                        FROM         Financial.Data_View_Accounts INNER JOIN
                                              Financial.Data_JournalEntryDetails ON Financial.Data_View_Accounts.AccountID_PK = Financial.Data_JournalEntryDetails.AccountID_FK
                        GROUP BY Financial.Data_View_Accounts.AccountID_PK, Financial.Data_View_Accounts.AccountNumber, Financial.Data_View_Accounts.AccountName, 
                                              Financial.Data_View_Accounts.AccountClassificationID_FK, MONTH(Financial.Data_JournalEntryDetails.JEntryDate), 
                                              YEAR(Financial.Data_JournalEntryDetails.JEntryDate), Financial.Data_View_Accounts.AccountsNature) AS AcMonthlyRepory;

-- DROP SCHEMA guest;

CREATE SCHEMA guest;

-- DROP SCHEMA Inventory;

CREATE SCHEMA Inventory;
-- InfinityRetailDB.Inventory.RefDamagedItemTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefDamagedItemTypes;

CREATE TABLE InfinityRetailDB.Inventory.RefDamagedItemTypes (
	DamagedItemTypeID_PK tinyint IDENTITY(1,1) NOT NULL,
	DamagedItemTypeCaption nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	IsReadOnly bit NOT NULL,
	CONSTRAINT PK_RefDamagedItemTypes PRIMARY KEY (DamagedItemTypeID_PK)
);


-- InfinityRetailDB.Inventory.RefInventoryCategories definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefInventoryCategories;

CREATE TABLE InfinityRetailDB.Inventory.RefInventoryCategories (
	InventoryCategoryID_PK int IDENTITY(1,1) NOT NULL,
	InventoryCategoryCode nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	InventoryCategoryName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_InventoryCategories PRIMARY KEY (InventoryCategoryID_PK)
);


-- InfinityRetailDB.Inventory.RefPriceUpdateReasons definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefPriceUpdateReasons;

CREATE TABLE InfinityRetailDB.Inventory.RefPriceUpdateReasons (
	PriceUpdateReasonID_PK tinyint NOT NULL,
	PriceUpdateReasonCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefPriceUpdateReasons PRIMARY KEY (PriceUpdateReasonID_PK)
);


-- InfinityRetailDB.Inventory.RefProductGroups definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefProductGroups;

CREATE TABLE InfinityRetailDB.Inventory.RefProductGroups (
	ProductGroupID_PK int IDENTITY(1,1) NOT NULL,
	ProductGroupDescription nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefProductGroups PRIMARY KEY (ProductGroupID_PK)
);


-- InfinityRetailDB.Inventory.RefProductTrademarks definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefProductTrademarks;

CREATE TABLE InfinityRetailDB.Inventory.RefProductTrademarks (
	ProductTrademarkID_PK int IDENTITY(1,1) NOT NULL,
	ProductTrademarkDescrption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefProductTrademarks PRIMARY KEY (ProductTrademarkID_PK)
);


-- InfinityRetailDB.Inventory.RefProductTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefProductTypes;

CREATE TABLE InfinityRetailDB.Inventory.RefProductTypes (
	ProductTypeID_PK tinyint NOT NULL,
	ProductTypeDescrption nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_RefProductTypes PRIMARY KEY (ProductTypeID_PK)
);


-- InfinityRetailDB.Inventory.RefStockAdjustmentReasons definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefStockAdjustmentReasons;

CREATE TABLE InfinityRetailDB.Inventory.RefStockAdjustmentReasons (
	StockAdjustmentReasonID_PK tinyint IDENTITY(1,1) NOT NULL,
	StockAdjustmentReasonCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefStockAdjustmentReasons PRIMARY KEY (StockAdjustmentReasonID_PK)
);


-- InfinityRetailDB.Inventory.RefStockAdjustmentStates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefStockAdjustmentStates;

CREATE TABLE InfinityRetailDB.Inventory.RefStockAdjustmentStates (
	StockAdjustmentStateID_PK tinyint NOT NULL,
	StockAdjustmentStateCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefStockAdjustmentStates PRIMARY KEY (StockAdjustmentStateID_PK)
);


-- InfinityRetailDB.Inventory.RefStockAdjustmentTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefStockAdjustmentTypes;

CREATE TABLE InfinityRetailDB.Inventory.RefStockAdjustmentTypes (
	StockAdjustmentTypeID_PK tinyint NOT NULL,
	StockAdjustmentTypeCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefStockAdjustmentTypes PRIMARY KEY (StockAdjustmentTypeID_PK)
);


-- InfinityRetailDB.Inventory.RefTransactionSources definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefTransactionSources;

CREATE TABLE InfinityRetailDB.Inventory.RefTransactionSources (
	TransSourceID_PK tinyint NOT NULL,
	TransSourceCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Ref_AccountTransactionSources PRIMARY KEY (TransSourceID_PK)
);


-- InfinityRetailDB.Inventory.RefUOMCategories definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefUOMCategories;

CREATE TABLE InfinityRetailDB.Inventory.RefUOMCategories (
	UOMCategoryID_PK smallint IDENTITY(1,1) NOT NULL,
	UOMCategoryName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Config_UOMCategories PRIMARY KEY (UOMCategoryID_PK)
);


-- InfinityRetailDB.Inventory.RefUOMs definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefUOMs;

CREATE TABLE InfinityRetailDB.Inventory.RefUOMs (
	UOMID_PK smallint IDENTITY(1,1) NOT NULL,
	UOMCategoryID_FK smallint DEFAULT 1 NOT NULL,
	UOMName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefUOMs PRIMARY KEY (UOMID_PK),
	CONSTRAINT FK_RefUOMs_RefUOMCategories FOREIGN KEY (UOMCategoryID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMCategories(UOMCategoryID_PK)
);
 CREATE NONCLUSTERED INDEX IX_RefUOMs_UOMCategoryID_FK ON InfinityRetailDB.Inventory.RefUOMs (  UOMCategoryID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_RefUOMs_UOMID_PK_UOMName ON InfinityRetailDB.Inventory.RefUOMs (  UOMID_PK ASC  )  
	 INCLUDE ( UOMName ) 
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_DamagedItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_DamagedItems;

CREATE TABLE InfinityRetailDB.Inventory.Data_DamagedItems (
	DamagedItemID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	DamagedItemTypeID_FK tinyint NOT NULL,
	ProductID_FK bigint NOT NULL,
	UomID_FK smallint DEFAULT 1 NOT NULL,
	QYT decimal(15,3) NOT NULL,
	Cost decimal(15,3) NOT NULL,
	ExpiryDate datetime NULL,
	Note nvarchar(250) COLLATE Arabic_CI_AS NULL,
	LocationID_FK int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Data_DamagedItems PRIMARY KEY (DamagedItemID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_DamagedItems_BranchID_FK ON InfinityRetailDB.Inventory.Data_DamagedItems (  BranchID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_DamagedItems_DamagedItemTypeID_FK ON InfinityRetailDB.Inventory.Data_DamagedItems (  DamagedItemTypeID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_DamagedItems_LocationID_FK ON InfinityRetailDB.Inventory.Data_DamagedItems (  LocationID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_DamagedItems_ProductID_FK ON InfinityRetailDB.Inventory.Data_DamagedItems (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_InventoryTransactions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_InventoryTransactions;

CREATE TABLE InfinityRetailDB.Inventory.Data_InventoryTransactions (
	TransactionID_PK bigint IDENTITY(1,1) NOT NULL,
	TransactionCode nvarchar(3) COLLATE Arabic_CI_AS DEFAULT N'IN' NOT NULL,
	TransactionDate datetime NOT NULL,
	TransSourceID_FK tinyint NOT NULL,
	TransSourceReference int NOT NULL,
	ProductID_FK int NOT NULL,
	Comments nvarchar(250) COLLATE Arabic_CI_AS NULL,
	TransactionQYT decimal(10,3) NOT NULL,
	UnitID_FK smallint DEFAULT 1 NOT NULL,
	UnitCost decimal(10,3) DEFAULT 0 NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	LocationID_FK int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Data_InventoryTransactions PRIMARY KEY (TransactionID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_BranchID_FK ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  BranchID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_LocationID_FK ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  LocationID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_ProductID_FK ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_TransSourceID_FK ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  TransSourceID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_TransSourceReference ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  TransSourceReference ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_InventoryTransactions_TransactionDate ON InfinityRetailDB.Inventory.Data_InventoryTransactions (  TransactionDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ProductBOMItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductBOMItems;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductBOMItems (
	ProductBOMItemID_PK int IDENTITY(1,1) NOT NULL,
	ProductBOMID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UomID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	QYT decimal(10,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_ProductUOMItems PRIMARY KEY (ProductBOMItemID_PK)
);


-- InfinityRetailDB.Inventory.Data_ProductBOMs definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductBOMs;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductBOMs (
	ProductBOMID_PK int IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	UomID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	ProductQTY decimal(10,3) NOT NULL,
	Note nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	SyncDate datetime NULL,
	CONSTRAINT PK_Data_ProductBOMs PRIMARY KEY (ProductBOMID_PK)
);


-- InfinityRetailDB.Inventory.Data_ProductBarcodes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductBarcodes;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductBarcodes (
	ProductBarcodeID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductUOMID_FK bigint NOT NULL,
	ProductBarcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	GeneratedByInfinityPOS bit NOT NULL,
	CONSTRAINT PK_Data_ProductBarcodes PRIMARY KEY (ProductBarcodeID_PK)
);
 CREATE UNIQUE NONCLUSTERED INDEX IX_Data_ProductBarcodes_Barcode ON InfinityRetailDB.Inventory.Data_ProductBarcodes (  ProductBarcode ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductUOM ON InfinityRetailDB.Inventory.Data_ProductBarcodes (  ProductUOMID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ProductExpiryDates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductExpiryDates;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductExpiryDates (
	ExpiryDateID_PK bigint IDENTITY(1,1) NOT NULL,
	BranchID_FK int NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NOT NULL,
	CONSTRAINT PK_Data_ProductExpiryDates PRIMARY KEY (ExpiryDateID_PK)
);


-- InfinityRetailDB.Inventory.Data_ProductInventories definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductInventories;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductInventories (
	ProductInventoryID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	LocationID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	StockOnHand decimal(15,3) NOT NULL,
	StockOnHold decimal(15,3) NOT NULL,
	ProductionDate datetime NULL,
	ExpiryDate datetime NULL,
	CONSTRAINT PK_Data_ProductInventories PRIMARY KEY (ProductInventoryID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_ProductInventories_BranchID_FK ON InfinityRetailDB.Inventory.Data_ProductInventories (  BranchID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductInventories_ExpiryDate ON InfinityRetailDB.Inventory.Data_ProductInventories (  ExpiryDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductInventories_LocationID_FK ON InfinityRetailDB.Inventory.Data_ProductInventories (  LocationID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductInventories_ProductID_FK ON InfinityRetailDB.Inventory.Data_ProductInventories (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ProductPackageItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductPackageItems;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductPackageItems (
	ProductPackageItemID_PK int IDENTITY(1,1) NOT NULL,
	ProductUomID_FK bigint NOT NULL,
	PackageProductID_FK bigint NOT NULL,
	UomID_FK smallint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UomCost decimal(12,3) NOT NULL,
	CONSTRAINT PK_Data_ProductPackageItems PRIMARY KEY (ProductPackageItemID_PK),
	CONSTRAINT UK_Data_ProductPackageItems_UniquePackageProductID_FKPerProductID_FK UNIQUE (ProductUomID_FK,PackageProductID_FK)
);
 CREATE NONCLUSTERED INDEX IX_Data_ProductPackageItems_PackageProductID_FK ON InfinityRetailDB.Inventory.Data_ProductPackageItems (  PackageProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ProductPhotos definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductPhotos;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductPhotos (
	ProductID_PK bigint NOT NULL,
	Photo image NOT NULL,
	CONSTRAINT PK_Data_ProductPhotos PRIMARY KEY (ProductID_PK)
);


-- InfinityRetailDB.Inventory.Data_ProductPriceUpdates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductPriceUpdates;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductPriceUpdates (
	ProductPriceUpdateID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	PriceLevel tinyint NOT NULL,
	OldValue decimal(12,3) NOT NULL,
	NewValue decimal(12,3) NOT NULL,
	Variance decimal(12,3) NOT NULL,
	UpdateSourceReference int NOT NULL,
	UpdateReasonID_FK tinyint NOT NULL,
	PriceUpdateDescription nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Data_ProductPriceUpdates PRIMARY KEY (ProductPriceUpdateID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_ProductPriceUpdates_CreatedDate ON InfinityRetailDB.Inventory.Data_ProductPriceUpdates (  CreatedDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductPriceUpdates_ProductID_FK ON InfinityRetailDB.Inventory.Data_ProductPriceUpdates (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ProductSNs definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductSNs;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductSNs (
	ProductSerialNoID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	SN nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	ReceivedDate datetime NULL,
	SaleDate datetime NULL,
	SalesRef nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	Comment nvarchar(350) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_ProductSNs PRIMARY KEY (ProductSerialNoID_PK),
	CONSTRAINT UK_Data_ProductSNs_OneSNPerProduct UNIQUE (ProductID_FK,SN)
);


-- InfinityRetailDB.Inventory.Data_ProductUOMs definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ProductUOMs;

CREATE TABLE InfinityRetailDB.Inventory.Data_ProductUOMs (
	ProductUomID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	UomID_FK smallint NOT NULL,
	BaseUnitQYT decimal(7,3) NOT NULL,
	UomPurchaseCost decimal(12,3) NOT NULL,
	UomCost decimal(12,3) NOT NULL,
	UomLastPurchaseCost decimal(12,3) NOT NULL,
	UomLastCost decimal(12,3) NOT NULL,
	UomPrice1 decimal(12,3) NOT NULL,
	UomPrice2 decimal(12,3) NOT NULL,
	UomPrice3 decimal(12,3) NOT NULL,
	UomPrice4 decimal(12,3) NOT NULL,
	UomMiniPrice decimal(12,3) NULL,
	UOMLastPrice decimal(12,3) DEFAULT -1 NULL,
	CONSTRAINT PK_Config_ProductsUOMs PRIMARY KEY (ProductUomID_PK),
	CONSTRAINT UK_BaseUnitQYTPerProduct UNIQUE (ProductID_FK,BaseUnitQYT),
	CONSTRAINT UK_UniqueUOMPerProduct UNIQUE (ProductID_FK,UomID_FK)
);
 CREATE NONCLUSTERED INDEX IX_Data_ProductID_FK ON InfinityRetailDB.Inventory.Data_ProductUOMs (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductUOMs_ProductID_FK ON InfinityRetailDB.Inventory.Data_ProductUOMs (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_ProductUOMs_UomID_FK ON InfinityRetailDB.Inventory.Data_ProductUOMs (  UomID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_Products definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_Products;

CREATE TABLE InfinityRetailDB.Inventory.Data_Products (
	ProductID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductCode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	ProductShortName nvarchar(75) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	SalesDecription nvarchar(300) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	PurchaseDescription nvarchar(300) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	ProductLocations nvarchar(300) COLLATE Arabic_CI_AS NULL,
	manfuctureCode nvarchar(30) COLLATE Arabic_CI_AS NULL,
	ProductTypeID_FK tinyint NOT NULL,
	InvSubDepartmentID_FK int NOT NULL,
	ProductGroupID_FK int NOT NULL,
	ProductTrademarkID_FK int NOT NULL,
	DefaultSellUomID_FK smallint NOT NULL,
	DefaultOrderUomID_FK smallint NOT NULL,
	DefaultInventoryUomID_FK smallint NOT NULL,
	MinStockLevel decimal(9,3) NOT NULL,
	MaxStockLevel decimal(9,3) NOT NULL,
	IsInActive bit DEFAULT 1 NOT NULL,
	IsDiscontinuousItem bit NOT NULL,
	IsNonDiscountableItem bit NOT NULL,
	IsHasOpenPrice bit NOT NULL,
	StockOnHand decimal(15,3) DEFAULT 0 NOT NULL,
	StockOnHold decimal(15,3) DEFAULT 0 NOT NULL,
	TotalReceivedQYT decimal(15,3) DEFAULT 0 NOT NULL,
	TotalSoldQYT decimal(15,3) NOT NULL,
	LastSalesTransactionDate datetime NULL,
	LastReceiveTransactionDate datetime NULL,
	LastOrderTransactionDate datetime NULL,
	LastStockAdjTransactionDate datetime NULL,
	LastRefundTransactionDate datetime NULL,
	ConfirmSoldProductUOM bit DEFAULT 0 NOT NULL,
	IsNonRefundableItem bit DEFAULT 0 NOT NULL,
	LogicalOrderPrinter1ID int NULL,
	LogicalOrderPrinter2ID int NULL,
	MainSupplierID_FK int NULL,
	IsProductionProduct bit DEFAULT 0 NOT NULL,
	ISCostHidden bit DEFAULT 0 NOT NULL,
	SalesPoints int DEFAULT 0 NOT NULL,
	IsHasSerialNO bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Products PRIMARY KEY (ProductID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_Products_DefaultInventoryUomID_FK ON InfinityRetailDB.Inventory.Data_Products (  DefaultInventoryUomID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_DefaultOrderUomID_FK ON InfinityRetailDB.Inventory.Data_Products (  DefaultOrderUomID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_DefaultSellUomID_FK ON InfinityRetailDB.Inventory.Data_Products (  DefaultSellUomID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_InvSubDepartmentID_FK ON InfinityRetailDB.Inventory.Data_Products (  InvSubDepartmentID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_MainSupplierID_FK ON InfinityRetailDB.Inventory.Data_Products (  MainSupplierID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_ProductCode ON InfinityRetailDB.Inventory.Data_Products (  ProductCode ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_ProductGroupID_FK ON InfinityRetailDB.Inventory.Data_Products (  ProductGroupID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_Products_ProductTrademarkID_FK ON InfinityRetailDB.Inventory.Data_Products (  ProductTrademarkID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_ScaleProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_ScaleProducts;

CREATE TABLE InfinityRetailDB.Inventory.Data_ScaleProducts (
	ProductID_FK bigint NOT NULL,
	HotKey int NOT NULL,
	LFCode int NOT NULL,
	BarcodeType smallint NOT NULL,
	ProductUomID_FK bigint NOT NULL,
	Price decimal(18,3) NOT NULL,
	PriceLevel nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	IsUpdated bit DEFAULT 0 NOT NULL,
	DepartmentID_FK int NOT NULL,
	CONSTRAINT PK_Data_ScaleProducts PRIMARY KEY (ProductID_FK)
);


-- InfinityRetailDB.Inventory.Data_StockAdjustmentExpiryDates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentExpiryDates;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentExpiryDates (
	StockAdjustmentExpiryDateID_PK int IDENTITY(1,1) NOT NULL,
	StockAdjustmentProductID_FK int NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NOT NULL,
	CONSTRAINT PK_Data_StockAdjustmentExpiryDates PRIMARY KEY (StockAdjustmentExpiryDateID_PK)
);


-- InfinityRetailDB.Inventory.Data_StockAdjustmentProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentProducts;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentProducts (
	StockAdjustmentProductID_PK int IDENTITY(1,1) NOT NULL,
	StockAdjustmentID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	StockOnHand decimal(10,3) NOT NULL,
	AdjustmentQYT decimal(10,3) NOT NULL,
	AdjustmentValue decimal(12,3) NOT NULL,
	QYTVariance decimal(10,3) NOT NULL,
	ValueVariance decimal(12,3) NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_StockAdjustmentProducts PRIMARY KEY (StockAdjustmentProductID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_StockAdjustmentProducts_CreatedDate ON InfinityRetailDB.Inventory.Data_StockAdjustmentProducts (  CreatedDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_StockAdjustmentProducts_ProductID_FK ON InfinityRetailDB.Inventory.Data_StockAdjustmentProducts (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_StockAdjustmentProducts_StockAdjustmentID_FK ON InfinityRetailDB.Inventory.Data_StockAdjustmentProducts (  StockAdjustmentID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_StockAdjustments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockAdjustments;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockAdjustments (
	StockAdjustmentID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	LocationID_FK int NOT NULL,
	StockAdjustmentTypeID_FK tinyint NOT NULL,
	StockAdjustmentNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	StockAdjustmentReasonID_FK tinyint NOT NULL,
	StockAdjustmentNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	StockAdjustmentStateID_FK tinyint NOT NULL,
	JournalEntryID_FK int NULL,
	CONSTRAINT PK_Data_StockAdjustments PRIMARY KEY (StockAdjustmentID_PK)
);


-- InfinityRetailDB.Inventory.Data_StockProductionItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockProductionItems;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockProductionItems (
	StockProductionItemID_PK int IDENTITY(1,1) NOT NULL,
	StockProductionID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	StockOnHand decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	ProductionQYT decimal(10,3) NOT NULL,
	ProductionValue decimal(12,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	ExpiryDate datetime NULL,
	CONSTRAINT PK_Data_StockProductionItems PRIMARY KEY (StockProductionItemID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_StockProductionItems_ProductID_FK ON InfinityRetailDB.Inventory.Data_StockProductionItems (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_StockProductionItems_StockProductionID_FK ON InfinityRetailDB.Inventory.Data_StockProductionItems (  StockProductionID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_StockProductions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockProductions;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockProductions (
	StockProductionID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	LocationID_FK int NOT NULL,
	StockProductionNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	StockProductionStateID_FK smallint NOT NULL,
	DocumentDate datetime NOT NULL,
	ProductionDate datetime NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductionQYT decimal(10,3) NOT NULL,
	UomID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	ProductionTotalCost decimal(12,3) NOT NULL,
	ExpiryDate datetime NULL,
	LotNumber nvarchar(10) COLLATE Arabic_CI_AS NULL,
	StockProductionNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	JournalEntryID_FK int NULL,
	ProductionTypeCode int DEFAULT 100 NOT NULL,
	CONSTRAINT PK_Data_StockProductions PRIMARY KEY (StockProductionID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_StockProductions_ProductID_FK ON InfinityRetailDB.Inventory.Data_StockProductions (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_StockTransferOrderActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderActions;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderActions (
	StockTransferOrderActionID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferOrderID_FK int NOT NULL,
	ActionID int DEFAULT 0 NOT NULL,
	CurrentDocumentStateID_FK smallint NOT NULL,
	Description nvarchar(200) COLLATE Arabic_CI_AS NOT NULL,
	ActionDate datetime NOT NULL,
	UserID int NOT NULL,
	UserName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_StockTransferOrderActions PRIMARY KEY (StockTransferOrderActionID_PK)
);


-- InfinityRetailDB.Inventory.Data_StockTransferOrderItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderItems;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderItems (
	StockTransferOrderItemID_PK bigint IDENTITY(1,1) NOT NULL,
	StockTransferOrderID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	OrderQYT decimal(10,3) NOT NULL,
	ApprovedQYT decimal(10,3) NULL,
	ReadyQYT decimal(10,3) NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	Note nvarchar(250) COLLATE Arabic_CI_AS NULL,
	BoxCaption nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_StockTransferOrderItems PRIMARY KEY (StockTransferOrderItemID_PK)
);


-- InfinityRetailDB.Inventory.Data_StockTransferOrders definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders (
	StockTransferOrderID_PK int IDENTITY(1,1) NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	DocumentStateID_FK smallint NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NULL,
	OrderNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	OrderDate datetime NOT NULL,
	DeliveryDate datetime NOT NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_StockTransferOrders PRIMARY KEY (StockTransferOrderID_PK)
);


-- InfinityRetailDB.Inventory.Data_StockTransferProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockTransferProducts;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockTransferProducts (
	StockTransferProductID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	StockOnHand decimal(10,3) NOT NULL,
	TransferredQYT decimal(10,3) NOT NULL,
	TransferredValue decimal(12,3) NOT NULL,
	IntransitQYT decimal(10,3) NOT NULL,
	ReceivedQYT decimal(10,3) NOT NULL,
	AddedToInventoryQYT decimal(10,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	ExpiryDate datetime NULL,
	CONSTRAINT PK_Data_StockTransferProduts PRIMARY KEY (StockTransferProductID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_StockTransferProducts_ProductID_FK ON InfinityRetailDB.Inventory.Data_StockTransferProducts (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_StockTransferProducts_StockTransferID_FK ON InfinityRetailDB.Inventory.Data_StockTransferProducts (  StockTransferID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_StockTransfers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Data_StockTransfers;

CREATE TABLE InfinityRetailDB.Inventory.Data_StockTransfers (
	StockTransferID_PK int IDENTITY(1,1) NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NOT NULL,
	StockTransferNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	DocumentDate datetime NOT NULL,
	RequestedAtDate datetime NOT NULL,
	ReceivedDate datetime NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	StockTransferNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	StockTransferStateID_FK int NOT NULL,
	JournalEntryID_FK int NULL,
	CONSTRAINT PK_Data_StockTransfers PRIMARY KEY (StockTransferID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_StockTransfers_DocumentDate ON InfinityRetailDB.Inventory.Data_StockTransfers (  DocumentDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_StockTransfers_StockTransferNumber ON InfinityRetailDB.Inventory.Data_StockTransfers (  StockTransferNumber ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Log_OnllineStockUpdates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Log_OnllineStockUpdates;

CREATE TABLE InfinityRetailDB.Inventory.Log_OnllineStockUpdates (
	OnlineStockUpdateID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	UpdateType tinyint NOT NULL,
	QYT decimal(18,3) NOT NULL,
	CreateDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT PK_Log_OnllineStockUpdates PRIMARY KEY (OnlineStockUpdateID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Log_OnllineStockUpdates_ProductID_FK ON InfinityRetailDB.Inventory.Log_OnllineStockUpdates (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Log_OnllineStoreUpdates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.Log_OnllineStoreUpdates;

CREATE TABLE InfinityRetailDB.Inventory.Log_OnllineStoreUpdates (
	OnlineStoreUpdateID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(18,3) NOT NULL,
	BaseUnitQYT decimal(7,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UpdateType nvarchar(3) COLLATE Arabic_CI_AS NOT NULL,
	CreateDate datetime NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	CONSTRAINT PK_Log_OnllineStoreUpdates PRIMARY KEY (OnlineStoreUpdateID_PK)
);


-- InfinityRetailDB.Inventory.RefInventoryDepartments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefInventoryDepartments;

CREATE TABLE InfinityRetailDB.Inventory.RefInventoryDepartments (
	InvDepartmentID_PK int IDENTITY(1,1) NOT NULL,
	InventoryCategoryID_FK int DEFAULT 1 NOT NULL,
	InvDepartmentCode nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	InvDepartmentName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	InventoryAccountID_FK int DEFAULT 311 NULL,
	RevnueAccountID_FK int DEFAULT 306 NULL,
	RevnueRefundAccountID_FK int DEFAULT 307 NULL,
	ExpenseAccountID_FK int NULL,
	AdjustmentAccountID_FK int NULL,
	CONSTRAINT PK_Categories PRIMARY KEY (InvDepartmentID_PK),
	CONSTRAINT UK_DepartmentNameOnCategory UNIQUE (InventoryCategoryID_FK,InvDepartmentName)
);
 CREATE NONCLUSTERED INDEX IX_RefInventoryDepartments_InventoryCategoryID_FK ON InfinityRetailDB.Inventory.RefInventoryDepartments (  InventoryCategoryID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.RefInventorySubDepartments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Inventory.RefInventorySubDepartments;

CREATE TABLE InfinityRetailDB.Inventory.RefInventorySubDepartments (
	InvSubDepartmentID_PK int IDENTITY(1,1) NOT NULL,
	InvDepartmentID_FK int NOT NULL,
	InvSubDepartmentName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefInventorySubDepartments PRIMARY KEY (InvSubDepartmentID_PK)
);
 CREATE NONCLUSTERED INDEX IDX_RefInventorySubDepartments_InvSubDepartmentID_PK_INCLUD_InvDepartmentID_FK ON InfinityRetailDB.Inventory.RefInventorySubDepartments (  InvSubDepartmentID_PK ASC  )  
	 INCLUDE ( InvDepartmentID_FK ) 
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_RefInventorySubDepartments_InvDepartmentID_FK ON InfinityRetailDB.Inventory.RefInventorySubDepartments (  InvDepartmentID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Inventory.Data_DamagedItems foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_DamagedItems ADD CONSTRAINT FK_Data_DamagedItems_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_DamagedItems ADD CONSTRAINT FK_Data_DamagedItems_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_DamagedItems ADD CONSTRAINT FK_Data_DamagedItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_DamagedItems ADD CONSTRAINT FK_Data_DamagedItems_RefDamagedItemTypes FOREIGN KEY (DamagedItemTypeID_FK) REFERENCES InfinityRetailDB.Inventory.RefDamagedItemTypes(DamagedItemTypeID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_DamagedItems ADD CONSTRAINT FK_Data_DamagedItems_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_InventoryTransactions foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_InventoryTransactions ADD CONSTRAINT FK_Data_InventoryTransactions_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_InventoryTransactions ADD CONSTRAINT FK_Data_InventoryTransactions_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.Inventory.Data_ProductBOMItems foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBOMItems ADD CONSTRAINT FK_Data_ProductBOMItems_Data_ProductBOMs FOREIGN KEY (ProductBOMID_FK) REFERENCES InfinityRetailDB.Inventory.Data_ProductBOMs(ProductBOMID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBOMItems ADD CONSTRAINT FK_Data_ProductBOMItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBOMItems ADD CONSTRAINT FK_Data_ProductBOMItems_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_ProductBOMs foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBOMs ADD CONSTRAINT FK_Data_ProductBOMs_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBOMs ADD CONSTRAINT FK_Data_ProductBOMs_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_ProductBarcodes foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductBarcodes ADD CONSTRAINT FK_Data_ProductBarcodes_Data_ProductUOMs FOREIGN KEY (ProductUOMID_FK) REFERENCES InfinityRetailDB.Inventory.Data_ProductUOMs(ProductUomID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.Inventory.Data_ProductExpiryDates foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductExpiryDates ADD CONSTRAINT FK_Data_ProductExpireDates_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);


-- InfinityRetailDB.Inventory.Data_ProductInventories foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductInventories ADD CONSTRAINT FK_Data_ProductInventories_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductInventories ADD CONSTRAINT FK_Data_ProductInventories_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductInventories ADD CONSTRAINT FK_Data_ProductInventories_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);


-- InfinityRetailDB.Inventory.Data_ProductPackageItems foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPackageItems ADD CONSTRAINT FK_Data_ProductPackageItems_Data_ProductUOMs FOREIGN KEY (ProductUomID_FK) REFERENCES InfinityRetailDB.Inventory.Data_ProductUOMs(ProductUomID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPackageItems ADD CONSTRAINT FK_Data_ProductPackageItems_Data_Products FOREIGN KEY (PackageProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPackageItems ADD CONSTRAINT FK_Data_ProductPackageItems_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_ProductPhotos foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPhotos ADD CONSTRAINT FK_Data_ProductPhotos_Data_Products FOREIGN KEY (ProductID_PK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.Inventory.Data_ProductPriceUpdates foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPriceUpdates ADD CONSTRAINT FK_Data_ProductPriceUpdates_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductPriceUpdates ADD CONSTRAINT FK_Data_ProductPriceUpdates_RefPriceUpdateReasons FOREIGN KEY (UpdateReasonID_FK) REFERENCES InfinityRetailDB.Inventory.RefPriceUpdateReasons(PriceUpdateReasonID_PK);


-- InfinityRetailDB.Inventory.Data_ProductSNs foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductSNs ADD CONSTRAINT FK_Data_ProductSNs_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);


-- InfinityRetailDB.Inventory.Data_ProductUOMs foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ProductUOMs ADD CONSTRAINT FK_Data_ProductUOMs_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ProductUOMs ADD CONSTRAINT FK_Data_ProductUOMs_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_Products foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_Data_Suppliers FOREIGN KEY (MainSupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefInventorySubDepartments FOREIGN KEY (InvSubDepartmentID_FK) REFERENCES InfinityRetailDB.Inventory.RefInventorySubDepartments(InvSubDepartmentID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefProductGroups FOREIGN KEY (ProductGroupID_FK) REFERENCES InfinityRetailDB.Inventory.RefProductGroups(ProductGroupID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefProductTrademarks FOREIGN KEY (ProductTrademarkID_FK) REFERENCES InfinityRetailDB.Inventory.RefProductTrademarks(ProductTrademarkID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefUOMs FOREIGN KEY (DefaultSellUomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefUOMs1 FOREIGN KEY (DefaultOrderUomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_Products ADD CONSTRAINT FK_Data_Products_RefUOMs2 FOREIGN KEY (DefaultInventoryUomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_ScaleProducts foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_ScaleProducts ADD CONSTRAINT FK_Data_ScaleProducts_Data_ProductUOMs FOREIGN KEY (ProductUomID_FK) REFERENCES InfinityRetailDB.Inventory.Data_ProductUOMs(ProductUomID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ScaleProducts ADD CONSTRAINT FK_Data_ScaleProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_ScaleProducts ADD CONSTRAINT FK_Data_ScaleProducts_Department FOREIGN KEY (DepartmentID_FK) REFERENCES InfinityRetailDB.MyCompany.Department(DepartmentID_PK);


-- InfinityRetailDB.Inventory.Data_StockAdjustmentExpiryDates foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentExpiryDates ADD CONSTRAINT FK_Data_StockAdjustmentExpiryDates_Data_StockAdjustmentProducts FOREIGN KEY (StockAdjustmentProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockAdjustmentProducts(StockAdjustmentProductID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.Inventory.Data_StockAdjustmentProducts foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentProducts ADD CONSTRAINT FK_Data_StockAdjustmentProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentProducts ADD CONSTRAINT FK_Data_StockAdjustmentProducts_Data_StockAdjustments FOREIGN KEY (StockAdjustmentID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockAdjustments(StockAdjustmentID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustmentProducts ADD CONSTRAINT FK_Data_StockAdjustmentProducts_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_StockAdjustments foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_Data_JournalEntries FOREIGN KEY (JournalEntryID_FK) REFERENCES InfinityRetailDB.Financial.Data_JournalEntries(JournalEntryID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_RefStockAdjustmentReasons FOREIGN KEY (StockAdjustmentReasonID_FK) REFERENCES InfinityRetailDB.Inventory.RefStockAdjustmentReasons(StockAdjustmentReasonID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_RefStockAdjustmentStates FOREIGN KEY (StockAdjustmentStateID_FK) REFERENCES InfinityRetailDB.Inventory.RefStockAdjustmentStates(StockAdjustmentStateID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockAdjustments ADD CONSTRAINT FK_Data_StockAdjustments_RefStockAdjustmentTypes FOREIGN KEY (StockAdjustmentTypeID_FK) REFERENCES InfinityRetailDB.Inventory.RefStockAdjustmentTypes(StockAdjustmentTypeID_PK);


-- InfinityRetailDB.Inventory.Data_StockProductionItems foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductionItems ADD CONSTRAINT FK_Data_StockProductionItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductionItems ADD CONSTRAINT FK_Data_StockProductionItems_Data_StockProductions FOREIGN KEY (StockProductionID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockProductions(StockProductionID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductionItems ADD CONSTRAINT FK_Data_StockProductionItems_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_StockProductions foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_RefDocumentStates FOREIGN KEY (StockProductionStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockProductions ADD CONSTRAINT FK_Data_StockProductions_RefUOMs FOREIGN KEY (UomID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_StockTransferOrderActions foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderActions ADD CONSTRAINT FK_Data_StockTransferOrderActions_Data_StockTransfers FOREIGN KEY (StockTransferOrderID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockTransferOrders(StockTransferOrderID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderActions ADD CONSTRAINT FK_Data_StockTransferOrderActions_RefDocumentStates FOREIGN KEY (CurrentDocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);


-- InfinityRetailDB.Inventory.Data_StockTransferOrderItems foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderItems ADD CONSTRAINT FK_Data_StockTransferOrderItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderItems ADD CONSTRAINT FK_Data_StockTransferOrderItems_Data_StockTransferOrders FOREIGN KEY (StockTransferOrderID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockTransferOrders(StockTransferOrderID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrderItems ADD CONSTRAINT FK_Data_StockTransferOrderItems_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_StockTransferOrders foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_Config_BranchLocations FOREIGN KEY (FromLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_Config_BranchLocations1 FOREIGN KEY (ToLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_Config_Branchs FOREIGN KEY (ToBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_Config_Branchs1 FOREIGN KEY (FromBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_RefDocumentStates FOREIGN KEY (DocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferOrders ADD CONSTRAINT FK_Data_StockTransferOrders_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);


-- InfinityRetailDB.Inventory.Data_StockTransferProducts foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferProducts ADD CONSTRAINT FK_Data_StockTransferProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferProducts ADD CONSTRAINT FK_Data_StockTransferProducts_Data_StockTransfers FOREIGN KEY (StockTransferID_FK) REFERENCES InfinityRetailDB.Inventory.Data_StockTransfers(StockTransferID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransferProducts ADD CONSTRAINT FK_Data_StockTransferProducts_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.Data_StockTransfers foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransfers ADD CONSTRAINT FK_Data_StockTransfers_Config_BranchLocations_From FOREIGN KEY (FromLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransfers ADD CONSTRAINT FK_Data_StockTransfers_Config_BranchLocations_To FOREIGN KEY (ToLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransfers ADD CONSTRAINT FK_Data_StockTransfers_Config_Branchs_Create FOREIGN KEY (CreatedByBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransfers ADD CONSTRAINT FK_Data_StockTransfers_Config_Branchs_From FOREIGN KEY (FromBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Data_StockTransfers ADD CONSTRAINT FK_Data_StockTransfers_Config_Branchs_To FOREIGN KEY (ToBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.Inventory.Log_OnllineStockUpdates foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Log_OnllineStockUpdates ADD CONSTRAINT FK_Log_OnllineStockUpdates_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);


-- InfinityRetailDB.Inventory.Log_OnllineStoreUpdates foreign keys

ALTER TABLE InfinityRetailDB.Inventory.Log_OnllineStoreUpdates ADD CONSTRAINT FK_Log_OnllineStoreUpdates_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Log_OnllineStoreUpdates ADD CONSTRAINT FK_Log_OnllineStoreUpdates_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.Inventory.Log_OnllineStoreUpdates ADD CONSTRAINT FK_Log_OnllineStoreUpdates_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Inventory.RefInventoryDepartments foreign keys

ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_Data_Accounts_AdjustmentAccount FOREIGN KEY (AdjustmentAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_Data_Accounts_ExpenseAccount FOREIGN KEY (ExpenseAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_Data_Accounts_InventoryAccount FOREIGN KEY (InventoryAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_Data_Accounts_RevnueAccount FOREIGN KEY (RevnueAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_Data_Accounts_RevnueRefundAccount FOREIGN KEY (RevnueRefundAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Inventory.RefInventoryDepartments ADD CONSTRAINT FK_RefInventoryDepartments_RefInventoryCategories FOREIGN KEY (InventoryCategoryID_FK) REFERENCES InfinityRetailDB.Inventory.RefInventoryCategories(InventoryCategoryID_PK);


-- InfinityRetailDB.Inventory.RefInventorySubDepartments foreign keys

ALTER TABLE InfinityRetailDB.Inventory.RefInventorySubDepartments ADD CONSTRAINT FK_RefInventorySubDepartments_RefInventoryDepartments FOREIGN KEY (InvDepartmentID_FK) REFERENCES InfinityRetailDB.Inventory.RefInventoryDepartments(InvDepartmentID_PK);


-- Inventory.Data_View_DamagedItems source

ALTER VIEW [Inventory].[Data_View_DamagedItems]
AS
SELECT     Inventory.Data_DamagedItems.BranchID_FK, Inventory.Data_DamagedItems.DamagedItemTypeID_FK, Inventory.Data_DamagedItems.ProductID_FK, 
                      Inventory.Data_DamagedItems.UomID_FK, Inventory.Data_DamagedItems.QYT, Inventory.Data_DamagedItems.Cost, Inventory.Data_DamagedItems.ExpiryDate, 
                      Inventory.Data_DamagedItems.Note, Inventory.Data_DamagedItems.CreatedByUserID, Inventory.Data_DamagedItems.CreatedByUserName, 
                      Inventory.Data_DamagedItems.CreatedDate, Inventory.Data_DamagedItems.ModifiedByUserID, Inventory.Data_DamagedItems.ModifiedByUserName, 
                      Inventory.Data_DamagedItems.ModifiedDate, Inventory.RefDamagedItemTypes.DamagedItemTypeCaption, Inventory.RefDamagedItemTypes.IsReadOnly, 
                      Inventory.Data_View_Products.ProductCode, Inventory.Data_View_Products.ProductName, Inventory.Data_View_Products.InvDepartmentName, 
                      Inventory.Data_View_Products.InvSubDepartmentName, Inventory.Data_View_Products.InventoryCategoryName, 
                      Inventory.Data_View_Products.ProductTrademarkDescrption, Inventory.Data_View_Products.ProductGroupDescription, Inventory.RefUOMs.UOMName, 
                      Inventory.Data_DamagedItems.DamagedItemID_PK, MyCompany.Config_BranchLocations.LocationCode, MyCompany.Config_BranchLocations.LocationName, 
                      Inventory.Data_DamagedItems.LocationID_FK, MyCompany.Config_Branchs.BranchName, Inventory.Data_DamagedItems.IsSynced
FROM         Inventory.Data_DamagedItems INNER JOIN
                      Inventory.RefDamagedItemTypes ON 
                      Inventory.Data_DamagedItems.DamagedItemTypeID_FK = Inventory.RefDamagedItemTypes.DamagedItemTypeID_PK INNER JOIN
                      Inventory.Data_View_Products ON Inventory.Data_DamagedItems.ProductID_FK = Inventory.Data_View_Products.ProductID_PK INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_DamagedItems.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON Inventory.Data_DamagedItems.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_DamagedItems.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Inventory.Data_View_OnStockExpiredInventory source

ALTER VIEW [Inventory].[Data_View_OnStockExpiredInventory]
AS
SELECT     Inventory.Data_View_ProductInventories.BranchName, Inventory.Data_View_ProductInventories.LocationName, Inventory.Data_View_ProductInventories.ExpiryDate, 
                      Inventory.Data_View_ProductInventories.StockOnHand, Inventory.Data_View_ProductInventories.LocationID_FK, 
                      Inventory.Data_View_ProductInventories.modifiedByUserName, Inventory.Data_View_ProductInventories.CreatedByUserName, 
                      Inventory.Data_View_ProductInventories.Createddate, Inventory.Data_View_ProductInventories.BranchID_FK, Inventory.Data_View_ProductInventories.modifiedDate, 
                      Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, Inventory.Data_Products.StockOnHand AS TotalStockOnHand, 
                      Inventory.Data_Products.ProductLocations, Inventory.Data_View_ProductInventories.ProductInventoryID_PK, Inventory.Data_Products.ProductShortName, 
                      Inventory.Data_Products.ProductID_PK
FROM         Inventory.Data_View_ProductInventories INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_View_ProductInventories.ProductID_FK = Inventory.Data_Products.ProductID_PK
WHERE     (Inventory.Data_View_ProductInventories.ExpiryDate <= GETDATE());


-- Inventory.Data_View_ProductBOMItems source

ALTER VIEW [Inventory].[Data_View_ProductBOMItems]
AS
SELECT     Inventory.Data_ProductBOMItems.ProductBOMItemID_PK, Inventory.Data_ProductBOMItems.ProductBOMID_FK, Inventory.Data_ProductBOMItems.ProductID_FK, 
                      Inventory.Data_ProductBOMItems.UomID_FK, Inventory.Data_ProductBOMItems.UnitBaseQYT, Inventory.Data_ProductBOMItems.QYT, 
                      Inventory.Data_ProductBOMItems.Comment, Inventory.Data_ProductBOMItems.CreatedByUserID, Inventory.Data_ProductBOMItems.CreatedByUserName, 
                      Inventory.Data_ProductBOMItems.CreatedDate, Inventory.Data_ProductBOMItems.ModifiedByUserID, Inventory.Data_ProductBOMItems.ModifiedByUserName, 
                      Inventory.Data_ProductBOMItems.ModifiedDate, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductTypeID_FK, 
                      Inventory.Data_Products.ProductName, Inventory.RefUOMs.UOMName, Inventory.Data_ProductUOMs.UomCost
FROM         Inventory.Data_ProductBOMItems INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_ProductBOMItems.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductBOMItems.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_ProductUOMs ON Inventory.Data_Products.ProductID_PK = Inventory.Data_ProductUOMs.ProductID_FK AND 
                      Inventory.RefUOMs.UOMID_PK = Inventory.Data_ProductUOMs.UomID_FK;


-- Inventory.Data_View_ProductBOMs source

ALTER VIEW [Inventory].[Data_View_ProductBOMs]
AS
SELECT     Inventory.Data_ProductBOMs.ProductBOMID_PK, Inventory.Data_ProductBOMs.ProductID_FK, Inventory.Data_ProductBOMs.UomID_FK, 
                      Inventory.Data_ProductBOMs.BaseUnitQYT, Inventory.Data_ProductBOMs.ProductQTY, Inventory.Data_ProductBOMs.Note, 
                      Inventory.Data_ProductBOMs.CreatedByUserID, Inventory.Data_ProductBOMs.CreatedByUserName, Inventory.Data_ProductBOMs.CreatedDate, 
                      Inventory.Data_ProductBOMs.ModifiedByUserID, Inventory.Data_ProductBOMs.ModifiedByUserName, Inventory.Data_ProductBOMs.ModifiedDate, 
                      Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, Inventory.Data_Products.ProductTypeID_FK, Inventory.RefUOMs.UOMName
FROM         Inventory.Data_ProductBOMs INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_ProductBOMs.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductBOMs.UomID_FK = Inventory.RefUOMs.UOMID_PK;


-- Inventory.Data_View_ProductInventories source

ALTER VIEW [Inventory].[Data_View_ProductInventories]
AS
SELECT     Inventory.Data_ProductInventories.*, MyCompany.Config_Branchs.BranchName, MyCompany.Config_BranchLocations.LocationCode, 
					  MyCompany.Config_BranchLocations.LocationName, 
                      CASE WHEN Inventory.Data_ProductInventories.StockOnHand < 0 THEN 1 ELSE 0 END AS IsNegativeStock
FROM         Inventory.Data_ProductInventories INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_ProductInventories.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON Inventory.Data_ProductInventories.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK AND 
                      MyCompany.Config_Branchs.BranchID_PK = MyCompany.Config_BranchLocations.BranchID_FK AND 
                      MyCompany.Config_Branchs.BranchID_PK = MyCompany.Config_BranchLocations.BranchID_FK;


-- Inventory.Data_View_ProductPackageItems source

ALTER VIEW [Inventory].[Data_View_ProductPackageItems]
AS
SELECT     Inventory.Data_ProductPackageItems.ProductPackageItemID_PK, Inventory.Data_ProductPackageItems.ProductUomID_FK, 
                      Inventory.Data_ProductPackageItems.PackageProductID_FK, Inventory.Data_ProductPackageItems.UomID_FK, Inventory.Data_ProductPackageItems.QYT, 
                      Inventory.Data_ProductPackageItems.UomCost, Inventory.Data_ProductPackageItems.CreatedByUserID, Inventory.Data_ProductPackageItems.CreatedByUserName, 
                      Inventory.Data_ProductPackageItems.CreatedDate, Inventory.Data_ProductPackageItems.ModifiedByUserID, 
                      Inventory.Data_ProductPackageItems.ModifiedByUserName, Inventory.Data_ProductPackageItems.ModifiedDate, Inventory.RefUOMs.UOMName, 
                      Inventory.Data_Products.ProductName, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductTypeID_FK, Inventory.Data_Products.ProductID_PK, 
                      Inventory.Data_ProductUOMs.ProductID_FK
FROM         Inventory.Data_ProductPackageItems INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductPackageItems.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_ProductPackageItems.PackageProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.Data_ProductUOMs ON Inventory.Data_ProductPackageItems.ProductUomID_FK = Inventory.Data_ProductUOMs.ProductUomID_PK;


-- Inventory.Data_View_ProductPriceUpdates source

ALTER VIEW [Inventory].[Data_View_ProductPriceUpdates]
AS
SELECT     Inventory.Data_ProductPriceUpdates.ProductPriceUpdateID_PK, Inventory.Data_ProductPriceUpdates.BranchID_FK, 
                      Inventory.Data_ProductPriceUpdates.ProductID_FK, Inventory.Data_ProductPriceUpdates.PriceLevel, Inventory.Data_ProductPriceUpdates.OldValue, 
                      Inventory.Data_ProductPriceUpdates.NewValue, Inventory.Data_ProductPriceUpdates.Variance, Inventory.Data_ProductPriceUpdates.UpdateSourceReference, 
                      Inventory.Data_ProductPriceUpdates.UpdateReasonID_FK, Inventory.Data_ProductPriceUpdates.PriceUpdateDescription, 
                      Inventory.Data_ProductPriceUpdates.CreatedByUserID, Inventory.Data_ProductPriceUpdates.CreatedByUserName, Inventory.Data_ProductPriceUpdates.CreatedDate, 
                      Inventory.RefPriceUpdateReasons.PriceUpdateReasonCaption, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, 
                      Inventory.Data_Products.ISCostHidden, Inventory.Data_ProductPriceUpdates.IsSynced, MyCompany.Config_Branchs.BranchName
FROM         Inventory.Data_ProductPriceUpdates INNER JOIN
                      Inventory.RefPriceUpdateReasons ON 
                      Inventory.Data_ProductPriceUpdates.UpdateReasonID_FK = Inventory.RefPriceUpdateReasons.PriceUpdateReasonID_PK INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_ProductPriceUpdates.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_ProductPriceUpdates.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Inventory.Data_View_ProductSNs source

ALTER VIEW [Inventory].[Data_View_ProductSNs]
AS
SELECT     Inventory.Data_ProductSNs.*
FROM         Inventory.Data_ProductSNs;


-- Inventory.Data_View_ProductUOMBarcodes source

ALTER VIEW Inventory.Data_View_ProductUOMBarcodes
AS
SELECT     Inventory.Data_ProductBarcodes.ProductBarcodeID_PK, Inventory.Data_ProductBarcodes.ProductUOMID_FK, Inventory.Data_ProductBarcodes.ProductBarcode, 
                      Inventory.Data_View_ProductUOMs.ProductUomID_PK, Inventory.Data_View_ProductUOMs.ProductID_FK, Inventory.Data_View_ProductUOMs.UomID_FK, 
                      Inventory.Data_View_ProductUOMs.BaseUnitQYT, Inventory.Data_View_ProductUOMs.UomLastCost, Inventory.Data_View_ProductUOMs.UomPrice1, 
                      Inventory.Data_View_ProductUOMs.UomPrice2, Inventory.Data_View_ProductUOMs.UomPrice3, Inventory.Data_View_ProductUOMs.UomPrice4, 
                      Inventory.Data_ProductBarcodes.CreatedByUserID, Inventory.Data_ProductBarcodes.CreatedByUserName, Inventory.Data_ProductBarcodes.CreatedDate, 
                      Inventory.Data_ProductBarcodes.ModifiedByUserID, Inventory.Data_ProductBarcodes.ModifiedByUserName, Inventory.Data_ProductBarcodes.ModifiedDate, 
                      Inventory.Data_View_ProductUOMs.UomLastPurchaseCost, Inventory.Data_View_ProductUOMs.UomCost, Inventory.Data_View_ProductUOMs.UomPurchaseCost, 
                      Inventory.Data_View_ProductUOMs.UOMCategoryName, Inventory.Data_View_ProductUOMs.UOMCategoryID_FK, Inventory.Data_View_ProductUOMs.UomMiniPrice, 
                      Inventory.Data_View_ProductUOMs.UOMName, Inventory.Data_ProductBarcodes.GeneratedByInfinityPOS
FROM         Inventory.Data_ProductBarcodes INNER JOIN
                      Inventory.Data_View_ProductUOMs ON Inventory.Data_ProductBarcodes.ProductUOMID_FK = Inventory.Data_View_ProductUOMs.ProductUomID_PK;


-- Inventory.Data_View_ProductUOMs source

ALTER VIEW [Inventory].[Data_View_ProductUOMs]
AS
SELECT     Inventory.Data_ProductUOMs.ProductUomID_PK, Inventory.Data_ProductUOMs.ProductID_FK, Inventory.Data_ProductUOMs.UomID_FK, 
                      Inventory.Data_ProductUOMs.BaseUnitQYT, Inventory.Data_ProductUOMs.UomPurchaseCost, Inventory.Data_ProductUOMs.UomCost, 
                      Inventory.Data_ProductUOMs.UomLastPurchaseCost, Inventory.Data_ProductUOMs.UomLastCost, Inventory.Data_ProductUOMs.UomPrice1, 
                      Inventory.Data_ProductUOMs.UomPrice2, Inventory.Data_ProductUOMs.UomPrice3, Inventory.Data_ProductUOMs.UomPrice4, 
                      Inventory.Data_ProductUOMs.CreatedByUserID, Inventory.Data_ProductUOMs.CreatedByUserName, Inventory.Data_ProductUOMs.CreatedDate, 
                      Inventory.Data_ProductUOMs.ModifiedByUserID, Inventory.Data_ProductUOMs.ModifiedByUserName, Inventory.Data_ProductUOMs.ModifiedDate, 
                      Inventory.RefUOMs.UOMName, Inventory.Data_ProductUOMs.UomMiniPrice, Inventory.RefUOMs.UOMCategoryID_FK, 
                      Inventory.RefUOMCategories.UOMCategoryName, Inventory.Data_ProductUOMs.UOMLastPrice, 
                      CASE WHEN Inventory.Data_ProductUOMs.UomCost <> 0 THEN ((Inventory.Data_ProductUOMs.UomPrice1 - Inventory.Data_ProductUOMs.UomCost) / UomCost) 
                      * 100 ELSE 0 END AS UOMProfitRate, 
                      CASE WHEN Inventory.Data_ProductUOMs.UomPrice1 <> 0 THEN ((Inventory.Data_ProductUOMs.UomPrice1 - Inventory.Data_ProductUOMs.UomCost) / UomPrice1) 
                      * 100 ELSE 0 END AS UOMProfitMargin, 
                      CASE WHEN Inventory.Data_ProductUOMs.UomLastPurchaseCost <> 0 THEN ((Inventory.Data_ProductUOMs.UomPrice1 - Inventory.Data_ProductUOMs.UomLastPurchaseCost)
                       / UomLastPurchaseCost) * 100 ELSE 0 END AS UOMLastPCostProfitRate, 
                      CASE WHEN Inventory.Data_ProductUOMs.UomPrice1 <> 0 THEN ((Inventory.Data_ProductUOMs.UomPrice1 - Inventory.Data_ProductUOMs.UomLastPurchaseCost) 
                      / UomPrice1) * 100 ELSE 0 END AS UOMLastPCostProfitMargin
FROM         Inventory.Data_ProductUOMs INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductUOMs.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.RefUOMCategories ON Inventory.RefUOMs.UOMCategoryID_FK = Inventory.RefUOMCategories.UOMCategoryID_PK;


-- Inventory.Data_View_Products source

ALTER VIEW [Inventory].[Data_View_Products]
AS
SELECT     Inventory.Data_Products.ProductID_PK, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, Inventory.Data_Products.ProductShortName, 
                      Inventory.Data_Products.SalesDecription, Inventory.Data_Products.PurchaseDescription, Inventory.Data_Products.ProductTypeID_FK, 
                      Inventory.Data_Products.InvSubDepartmentID_FK, Inventory.Data_Products.ProductGroupID_FK, Inventory.Data_Products.ProductTrademarkID_FK, 
                      Inventory.Data_Products.DefaultSellUomID_FK, Inventory.Data_Products.DefaultOrderUomID_FK, Inventory.Data_Products.MinStockLevel, 
                      Inventory.Data_Products.MaxStockLevel, Inventory.Data_Products.IsInActive, Inventory.Data_Products.IsDiscontinuousItem, 
                      Inventory.Data_Products.IsNonDiscountableItem, Inventory.Data_Products.IsHasOpenPrice, Inventory.Data_Products.StockOnHand, 
                      Inventory.Data_Products.StockOnHold, Inventory.Data_Products.TotalReceivedQYT, Inventory.Data_Products.TotalSoldQYT, 
                      Inventory.Data_Products.LastSalesTransactionDate, Inventory.Data_Products.LastReceiveTransactionDate, Inventory.Data_Products.LastOrderTransactionDate, 
                      Inventory.Data_Products.LastStockAdjTransactionDate, Inventory.Data_Products.CreatedByUserID, Inventory.Data_Products.CreatedByUserName, 
                      Inventory.Data_Products.CreatedDate, Inventory.Data_Products.ModifiedByUserID, Inventory.Data_Products.ModifiedByUserName, 
                      Inventory.Data_Products.ModifiedDate, Inventory.RefInventorySubDepartments.InvSubDepartmentName, Inventory.RefInventoryDepartments.InvDepartmentName, 
                      Inventory.RefInventoryDepartments.InvDepartmentCode, Inventory.RefInventoryDepartments.InvDepartmentID_PK, 
                      Inventory.RefInventoryCategories.InventoryCategoryID_PK, Inventory.RefInventoryCategories.InventoryCategoryCode, 
                      Inventory.RefInventoryCategories.InventoryCategoryName, Inventory.RefProductTrademarks.ProductTrademarkID_PK, 
                      Inventory.RefProductTrademarks.ProductTrademarkDescrption, Inventory.RefProductGroups.ProductGroupID_PK, 
                      Inventory.RefProductGroups.ProductGroupDescription, Inventory.Data_Products.DefaultInventoryUomID_FK, Inventory.Data_Products.manfuctureCode, 
                      Inventory.Data_Products.ProductLocations, Inventory.Data_Products.LastRefundTransactionDate, Inventory.RefInventoryDepartments.InventoryAccountID_FK, 
                      Inventory.RefInventoryDepartments.RevnueAccountID_FK, Inventory.RefInventoryDepartments.ExpenseAccountID_FK, 
                      Inventory.Data_Products.ConfirmSoldProductUOM, Inventory.Data_Products.IsNonRefundableItem, Inventory.Data_Products.LogicalOrderPrinter1ID, 
                      Inventory.Data_Products.LogicalOrderPrinter2ID, Inventory.Data_Products.MainSupplierID_FK, Purchase.Data_Suppliers.SupplierName, 
                      Inventory.RefProductTypes.ProductTypeDescrption, Inventory.Data_Products.IsProductionProduct, Inventory.Data_Products.ISCostHidden, 
                      Inventory.Data_Products.SalesPoints, Inventory.RefInventoryDepartments.RevnueRefundAccountID_FK, Inventory.RefInventoryDepartments.AdjustmentAccountID_FK, 
                      Inventory.Data_Products.IsHasSerialNO, Inventory.Data_ProductPhotos.ProductID_PK AS PhotoID_PK
FROM         Inventory.Data_Products INNER JOIN
                      Inventory.RefInventorySubDepartments ON 
                      Inventory.Data_Products.InvSubDepartmentID_FK = Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK INNER JOIN
                      Inventory.RefInventoryDepartments ON 
                      Inventory.RefInventorySubDepartments.InvDepartmentID_FK = Inventory.RefInventoryDepartments.InvDepartmentID_PK INNER JOIN
                      Inventory.RefInventoryCategories ON 
                      Inventory.RefInventoryDepartments.InventoryCategoryID_FK = Inventory.RefInventoryCategories.InventoryCategoryID_PK INNER JOIN
                      Inventory.RefProductTrademarks ON Inventory.Data_Products.ProductTrademarkID_FK = Inventory.RefProductTrademarks.ProductTrademarkID_PK INNER JOIN
                      Inventory.RefProductGroups ON Inventory.Data_Products.ProductGroupID_FK = Inventory.RefProductGroups.ProductGroupID_PK INNER JOIN
                      Inventory.RefProductTypes ON Inventory.Data_Products.ProductTypeID_FK = Inventory.RefProductTypes.ProductTypeID_PK LEFT OUTER JOIN
                      Inventory.Data_ProductPhotos ON Inventory.Data_Products.ProductID_PK = Inventory.Data_ProductPhotos.ProductID_PK LEFT OUTER JOIN
                      Purchase.Data_Suppliers ON Inventory.Data_Products.MainSupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK;


-- Inventory.Data_View_ProductsWithBasedUOM source

ALTER VIEW [Inventory].[Data_View_ProductsWithBasedUOM]
AS
SELECT     Inventory.RefUOMs.UOMName, Inventory.Data_ProductUOMs.UomPurchaseCost, Inventory.Data_ProductUOMs.UomCost, 
                      Inventory.Data_ProductUOMs.UomLastPurchaseCost, Inventory.Data_ProductUOMs.UomLastCost, Inventory.Data_ProductUOMs.UomID_FK, 
                      Inventory.Data_ProductUOMs.BaseUnitQYT, Inventory.Data_ProductUOMs.UomPrice1, Inventory.Data_ProductUOMs.UomPrice2, 
                      Inventory.Data_ProductUOMs.UomPrice3, Inventory.Data_ProductUOMs.UomPrice4, Inventory.Data_ProductUOMs.UomMiniPrice, 
                      Inventory.Data_ProductUOMs.ProductUomID_PK, Inventory.Data_View_Products.ProductID_PK, Inventory.Data_View_Products.ProductCode, 
                      Inventory.Data_View_Products.ProductName, Inventory.Data_View_Products.ProductShortName, Inventory.Data_View_Products.SalesDecription, 
                      Inventory.Data_View_Products.PurchaseDescription, Inventory.Data_View_Products.ProductTypeID_FK, Inventory.Data_View_Products.InvSubDepartmentID_FK, 
                      Inventory.Data_View_Products.ProductGroupID_FK, Inventory.Data_View_Products.ProductTrademarkID_FK, Inventory.Data_View_Products.DefaultSellUomID_FK, 
                      Inventory.Data_View_Products.DefaultOrderUomID_FK, Inventory.Data_View_Products.MinStockLevel, Inventory.Data_View_Products.MaxStockLevel, 
                      Inventory.Data_View_Products.IsInActive, Inventory.Data_View_Products.IsDiscontinuousItem, Inventory.Data_View_Products.IsNonDiscountableItem, 
                      Inventory.Data_View_Products.IsHasOpenPrice, Inventory.Data_View_Products.StockOnHand, Inventory.Data_View_Products.StockOnHold, 
                      Inventory.Data_View_Products.TotalReceivedQYT, Inventory.Data_View_Products.TotalSoldQYT, Inventory.Data_View_Products.LastSalesTransactionDate, 
                      Inventory.Data_View_Products.LastReceiveTransactionDate, Inventory.Data_View_Products.LastOrderTransactionDate, 
                      Inventory.Data_View_Products.LastStockAdjTransactionDate, Inventory.Data_View_Products.CreatedByUserID, Inventory.Data_View_Products.CreatedByUserName, 
                      Inventory.Data_View_Products.CreatedDate, Inventory.Data_View_Products.ModifiedByUserID, Inventory.Data_View_Products.ModifiedByUserName, 
                      Inventory.Data_View_Products.ModifiedDate, Inventory.Data_View_Products.InvSubDepartmentName, Inventory.Data_View_Products.InvDepartmentName, 
                      Inventory.Data_View_Products.InvDepartmentCode, Inventory.Data_View_Products.InvDepartmentID_PK, Inventory.Data_View_Products.InventoryCategoryID_PK, 
                      Inventory.Data_View_Products.InventoryCategoryCode, Inventory.Data_View_Products.InventoryCategoryName, 
                      Inventory.Data_View_Products.ProductTrademarkID_PK, Inventory.Data_View_Products.ProductTrademarkDescrption, 
                      Inventory.Data_View_Products.ProductGroupID_PK, Inventory.Data_View_Products.ProductGroupDescription, 
                      Inventory.Data_View_Products.DefaultInventoryUomID_FK, Inventory.Data_View_Products.manfuctureCode, Inventory.Data_View_Products.ProductLocations, 
                      Inventory.Data_View_Products.LastRefundTransactionDate, Inventory.Data_View_Products.InventoryAccountID_FK, 
                      Inventory.Data_View_Products.RevnueAccountID_FK, Inventory.Data_View_Products.ExpenseAccountID_FK, Inventory.Data_View_Products.ConfirmSoldProductUOM, 
                      Inventory.Data_ProductUOMs.UOMLastPrice, Inventory.Data_View_Products.MainSupplierID_FK, Inventory.Data_View_Products.SupplierName, 
                      Inventory.Data_View_Products.IsProductionProduct, Inventory.Data_View_Products.ProductTypeDescrption, Inventory.Data_View_Products.IsNonRefundableItem, 
                      Inventory.Data_View_Products.LogicalOrderPrinter1ID, Inventory.Data_View_Products.LogicalOrderPrinter2ID, Inventory.Data_View_Products.ISCostHidden, 
                      Inventory.Data_View_Products.IsHasSerialNO, Inventory.Data_View_Products.PhotoID_PK
FROM         Inventory.Data_ProductUOMs INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductUOMs.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_View_Products ON Inventory.Data_ProductUOMs.ProductID_FK = Inventory.Data_View_Products.ProductID_PK
WHERE     (Inventory.Data_ProductUOMs.BaseUnitQYT = 1);


-- Inventory.Data_View_ProductsWithInventoryUOM source

ALTER VIEW [Inventory].[Data_View_ProductsWithInventoryUOM]
AS
SELECT     Inventory.RefUOMs.UOMName, Inventory.Data_ProductUOMs.UomPurchaseCost, Inventory.Data_ProductUOMs.UomCost, 
                      Inventory.Data_ProductUOMs.UomLastPurchaseCost, Inventory.Data_ProductUOMs.UomLastCost, Inventory.Data_ProductUOMs.UomID_FK, 
                      Inventory.Data_ProductUOMs.BaseUnitQYT, Inventory.Data_ProductUOMs.UomPrice1, Inventory.Data_ProductUOMs.UomPrice2, 
                      Inventory.Data_ProductUOMs.UomPrice3, Inventory.Data_ProductUOMs.UomPrice4, Inventory.Data_ProductUOMs.UomMiniPrice, 
                      Inventory.Data_ProductUOMs.ProductUomID_PK, Inventory.Data_View_Products.ProductID_PK, Inventory.Data_View_Products.ProductCode, 
                      Inventory.Data_View_Products.ProductName, Inventory.Data_View_Products.ProductShortName, Inventory.Data_View_Products.SalesDecription, 
                      Inventory.Data_View_Products.PurchaseDescription, Inventory.Data_View_Products.ProductTypeID_FK, Inventory.Data_View_Products.InvSubDepartmentID_FK, 
                      Inventory.Data_View_Products.ProductGroupID_FK, Inventory.Data_View_Products.ProductTrademarkID_FK, Inventory.Data_View_Products.DefaultSellUomID_FK, 
                      Inventory.Data_View_Products.DefaultOrderUomID_FK, Inventory.Data_View_Products.MinStockLevel, Inventory.Data_View_Products.MaxStockLevel, 
                      Inventory.Data_View_Products.IsInActive, Inventory.Data_View_Products.IsDiscontinuousItem, Inventory.Data_View_Products.IsNonDiscountableItem, 
                      Inventory.Data_View_Products.IsHasOpenPrice, Inventory.Data_View_Products.StockOnHand, Inventory.Data_View_Products.StockOnHold, 
                      Inventory.Data_View_Products.TotalReceivedQYT, Inventory.Data_View_Products.TotalSoldQYT, Inventory.Data_View_Products.LastSalesTransactionDate, 
                      Inventory.Data_View_Products.LastReceiveTransactionDate, Inventory.Data_View_Products.LastOrderTransactionDate, 
                      Inventory.Data_View_Products.LastStockAdjTransactionDate, Inventory.Data_View_Products.CreatedByUserID, Inventory.Data_View_Products.CreatedByUserName, 
                      Inventory.Data_View_Products.CreatedDate, Inventory.Data_View_Products.ModifiedByUserID, Inventory.Data_View_Products.ModifiedByUserName, 
                      Inventory.Data_View_Products.ModifiedDate, Inventory.Data_View_Products.InvSubDepartmentName, Inventory.Data_View_Products.InvDepartmentName, 
                      Inventory.Data_View_Products.InvDepartmentCode, Inventory.Data_View_Products.InvDepartmentID_PK, Inventory.Data_View_Products.InventoryCategoryID_PK, 
                      Inventory.Data_View_Products.InventoryCategoryCode, Inventory.Data_View_Products.InventoryCategoryName, 
                      Inventory.Data_View_Products.ProductTrademarkID_PK, Inventory.Data_View_Products.ProductTrademarkDescrption, 
                      Inventory.Data_View_Products.ProductGroupID_PK, Inventory.Data_View_Products.ProductGroupDescription, 
                      Inventory.Data_View_Products.DefaultInventoryUomID_FK, Inventory.Data_View_Products.manfuctureCode, Inventory.Data_View_Products.ProductLocations, 
                      Inventory.Data_View_Products.LastRefundTransactionDate, Inventory.Data_View_Products.InventoryAccountID_FK, 
                      Inventory.Data_View_Products.RevnueAccountID_FK, Inventory.Data_View_Products.ExpenseAccountID_FK, Inventory.Data_View_Products.ConfirmSoldProductUOM, 
                      Inventory.Data_ProductUOMs.UOMLastPrice, Inventory.Data_View_Products.MainSupplierID_FK, Inventory.Data_View_Products.SupplierName, 
                      Inventory.Data_View_Products.ProductTypeDescrption, Inventory.Data_View_Products.IsProductionProduct, Inventory.Data_View_Products.LogicalOrderPrinter2ID, 
                      Inventory.Data_View_Products.LogicalOrderPrinter1ID, Inventory.Data_View_Products.IsNonRefundableItem, Inventory.Data_View_Products.ISCostHidden, 
                      Inventory.Data_View_Products.IsHasSerialNO, Inventory.Data_View_Products.PhotoID_PK
FROM         Inventory.Data_ProductUOMs INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_ProductUOMs.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_View_Products ON Inventory.Data_ProductUOMs.ProductID_FK = Inventory.Data_View_Products.ProductID_PK AND 
                      Inventory.Data_ProductUOMs.UomID_FK = Inventory.Data_View_Products.DefaultInventoryUomID_FK;


-- Inventory.Data_View_StockAdjustmentDistinctCountedProducts source

ALTER VIEW [Inventory].[Data_View_StockAdjustmentDistinctCountedProducts]
AS
SELECT DISTINCT Inventory.Data_StockAdjustmentProducts.ProductID_FK
FROM         Inventory.Data_StockAdjustmentProducts INNER JOIN
                      Inventory.Data_StockAdjustments ON 
                      Inventory.Data_StockAdjustmentProducts.StockAdjustmentID_FK = Inventory.Data_StockAdjustments.StockAdjustmentID_PK
WHERE     (Inventory.Data_StockAdjustments.StockAdjustmentTypeID_FK = 40) AND (Inventory.Data_StockAdjustments.StockAdjustmentStateID_FK = 10);


-- Inventory.Data_View_StockAdjustmentExpiryDates source

ALTER VIEW [Inventory].[Data_View_StockAdjustmentExpiryDates]
AS
SELECT     Inventory.Data_StockAdjustmentExpiryDates.*
FROM         Inventory.Data_StockAdjustmentExpiryDates;


-- Inventory.Data_View_StockAdjustmentProducts source

ALTER VIEW [Inventory].[Data_View_StockAdjustmentProducts]
AS
SELECT     Inventory.Data_StockAdjustmentProducts.StockAdjustmentProductID_PK, Inventory.Data_StockAdjustmentProducts.StockAdjustmentID_FK, 
                      Inventory.Data_StockAdjustmentProducts.ProductID_FK, Inventory.Data_StockAdjustmentProducts.UnitID_FK, Inventory.Data_StockAdjustmentProducts.UnitBaseQYT, 
                      Inventory.Data_StockAdjustmentProducts.UnitCost, Inventory.Data_StockAdjustmentProducts.StockOnHand, Inventory.Data_StockAdjustmentProducts.AdjustmentQYT, 
                      Inventory.Data_StockAdjustmentProducts.AdjustmentValue, Inventory.Data_StockAdjustmentProducts.QYTVariance, 
                      Inventory.Data_StockAdjustmentProducts.ValueVariance, Inventory.Data_StockAdjustmentProducts.Comment, 
                      Inventory.Data_StockAdjustmentProducts.CreatedByUserID, Inventory.Data_StockAdjustmentProducts.CreatedByUserName, 
                      Inventory.Data_StockAdjustmentProducts.CreatedDate, Inventory.Data_StockAdjustmentProducts.ModifiedByUserID, 
                      Inventory.Data_StockAdjustmentProducts.ModifiedByUserName, Inventory.Data_StockAdjustmentProducts.ModifiedDate, Inventory.RefUOMs.UOMName, 
                      Inventory.Data_View_Products.ProductID_PK, Inventory.Data_View_Products.ProductCode, Inventory.Data_View_Products.ProductName, 
                      Inventory.Data_View_Products.ProductTypeID_FK, Inventory.Data_View_Products.InventoryAccountID_FK, 
                      Inventory.Data_View_Products.AdjustmentAccountID_FK
FROM         Inventory.Data_StockAdjustmentProducts INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_StockAdjustmentProducts.UnitID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_View_Products ON Inventory.Data_StockAdjustmentProducts.ProductID_FK = Inventory.Data_View_Products.ProductID_PK;


-- Inventory.Data_View_StockAdjustments source

ALTER VIEW [Inventory].[Data_View_StockAdjustments]
AS
SELECT     Inventory.Data_StockAdjustments.StockAdjustmentID_PK, Inventory.Data_StockAdjustments.BranchID_FK, Inventory.Data_StockAdjustments.LocationID_FK, 
                      Inventory.Data_StockAdjustments.StockAdjustmentTypeID_FK, Inventory.Data_StockAdjustments.StockAdjustmentNumber, 
                      Inventory.Data_StockAdjustments.DocumentTypeID_FK, Inventory.Data_StockAdjustments.StockAdjustmentReasonID_FK, 
                      Inventory.Data_StockAdjustments.StockAdjustmentNote, Inventory.Data_StockAdjustments.StockAdjustmentStateID_FK, 
                      Inventory.Data_StockAdjustments.CreatedByUserID, Inventory.Data_StockAdjustments.CreatedByUserName, Inventory.Data_StockAdjustments.CreatedDate, 
                      Inventory.Data_StockAdjustments.ModifiedByUserID, Inventory.Data_StockAdjustments.ModifiedByUserName, Inventory.Data_StockAdjustments.ModifiedDate, 
                      Inventory.Data_StockAdjustments.JournalEntryID_FK, Inventory.RefStockAdjustmentReasons.StockAdjustmentReasonCaption, 
                      Inventory.RefStockAdjustmentStates.StockAdjustmentStateCaption, MyCompany.Config_BranchLocations.LocationName, 
                      Inventory.RefStockAdjustmentTypes.StockAdjustmentTypeCaption, MyCompany.Config_Branchs.BranchName, Inventory.Data_StockAdjustments.IsSynced
FROM         Inventory.Data_StockAdjustments INNER JOIN
                      Inventory.RefStockAdjustmentReasons ON 
                      Inventory.Data_StockAdjustments.StockAdjustmentReasonID_FK = Inventory.RefStockAdjustmentReasons.StockAdjustmentReasonID_PK INNER JOIN
                      Inventory.RefStockAdjustmentStates ON 
                      Inventory.Data_StockAdjustments.StockAdjustmentStateID_FK = Inventory.RefStockAdjustmentStates.StockAdjustmentStateID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON Inventory.Data_StockAdjustments.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK INNER JOIN
                      Inventory.RefStockAdjustmentTypes ON 
                      Inventory.Data_StockAdjustments.StockAdjustmentTypeID_FK = Inventory.RefStockAdjustmentTypes.StockAdjustmentTypeID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_StockAdjustments.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Inventory.Data_View_StockProductionItems source

ALTER VIEW [Inventory].[Data_View_StockProductionItems]
AS
SELECT     Inventory.Data_StockProductionItems.*, Inventory.RefUOMs.UOMName, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, 
                      Inventory.Data_Products.ProductTypeID_FK
FROM         Inventory.Data_StockProductionItems INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_StockProductionItems.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_StockProductionItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK;


-- Inventory.Data_View_StockProductions source

ALTER VIEW [Inventory].[Data_View_StockProductions]
AS
SELECT     Inventory.Data_StockProductions.StockProductionID_PK, Inventory.Data_StockProductions.BranchID_FK, Inventory.Data_StockProductions.LocationID_FK, 
                      Inventory.Data_StockProductions.StockProductionNumber, Inventory.Data_StockProductions.DocumentTypeID_FK, 
                      Inventory.Data_StockProductions.StockProductionStateID_FK, Inventory.Data_StockProductions.DocumentDate, Inventory.Data_StockProductions.ProductionDate, 
                      Inventory.Data_StockProductions.ProductID_FK, Inventory.Data_StockProductions.ProductionQYT, Inventory.Data_StockProductions.UomID_FK, 
                      Inventory.Data_StockProductions.BaseUnitQYT, Inventory.Data_StockProductions.ProductionTotalCost, Inventory.Data_StockProductions.ExpiryDate, 
                      Inventory.Data_StockProductions.LotNumber, Inventory.Data_StockProductions.StockProductionNote, Inventory.Data_StockProductions.CreatedByUserID, 
                      Inventory.Data_StockProductions.CreatedByUserName, Inventory.Data_StockProductions.CreatedDate, Inventory.Data_StockProductions.ModifiedByUserID, 
                      Inventory.Data_StockProductions.ModifiedByUserName, Inventory.Data_StockProductions.ModifiedDate, Inventory.Data_StockProductions.JournalEntryID_FK, 
                      MyCompany.Config_BranchLocations.LocationName, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, 
                      MyCompany.RefDocumentStates.DocumentStateCaption, Inventory.RefUOMs.UOMName, Inventory.Data_StockProductions.IsSynced, 
                      MyCompany.Config_Branchs.BranchName, Inventory.Data_StockProductions.ProductionTypeCode
FROM         Inventory.Data_StockProductions INNER JOIN
                      MyCompany.Config_BranchLocations ON Inventory.Data_StockProductions.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_StockProductions.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      MyCompany.RefDocumentStates ON 
                      Inventory.Data_StockProductions.StockProductionStateID_FK = MyCompany.RefDocumentStates.DocumentStateID_PK INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_StockProductions.UomID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_StockProductions.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Inventory.Data_View_StockTransferOrderItems source

ALTER VIEW [Inventory].[Data_View_StockTransferOrderItems]
AS
SELECT     Inventory.Data_StockTransferOrderItems.*, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, Inventory.RefUOMs.UOMName
FROM         Inventory.Data_StockTransferOrderItems INNER JOIN
                      Inventory.RefUOMs ON Inventory.Data_StockTransferOrderItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_StockTransferOrderItems.ProductID_FK = Inventory.Data_Products.ProductID_PK;


-- Inventory.Data_View_StockTransferOrders source

ALTER VIEW [Inventory].[Data_View_StockTransferOrders]
AS 
SELECT     Inventory.Data_StockTransferOrders.*, MyCompany.Config_Branchs.BranchName AS FromBranchName, 
                      MyCompany.Config_BranchLocations.LocationName AS FromLocationName, Config_Branchs_1.BranchName AS ToBranchName, 
                      MyCompany.RefDocumentStates.DocumentStateCaption, Config_Branchs_1.BranchTypeID_FK AS ToBranchTypeID_FK
FROM         MyCompany.Config_Branchs INNER JOIN
                      Inventory.Data_StockTransferOrders ON MyCompany.Config_Branchs.BranchID_PK = Inventory.Data_StockTransferOrders.FromBranchID_FK INNER JOIN
                      MyCompany.Config_Branchs AS Config_Branchs_1 ON Inventory.Data_StockTransferOrders.ToBranchID_FK = Config_Branchs_1.BranchID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON Inventory.Data_StockTransferOrders.FromLocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK INNER JOIN
                      MyCompany.RefDocumentStates ON Inventory.Data_StockTransferOrders.DocumentStateID_FK = MyCompany.RefDocumentStates.DocumentStateID_PK;


-- Inventory.Data_View_StockTransferProducts source

ALTER VIEW [Inventory].[Data_View_StockTransferProducts]
AS
SELECT     Inventory.Data_StockTransferProducts.*, Inventory.RefUOMs.UOMName, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, 
                      Inventory.Data_Products.ProductTypeID_FK
FROM         Inventory.RefUOMs INNER JOIN
                      Inventory.Data_StockTransferProducts ON Inventory.RefUOMs.UOMID_PK = Inventory.Data_StockTransferProducts.UnitID_FK INNER JOIN
                      Inventory.Data_Products ON Inventory.Data_StockTransferProducts.ProductID_FK = Inventory.Data_Products.ProductID_PK;


-- Inventory.Data_View_StockTransfers source

ALTER VIEW [Inventory].[Data_View_StockTransfers]
AS
SELECT     Inventory.Data_StockTransfers.StockTransferID_PK, Inventory.Data_StockTransfers.FromBranchID_FK, Inventory.Data_StockTransfers.FromLocationID_FK, 
                      Inventory.Data_StockTransfers.ToBranchID_FK, Inventory.Data_StockTransfers.ToLocationID_FK, Inventory.Data_StockTransfers.StockTransferNumber, 
                      Inventory.Data_StockTransfers.DocumentTypeID_FK, Inventory.Data_StockTransfers.StockTransferNote, Inventory.Data_StockTransfers.StockTransferStateID_FK, 
                      Inventory.Data_StockTransfers.CreatedByBranchID_FK, Inventory.Data_StockTransfers.CreatedByUserID, Inventory.Data_StockTransfers.CreatedByUserName, 
                      Inventory.Data_StockTransfers.CreatedDate, Inventory.Data_StockTransfers.ModifiedByUserID, Inventory.Data_StockTransfers.ModifiedByUserName, 
                      Inventory.Data_StockTransfers.ModifiedDate, Inventory.Data_StockTransfers.JournalEntryID_FK, MyCompany.RefDocumentStates.DocumentStateCaption, 
                      Config_Target_BranchLocations.LocationName AS TargetLocationName, Config_Source_BranchLocations.LocationName AS SourceLocationName, 
                      Inventory.Data_StockTransfers.ReceivedDate, Inventory.Data_StockTransfers.RequestedAtDate, Inventory.Data_StockTransfers.DocumentDate, 
                      Inventory.Data_StockTransfers.IsSynced, MyCompany.Config_Branchs.BranchName
FROM         Inventory.Data_StockTransfers INNER JOIN
                      MyCompany.RefDocumentStates ON Inventory.Data_StockTransfers.StockTransferStateID_FK = MyCompany.RefDocumentStates.DocumentStateID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_Source_BranchLocations ON 
                      Inventory.Data_StockTransfers.FromLocationID_FK = Config_Source_BranchLocations.LocationID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_Target_BranchLocations ON 
                      Inventory.Data_StockTransfers.ToLocationID_FK = Config_Target_BranchLocations.LocationID_PK INNER JOIN
                      MyCompany.Config_Branchs ON Inventory.Data_StockTransfers.CreatedByBranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- Inventory.Ref_View_ProductSubDepartments source

ALTER VIEW [Inventory].[Ref_View_ProductSubDepartments]
AS
SELECT     Inventory.RefInventoryCategories.InventoryCategoryID_PK, MAX(Inventory.RefInventoryCategories.InventoryCategoryName) AS InventoryCategoryName, 
                      Inventory.RefInventoryDepartments.InvDepartmentID_PK, MAX(Inventory.RefInventoryDepartments.InvDepartmentName) AS InvDepartmentName, 
                      Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK, MAX(Inventory.RefInventorySubDepartments.InvSubDepartmentName) 
                      AS InvSubDepartmentName
FROM         Inventory.RefInventoryDepartments LEFT OUTER JOIN
                      Inventory.RefInventorySubDepartments ON 
                      Inventory.RefInventoryDepartments.InvDepartmentID_PK = Inventory.RefInventorySubDepartments.InvDepartmentID_FK RIGHT OUTER JOIN
                      Inventory.RefInventoryCategories ON 
                      Inventory.RefInventoryDepartments.InventoryCategoryID_FK = Inventory.RefInventoryCategories.InventoryCategoryID_PK
GROUP BY Inventory.RefInventoryCategories.InventoryCategoryID_PK, Inventory.RefInventoryDepartments.InvDepartmentID_PK, 
                      Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK;

-- DROP SCHEMA IShop;

CREATE SCHEMA IShop;
-- InfinityRetailDB.IShop.OwnerAgent_SyncLog definition

-- Drop table

-- DROP TABLE InfinityRetailDB.IShop.OwnerAgent_SyncLog;

CREATE TABLE InfinityRetailDB.IShop.OwnerAgent_SyncLog (
	SyncID_PK int IDENTITY(1,1) NOT NULL,
	SyncDate datetime NOT NULL,
	IsDone bit NOT NULL,
	CONSTRAINT PK_SyncAgent PRIMARY KEY (SyncID_PK)
);

-- DROP SCHEMA MyCompany;

CREATE SCHEMA MyCompany;
-- InfinityRetailDB.MyCompany.Config_BranchProfile definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.Config_BranchProfile;

CREATE TABLE InfinityRetailDB.MyCompany.Config_BranchProfile (
	ConfigurationID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	ConfigurationCode nvarchar(1500) COLLATE Arabic_CI_AS NULL,
	ConfigurationName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	ConfigurationValue nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Config_BranchProfile PRIMARY KEY (ConfigurationID_PK)
);


-- InfinityRetailDB.MyCompany.Department definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.Department;

CREATE TABLE InfinityRetailDB.MyCompany.Department (
	DepartmentID_PK int IDENTITY(1,1) NOT NULL,
	DepartmentName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Department_1 PRIMARY KEY (DepartmentID_PK)
);


-- InfinityRetailDB.MyCompany.RefCurrencies definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefCurrencies;

CREATE TABLE InfinityRetailDB.MyCompany.RefCurrencies (
	CurrencyID_PK smallint IDENTITY(1,1) NOT NULL,
	CurrencyName nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	CurrencySymbol nvarchar(5) COLLATE Arabic_CI_AS NOT NULL,
	CurrencyRate decimal(10,5) NOT NULL,
	CurrencyScale tinyint NOT NULL,
	CONSTRAINT PK_Ref_Currencies PRIMARY KEY (CurrencyID_PK)
);


-- InfinityRetailDB.MyCompany.RefDiscountTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefDiscountTypes;

CREATE TABLE InfinityRetailDB.MyCompany.RefDiscountTypes (
	DiscountTypeID_PK tinyint IDENTITY(1,1) NOT NULL,
	DiscountTypeCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefDiscountTypes PRIMARY KEY (DiscountTypeID_PK)
);


-- InfinityRetailDB.MyCompany.RefDocumentStates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefDocumentStates;

CREATE TABLE InfinityRetailDB.MyCompany.RefDocumentStates (
	DocumentStateID_PK smallint NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	DocumentStateCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefDocumentStates_1 PRIMARY KEY (DocumentStateID_PK)
);


-- InfinityRetailDB.MyCompany.RefDocumentTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefDocumentTypes;

CREATE TABLE InfinityRetailDB.MyCompany.RefDocumentTypes (
	DocumentTypeID_PK tinyint IDENTITY(1,1) NOT NULL,
	DocumentTypeCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefDocumentTypes PRIMARY KEY (DocumentTypeID_PK)
);


-- InfinityRetailDB.MyCompany.RefPaymentMethodTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefPaymentMethodTypes;

CREATE TABLE InfinityRetailDB.MyCompany.RefPaymentMethodTypes (
	PaymentMethodTypeID_PK smallint NOT NULL,
	PaymentMethodTypeCaption nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefPaymentMethodTypes PRIMARY KEY (PaymentMethodTypeID_PK)
);


-- InfinityRetailDB.MyCompany.Config_BranchLocations definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.Config_BranchLocations;

CREATE TABLE InfinityRetailDB.MyCompany.Config_BranchLocations (
	LocationID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	LocationCode nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	LocationName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	LocationAddress nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	LocationManager nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	CONSTRAINT PK_Config_BranchLocations PRIMARY KEY (LocationID_PK)
);


-- InfinityRetailDB.MyCompany.Config_Branchs definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.Config_Branchs;

CREATE TABLE InfinityRetailDB.MyCompany.Config_Branchs (
	BranchID_PK int IDENTITY(1,1) NOT NULL,
	BranchName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	BranchTypeID_FK tinyint DEFAULT 1 NOT NULL,
	BranchAddressLine1 nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	BranchAddressLine2 nvarchar(100) COLLATE Arabic_CI_AS NULL,
	BranchAddressLine3 nvarchar(100) COLLATE Arabic_CI_AS NULL,
	BranchPhone nvarchar(50) COLLATE Arabic_CI_AS NULL,
	BranchEmailAddress nvarchar(100) COLLATE Arabic_CI_AS NULL,
	BranchLogo image NULL,
	CurrencyID_FK smallint NOT NULL,
	CustomerID_FK int NULL,
	IsCurrentBranch bit DEFAULT 0 NOT NULL,
	BranchCostExportFiled tinyint DEFAULT 0 NOT NULL,
	BranchPrice1ExportFiled tinyint DEFAULT 1 NOT NULL,
	BranchPrice2ExportFiled tinyint DEFAULT 2 NOT NULL,
	BranchPrice3ExportFiled tinyint DEFAULT 3 NOT NULL,
	BranchPrice4ExportFiled tinyint DEFAULT 4 NOT NULL,
	BranchCategoryID_FK smallint DEFAULT 0 NOT NULL,
	CustomerCode int DEFAULT 0 NOT NULL,
	CostCenterID_FK int DEFAULT 1 NOT NULL,
	AccessToOnlineInventory bit DEFAULT 0 NOT NULL,
	Ignore_STO_InventoryControl bit DEFAULT 0 NOT NULL,
	Ignore_SO_InventoryControl bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Config_Branchs PRIMARY KEY (BranchID_PK)
);


-- InfinityRetailDB.MyCompany.RefPaymentMethods definition

-- Drop table

-- DROP TABLE InfinityRetailDB.MyCompany.RefPaymentMethods;

CREATE TABLE InfinityRetailDB.MyCompany.RefPaymentMethods (
	PaymentMethodID_PK smallint IDENTITY(1,1) NOT NULL,
	PaymentMethodCaption nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	CurrencyID_FK smallint NOT NULL,
	PaymentMethodTypeID_FK smallint NOT NULL,
	IsEnabledOnPurchaseDocuments bit DEFAULT 1 NOT NULL,
	IsEnabledOnSalesDocuments bit DEFAULT 1 NOT NULL,
	PaymentAccountID_FK int NULL,
	IsEnabledOnRefundDocuments bit DEFAULT 1 NOT NULL,
	MyPriceLevel tinyint DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	DocumentsPostingTime tinyint DEFAULT 3 NOT NULL,
	CONSTRAINT PK_Ref_PaymentMethods PRIMARY KEY (PaymentMethodID_PK)
);


-- InfinityRetailDB.MyCompany.Config_BranchLocations foreign keys

ALTER TABLE InfinityRetailDB.MyCompany.Config_BranchLocations ADD CONSTRAINT FK_Config_BranchLocations_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.MyCompany.Config_Branchs foreign keys

ALTER TABLE InfinityRetailDB.MyCompany.Config_Branchs ADD CONSTRAINT FK_Config_Branchs_RefCostCenters FOREIGN KEY (CostCenterID_FK) REFERENCES InfinityRetailDB.Financial.RefCostCenters(CostCenterID_PK);


-- InfinityRetailDB.MyCompany.RefPaymentMethods foreign keys

ALTER TABLE InfinityRetailDB.MyCompany.RefPaymentMethods ADD CONSTRAINT FK_RefPaymentMethods_Data_Accounts FOREIGN KEY (PaymentAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.MyCompany.RefPaymentMethods ADD CONSTRAINT FK_RefPaymentMethods_RefCurrencies FOREIGN KEY (CurrencyID_FK) REFERENCES InfinityRetailDB.MyCompany.RefCurrencies(CurrencyID_PK);
ALTER TABLE InfinityRetailDB.MyCompany.RefPaymentMethods ADD CONSTRAINT FK_RefPaymentMethods_RefPaymentMethodTypes FOREIGN KEY (PaymentMethodTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefPaymentMethodTypes(PaymentMethodTypeID_PK);


-- MyCompany.Config_View_Branchs source

ALTER VIEW [MyCompany].[Config_View_Branchs]
AS
SELECT     MyCompany.Config_Branchs.BranchID_PK, MyCompany.Config_Branchs.BranchName, MyCompany.Config_Branchs.BranchTypeID_FK, 
                      MyCompany.Config_Branchs.BranchAddressLine1, MyCompany.Config_Branchs.BranchAddressLine2, MyCompany.Config_Branchs.BranchPhone, 
                      MyCompany.Config_Branchs.BranchEmailAddress, MyCompany.Config_Branchs.BranchAddressLine3, 
                      MyCompany.Config_Branchs.CurrencyID_FK AS BranchCurrencyID_FK, MyCompany.RefCurrencies.CurrencyName AS BranchCurrencyName, 
                      MyCompany.RefCurrencies.CurrencySymbol AS BranchCurrencySymbol, MyCompany.RefCurrencies.CurrencyRate AS BranchCurrencyRate, 
                      MyCompany.RefCurrencies.CurrencyScale AS BranchCurrencyScale, MyCompany.Config_Branchs.CustomerID_FK, MyCompany.Config_Branchs.IsCurrentBranch, 
                      MyCompany.Config_Branchs.BranchCostExportFiled, MyCompany.Config_Branchs.BranchPrice2ExportFiled, MyCompany.Config_Branchs.BranchPrice1ExportFiled, 
                      MyCompany.Config_Branchs.BranchPrice3ExportFiled, MyCompany.Config_Branchs.BranchPrice4ExportFiled, MyCompany.Config_Branchs.BranchCategoryID_FK, 
                      MyCompany.Config_Branchs.CustomerCode, MyCompany.Config_Branchs.CostCenterID_FK
FROM         MyCompany.Config_Branchs INNER JOIN
                      MyCompany.RefCurrencies ON MyCompany.Config_Branchs.CurrencyID_FK = MyCompany.RefCurrencies.CurrencyID_PK;


-- MyCompany.RefView_PaymentMethods source

ALTER VIEW [MyCompany].[RefView_PaymentMethods]
AS
SELECT     MyCompany.RefPaymentMethods.PaymentMethodID_PK, MyCompany.RefPaymentMethods.PaymentMethodCaption, 
                      MyCompany.RefPaymentMethods.CurrencyID_FK, MyCompany.RefPaymentMethods.PaymentMethodTypeID_FK, 
                      MyCompany.RefPaymentMethods.IsEnabledOnSalesDocuments, MyCompany.RefPaymentMethods.IsEnabledOnPurchaseDocuments, 
                      MyCompany.RefPaymentMethodTypes.PaymentMethodTypeCaption, MyCompany.RefCurrencies.CurrencyName, MyCompany.RefCurrencies.CurrencySymbol, 
                      MyCompany.RefCurrencies.CurrencyRate, MyCompany.RefCurrencies.CurrencyScale, MyCompany.RefPaymentMethods.PaymentAccountID_FK, 
                      MyCompany.RefPaymentMethods.IsEnabledOnRefundDocuments, MyCompany.RefPaymentMethods.MyPriceLevel, 
                      MyCompany.RefPaymentMethods.DocumentsPostingTime, MyCompany.RefPaymentMethods.IsActive
FROM         MyCompany.RefPaymentMethods INNER JOIN
                      MyCompany.RefPaymentMethodTypes ON 
                      MyCompany.RefPaymentMethods.PaymentMethodTypeID_FK = MyCompany.RefPaymentMethodTypes.PaymentMethodTypeID_PK INNER JOIN
                      MyCompany.RefCurrencies ON MyCompany.RefPaymentMethods.CurrencyID_FK = MyCompany.RefCurrencies.CurrencyID_PK;


-- MyCompany.Statistic_View_ProductCountBySubDepartment source

ALTER VIEW [MyCompany].[Statistic_View_ProductCountBySubDepartment]
AS
SELECT     Inventory.RefInventoryCategories.InventoryCategoryID_PK, MAX(Inventory.RefInventoryCategories.InventoryCategoryName) AS InventoryCategoryName, 
                      Inventory.RefInventoryDepartments.InvDepartmentID_PK, MAX(Inventory.RefInventoryDepartments.InvDepartmentName) AS InvDepartmentName, 
                      Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK, MAX(Inventory.RefInventorySubDepartments.InvSubDepartmentName) AS InvSubDepartmentName, 
                      COUNT(Inventory.Data_Products.ProductID_PK) AS ItemCount
FROM         Inventory.RefInventoryDepartments LEFT OUTER JOIN
                      Inventory.RefInventorySubDepartments ON 
                      Inventory.RefInventoryDepartments.InvDepartmentID_PK = Inventory.RefInventorySubDepartments.InvDepartmentID_FK LEFT OUTER JOIN
                      Inventory.Data_Products ON Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK = Inventory.Data_Products.InvSubDepartmentID_FK RIGHT OUTER JOIN
                      Inventory.RefInventoryCategories ON Inventory.RefInventoryDepartments.InventoryCategoryID_FK = Inventory.RefInventoryCategories.InventoryCategoryID_PK
GROUP BY Inventory.RefInventoryCategories.InventoryCategoryID_PK, Inventory.RefInventoryDepartments.InvDepartmentID_PK, 
                      Inventory.RefInventorySubDepartments.InvSubDepartmentID_PK;

-- DROP SCHEMA OLDSCHEMA;

CREATE SCHEMA OLDSCHEMA;

-- DROP SCHEMA PDA;

CREATE SCHEMA PDA;
-- InfinityRetailDB.PDA.Data_MySalesInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MySalesInvoices;

CREATE TABLE InfinityRetailDB.PDA.Data_MySalesInvoices (
	SalesInvoiceID_PK int NOT NULL,
	CustomerID_FK int NOT NULL,
	CustomerName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceNumber int NOT NULL,
	Createddate datetime NOT NULL,
	DeviceID nvarchar(120) COLLATE Arabic_CI_AS NOT NULL,
	LocationID_FK int NOT NULL,
	CashCustomerName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	IsImported bit DEFAULT 0 NULL,
	CONSTRAINT PK_Data_MySalesInvoices PRIMARY KEY (SalesInvoiceID_PK),
	CONSTRAINT FK_Data_MySalesInvoices_Data_MySalesInvoices FOREIGN KEY (SalesInvoiceID_PK) REFERENCES InfinityRetailDB.PDA.Data_MySalesInvoices(SalesInvoiceID_PK)
);


-- InfinityRetailDB.PDA.Data_InventoryCounting definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_InventoryCounting;

CREATE TABLE InfinityRetailDB.PDA.Data_InventoryCounting (
	InventoryCountingID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	UserName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CreatedDate datetime NOT NULL,
	IsImported bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_InventoryCounting PRIMARY KEY (InventoryCountingID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_InventoryCounting_ProductID_FK ON InfinityRetailDB.PDA.Data_InventoryCounting (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.PDA.Data_MyInventoryCounting definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MyInventoryCounting;

CREATE TABLE InfinityRetailDB.PDA.Data_MyInventoryCounting (
	InventoryCountingID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	UserName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	IsImported bit DEFAULT 0 NOT NULL,
	Note nvarchar(80) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_MyInventoryCounting PRIMARY KEY (InventoryCountingID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_MyInventoryCounting_ProductID_FK ON InfinityRetailDB.PDA.Data_MyInventoryCounting (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems;

CREATE TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems (
	PurchaseInvoiceItemID_PK int NOT NULL,
	PurchaseInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsNew bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_MyPurchaseInvoiceItems PRIMARY KEY (PurchaseInvoiceItemID_PK)
);


-- InfinityRetailDB.PDA.Data_MyPurchaseInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoices;

CREATE TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoices (
	PurchaseInvoiceID_PK int NOT NULL,
	SupplierID_FK int NOT NULL,
	SupplierName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceNumber int NOT NULL,
	DeviceID nvarchar(120) COLLATE Arabic_CI_AS NOT NULL,
	IsImported bit DEFAULT 0 NULL,
	CONSTRAINT PK_Data_MyPurchaseInvoices PRIMARY KEY (PurchaseInvoiceID_PK)
);


-- InfinityRetailDB.PDA.Data_MySalesInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MySalesInvoiceItems;

CREATE TABLE InfinityRetailDB.PDA.Data_MySalesInvoiceItems (
	SalesInvoiceItemID_PK int NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	UnitCost decimal(10,3) NULL,
	UnitPrice decimal(10,3) NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsNew bit NULL,
	CONSTRAINT PK_Data_MySalesInvoiceItems PRIMARY KEY (SalesInvoiceItemID_PK)
);


-- InfinityRetailDB.PDA.Data_MyStockTransferProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MyStockTransferProducts;

CREATE TABLE InfinityRetailDB.PDA.Data_MyStockTransferProducts (
	StockTransferProductID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsImported bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_MyStockTransferProducts PRIMARY KEY (StockTransferProductID_PK)
);


-- InfinityRetailDB.PDA.Data_MyStockTransfers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_MyStockTransfers;

CREATE TABLE InfinityRetailDB.PDA.Data_MyStockTransfers (
	StockTransferID_PK int IDENTITY(1,1) NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NOT NULL,
	StockTransferNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	TransferFromPDADate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_MyStockTransfers PRIMARY KEY (StockTransferID_PK)
);


-- InfinityRetailDB.PDA.Data_PurchaseInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_PurchaseInvoiceItems;

CREATE TABLE InfinityRetailDB.PDA.Data_PurchaseInvoiceItems (
	PurchaseInvoiceItemID_PK int IDENTITY(1,1) NOT NULL,
	PurchaseInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsNew bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_PurchaseInvoiceItems PRIMARY KEY (PurchaseInvoiceItemID_PK)
);


-- InfinityRetailDB.PDA.Data_PurchaseInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_PurchaseInvoices;

CREATE TABLE InfinityRetailDB.PDA.Data_PurchaseInvoices (
	PurchaseInvoiceID_PK int IDENTITY(1,1) NOT NULL,
	SupplierID_FK int NOT NULL,
	SupplierName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceNumber int NOT NULL,
	DeviceID nvarchar(120) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_PurchaseInvoices PRIMARY KEY (PurchaseInvoiceID_PK)
);


-- InfinityRetailDB.PDA.Data_StockTransferProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_StockTransferProducts;

CREATE TABLE InfinityRetailDB.PDA.Data_StockTransferProducts (
	StockTransferProductID_PK int IDENTITY(1,1) NOT NULL,
	StockTransferID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	UOMID_FK smallint NOT NULL,
	BaseUnitQYT decimal(10,3) NOT NULL,
	Barcode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	ExpiryDate datetime NULL,
	CountingDate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsImported bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_StockTransferProducts PRIMARY KEY (StockTransferProductID_PK)
);


-- InfinityRetailDB.PDA.Data_StockTransfers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.PDA.Data_StockTransfers;

CREATE TABLE InfinityRetailDB.PDA.Data_StockTransfers (
	StockTransferID_PK int IDENTITY(1,1) NOT NULL,
	FromBranchID_FK int NOT NULL,
	FromLocationID_FK int NOT NULL,
	ToBranchID_FK int NOT NULL,
	ToLocationID_FK int NOT NULL,
	StockTransferNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	TransferFromPDADate datetime NOT NULL,
	DeviceID nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_StockTransfers PRIMARY KEY (StockTransferID_PK)
);


-- InfinityRetailDB.PDA.Data_InventoryCounting foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_InventoryCounting ADD CONSTRAINT FK_Data_InventoryCounting_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.PDA.Data_InventoryCounting ADD CONSTRAINT FK_Data_InventoryCounting_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_MyInventoryCounting foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MyInventoryCounting ADD CONSTRAINT FK_Data_MyInventoryCounting_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.PDA.Data_MyInventoryCounting ADD CONSTRAINT FK_Data_MyInventoryCounting_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_MyPurchaseInvoiceItems_Data_MyPurchaseInvoices FOREIGN KEY (PurchaseInvoiceID_FK) REFERENCES InfinityRetailDB.PDA.Data_MyPurchaseInvoices(PurchaseInvoiceID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_MyPurchaseInvoiceItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_MyPurchaseInvoiceItems_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_MyPurchaseInvoices foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MyPurchaseInvoices ADD CONSTRAINT PDA_FK_Data_MyPurchaseInvoices_Data_Suppliers FOREIGN KEY (SupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);


-- InfinityRetailDB.PDA.Data_MySalesInvoiceItems foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MySalesInvoiceItems ADD CONSTRAINT FK_Data_MySalesInvoiceItems_Data_MySalesInvoices FOREIGN KEY (SalesInvoiceID_FK) REFERENCES InfinityRetailDB.PDA.Data_MySalesInvoices(SalesInvoiceID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MySalesInvoiceItems ADD CONSTRAINT FK_Data_MySalesInvoiceItems_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MySalesInvoiceItems ADD CONSTRAINT FK_Data_Products_Data_PDA_InvoiceItems FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);


-- InfinityRetailDB.PDA.Data_MyStockTransferProducts foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransferProducts ADD CONSTRAINT PDA_FK_Data_MyStockTransferProducts_Data_MyStockTransfers FOREIGN KEY (StockTransferID_FK) REFERENCES InfinityRetailDB.PDA.Data_MyStockTransfers(StockTransferID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransferProducts ADD CONSTRAINT PDA_FK_Data_MyStockTransferProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransferProducts ADD CONSTRAINT PDA_FK_Data_MyStockTransferProducts_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_MyStockTransfers foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransfers ADD CONSTRAINT PDA_FK_Data_MyStockTransfers_Config_BranchLocations_From FOREIGN KEY (FromLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransfers ADD CONSTRAINT PDA_FK_Data_MyStockTransfers_Config_BranchLocations_To FOREIGN KEY (ToLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransfers ADD CONSTRAINT PDA_FK_Data_MyStockTransfers_Config_Branchs_From FOREIGN KEY (FromBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_MyStockTransfers ADD CONSTRAINT PDA_FK_Data_MyStockTransfers_Config_Branchs_To FOREIGN KEY (ToBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.PDA.Data_PurchaseInvoiceItems foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_PurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_PurchaseInvoiceItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_PurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_PurchaseInvoiceItems_Data_PurchaseInvoices FOREIGN KEY (PurchaseInvoiceID_FK) REFERENCES InfinityRetailDB.PDA.Data_PurchaseInvoices(PurchaseInvoiceID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_PurchaseInvoiceItems ADD CONSTRAINT PDA_FK_Data_PurchaseInvoiceItems_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_PurchaseInvoices foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_PurchaseInvoices ADD CONSTRAINT PDA_FK_Data_PurchaseInvoices_Data_Suppliers FOREIGN KEY (SupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);


-- InfinityRetailDB.PDA.Data_StockTransferProducts foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_StockTransferProducts ADD CONSTRAINT PDA_FK_Data_StockTransferProducts_Data_StockTransferProducts FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_StockTransferProducts ADD CONSTRAINT PDA_FK_Data_StockTransferProducts_Data_StockTransfers FOREIGN KEY (StockTransferID_FK) REFERENCES InfinityRetailDB.PDA.Data_StockTransfers(StockTransferID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_StockTransferProducts ADD CONSTRAINT PDA_FK_Data_StockTransferProducts_RefUOMs FOREIGN KEY (UOMID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.PDA.Data_StockTransfers foreign keys

ALTER TABLE InfinityRetailDB.PDA.Data_StockTransfers ADD CONSTRAINT PDA_FK_Data_StockTransfers_Config_BranchLocations_From FOREIGN KEY (FromLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_StockTransfers ADD CONSTRAINT PDA_FK_Data_StockTransfers_Config_BranchLocations_To FOREIGN KEY (ToLocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_StockTransfers ADD CONSTRAINT PDA_FK_Data_StockTransfers_Config_Branchs_From FOREIGN KEY (FromBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.PDA.Data_StockTransfers ADD CONSTRAINT PDA_FK_Data_StockTransfers_Config_Branchs_To FOREIGN KEY (ToBranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- PDA.Data_View_InventoryCounting source

ALTER VIEW [PDA].[Data_View_InventoryCounting]
AS
SELECT     TOP (100) PERCENT Inventory.RefUOMs.UOMName, PDA.Data_InventoryCounting.InventoryCountingID_PK, PDA.Data_InventoryCounting.ProductID_FK, 
                      PDA.Data_InventoryCounting.ProductName, PDA.Data_InventoryCounting.UOMID_FK, PDA.Data_InventoryCounting.BaseUnitQYT, 
                      PDA.Data_InventoryCounting.Barcode, PDA.Data_InventoryCounting.QYT, PDA.Data_InventoryCounting.ExpiryDate, PDA.Data_InventoryCounting.CountingDate, 
                      PDA.Data_InventoryCounting.DeviceID, PDA.Data_InventoryCounting.UserName, PDA.Data_InventoryCounting.CreatedDate, 
                      PDA.Data_View_InventoryCounting_Totals.RecordCount, PDA.Data_View_InventoryCounting_Totals.UOMCount, 
                      PDA.Data_View_InventoryCounting_Totals.ExpiryDateCount, PDA.Data_View_InventoryCounting_Totals.MaxUOMID_FK, 
                      PDA.Data_View_InventoryCounting_Totals.MinUOMID_FK, PDA.Data_InventoryCounting.IsImported
FROM         PDA.Data_InventoryCounting INNER JOIN
                      Inventory.RefUOMs ON PDA.Data_InventoryCounting.UOMID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_Products ON PDA.Data_InventoryCounting.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      PDA.Data_View_InventoryCounting_Totals ON PDA.Data_InventoryCounting.ProductID_FK = PDA.Data_View_InventoryCounting_Totals.ProductID_FK
WHERE     (PDA.Data_InventoryCounting.IsImported = 0)
ORDER BY PDA.Data_InventoryCounting.ProductID_FK;


-- PDA.Data_View_InventoryCounting_Totals source

ALTER VIEW [PDA].[Data_View_InventoryCounting_Totals]
AS
SELECT     ProductID_FK, COUNT(*) AS RecordCount, COUNT(DISTINCT UOMID_FK) AS UOMCount, COUNT(DISTINCT ExpiryDate) AS ExpiryDateCount, MIN(UOMID_FK) 
                      AS MinUOMID_FK, MAX(UOMID_FK) AS MaxUOMID_FK
FROM         PDA.Data_InventoryCounting
WHERE     (IsImported = 0)
GROUP BY ProductID_FK;


-- PDA.Data_View_MyInventoryCounting source

ALTER VIEW [PDA].[Data_View_MyInventoryCounting]
AS
SELECT        TOP (100) PERCENT Inventory.RefUOMs.UOMName, PDA.Data_MyInventoryCounting.InventoryCountingID_PK, PDA.Data_MyInventoryCounting.ProductID_FK, PDA.Data_MyInventoryCounting.ProductName, 
                         PDA.Data_MyInventoryCounting.UOMID_FK, PDA.Data_MyInventoryCounting.BaseUnitQYT, PDA.Data_MyInventoryCounting.Barcode, PDA.Data_MyInventoryCounting.QYT, PDA.Data_MyInventoryCounting.ExpiryDate, 
                         PDA.Data_MyInventoryCounting.CountingDate, PDA.Data_MyInventoryCounting.DeviceID, PDA.Data_MyInventoryCounting.UserName, PDA.Data_MyInventoryCounting.CreatedDate, 
                         PDA.Data_View_MyInventoryCounting_Totals.RecordCount, PDA.Data_View_MyInventoryCounting_Totals.UOMCount, PDA.Data_View_MyInventoryCounting_Totals.ExpiryDateCount, 
                         PDA.Data_View_MyInventoryCounting_Totals.MaxUOMID_FK, PDA.Data_View_MyInventoryCounting_Totals.MinUOMID_FK, PDA.Data_MyInventoryCounting.IsImported,PDA.Data_MyInventoryCounting.Note
FROM            PDA.Data_MyInventoryCounting INNER JOIN
                         Inventory.RefUOMs ON PDA.Data_MyInventoryCounting.UOMID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                         Inventory.Data_Products ON PDA.Data_MyInventoryCounting.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                         PDA.Data_View_MyInventoryCounting_Totals ON PDA.Data_MyInventoryCounting.ProductID_FK = PDA.Data_View_MyInventoryCounting_Totals.ProductID_FK
WHERE        (PDA.Data_MyInventoryCounting.IsImported = 0)
ORDER BY PDA.Data_MyInventoryCounting.ProductID_FK;


-- PDA.Data_View_MyInventoryCounting_Totals source

ALTER VIEW [PDA].[Data_View_MyInventoryCounting_Totals]
AS
SELECT     ProductID_FK, COUNT(*) AS RecordCount, COUNT(DISTINCT UOMID_FK) AS UOMCount, COUNT(DISTINCT ExpiryDate) AS ExpiryDateCount, MIN(UOMID_FK) 
                      AS MinUOMID_FK, MAX(UOMID_FK) AS MaxUOMID_FK
FROM         PDA.Data_MyInventoryCounting
WHERE     (IsImported = 0)
GROUP BY ProductID_FK;


-- PDA.Data_View_MyStockTransferProducts source

ALTER VIEW [PDA].[Data_View_MyStockTransferProducts]
AS
SELECT     PDA.Data_MyStockTransferProducts.StockTransferProductID_PK, PDA.Data_MyStockTransferProducts.StockTransferID_FK, 
                      Config_BranchLocations_From.LocationName AS From_LocationName, Config_BranchLocations_To.LocationName AS To_LocationName, 
                      PDA.Data_MyStockTransferProducts.ProductID_FK, PDA.Data_MyStockTransferProducts.ProductName, PDA.Data_MyStockTransferProducts.UOMID_FK, 
                      Inventory.RefUOMs.UOMName, PDA.Data_MyStockTransferProducts.BaseUnitQYT, PDA.Data_MyStockTransferProducts.Barcode, PDA.Data_MyStockTransferProducts.QYT, 
                      PDA.Data_MyStockTransferProducts.ExpiryDate, PDA.Data_MyStockTransferProducts.CountingDate, PDA.Data_MyStockTransferProducts.DeviceID, 
                      PDA.Data_MyStockTransferProducts.CreatedDate, PDA.Data_MyStockTransferProducts.IsImported
FROM         Inventory.RefUOMs INNER JOIN
                      PDA.Data_MyStockTransferProducts INNER JOIN
                      PDA.Data_MyStockTransfers ON PDA.Data_MyStockTransferProducts.StockTransferID_FK = PDA.Data_MyStockTransfers.StockTransferID_PK ON 
                      Inventory.RefUOMs.UOMID_PK = PDA.Data_MyStockTransferProducts.UOMID_FK INNER JOIN
                      Inventory.Data_Products ON PDA.Data_MyStockTransferProducts.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_BranchLocations_To ON 
                      PDA.Data_MyStockTransfers.ToLocationID_FK = Config_BranchLocations_To.LocationID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_BranchLocations_From ON 
                      PDA.Data_MyStockTransfers.FromLocationID_FK = Config_BranchLocations_From.LocationID_PK;


-- PDA.Data_View_ProductPurchaseHistory source

ALTER VIEW [PDA].[Data_View_ProductPurchaseHistory]
AS
SELECT        Inventory.Data_Products.ProductID_PK, Purchase.Data_PurchaseInvoiceItems.PurchaseInvoiceItemID_PK, Inventory.RefUOMs.UOMName, Purchase.Data_Suppliers.SupplierName,
                        Purchase.Data_PurchaseInvoiceItems.Createddate, Purchase.Data_PurchaseInvoiceItems.QYT, Purchase.Data_PurchaseInvoiceItems.UnitCost
FROM            Inventory.Data_Products INNER JOIN
                        Purchase.Data_PurchaseInvoiceItems ON Inventory.Data_Products.ProductID_PK = Purchase.Data_PurchaseInvoiceItems.ProductID_FK INNER JOIN
                        Purchase.Data_PurchaseInvoices ON Purchase.Data_PurchaseInvoiceItems.InvoiceID_FK = Purchase.Data_PurchaseInvoices.InvoiceID_PK INNER JOIN
                        Inventory.RefUOMs ON Purchase.Data_PurchaseInvoiceItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK AND Purchase.Data_PurchaseInvoiceItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                        Purchase.Data_Suppliers ON Purchase.Data_PurchaseInvoices.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK AND Purchase.Data_PurchaseInvoices.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK AND
                        Purchase.Data_PurchaseInvoices.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK;


-- PDA.Data_View_StockTransferProducts source

ALTER VIEW [PDA].[Data_View_StockTransferProducts]
AS
SELECT     PDA.Data_StockTransferProducts.StockTransferProductID_PK, PDA.Data_StockTransferProducts.StockTransferID_FK, 
                      Config_BranchLocations_From.LocationName AS From_LocationName, Config_BranchLocations_To.LocationName AS To_LocationName, 
                      PDA.Data_StockTransferProducts.ProductID_FK, PDA.Data_StockTransferProducts.ProductName, PDA.Data_StockTransferProducts.UOMID_FK, 
                      Inventory.RefUOMs.UOMName, PDA.Data_StockTransferProducts.BaseUnitQYT, PDA.Data_StockTransferProducts.Barcode, PDA.Data_StockTransferProducts.QYT, 
                      PDA.Data_StockTransferProducts.ExpiryDate, PDA.Data_StockTransferProducts.CountingDate, PDA.Data_StockTransferProducts.DeviceID, 
                      PDA.Data_StockTransferProducts.CreatedDate, PDA.Data_StockTransferProducts.IsImported
FROM         Inventory.RefUOMs INNER JOIN
                      PDA.Data_StockTransferProducts INNER JOIN
                      PDA.Data_StockTransfers ON PDA.Data_StockTransferProducts.StockTransferID_FK = PDA.Data_StockTransfers.StockTransferID_PK ON 
                      Inventory.RefUOMs.UOMID_PK = PDA.Data_StockTransferProducts.UOMID_FK INNER JOIN
                      Inventory.Data_Products ON PDA.Data_StockTransferProducts.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_BranchLocations_To ON 
                      PDA.Data_StockTransfers.ToLocationID_FK = Config_BranchLocations_To.LocationID_PK INNER JOIN
                      MyCompany.Config_BranchLocations AS Config_BranchLocations_From ON 
                      PDA.Data_StockTransfers.FromLocationID_FK = Config_BranchLocations_From.LocationID_PK;

-- DROP SCHEMA POS;

CREATE SCHEMA POS;
-- InfinityRetailDB.POS.Data_POSDrawerPayInOut definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_POSDrawerPayInOut;

CREATE TABLE InfinityRetailDB.POS.Data_POSDrawerPayInOut (
	PayINOutID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	EODID_FK int NULL,
	WsID_FK tinyint NOT NULL,
	CashDrawerID_FK tinyint NOT NULL,
	PayInOutDate datetime NOT NULL,
	PayInOutType nvarchar(3) COLLATE Arabic_CI_AS NOT NULL,
	PayInOutAmount decimal(12,3) NOT NULL,
	PersonName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	PayInOutDescription nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	POSTerminalShiftID_FK int NULL,
	PhoneNumber nvarchar(100) COLLATE Arabic_CI_AS NULL,
	PayInOutReason nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'' NULL,
	IsPosted bit DEFAULT 1 NOT NULL,
	PaymentVoucherID_FK int NULL,
	CONSTRAINT PK_Data_POSDrawerPayInOut PRIMARY KEY (PayINOutID_PK)
);


-- InfinityRetailDB.POS.Data_POSScreens definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_POSScreens;

CREATE TABLE InfinityRetailDB.POS.Data_POSScreens (
	ScreenID_PK int IDENTITY(1,1) NOT NULL,
	ScreenCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_POSScreens PRIMARY KEY (ScreenID_PK)
);


-- InfinityRetailDB.POS.RefPOSDrawerPayInOutReasons definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.RefPOSDrawerPayInOutReasons;

CREATE TABLE InfinityRetailDB.POS.RefPOSDrawerPayInOutReasons (
	PayInOutReasonCode int IDENTITY(1,1) NOT NULL,
	PayInOutReasonCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsUsedByPayIn bit NOT NULL,
	IsUsedByPayOut bit NOT NULL,
	CONSTRAINT PK_RefPOSDrawerPayInOutReasons PRIMARY KEY (PayInOutReasonCode)
);


-- InfinityRetailDB.POS.Data_POSScreenButtons definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_POSScreenButtons;

CREATE TABLE InfinityRetailDB.POS.Data_POSScreenButtons (
	ScreenButtonID_PK int IDENTITY(1,1) NOT NULL,
	ScreenID_FK int NOT NULL,
	ScreenButtonIndex tinyint NOT NULL,
	ScreenButtonTypeID_FK tinyint NOT NULL,
	TargetButtonObjectIDCode int NOT NULL,
	ScreenButtonCaption nvarchar(70) COLLATE Arabic_CI_AS NOT NULL,
	ScreenButtonBackcolor int NOT NULL,
	CONSTRAINT IX_Data_POSScreenButtons UNIQUE (ScreenID_FK,ScreenButtonIndex),
	CONSTRAINT PK_Data_POSScreenButtons PRIMARY KEY (ScreenButtonID_PK),
	CONSTRAINT FK_Data_POSScreenButtons_Data_POSScreens FOREIGN KEY (ScreenID_FK) REFERENCES InfinityRetailDB.POS.Data_POSScreens(ScreenID_PK)
);


-- InfinityRetailDB.POS.Data_POSStockOrders definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_POSStockOrders;

CREATE TABLE InfinityRetailDB.POS.Data_POSStockOrders (
	POSStockOrderD_PK int IDENTITY(1,1) NOT NULL,
	POSTerminalShiftID_FK int NULL,
	ProductCode nvarchar(20) COLLATE Arabic_CI_AS NULL,
	ProductName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	ProductDescription nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	RequestedQYT decimal(10,3) NOT NULL,
	Note nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	POSStockOrderStateID_FK tinyint NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	ProductID_FK bigint NULL,
	CONSTRAINT PK_Data_POSProductOrders PRIMARY KEY (POSStockOrderD_PK)
);


-- InfinityRetailDB.POS.Data_POSTerminalShifts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_POSTerminalShifts;

CREATE TABLE InfinityRetailDB.POS.Data_POSTerminalShifts (
	POSTerminalShiftID_PK int IDENTITY(1,1) NOT NULL,
	WsID_FK tinyint NOT NULL,
	CashDrawerID_FK tinyint NOT NULL,
	OpendByUserID int NOT NULL,
	OpendByUserName nvarchar(60) COLLATE Arabic_CI_AS NOT NULL,
	OpenDate datetime NOT NULL,
	IsClosed bit NOT NULL,
	TransactionCount int DEFAULT 0 NOT NULL,
	NoSaleCount smallint DEFAULT 0 NOT NULL,
	ClosedByUserID int NULL,
	ClosedByUserName nvarchar(60) COLLATE Arabic_CI_AS NULL,
	ClosedDate datetime NULL,
	OpenCash decimal(13,3) NOT NULL,
	CashTenders decimal(13,3) NOT NULL,
	CashReturned decimal(13,3) NOT NULL,
	PayOuts decimal(13,3) NOT NULL,
	PayIns decimal(13,3) NOT NULL,
	Drops decimal(13,3) NOT NULL,
	Purchases decimal(13,3) NOT NULL,
	ExpectedCash decimal(13,3) NOT NULL,
	ActualCash decimal(13,3) NOT NULL,
	Variance decimal(13,3) NOT NULL,
	CreditTenders decimal(13,3) DEFAULT 0 NOT NULL,
	CreditReturned decimal(13,3) DEFAULT 0 NOT NULL,
	JournalEntryID_FK int NULL,
	TotalReceiptPayment decimal(13,3) DEFAULT 0 NOT NULL,
	IsPosted bit DEFAULT 0 NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	InfinityModule nvarchar(5) COLLATE Arabic_CI_AS DEFAULT N'POS' NOT NULL,
	TotalPaymentVouchers decimal(13,3) DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_WsShifts PRIMARY KEY (POSTerminalShiftID_PK)
);


-- InfinityRetailDB.POS.Data_SalesOrderInfo definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_SalesOrderInfo;

CREATE TABLE InfinityRetailDB.POS.Data_SalesOrderInfo (
	SalesOrderInfoID_PK int NOT NULL,
	CustomerName nvarchar(150) COLLATE Arabic_CI_AS NULL,
	CustomerAddressLine1 nvarchar(150) COLLATE Arabic_CI_AS NULL,
	CustomerAddressLine2 nvarchar(150) COLLATE Arabic_CI_AS NULL,
	CustomerPhone1 nvarchar(20) COLLATE Arabic_CI_AS NULL,
	CustomerPhone2 nvarchar(20) COLLATE Arabic_CI_AS NULL,
	DeliveryDate datetime NULL,
	DeliveryAddress nvarchar(150) COLLATE Arabic_CI_AS NULL,
	DeliveryCost decimal(12,3) NULL,
	OrderNotes nvarchar(MAX) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_SalesOrderInfo PRIMARY KEY (SalesOrderInfoID_PK)
);


-- InfinityRetailDB.POS.Data_SalesOrderProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_SalesOrderProducts;

CREATE TABLE InfinityRetailDB.POS.Data_SalesOrderProducts (
	SalesOrderProductID_PK int IDENTITY(1,1) NOT NULL,
	SalesOrderID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	unitBaseQYT decimal(10,3) NOT NULL,
	UOMPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	CONSTRAINT PK_Data_POSSalesOrderProducts PRIMARY KEY (SalesOrderProductID_PK)
);


-- InfinityRetailDB.POS.Data_SalesOrders definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_SalesOrders;

CREATE TABLE InfinityRetailDB.POS.Data_SalesOrders (
	SalesOrderID_PK int IDENTITY(1,1) NOT NULL,
	OrderNumber nvarchar(12) COLLATE Arabic_CI_AS NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	DocumentStateID_FK smallint NOT NULL,
	IsOrderHolded bit NOT NULL,
	CustomerID_FK int DEFAULT -1 NOT NULL,
	WsID_FK tinyint NULL,
	CONSTRAINT PK_Data_POSSalesOrders PRIMARY KEY (SalesOrderID_PK)
);


-- InfinityRetailDB.POS.Data_UnPostedItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_UnPostedItems;

CREATE TABLE InfinityRetailDB.POS.Data_UnPostedItems (
	UnPostedItemID_PK bigint IDENTITY(1,1) NOT NULL,
	UnPostedTransactionID_FK bigint NOT NULL,
	ProductId_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) NOT NULL,
	DiscountAmount decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	ItemNote nvarchar(250) COLLATE Arabic_CI_AS NULL,
	IsQYTHolded bit DEFAULT 0 NOT NULL,
	QYTHoldedExpireDate datetime NULL,
	SerialNo nvarchar(4000) COLLATE Arabic_CI_AS NULL,
	OrderedQYT decimal(10,3) DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_ItemsBuffer PRIMARY KEY (UnPostedItemID_PK)
);


-- InfinityRetailDB.POS.Data_UnpostedTransactions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.POS.Data_UnpostedTransactions;

CREATE TABLE InfinityRetailDB.POS.Data_UnpostedTransactions (
	UnPostedTransactionID_PK bigint IDENTITY(1,1) NOT NULL,
	BranchID_FK int DEFAULT 1 NOT NULL,
	WsID_FK tinyint NOT NULL,
	WsPhysicalAddress nvarchar(25) COLLATE Arabic_CI_AS NOT NULL,
	CustomerID_FK int NOT NULL,
	TransactionDate datetime NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	IsTransactionHolded bit NOT NULL,
	TransactionNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	PriceLevel tinyint DEFAULT 1 NOT NULL,
	TransactionNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	TransactionBarcode nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	IsTransactionDiscountApplied bit DEFAULT 0 NOT NULL,
	CashCustomerName nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	POSTerminalShiftID_FK int DEFAULT 0 NOT NULL,
	OrderType nvarchar(10) COLLATE Arabic_CI_AS NULL,
	OrderNumber int NULL,
	SourceInvoiceID_FK int NULL,
	CONSTRAINT PK_Data_UnpostedTransactions PRIMARY KEY (UnPostedTransactionID_PK)
);


-- InfinityRetailDB.POS.Data_POSStockOrders foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_POSStockOrders ADD CONSTRAINT FK_Data_POSStockOrders_Data_POSTerminalShifts FOREIGN KEY (POSTerminalShiftID_FK) REFERENCES InfinityRetailDB.POS.Data_POSTerminalShifts(POSTerminalShiftID_PK);


-- InfinityRetailDB.POS.Data_POSTerminalShifts foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_POSTerminalShifts ADD CONSTRAINT FK_Data_POSTerminalShifts_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.POS.Data_SalesOrderInfo foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_SalesOrderInfo ADD CONSTRAINT FK_Data_SalesOrderInfo_Data_SalesOrders FOREIGN KEY (SalesOrderInfoID_PK) REFERENCES InfinityRetailDB.POS.Data_SalesOrders(SalesOrderID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.POS.Data_SalesOrderProducts foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_SalesOrderProducts ADD CONSTRAINT FK_Data_POSSalesOrderProducts_Data_POSSalesOrder FOREIGN KEY (SalesOrderID_FK) REFERENCES InfinityRetailDB.POS.Data_SalesOrders(SalesOrderID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.POS.Data_SalesOrderProducts ADD CONSTRAINT FK_Data_POSSalesOrderProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.POS.Data_SalesOrderProducts ADD CONSTRAINT FK_Data_POSSalesOrderProducts_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.POS.Data_SalesOrders foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_SalesOrders ADD CONSTRAINT FK_Data_POSSaleOrders_Data_Customers FOREIGN KEY (CustomerID_FK) REFERENCES InfinityRetailDB.SALES.Data_Customers(CustomerID_PK);
ALTER TABLE InfinityRetailDB.POS.Data_SalesOrders ADD CONSTRAINT FK_Data_POSSaleOrders_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.POS.Data_SalesOrders ADD CONSTRAINT FK_Data_SalesOrders_RefDocumentStates FOREIGN KEY (DocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);


-- InfinityRetailDB.POS.Data_UnPostedItems foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_UnPostedItems ADD CONSTRAINT FK_Data_UnPostedItems_Data_UnpostedTransactions FOREIGN KEY (UnPostedTransactionID_FK) REFERENCES InfinityRetailDB.POS.Data_UnpostedTransactions(UnPostedTransactionID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.POS.Data_UnpostedTransactions foreign keys

ALTER TABLE InfinityRetailDB.POS.Data_UnpostedTransactions ADD CONSTRAINT FK_Data_UnpostedTransactions_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.POS.Data_UnpostedTransactions ADD CONSTRAINT FK_Data_UnpostedTransactions_Data_Customers FOREIGN KEY (CustomerID_FK) REFERENCES InfinityRetailDB.SALES.Data_Customers(CustomerID_PK);
ALTER TABLE InfinityRetailDB.POS.Data_UnpostedTransactions ADD CONSTRAINT FK_Data_UnpostedTransactions_Data_POSTerminalShifts FOREIGN KEY (POSTerminalShiftID_FK) REFERENCES InfinityRetailDB.POS.Data_POSTerminalShifts(POSTerminalShiftID_PK);


-- POS.Data_View_POSDrawerPayInOut source

ALTER VIEW [POS].[Data_View_POSDrawerPayInOut]
AS
SELECT     POS.Data_POSDrawerPayInOut.*,MyCompany.Config_Branchs.BranchName
FROM         POS.Data_POSDrawerPayInOut INNER JOIN
                      MyCompany.Config_Branchs ON POS.Data_POSDrawerPayInOut.BranchID_FK = MyCompany.Config_Branchs.BranchID_PK;


-- POS.Data_View_POSStockOrders source

ALTER VIEW [POS].[Data_View_POSStockOrders]
AS
SELECT     POS.Data_POSStockOrders.POSStockOrderD_PK, POS.Data_POSStockOrders.POSTerminalShiftID_FK, POS.Data_POSStockOrders.ProductCode, 
                      POS.Data_POSStockOrders.ProductName, POS.Data_POSStockOrders.ProductDescription, POS.Data_POSStockOrders.RequestedQYT, 
                      POS.Data_POSStockOrders.Note, POS.Data_POSStockOrders.POSStockOrderStateID_FK, POS.Data_POSStockOrders.CreatedByUserID, 
                      POS.Data_POSStockOrders.CreatedByUserName, POS.Data_POSStockOrders.Createddate, POS.Data_POSStockOrders.modifiedByUserID, 
                      POS.Data_POSStockOrders.modifiedByUserName, POS.Data_POSStockOrders.modifiedDate, POS.Data_POSTerminalShifts.WsID_FK, 
                      POS.Data_POSTerminalShifts.IsClosed, MyCompany.Config_Branchs.BranchName, Inventory.Data_View_ProductsWithBasedUOM.UomPurchaseCost, 
                      POS.Data_POSStockOrders.IsSyncedIAS, POS.Data_POSStockOrders.ProductID_FK, POS.Data_POSStockOrders.BranchID_FK, 
                      POS.Data_POSStockOrders.IsSynced
FROM         POS.Data_POSTerminalShifts RIGHT OUTER JOIN
                      MyCompany.Config_Branchs INNER JOIN
                      POS.Data_POSStockOrders ON MyCompany.Config_Branchs.BranchID_PK = POS.Data_POSStockOrders.BranchID_FK LEFT OUTER JOIN
                      Inventory.Data_View_ProductsWithBasedUOM ON POS.Data_POSStockOrders.ProductID_FK = Inventory.Data_View_ProductsWithBasedUOM.ProductID_PK ON 
                      POS.Data_POSTerminalShifts.POSTerminalShiftID_PK = POS.Data_POSStockOrders.POSTerminalShiftID_FK;


-- POS.Data_View_POSTerminalShifts source

ALTER VIEW [POS].[Data_View_POSTerminalShifts]
AS
SELECT     POS.Data_POSTerminalShifts.POSTerminalShiftID_PK, POS.Data_POSTerminalShifts.WsID_FK, POS.Data_POSTerminalShifts.CashDrawerID_FK, 
                      POS.Data_POSTerminalShifts.OpendByUserID, POS.Data_POSTerminalShifts.OpendByUserName, POS.Data_POSTerminalShifts.OpenDate, 
                      POS.Data_POSTerminalShifts.IsClosed, POS.Data_POSTerminalShifts.ClosedByUserName, POS.Data_POSTerminalShifts.ClosedDate, 
                      POS.Data_POSTerminalShifts.OpenCash, POS.Data_POSTerminalShifts.CashTenders, POS.Data_POSTerminalShifts.CashReturned, 
                      POS.Data_POSTerminalShifts.PayOuts, POS.Data_POSTerminalShifts.PayIns, POS.Data_POSTerminalShifts.Drops, POS.Data_POSTerminalShifts.Purchases, 
                      POS.Data_POSTerminalShifts.ExpectedCash, POS.Data_POSTerminalShifts.ActualCash, POS.Data_POSTerminalShifts.Variance, 
                      POS.Data_POSTerminalShifts.TransactionCount, POS.Data_POSTerminalShifts.NoSaleCount, POS.Data_POSTerminalShifts.ClosedByUserID, 
                      POS.Data_POSTerminalShifts.CreditReturned, POS.Data_POSTerminalShifts.CreditTenders, SysConfig.Config_Workstations.WsName, 
                      POS.Data_POSTerminalShifts.JournalEntryID_FK, POS.Data_POSTerminalShifts.IsPosted, POS.Data_POSTerminalShifts.TotalReceiptPayment, 
                      POS.Data_POSTerminalShifts.BranchID_FK, POS.Data_POSTerminalShifts.InfinityModule, POS.Data_POSTerminalShifts.modifiedDate, 
                      POS.Data_POSTerminalShifts.IsSynced, MyCompany.Config_Branchs.BranchName, POS.Data_POSTerminalShifts.TotalPaymentVouchers
FROM         MyCompany.Config_Branchs INNER JOIN
                      POS.Data_POSTerminalShifts ON MyCompany.Config_Branchs.BranchID_PK = POS.Data_POSTerminalShifts.BranchID_FK AND 
                      MyCompany.Config_Branchs.BranchID_PK = POS.Data_POSTerminalShifts.BranchID_FK LEFT OUTER JOIN
                      SysConfig.Config_Workstations ON POS.Data_POSTerminalShifts.WsID_FK = SysConfig.Config_Workstations.WsID_PK;


-- POS.Data_View_UnPostedItems source

ALTER VIEW [POS].[Data_View_UnPostedItems]
AS
SELECT     POS.Data_UnPostedItems.UnPostedItemID_PK, POS.Data_UnPostedItems.UnPostedTransactionID_FK, POS.Data_UnPostedItems.ProductId_FK, 
                      POS.Data_UnPostedItems.QYT, POS.Data_UnPostedItems.UnitID_FK, POS.Data_UnPostedItems.UnitBaseQYT, POS.Data_UnPostedItems.UnitCost, 
                      POS.Data_UnPostedItems.UnitPrice, POS.Data_UnPostedItems.SubTotal, POS.Data_UnPostedItems.DiscountPersentage, POS.Data_UnPostedItems.DiscountAmount, 
                      POS.Data_UnPostedItems.ExpireDate, POS.Data_UnPostedItems.ItemNote, POS.Data_UnPostedItems.CreatedByUserID, 
                      POS.Data_UnPostedItems.CreatedByUserName, POS.Data_UnPostedItems.Createddate, Inventory.Data_Products.ProductCode, 
                      Inventory.Data_Products.ProductName, Inventory.RefUOMs.UOMName, Inventory.Data_Products.ProductTypeID_FK, Inventory.Data_Products.IsNonDiscountableItem, 
                      Inventory.Data_ProductUOMs.UomCost, Inventory.Data_ProductUOMs.UomLastCost, Inventory.Data_ProductUOMs.UomPrice1, 
                      Inventory.Data_ProductUOMs.UomPrice2, Inventory.Data_ProductUOMs.UomPrice3, Inventory.Data_ProductUOMs.UomPrice4, 
                      POS.Data_UnPostedItems.IsQYTHolded, POS.Data_UnPostedItems.QYTHoldedExpireDate, Inventory.Data_ProductUOMs.UomMiniPrice, 
                      Inventory.Data_ProductUOMs.UomLastPurchaseCost, Inventory.Data_ProductUOMs.UomPurchaseCost, Inventory.Data_Products.ISCostHidden, 
                      Inventory.Data_Products.SalesPoints, POS.Data_UnPostedItems.SerialNo, Inventory.Data_Products.IsHasSerialNO, POS.Data_UnPostedItems.OrderedQYT, 
                      Inventory.Data_Products.LogicalOrderPrinter1ID
FROM         Inventory.RefUOMs INNER JOIN
                      POS.Data_UnPostedItems ON Inventory.RefUOMs.UOMID_PK = POS.Data_UnPostedItems.UnitID_FK INNER JOIN
                      Inventory.Data_Products ON POS.Data_UnPostedItems.ProductId_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.Data_ProductUOMs ON Inventory.RefUOMs.UOMID_PK = Inventory.Data_ProductUOMs.UomID_FK AND 
                      Inventory.Data_Products.ProductID_PK = Inventory.Data_ProductUOMs.ProductID_FK AND 
                      Inventory.Data_Products.ProductID_PK = Inventory.Data_ProductUOMs.ProductID_FK;


-- POS.Data_View_UnPostedTransactions source

ALTER VIEW [POS].[Data_View_UnPostedTransactions]
AS
SELECT     POS.Data_UnpostedTransactions.UnPostedTransactionID_PK, POS.Data_UnpostedTransactions.BranchID_FK, POS.Data_UnpostedTransactions.WsID_FK, 
                      POS.Data_UnpostedTransactions.WsPhysicalAddress, POS.Data_UnpostedTransactions.CustomerID_FK, POS.Data_UnpostedTransactions.TransactionDate, 
                      POS.Data_UnpostedTransactions.DocumentTypeID_FK, POS.Data_UnpostedTransactions.IsTransactionHolded, POS.Data_UnpostedTransactions.TransactionNote, 
                      POS.Data_UnpostedTransactions.PriceLevel, POS.Data_UnpostedTransactions.CreatedByUserID, POS.Data_UnpostedTransactions.CreatedByUserName, 
                      POS.Data_UnpostedTransactions.Createddate, SALES.Data_Customers.CustomerName, POS.Data_UnpostedTransactions.TransactionNumber, 
                      POS.Data_UnpostedTransactions.TransactionBarcode, POS.Data_UnpostedTransactions.IsTransactionDiscountApplied, 
                      POS.Data_UnpostedTransactions.CashCustomerName, POS.Data_UnpostedTransactions.POSTerminalShiftID_FK, POS.Data_UnpostedTransactions.OrderType, 
                      POS.Data_UnpostedTransactions.OrderNumber,POS.Data_UnpostedTransactions.SourceInvoiceID_FK
FROM         SALES.Data_Customers INNER JOIN
                      POS.Data_UnpostedTransactions ON SALES.Data_Customers.CustomerID_PK = POS.Data_UnpostedTransactions.CustomerID_FK;

-- DROP SCHEMA PROCM;

CREATE SCHEMA PROCM;

-- DROP SCHEMA PRODUCT;

CREATE SCHEMA PRODUCT;

-- DROP SCHEMA Purchase;

CREATE SCHEMA Purchase;
-- InfinityRetailDB.Purchase.RefPurchaseExpenseTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.RefPurchaseExpenseTypes;

CREATE TABLE InfinityRetailDB.Purchase.RefPurchaseExpenseTypes (
	PurchaseExpenseTypeID_PK smallint IDENTITY(1,1) NOT NULL,
	PurchaseExpenseTypeCaption nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	DebitAccountID_FK int NULL,
	CreditAccountID_FK int NULL,
	PurchaseExpenseDistributedMethod tinyint NOT NULL,
	CONSTRAINT PK_RefPurchaseExpenseTypes PRIMARY KEY (PurchaseExpenseTypeID_PK)
);


-- InfinityRetailDB.Purchase.RefPurchaseInvoiceStates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.RefPurchaseInvoiceStates;

CREATE TABLE InfinityRetailDB.Purchase.RefPurchaseInvoiceStates (
	PurchaseInvoiceStateID_PK smallint NOT NULL,
	PurchaseInvoiceStateCaption nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefPurchaseInvoiceStates PRIMARY KEY (PurchaseInvoiceStateID_PK)
);


-- InfinityRetailDB.Purchase.RefPurchaseOrderStates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.RefPurchaseOrderStates;

CREATE TABLE InfinityRetailDB.Purchase.RefPurchaseOrderStates (
	POrderStatusID_PK tinyint NOT NULL,
	POrderStatusCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsEnableToModifiy bit NOT NULL,
	CONSTRAINT PK_RefPurchaseOrderStatus PRIMARY KEY (POrderStatusID_PK)
);


-- InfinityRetailDB.Purchase.Data_PaymentAppointments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments;

CREATE TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments (
	PAppointmentID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	PAppointmentDate datetime NOT NULL,
	PAppointmentDescription nvarchar(100) COLLATE Arabic_CI_AS NULL,
	SupplierID_FK int NOT NULL,
	PurchaseInvoiceID_FK int NULL,
	PurchaseInvoiceNumber nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	PaymentAmount decimal(12,3) NOT NULL,
	IsDone bit NOT NULL,
	PaymentVoucherID_FK int NULL,
	CONSTRAINT PK_Data_PaymentAppointments PRIMARY KEY (PAppointmentID_PK)
);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses (
	PurchaseInvoiceExpenseID_PK int IDENTITY(1,1) NOT NULL,
	PurchaseInvoiceID_FK int NOT NULL,
	ExpenseTypeID_FK smallint NOT NULL,
	ExpenseDate datetime NOT NULL,
	ExpenseCurrencyID_FK smallint NOT NULL,
	CurrencyRate decimal(10,5) NOT NULL,
	ExpenseAmount decimal(10,3) NOT NULL,
	LocalCurrencyExpenseAmount decimal(10,3) NOT NULL,
	IncludedOnItemCost bit NOT NULL,
	PaymentAccountID_FK int NOT NULL,
	CONSTRAINT PK_Data_PurchaseInvoiceExpenses PRIMARY KEY (PurchaseInvoiceExpenseID_PK)
);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems (
	PurchaseInvoiceItemID_PK int IDENTITY(1,1) NOT NULL,
	InvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint DEFAULT 0 NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) DEFAULT 0 NOT NULL,
	DiscountAmount decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyUnitCost decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencySubTotal decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyDiscountAmount decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyExpenseAmount decimal(12,3) DEFAULT 0 NOT NULL,
	ExpireDate datetime NULL,
	NewPrice decimal(12,3) NULL,
	IsQYTReceived bit NOT NULL,
	QYTReceiveDate datetime NULL,
	PurchaseInvoiceItemID_FK int NULL,
	InvoiceItemPostDate datetime NULL,
	SerialNo nvarchar(4000) COLLATE Arabic_CI_AS NULL,
	FirstWeightRead decimal(12,3) NULL,
	SecondWeightRead decimal(12,3) NULL,
	FirstWeightReadTime datetime NULL,
	SecondWeightReadTime datetime NULL,
	CONSTRAINT PK_Data_PurchaseInvoiceItems PRIMARY KEY (PurchaseInvoiceItemID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoiceItems_InvoiceID_FK ON InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems (  InvoiceID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoiceItems_ProductID_FK ON InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceRefundSource definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceRefundSource;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceRefundSource (
	PurchaseInvoiceItemID_PK int NOT NULL,
	InvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint DEFAULT 0 NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) DEFAULT 0 NOT NULL,
	DiscountAmount decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyUnitCost decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencySubTotal decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyDiscountAmount decimal(12,3) DEFAULT 0 NOT NULL,
	LocCurrencyExpenseAmount decimal(12,3) DEFAULT 0 NOT NULL,
	ExpireDate datetime NULL,
	NewPrice decimal(12,3) NULL,
	IsQYTReceived bit NOT NULL,
	QYTReceiveDate datetime NULL,
	CONSTRAINT PK_Data_PurchaseInvoiceRefundItemSource PRIMARY KEY (PurchaseInvoiceItemID_PK)
);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices (
	InvoiceID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	PurchaseInvoiceStateID_PK smallint NOT NULL,
	InvoiceNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	SupplierID_FK int NOT NULL,
	InvoiceDate datetime NOT NULL,
	InvoiceCurrencyID_FK smallint NOT NULL,
	CurrencyXchangeRate decimal(10,5) DEFAULT 0 NOT NULL,
	DiscountTypeID_FK tinyint DEFAULT 1 NOT NULL,
	DefaultDiscountPersentage tinyint DEFAULT 0 NOT NULL,
	InvoiceSubTotal decimal(15,3) NOT NULL,
	InvoiceDiscountTotal decimal(15,3) NOT NULL,
	InvoiceNetTotal decimal(15,3) NOT NULL,
	InvoiceLocCurrencySubTotal decimal(15,3) DEFAULT 0 NOT NULL,
	InvoiceLocCurrencyDiscountTotal decimal(15,3) DEFAULT 0 NOT NULL,
	InvoiceLocCurrencyExpensesTotal decimal(15,3) DEFAULT 0 NOT NULL,
	InvoiceLocCurrencyNetTotal decimal(15,3) DEFAULT 0 NOT NULL,
	InvoicePaymentID_FK smallint NOT NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	IsSalesPricesReviewed bit DEFAULT 0 NOT NULL,
	LocationID_FK int DEFAULT 1 NOT NULL,
	SalePersonID_FK int NULL,
	SourceInvoiceID_FK int NULL,
	CONSTRAINT PK_purchases_invoices PRIMARY KEY (InvoiceID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoices_BranchID_FK ON InfinityRetailDB.Purchase.Data_PurchaseInvoices (  BranchID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoices_InvoiceDate ON InfinityRetailDB.Purchase.Data_PurchaseInvoices (  InvoiceDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoices_LocationID_FK ON InfinityRetailDB.Purchase.Data_PurchaseInvoices (  LocationID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_PurchaseInvoices_SupplierID_FK ON InfinityRetailDB.Purchase.Data_PurchaseInvoices (  SupplierID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.Purchase.Data_PurchaseOrderProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseOrderProducts;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseOrderProducts (
	PurchaseOrderProductID_PK bigint IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	PurchaseOrderID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UOMID_FK smallint NOT NULL,
	OrderedQYT decimal(9,3) NOT NULL,
	OnOrderQYT decimal(9,3) NULL,
	ReceivedQYT decimal(9,3) NOT NULL,
	Cost decimal(10,3) NOT NULL,
	ExtCost decimal(10,3) NOT NULL,
	CONSTRAINT PK_Data_PurchaseOrderProducts PRIMARY KEY (PurchaseOrderProductID_PK)
);


-- InfinityRetailDB.Purchase.Data_PurchaseOrders definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_PurchaseOrders;

CREATE TABLE InfinityRetailDB.Purchase.Data_PurchaseOrders (
	PurchaseOrderID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	SupplierID_FK int NOT NULL,
	PurchaseOrderNumber nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	PurchaseOrderDate datetime NOT NULL,
	ExpectedDeliveryDate datetime NULL,
	DeliveryDate datetime NULL,
	PurchaseOrderStatusID_FK tinyint NOT NULL,
	PurchaseOrderCurrencyID_FK smallint NOT NULL,
	XchangeRate decimal(10,4) NOT NULL,
	SubTotal decimal(10,3) NOT NULL,
	DiscountAmount decimal(10,3) NOT NULL,
	FeeAmount decimal(10,3) NOT NULL,
	NetTotal decimal(10,3) NOT NULL,
	ShipTo nvarchar(300) COLLATE Arabic_CI_AS NULL,
	BillTo nvarchar(300) COLLATE Arabic_CI_AS NULL,
	Instructions nvarchar(400) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_PurchaseOrderHead PRIMARY KEY (PurchaseOrderID_PK)
);


-- InfinityRetailDB.Purchase.Data_SupplierDiscountItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_SupplierDiscountItems;

CREATE TABLE InfinityRetailDB.Purchase.Data_SupplierDiscountItems (
	SupplierDiscountItemID_PK int IDENTITY(1,1) NOT NULL,
	DiscountInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	DiscountQYT decimal(10,3) NOT NULL,
	OldUnitCost decimal(12,3) NOT NULL,
	NewUnitCost decimal(12,3) NOT NULL,
	DiscountValue decimal(12,3) NOT NULL,
	Comment nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_SupplierDiscountItems PRIMARY KEY (SupplierDiscountItemID_PK)
);


-- InfinityRetailDB.Purchase.Data_SupplierDiscounts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts;

CREATE TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts (
	DiscountInvoiceID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	DocumentStateID_FK smallint NOT NULL,
	SupplierID_FK int NOT NULL,
	SalePersonID_FK int NULL,
	DiscountInvoiceNumber nvarchar(12) COLLATE Arabic_CI_AS NOT NULL,
	DiscountInvoiceDate datetime NOT NULL,
	TotalDiscountAmount decimal(12,3) NOT NULL,
	DiscountInvoiceNote nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	JournalEntryID_FK int NULL,
	CONSTRAINT PK_Data_SupplierDiscountInvoices PRIMARY KEY (DiscountInvoiceID_PK)
);


-- InfinityRetailDB.Purchase.Data_Suppliers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.Data_Suppliers;

CREATE TABLE InfinityRetailDB.Purchase.Data_Suppliers (
	SupplierID_PK int IDENTITY(1,1) NOT NULL,
	AccountID_FK int NULL,
	SupplierName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	ContactPersonName nvarchar(150) COLLATE Arabic_CI_AS NULL,
	SupplierAddress nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	SupplierAddress2 nvarchar(250) COLLATE Arabic_CI_AS NULL,
	SupplierPhone nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	SupplierMobilePhone nvarchar(50) COLLATE Arabic_CI_AS NULL,
	SupplierFax nvarchar(50) COLLATE Arabic_CI_AS NULL,
	SupplierEmail nvarchar(50) COLLATE Arabic_CI_AS NULL,
	DefaultCurrencyID_FK smallint DEFAULT 1 NOT NULL,
	IsActiveAccount bit DEFAULT 1 NOT NULL,
	LastOrderTransactionDate datetime NULL,
	LastReceiveTransactionDate datetime NULL,
	SupplierAccountCurrentBalance decimal(10,3) DEFAULT 0 NOT NULL,
	IsAllowCreditPurchase bit DEFAULT 0 NOT NULL,
	SupplierCategoryID_FK int NULL,
	CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID_PK)
);


-- InfinityRetailDB.Purchase.History_PurchaseOrderStatuses definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Purchase.History_PurchaseOrderStatuses;

CREATE TABLE InfinityRetailDB.Purchase.History_PurchaseOrderStatuses (
	POStatusChangeID_PK bigint NOT NULL,
	POStatusChangeDate datetime NOT NULL,
	POrderID_FK int NOT NULL,
	CurrentStatusID_FK tinyint NOT NULL,
	NewStatusID_FK tinyint NOT NULL,
	ChangedByUserID_FK smallint NOT NULL,
	CONSTRAINT PK_History_PurchaseOrderStatuses PRIMARY KEY (POStatusChangeID_PK)
);


-- InfinityRetailDB.Purchase.Data_PaymentAppointments foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments ADD CONSTRAINT FK_Data_PaymentAppointments_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments ADD CONSTRAINT FK_Data_PaymentAppointments_Data_PaymentVouchers FOREIGN KEY (PaymentVoucherID_FK) REFERENCES InfinityRetailDB.Financial.Data_PaymentVouchers(PaymentVoucherID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments ADD CONSTRAINT FK_Data_PaymentAppointments_Data_PurchaseInvoices FOREIGN KEY (PurchaseInvoiceID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseInvoices(InvoiceID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PaymentAppointments ADD CONSTRAINT FK_Data_PaymentAppointments_Data_Suppliers FOREIGN KEY (SupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses ADD CONSTRAINT FK_Data_PurchaseInvoiceExpenses_Data_Accounts FOREIGN KEY (PaymentAccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses ADD CONSTRAINT FK_Data_PurchaseInvoiceExpenses_Data_PurchaseInvoices FOREIGN KEY (PurchaseInvoiceID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseInvoices(InvoiceID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses ADD CONSTRAINT FK_Data_PurchaseInvoiceExpenses_RefPurchaseExpenseTypes FOREIGN KEY (ExpenseTypeID_FK) REFERENCES InfinityRetailDB.Purchase.RefPurchaseExpenseTypes(PurchaseExpenseTypeID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceExpenses ADD CONSTRAINT FK_Data_PurchaseInvoiceExpenses_Ref_Currencies FOREIGN KEY (ExpenseCurrencyID_FK) REFERENCES InfinityRetailDB.MyCompany.RefCurrencies(CurrencyID_PK);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems ADD CONSTRAINT FK_Data_PurchaseInvoiceItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems ADD CONSTRAINT FK_Data_PurchaseInvoiceItems_Data_PurchaseInvoiceItems FOREIGN KEY (PurchaseInvoiceItemID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems(PurchaseInvoiceItemID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems ADD CONSTRAINT FK_Data_PurchaseInvoiceItems_Data_PurchaseInvoices FOREIGN KEY (InvoiceID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseInvoices(InvoiceID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems ADD CONSTRAINT FK_Data_PurchaseInvoiceItems_RefInventoryUnits FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Purchase.Data_PurchaseInvoiceRefundSource foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoiceRefundSource ADD CONSTRAINT FK_Data_PurchaseInvoiceRefundItemSource_Data_PurchaseInvoiceItems FOREIGN KEY (PurchaseInvoiceItemID_PK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseInvoiceItems(PurchaseInvoiceItemID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.Purchase.Data_PurchaseInvoices foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Config_SalePersons FOREIGN KEY (SalePersonID_FK) REFERENCES InfinityRetailDB.SALES.Config_SalePersons(SalePersonID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Data_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Data_Suppliers FOREIGN KEY (SupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_RefDiscountTypes FOREIGN KEY (DiscountTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDiscountTypes(DiscountTypeID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_RefPurchaseInvoiceStates FOREIGN KEY (PurchaseInvoiceStateID_PK) REFERENCES InfinityRetailDB.Purchase.RefPurchaseInvoiceStates(PurchaseInvoiceStateID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Ref_Currencies FOREIGN KEY (InvoiceCurrencyID_FK) REFERENCES InfinityRetailDB.MyCompany.RefCurrencies(CurrencyID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseInvoices ADD CONSTRAINT FK_Data_PurchaseInvoices_Ref_PaymentMethods FOREIGN KEY (InvoicePaymentID_FK) REFERENCES InfinityRetailDB.MyCompany.RefPaymentMethods(PaymentMethodID_PK);


-- InfinityRetailDB.Purchase.Data_PurchaseOrderProducts foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseOrderProducts ADD CONSTRAINT FK_Data_PurchaseOrderProducts_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseOrderProducts ADD CONSTRAINT FK_Data_PurchaseOrderProducts_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseOrderProducts ADD CONSTRAINT FK_Data_PurchaseOrderProducts_Data_PurchaseOrders FOREIGN KEY (PurchaseOrderID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseOrders(PurchaseOrderID_PK);


-- InfinityRetailDB.Purchase.Data_PurchaseOrders foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseOrders ADD CONSTRAINT FK_Data_PurchaseOrderHead_RefPurchaseOrderStatus FOREIGN KEY (PurchaseOrderStatusID_FK) REFERENCES InfinityRetailDB.Purchase.RefPurchaseOrderStates(POrderStatusID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_PurchaseOrders ADD CONSTRAINT FK_Data_PurchaseOrders_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- InfinityRetailDB.Purchase.Data_SupplierDiscountItems foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscountItems ADD CONSTRAINT FK_Data_SupplierDiscountItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscountItems ADD CONSTRAINT FK_Data_SupplierDiscountItems_Data_SupplierDiscounts FOREIGN KEY (DiscountInvoiceID_FK) REFERENCES InfinityRetailDB.Purchase.Data_SupplierDiscounts(DiscountInvoiceID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscountItems ADD CONSTRAINT FK_Data_SupplierDiscountItems_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.Purchase.Data_SupplierDiscounts foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts ADD CONSTRAINT FK_Data_SupplierDiscounts_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts ADD CONSTRAINT FK_Data_SupplierDiscounts_Config_SalePersons FOREIGN KEY (SalePersonID_FK) REFERENCES InfinityRetailDB.SALES.Config_SalePersons(SalePersonID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts ADD CONSTRAINT FK_Data_SupplierDiscounts_Data_Suppliers FOREIGN KEY (SupplierID_FK) REFERENCES InfinityRetailDB.Purchase.Data_Suppliers(SupplierID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts ADD CONSTRAINT FK_Data_SupplierDiscounts_RefDocumentStates FOREIGN KEY (DocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_SupplierDiscounts ADD CONSTRAINT FK_Data_SupplierDiscounts_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);


-- InfinityRetailDB.Purchase.Data_Suppliers foreign keys

ALTER TABLE InfinityRetailDB.Purchase.Data_Suppliers ADD CONSTRAINT FK_Data_Suppliers_Data_Accounts FOREIGN KEY (AccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.Purchase.Data_Suppliers ADD CONSTRAINT FK_Data_Suppliers_RefCustomerCategories FOREIGN KEY (SupplierCategoryID_FK) REFERENCES InfinityRetailDB.SALES.RefCustomerCategories(CustomerCategoryID_PK);


-- InfinityRetailDB.Purchase.History_PurchaseOrderStatuses foreign keys

ALTER TABLE InfinityRetailDB.Purchase.History_PurchaseOrderStatuses ADD CONSTRAINT FK_History_PurchaseOrderStatuses_Data_PurchaseOrderHead FOREIGN KEY (POrderID_FK) REFERENCES InfinityRetailDB.Purchase.Data_PurchaseOrders(PurchaseOrderID_PK);


-- Purchase.Data_View_PaymentAppointments source

ALTER VIEW Purchase.Data_View_PaymentAppointments
AS
SELECT     Purchase.Data_PaymentAppointments.PAppointmentID_PK, Purchase.Data_PaymentAppointments.BranchID_FK, 
                      Purchase.Data_PaymentAppointments.PAppointmentDate, Purchase.Data_PaymentAppointments.PAppointmentDescription, 
                      Purchase.Data_PaymentAppointments.SupplierID_FK, Purchase.Data_PaymentAppointments.PurchaseInvoiceID_FK, 
                      Purchase.Data_PaymentAppointments.PurchaseInvoiceNumber, Purchase.Data_PaymentAppointments.PaymentAmount, 
                      Purchase.Data_PaymentAppointments.IsDone, Purchase.Data_PaymentAppointments.PaymentVoucherID_FK, 
                      Purchase.Data_PaymentAppointments.CreatedByUserID, Purchase.Data_PaymentAppointments.CreatedByUserName, 
                      Purchase.Data_PaymentAppointments.CreatedDate, Purchase.Data_PaymentAppointments.ModifiedByUserID, 
                      Purchase.Data_PaymentAppointments.ModifiedByUserName, Purchase.Data_PaymentAppointments.ModifiedDate, Purchase.Data_Suppliers.SupplierName, 
                      Purchase.Data_PurchaseInvoices.InvoiceNumber, Purchase.Data_PurchaseInvoices.InvoiceDate
FROM         Purchase.Data_PaymentAppointments INNER JOIN
                      Purchase.Data_Suppliers ON Purchase.Data_PaymentAppointments.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK LEFT OUTER JOIN
                      Purchase.Data_PurchaseInvoices ON Purchase.Data_PaymentAppointments.PurchaseInvoiceID_FK = Purchase.Data_PurchaseInvoices.InvoiceID_PK;


-- Purchase.Data_View_ProductTotalPurchaseWithBasedUOM source

ALTER VIEW [Purchase].[Data_View_ProductTotalPurchaseWithBasedUOM]
AS
SELECT     Inventory.Data_Products.ProductID_PK, SUM(Purchase.Data_PurchaseInvoiceItems.QYT * Purchase.Data_PurchaseInvoiceItems.UnitBaseQYT) 
                      AS ItemTotalQytByBaseUOM, SUM(Purchase.Data_PurchaseInvoiceItems.LocCurrencySubTotal - Purchase.Data_PurchaseInvoiceItems.LocCurrencyDiscountAmount) 
                      AS LocCurrencyNetAmountTotal
FROM         Inventory.Data_Products INNER JOIN
                      Purchase.Data_PurchaseInvoiceItems ON Inventory.Data_Products.ProductID_PK = Purchase.Data_PurchaseInvoiceItems.ProductID_FK INNER JOIN
                      Purchase.Data_PurchaseInvoices ON Purchase.Data_PurchaseInvoiceItems.InvoiceID_FK = Purchase.Data_PurchaseInvoices.InvoiceID_PK
WHERE     (Purchase.Data_PurchaseInvoices.PurchaseInvoiceStateID_PK = 300)
GROUP BY Inventory.Data_Products.ProductID_PK
HAVING      (SUM(Purchase.Data_PurchaseInvoiceItems.QYT * Purchase.Data_PurchaseInvoiceItems.UnitBaseQYT) <> 0);


-- Purchase.Data_View_PurchaseInvoiceExpenses source

ALTER VIEW Purchase.Data_View_PurchaseInvoiceExpenses
AS
SELECT     Purchase.Data_PurchaseInvoiceExpenses.PurchaseInvoiceExpenseID_PK, Purchase.Data_PurchaseInvoiceExpenses.PurchaseInvoiceID_FK, 
                      Purchase.Data_PurchaseInvoiceExpenses.ExpenseTypeID_FK, Purchase.Data_PurchaseInvoiceExpenses.ExpenseDate, 
                      Purchase.Data_PurchaseInvoiceExpenses.ExpenseCurrencyID_FK, Purchase.Data_PurchaseInvoiceExpenses.CurrencyRate, 
                      Purchase.Data_PurchaseInvoiceExpenses.ExpenseAmount, Purchase.Data_PurchaseInvoiceExpenses.LocalCurrencyExpenseAmount, 
                      Purchase.Data_PurchaseInvoiceExpenses.IncludedOnItemCost, Purchase.Data_PurchaseInvoiceExpenses.CreatedByUserID, 
                      Purchase.Data_PurchaseInvoiceExpenses.CreatedByUserName, Purchase.Data_PurchaseInvoiceExpenses.Createddate, 
                      Purchase.Data_PurchaseInvoiceExpenses.modifiedByUserID, Purchase.Data_PurchaseInvoiceExpenses.modifiedByUserName, 
                      Purchase.Data_PurchaseInvoiceExpenses.modifiedDate, Purchase.RefPurchaseExpenseTypes.PurchaseExpenseTypeCaption, 
                      MyCompany.RefCurrencies.CurrencySymbol, MyCompany.RefCurrencies.CurrencyName, MyCompany.RefCurrencies.CurrencyRate AS Expr1, 
                      MyCompany.RefCurrencies.CurrencyScale, Purchase.RefPurchaseExpenseTypes.CreditAccountID_FK, 
                      Purchase.Data_PurchaseInvoiceExpenses.PaymentAccountID_FK, Financial.Data_Accounts.AccountNumber, Financial.Data_Accounts.AccountName
FROM         Purchase.Data_PurchaseInvoiceExpenses INNER JOIN
                      Purchase.RefPurchaseExpenseTypes ON 
                      Purchase.Data_PurchaseInvoiceExpenses.ExpenseTypeID_FK = Purchase.RefPurchaseExpenseTypes.PurchaseExpenseTypeID_PK INNER JOIN
                      MyCompany.RefCurrencies ON Purchase.Data_PurchaseInvoiceExpenses.ExpenseCurrencyID_FK = MyCompany.RefCurrencies.CurrencyID_PK INNER JOIN
                      Financial.Data_Accounts ON Purchase.Data_PurchaseInvoiceExpenses.PaymentAccountID_FK = Financial.Data_Accounts.AccountID_PK;


-- Purchase.Data_View_PurchaseInvoiceItems source

ALTER VIEW [Purchase].[Data_View_PurchaseInvoiceItems]
AS
SELECT     Purchase.Data_PurchaseInvoiceItems.PurchaseInvoiceItemID_PK, Purchase.Data_PurchaseInvoiceItems.InvoiceID_FK, 
                      Purchase.Data_PurchaseInvoiceItems.ProductID_FK, Purchase.Data_PurchaseInvoiceItems.QYT, Purchase.Data_PurchaseInvoiceItems.UnitID_FK, 
                      Purchase.Data_PurchaseInvoiceItems.UnitCost, Purchase.Data_PurchaseInvoiceItems.SubTotal, Purchase.Data_PurchaseInvoiceItems.DiscountPersentage, 
                      Purchase.Data_PurchaseInvoiceItems.DiscountAmount, Purchase.Data_PurchaseInvoiceItems.LocCurrencyUnitCost, 
                      Purchase.Data_PurchaseInvoiceItems.LocCurrencyDiscountAmount, Purchase.Data_PurchaseInvoiceItems.LocCurrencySubTotal, 
                      Purchase.Data_PurchaseInvoiceItems.ExpireDate, Purchase.Data_PurchaseInvoiceItems.NewPrice, Purchase.Data_PurchaseInvoiceItems.CreatedByUserID, 
                      Purchase.Data_PurchaseInvoiceItems.CreatedByUserName, Purchase.Data_PurchaseInvoiceItems.Createddate, 
                      Purchase.Data_PurchaseInvoiceItems.modifiedByUserID, Purchase.Data_PurchaseInvoiceItems.modifiedByUserName, 
                      Purchase.Data_PurchaseInvoiceItems.modifiedDate, Inventory.RefUOMs.UOMName, Purchase.Data_PurchaseInvoiceItems.IsQYTReceived, 
                      Purchase.Data_PurchaseInvoiceItems.UnitBaseQYT, Purchase.Data_PurchaseInvoiceItems.QYTReceiveDate, Inventory.Data_View_Products.ProductCode, 
                      Inventory.Data_View_Products.ProductName, Inventory.Data_View_Products.ProductTypeID_FK, Inventory.Data_View_Products.InvDepartmentID_PK, 
                      Inventory.Data_View_Products.InvDepartmentName, 
                      Purchase.Data_PurchaseInvoiceItems.LocCurrencySubTotal - Purchase.Data_PurchaseInvoiceItems.LocCurrencyDiscountAmount AS LocCurrencyNetAmount, 
                      Purchase.Data_PurchaseInvoiceItems.LocCurrencyExpenseAmount, Inventory.Data_View_Products.InventoryAccountID_FK, 
                      Inventory.Data_View_Products.RevnueAccountID_FK, Inventory.Data_View_Products.ExpenseAccountID_FK, 
                      Purchase.Data_PurchaseInvoiceItems.PurchaseInvoiceItemID_FK, Inventory.Data_View_Products.ISCostHidden, Purchase.Data_PurchaseInvoiceItems.SerialNo, 
                      Inventory.Data_View_Products.IsHasSerialNO, Purchase.Data_PurchaseInvoiceItems.FirstWeightRead,Purchase.Data_PurchaseInvoiceItems.SecondWeightRead, 
                      Purchase.Data_PurchaseInvoiceItems.FirstWeightReadTime, Purchase.Data_PurchaseInvoiceItems.SecondWeightReadTime
FROM         Purchase.Data_PurchaseInvoiceItems INNER JOIN
                      Inventory.RefUOMs ON Purchase.Data_PurchaseInvoiceItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_View_Products ON Purchase.Data_PurchaseInvoiceItems.ProductID_FK = Inventory.Data_View_Products.ProductID_PK;


-- Purchase.Data_View_PurchaseInvoiceRefundSource source

ALTER VIEW [Purchase].[Data_View_PurchaseInvoiceRefundSource]
AS
SELECT     Purchase.Data_PurchaseInvoiceRefundSource.PurchaseInvoiceItemID_PK, Purchase.Data_PurchaseInvoiceRefundSource.InvoiceID_FK, 
                      Purchase.Data_PurchaseInvoiceRefundSource.ProductID_FK, Purchase.Data_PurchaseInvoiceRefundSource.QYT, 
                      Purchase.Data_PurchaseInvoiceRefundSource.UnitID_FK, Purchase.Data_PurchaseInvoiceRefundSource.UnitBaseQYT, 
                      Purchase.Data_PurchaseInvoiceRefundSource.UnitCost, Purchase.Data_PurchaseInvoiceRefundSource.SubTotal, 
                      Purchase.Data_PurchaseInvoiceRefundSource.DiscountPersentage, Purchase.Data_PurchaseInvoiceRefundSource.DiscountAmount, 
                      Purchase.Data_PurchaseInvoiceRefundSource.LocCurrencyUnitCost, Purchase.Data_PurchaseInvoiceRefundSource.LocCurrencySubTotal, 
                      Purchase.Data_PurchaseInvoiceRefundSource.LocCurrencyDiscountAmount, Purchase.Data_PurchaseInvoiceRefundSource.LocCurrencyExpenseAmount, 
                      Purchase.Data_PurchaseInvoiceRefundSource.ExpireDate, Purchase.Data_PurchaseInvoiceRefundSource.NewPrice, 
                      Purchase.Data_PurchaseInvoiceRefundSource.IsQYTReceived, Purchase.Data_PurchaseInvoiceRefundSource.QYTReceiveDate, 
                      Purchase.Data_PurchaseInvoiceRefundSource.CreatedByUserID, Purchase.Data_PurchaseInvoiceRefundSource.CreatedByUserName, 
                      Purchase.Data_PurchaseInvoiceRefundSource.Createddate, Purchase.Data_PurchaseInvoiceRefundSource.modifiedByUserID, 
                      Purchase.Data_PurchaseInvoiceRefundSource.modifiedByUserName, Purchase.Data_PurchaseInvoiceRefundSource.modifiedDate, Inventory.RefUOMs.UOMName, 
                      Inventory.Data_View_Products.ProductCode, Inventory.Data_View_Products.ProductName, Inventory.Data_View_Products.ProductTypeID_FK, 
                      Inventory.Data_View_Products.InvDepartmentID_PK, Inventory.Data_View_Products.InvDepartmentName, Inventory.Data_View_Products.InventoryAccountID_FK, 
                      Inventory.Data_View_Products.RevnueAccountID_FK, Inventory.Data_View_Products.ExpenseAccountID_FK
FROM         Inventory.Data_View_Products INNER JOIN
                      Purchase.Data_PurchaseInvoiceRefundSource ON 
                      Inventory.Data_View_Products.ProductID_PK = Purchase.Data_PurchaseInvoiceRefundSource.ProductID_FK INNER JOIN
                      Inventory.RefUOMs ON Purchase.Data_PurchaseInvoiceRefundSource.UnitID_FK = Inventory.RefUOMs.UOMID_PK;


-- Purchase.Data_View_PurchaseInvoices source

ALTER VIEW [Purchase].[Data_View_PurchaseInvoices]
AS
SELECT     Purchase.Data_PurchaseInvoices.InvoiceID_PK, Purchase.Data_PurchaseInvoices.BranchID_FK, Purchase.Data_PurchaseInvoices.DocumentTypeID_FK, 
                      Purchase.Data_PurchaseInvoices.PurchaseInvoiceStateID_PK, Purchase.Data_PurchaseInvoices.InvoiceNumber, Purchase.Data_PurchaseInvoices.SupplierID_FK, 
                      Purchase.Data_PurchaseInvoices.InvoiceDate, Purchase.Data_PurchaseInvoices.InvoiceCurrencyID_FK, Purchase.Data_PurchaseInvoices.CurrencyXchangeRate, 
                      Purchase.Data_PurchaseInvoices.DiscountTypeID_FK, Purchase.Data_PurchaseInvoices.DefaultDiscountPersentage, 
                      Purchase.Data_PurchaseInvoices.InvoiceSubTotal, Purchase.Data_PurchaseInvoices.InvoiceDiscountTotal, Purchase.Data_PurchaseInvoices.InvoiceNetTotal, 
                      Purchase.Data_PurchaseInvoices.InvoiceLocCurrencySubTotal, Purchase.Data_PurchaseInvoices.InvoiceLocCurrencyDiscountTotal, 
                      Purchase.Data_PurchaseInvoices.InvoiceLocCurrencyExpensesTotal, Purchase.Data_PurchaseInvoices.InvoiceLocCurrencyNetTotal, 
                      Purchase.Data_PurchaseInvoices.InvoicePaymentID_FK, Purchase.Data_PurchaseInvoices.Notes, Purchase.Data_PurchaseInvoices.CreatedByUserID, 
                      Purchase.Data_PurchaseInvoices.CreatedByUserName, Purchase.Data_PurchaseInvoices.Createddate, Purchase.Data_PurchaseInvoices.modifiedByUserID, 
                      Purchase.Data_PurchaseInvoices.modifiedByUserName, Purchase.Data_PurchaseInvoices.modifiedDate, MyCompany.RefDocumentTypes.DocumentTypeCaption, 
                      Purchase.Data_Suppliers.SupplierName, Purchase.Data_Suppliers.ContactPersonName, Purchase.Data_Suppliers.SupplierAddress, 
                      Purchase.Data_Suppliers.SupplierAddress2, Purchase.Data_Suppliers.SupplierAccountCurrentBalance, MyCompany.RefCurrencies.CurrencyName, 
                      MyCompany.RefCurrencies.CurrencyRate, MyCompany.RefCurrencies.CurrencySymbol, MyCompany.RefPaymentMethods.PaymentMethodCaption, 
                      MyCompany.RefPaymentMethods.CurrencyID_FK, Purchase.RefPurchaseInvoiceStates.PurchaseInvoiceStateCaption, Purchase.Data_Suppliers.SupplierPhone, 
                      Purchase.Data_Suppliers.SupplierMobilePhone, Purchase.Data_Suppliers.SupplierFax, Purchase.Data_Suppliers.SupplierEmail, 
                      MyCompany.RefCurrencies.CurrencyScale, Purchase.Data_PurchaseInvoices.IsSalesPricesReviewed, Purchase.Data_PurchaseInvoices.LocationID_FK, 
                      MyCompany.Config_BranchLocations.LocationName, MyCompany.Config_BranchLocations.LocationAddress, MyCompany.Config_BranchLocations.LocationCode, 
                      Purchase.Data_PurchaseInvoices.SalePersonID_FK, SALES.Config_SalePersons.SalePersonName, SALES.Config_SalePersons.SalePersonPhone, 
                      Purchase.Data_PurchaseInvoices.SourceInvoiceID_FK
FROM         Purchase.Data_PurchaseInvoices INNER JOIN
                      MyCompany.RefCurrencies ON Purchase.Data_PurchaseInvoices.InvoiceCurrencyID_FK = MyCompany.RefCurrencies.CurrencyID_PK INNER JOIN
                      MyCompany.RefDocumentTypes ON Purchase.Data_PurchaseInvoices.DocumentTypeID_FK = MyCompany.RefDocumentTypes.DocumentTypeID_PK INNER JOIN
                      MyCompany.RefPaymentMethods ON Purchase.Data_PurchaseInvoices.InvoicePaymentID_FK = MyCompany.RefPaymentMethods.PaymentMethodID_PK INNER JOIN
                      Purchase.Data_Suppliers ON Purchase.Data_PurchaseInvoices.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK INNER JOIN
                      Purchase.RefPurchaseInvoiceStates ON 
                      Purchase.Data_PurchaseInvoices.PurchaseInvoiceStateID_PK = Purchase.RefPurchaseInvoiceStates.PurchaseInvoiceStateID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON Purchase.Data_PurchaseInvoices.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK LEFT OUTER JOIN
                      SALES.Config_SalePersons ON Purchase.Data_PurchaseInvoices.SalePersonID_FK = SALES.Config_SalePersons.SalePersonID_PK;


-- Purchase.Data_View_PurchaseOrders source

ALTER VIEW Purchase.Data_View_PurchaseOrders
AS
SELECT     Purchase.Data_PurchaseOrders.*, Purchase.Data_Suppliers.SupplierName
FROM         Purchase.Data_PurchaseOrders INNER JOIN
                      Purchase.Data_Suppliers ON Purchase.Data_PurchaseOrders.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK;


-- Purchase.Data_View_SupplierDiscountItems source

ALTER VIEW [Purchase].[Data_View_SupplierDiscountItems]
AS
SELECT     Purchase.Data_SupplierDiscountItems.*, Inventory.RefUOMs.UOMName, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName
FROM         Inventory.Data_Products INNER JOIN
                      Purchase.Data_SupplierDiscountItems ON Inventory.Data_Products.ProductID_PK = Purchase.Data_SupplierDiscountItems.ProductID_FK INNER JOIN
                      Inventory.RefUOMs ON Purchase.Data_SupplierDiscountItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK;


-- Purchase.Data_View_SupplierDiscounts source

ALTER VIEW [Purchase].[Data_View_SupplierDiscounts]
AS
SELECT     Purchase.Data_SupplierDiscounts.DiscountInvoiceID_PK, Purchase.Data_SupplierDiscounts.BranchID_FK, Purchase.Data_SupplierDiscounts.DocumentTypeID_FK, 
                      Purchase.Data_SupplierDiscounts.DocumentStateID_FK, Purchase.Data_SupplierDiscounts.SupplierID_FK, Purchase.Data_SupplierDiscounts.SalePersonID_FK, 
                      Purchase.Data_SupplierDiscounts.DiscountInvoiceNumber, Purchase.Data_SupplierDiscounts.DiscountInvoiceDate, 
                      Purchase.Data_SupplierDiscounts.TotalDiscountAmount, Purchase.Data_SupplierDiscounts.DiscountInvoiceNote, 
                      Purchase.Data_SupplierDiscounts.CreatedByUserID, Purchase.Data_SupplierDiscounts.CreatedByUserName, Purchase.Data_SupplierDiscounts.CreatedDate, 
                      Purchase.Data_SupplierDiscounts.ModifiedByUserID, Purchase.Data_SupplierDiscounts.ModifiedByUserName, Purchase.Data_SupplierDiscounts.ModifiedDate, 
                      Purchase.Data_Suppliers.AccountID_FK, Purchase.Data_Suppliers.SupplierName, MyCompany.RefDocumentTypes.DocumentTypeCaption, 
                      MyCompany.RefDocumentStates.DocumentStateCaption, SALES.Config_SalePersons.SalePersonName,Purchase.Data_SupplierDiscounts.JournalEntryID_FK
FROM         Purchase.Data_SupplierDiscounts INNER JOIN
                      Purchase.Data_Suppliers ON Purchase.Data_SupplierDiscounts.SupplierID_FK = Purchase.Data_Suppliers.SupplierID_PK INNER JOIN
                      MyCompany.RefDocumentTypes ON Purchase.Data_SupplierDiscounts.DocumentTypeID_FK = MyCompany.RefDocumentTypes.DocumentTypeID_PK INNER JOIN
                      MyCompany.RefDocumentStates ON 
                      Purchase.Data_SupplierDiscounts.DocumentStateID_FK = MyCompany.RefDocumentStates.DocumentStateID_PK LEFT OUTER JOIN
                      SALES.Config_SalePersons ON Purchase.Data_SupplierDiscounts.SalePersonID_FK = SALES.Config_SalePersons.SalePersonID_PK;


-- Purchase.Data_View_Suppliers source

ALTER VIEW [Purchase].[Data_View_Suppliers]
AS
SELECT     Purchase.Data_Suppliers.SupplierID_PK, Purchase.Data_Suppliers.SupplierName, Purchase.Data_Suppliers.SupplierAddress, 
                      Purchase.Data_Suppliers.SupplierAddress2, Purchase.Data_Suppliers.SupplierCategoryID_FK, Purchase.Data_Suppliers.SupplierPhone, 
                      Purchase.Data_Suppliers.SupplierFax, Purchase.Data_Suppliers.SupplierEmail, Purchase.Data_Suppliers.DefaultCurrencyID_FK, 
                      Purchase.Data_Suppliers.CreatedByUserID, Purchase.Data_Suppliers.CreatedByUserName, Purchase.Data_Suppliers.CreatedDate, 
                      Purchase.Data_Suppliers.ModifiedByUserID, Purchase.Data_Suppliers.ModifiedByUserName, Purchase.Data_Suppliers.ModifiedDate, 
                      Purchase.Data_Suppliers.SupplierMobilePhone, Purchase.Data_Suppliers.ContactPersonName, Purchase.Data_Suppliers.IsActiveAccount, 
                      Purchase.Data_Suppliers.LastOrderTransactionDate, Purchase.Data_Suppliers.LastReceiveTransactionDate, 
                      Purchase.Data_Suppliers.SupplierAccountCurrentBalance, MyCompany.RefCurrencies.CurrencyName, MyCompany.RefCurrencies.CurrencySymbol, 
                      MyCompany.RefCurrencies.CurrencyRate, MyCompany.RefCurrencies.CurrencyScale, Purchase.Data_Suppliers.AccountID_FK, 
                      Purchase.Data_Suppliers.IsAllowCreditPurchase, SALES.RefCustomerCategories.CustomerCategoryCaption
FROM         Purchase.Data_Suppliers INNER JOIN
                      MyCompany.RefCurrencies ON Purchase.Data_Suppliers.DefaultCurrencyID_FK = MyCompany.RefCurrencies.CurrencyID_PK LEFT OUTER JOIN
                      SALES.RefCustomerCategories ON Purchase.Data_Suppliers.SupplierCategoryID_FK = SALES.RefCustomerCategories.CustomerCategoryID_PK;

-- DROP SCHEMA SALES;

CREATE SCHEMA SALES;
-- InfinityRetailDB.SALES.Config_SalePersons definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Config_SalePersons;

CREATE TABLE InfinityRetailDB.SALES.Config_SalePersons (
	SalePersonID_PK int IDENTITY(1,1) NOT NULL,
	SalePersonName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	SalePersonPhone nvarchar(20) COLLATE Arabic_CI_AS NULL,
	SalePersonAddress nvarchar(150) COLLATE Arabic_CI_AS NULL,
	Is_PurchasePerson bit DEFAULT 0 NOT NULL,
	Is_SalesPerson bit DEFAULT 1 NOT NULL,
	SyncDate datetime NULL,
	CONSTRAINT PK_Config_SalePersons PRIMARY KEY (SalePersonID_PK)
);


-- InfinityRetailDB.SALES.RefCustomerCategories definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.RefCustomerCategories;

CREATE TABLE InfinityRetailDB.SALES.RefCustomerCategories (
	CustomerCategoryID_PK int IDENTITY(1,1) NOT NULL,
	CustomerCategoryCaption nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	AccountSubGroupID_FK smallint DEFAULT 3 NOT NULL,
	CONSTRAINT PK_RefCustomerCategories PRIMARY KEY (CustomerCategoryID_PK)
);


-- InfinityRetailDB.SALES.RefCustomerPriceTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.RefCustomerPriceTypes;

CREATE TABLE InfinityRetailDB.SALES.RefCustomerPriceTypes (
	CustomerPriceTypeID_PK tinyint NOT NULL,
	CustomerPriceTypeCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefCustomerPriceTypes PRIMARY KEY (CustomerPriceTypeID_PK)
);


-- InfinityRetailDB.SALES.RefSalesInvoiceStates definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.RefSalesInvoiceStates;

CREATE TABLE InfinityRetailDB.SALES.RefSalesInvoiceStates (
	SalesInvoiceStateID_PK smallint NOT NULL,
	SalesInvoiceStateCaption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefSalesInvoiceStates PRIMARY KEY (SalesInvoiceStateID_PK)
);


-- InfinityRetailDB.SALES.Config_Discounts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Config_Discounts;

CREATE TABLE InfinityRetailDB.SALES.Config_Discounts (
	DiscountID_PK int IDENTITY(1,1) NOT NULL,
	DiscountTypeID_FK tinyint NOT NULL,
	DiscountDescription nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	DiscountValue decimal(6,3) NOT NULL,
	DiscountMaxValue decimal(6,3) DEFAULT 0 NOT NULL,
	IsFixedDiscount bit NOT NULL,
	IsRequestCustomer bit NOT NULL,
	MinAmountToApply decimal(15,3) NOT NULL,
	IsUsedPerItem bit NOT NULL,
	IsUsedPerTransaction bit NOT NULL,
	IsActive bit NOT NULL,
	RoundDiscountTotalCeiling decimal(6,3) NOT NULL,
	RoundDiscountTotalToUp bit NOT NULL,
	CONSTRAINT PK_Config_Discounts PRIMARY KEY (DiscountID_PK)
);


-- InfinityRetailDB.SALES.Data_CustomerPaymentAppointments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments;

CREATE TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments (
	CustomerPAppointmentID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	PAppointmentDate datetime NOT NULL,
	PAppointmentDescription nvarchar(100) COLLATE Arabic_CI_AS NULL,
	CustomerID_FK int NOT NULL,
	SalesInvoiceID_FK int NULL,
	SalesInvoiceNumber nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	PaymentAmount decimal(12,3) NOT NULL,
	IsDone bit NOT NULL,
	PaymentVoucherID_FK int NULL,
	CONSTRAINT PK_Data_CustomerPaymentAppointments PRIMARY KEY (CustomerPAppointmentID_PK)
);


-- InfinityRetailDB.SALES.Data_CustomerPhotos definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_CustomerPhotos;

CREATE TABLE InfinityRetailDB.SALES.Data_CustomerPhotos (
	CustomerPhotoID_PK int IDENTITY(1,1) NOT NULL,
	CustomerID_FK int NOT NULL,
	CustomerPhoto image NOT NULL,
	CONSTRAINT PK_Data_CustomerPhotos PRIMARY KEY (CustomerPhotoID_PK)
);


-- InfinityRetailDB.SALES.Data_Customers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_Customers;

CREATE TABLE InfinityRetailDB.SALES.Data_Customers (
	CustomerID_PK int IDENTITY(1,1) NOT NULL,
	AccountID_FK int NULL,
	CustomerCategoryID_FK int DEFAULT 1 NOT NULL,
	CustomerCompanyID_FK int NOT NULL,
	SalesPersonID_FK int DEFAULT 0 NOT NULL,
	MemberShipCode nvarchar(250) COLLATE Arabic_CI_AS NULL,
	CustomerName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CustomerDOB datetime NULL,
	CustomerAddressLine1 nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CustomerAddressLine2 nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CustomerAddressLine3 nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CustomerPhone nvarchar(20) COLLATE Arabic_CI_AS NULL,
	CustomerMobilePhone nvarchar(20) COLLATE Arabic_CI_AS NULL,
	CustomerFaxNumber nvarchar(20) COLLATE Arabic_CI_AS NULL,
	CustomerEmail nvarchar(50) COLLATE Arabic_CI_AS NULL,
	CustomerSkype nvarchar(50) COLLATE Arabic_CI_AS NULL,
	IsActiveAccount bit DEFAULT 1 NOT NULL,
	CustomerPriceTypeID_FK tinyint NOT NULL,
	CustomerPricePercentage tinyint NOT NULL,
	IsAllowCreditSales bit NOT NULL,
	CustomerCreditLimitValue decimal(10,3) DEFAULT 0 NOT NULL,
	CustomerCreditLimitAction tinyint NOT NULL,
	CustomerOutstanding decimal(10,3) DEFAULT 0 NOT NULL,
	CustomerPoints int DEFAULT 0 NOT NULL,
	IsEntitlePoints bit NOT NULL,
	CustomerExtraInformation1 nvarchar(100) COLLATE Arabic_CI_AS NULL,
	CustomerExtraInformation2 nvarchar(100) COLLATE Arabic_CI_AS NULL,
	CustomerExtraInformation3 nvarchar(100) COLLATE Arabic_CI_AS NULL,
	CustomerNote nvarchar(1000) COLLATE Arabic_CI_AS NULL,
	LastSalesTransactionDate datetime NULL,
	LastRefundTransactionDate datetime NULL,
	LastOrderTransactionDate datetime NULL,
	AccountLastActivationDate datetime NULL,
	AccountLastDeActivationDate datetime NULL,
	TotalSalesAmount decimal(10,3) DEFAULT 0 NOT NULL,
	TotalInvoicesCount int DEFAULT 0 NOT NULL,
	OverallInvoiceAverage decimal(10,3) DEFAULT 0 NOT NULL,
	TotalDiscountAmount decimal(10,3) DEFAULT 0 NOT NULL,
	TotalRefundAmount decimal(10,3) DEFAULT 0 NOT NULL,
	IsUsePrePaidCard bit DEFAULT 0 NOT NULL,
	IsPrePaidCardExpiryDate bit DEFAULT 0 NOT NULL,
	PrePaidCardExpiryDate datetime NULL,
	AccountExpiryDate datetime NULL,
	CONSTRAINT PK_Data_Customers PRIMARY KEY (CustomerID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_Customers_CustomerName ON InfinityRetailDB.SALES.Data_Customers (  CustomerName ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.SALES.Data_SalesInvoiceItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesInvoiceItems;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesInvoiceItems (
	SalesInvoiceItemID_PK bigint IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) NOT NULL,
	DiscountAmount decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	ItemNote nvarchar(250) COLLATE Arabic_CI_AS NULL,
	IsQYTDelivered bit NOT NULL,
	TotalSalesPoints int DEFAULT 0 NOT NULL,
	SerialNo nvarchar(4000) COLLATE Arabic_CI_AS NULL,
	PackageUnitID_FK smallint NULL,
	PackageUnitBaseQYT decimal(10,3) NULL,
	CONSTRAINT PK_Data_SalesInvoiceItems PRIMARY KEY (SalesInvoiceItemID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoiceItems_IsQYTDelivered ON InfinityRetailDB.SALES.Data_SalesInvoiceItems (  IsQYTDelivered ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoiceItems_ProductID_FK ON InfinityRetailDB.SALES.Data_SalesInvoiceItems (  ProductID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoiceItems_SalesInvoiceID_FK ON InfinityRetailDB.SALES.Data_SalesInvoiceItems (  SalesInvoiceID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.SALES.Data_SalesInvoicePayments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesInvoicePayments;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesInvoicePayments (
	SalesInvoicePaymentID_PK int IDENTITY(1,1) NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	PaymentMethodID_FK smallint NOT NULL,
	CurrencyXchangeRate decimal(10,5) NOT NULL,
	PaymentAmount decimal(15,3) NOT NULL,
	LocCurrencyPaymentAmount decimal(15,3) NOT NULL,
	PaymentNote nvarchar(500) COLLATE Arabic_CI_AS NULL,
	EPaymentTerminalID_FK int NULL,
	EPaymentTransactionReference nvarchar(20) COLLATE Arabic_CI_AS NULL,
	EPaymentVoucherAmount decimal(15,3) NULL,
	EPaymentVoucherLocCurrencyAmount decimal(15,3) NULL,
	EPaymentVoucherNote nvarchar(25) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_SalesInvoicePayments PRIMARY KEY (SalesInvoicePaymentID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoicePayments_PaymentMethodID_FK ON InfinityRetailDB.SALES.Data_SalesInvoicePayments (  PaymentMethodID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoicePayments_SalesInvoiceID_FK ON InfinityRetailDB.SALES.Data_SalesInvoicePayments (  SalesInvoiceID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.SALES.Data_SalesInvoiceRefundSource definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesInvoiceRefundSource;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesInvoiceRefundSource (
	SalesInvoiceItemID_PK bigint NOT NULL,
	SalesInvoiceID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	DiscountPersentage decimal(6,3) NOT NULL,
	DiscountAmount decimal(12,3) NOT NULL,
	ExpireDate datetime NULL,
	ItemNote nvarchar(250) COLLATE Arabic_CI_AS NULL,
	IsQYTDelivered bit NOT NULL,
	CONSTRAINT PK_Data_SalesInvoiceRefundSource PRIMARY KEY (SalesInvoiceItemID_PK)
);


-- InfinityRetailDB.SALES.Data_SalesInvoices definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesInvoices;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesInvoices (
	SalesInvoiceID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	WsID_FK tinyint NOT NULL,
	POSTerminalShiftID_FK int NULL,
	SalesInvoiceDate datetime NOT NULL,
	CustomerID_FK int NOT NULL,
	CashCustomerName nvarchar(75) COLLATE Arabic_CI_AS NULL,
	SalePersonID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	SalesInvoiceStateID_FK smallint NOT NULL,
	InvoiceNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceSubTotal decimal(15,3) NOT NULL,
	InvoiceDiscountTotal decimal(15,3) NOT NULL,
	InvoiceNetTotal decimal(15,3) NOT NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	PaymentCount tinyint NOT NULL,
	PaymentCaption nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	Cash decimal(15,3) NOT NULL,
	[Change] decimal(15,3) NOT NULL,
	TransactionBarcode nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	CreatedByUserID smallint NOT NULL,
	CreatedByUserName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	Createddate datetime DEFAULT GETDATE() NOT NULL,
	modifiedByUserID smallint NULL,
	modifiedByUserName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	modifiedDate datetime NULL,
	OrderNumber int DEFAULT 0 NOT NULL,
	OrderType nvarchar(10) COLLATE Arabic_CI_AS NULL,
	CustomerPriceTypeID_FK int DEFAULT 1 NOT NULL,
	CustomerDiscountDefaultValue decimal(15,3) DEFAULT 0 NOT NULL,
	CustomerDiscountUsedAsPersentage bit DEFAULT 0 NOT NULL,
	LocationID_FK int DEFAULT 1 NOT NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	SourceInvoiceID_FK int NULL,
	DeliveryNotePrintCount int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Data_SalesInvoices PRIMARY KEY (SalesInvoiceID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_CustomerID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  CustomerID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_DocumentTypeID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  DocumentTypeID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_InvoiceNumber ON InfinityRetailDB.SALES.Data_SalesInvoices (  InvoiceNumber ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_LocationID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  LocationID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_POSTerminalShiftID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  POSTerminalShiftID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_SalesInvoiceDate ON InfinityRetailDB.SALES.Data_SalesInvoices (  SalesInvoiceDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_SalesInvoiceStateID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  SalesInvoiceStateID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_SalesInvoices_SourceInvoiceID_FK ON InfinityRetailDB.SALES.Data_SalesInvoices (  SourceInvoiceID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.SALES.Data_SalesOrderActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesOrderActions;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesOrderActions (
	SalesOrderActionID_PK int IDENTITY(1,1) NOT NULL,
	SalesOrderID_FK int NOT NULL,
	ActionID int NOT NULL,
	CurrentDocumentStateID_FK smallint NOT NULL,
	Description nvarchar(200) COLLATE Arabic_CI_AS NOT NULL,
	ActionDate datetime NOT NULL,
	UserID int NOT NULL,
	UserName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_SalesOrderActions PRIMARY KEY (SalesOrderActionID_PK)
);


-- InfinityRetailDB.SALES.Data_SalesOrderItems definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesOrderItems;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesOrderItems (
	SalesOrderItemID_PK bigint IDENTITY(1,1) NOT NULL,
	SalesOrderID_FK int NOT NULL,
	ProductID_FK bigint NOT NULL,
	QYT decimal(10,3) NOT NULL,
	UnitID_FK smallint NOT NULL,
	UnitBaseQYT decimal(10,3) NOT NULL,
	UnitCost decimal(12,3) NOT NULL,
	UnitPrice decimal(12,3) NOT NULL,
	SubTotal decimal(12,3) NOT NULL,
	Note nvarchar(250) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_SalesOrderItems PRIMARY KEY (SalesOrderItemID_PK)
);


-- InfinityRetailDB.SALES.Data_SalesOrderPayments definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesOrderPayments;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesOrderPayments (
	SalesOrderPaymentID_PK int IDENTITY(1,1) NOT NULL,
	SalesOrderID_FK int NOT NULL,
	PaymentMethodID_FK smallint NOT NULL,
	PaymentAmount decimal(15,3) NOT NULL,
	PaymentDate datetime NOT NULL,
	PaymentNote nvarchar(500) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_SalesOrderPayments PRIMARY KEY (SalesOrderPaymentID_PK)
);


-- InfinityRetailDB.SALES.Data_SalesOrders definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SALES.Data_SalesOrders;

CREATE TABLE InfinityRetailDB.SALES.Data_SalesOrders (
	SalesOrderID_PK int IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	DocumentTypeID_FK tinyint NOT NULL,
	DocumentStateID_FK smallint NOT NULL,
	OrderSubTotal decimal(15,3) NOT NULL,
	OrderNumber nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	OrderDate datetime NOT NULL,
	DeliveryDate datetime NOT NULL,
	DeliveryAddress nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CustomerName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CustomerPhone1 nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	CustomerPhone2 nvarchar(20) COLLATE Arabic_CI_AS NULL,
	CustomerAddress nvarchar(50) COLLATE Arabic_CI_AS NULL,
	Notes nvarchar(500) COLLATE Arabic_CI_AS NULL,
	OrderDescription nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	OrderQYT decimal(10,3) NOT NULL,
	CONSTRAINT PK_Data_SalesOrders PRIMARY KEY (SalesOrderID_PK)
);


-- InfinityRetailDB.SALES.Config_Discounts foreign keys

ALTER TABLE InfinityRetailDB.SALES.Config_Discounts ADD CONSTRAINT FK_Config_Discounts_RefDiscountTypes FOREIGN KEY (DiscountTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDiscountTypes(DiscountTypeID_PK);


-- InfinityRetailDB.SALES.Data_CustomerPaymentAppointments foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments ADD CONSTRAINT FK_Data_CustomerPaymentAppointments_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments ADD CONSTRAINT FK_Data_CustomerPaymentAppointments_Data_Customers FOREIGN KEY (CustomerID_FK) REFERENCES InfinityRetailDB.SALES.Data_Customers(CustomerID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments ADD CONSTRAINT FK_Data_CustomerPaymentAppointments_Data_PaymentVouchers FOREIGN KEY (PaymentVoucherID_FK) REFERENCES InfinityRetailDB.Financial.Data_PaymentVouchers(PaymentVoucherID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_CustomerPaymentAppointments ADD CONSTRAINT FK_Data_CustomerPaymentAppointments_Data_SalesInvoices FOREIGN KEY (SalesInvoiceID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesInvoices(SalesInvoiceID_PK);


-- InfinityRetailDB.SALES.Data_CustomerPhotos foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_CustomerPhotos ADD CONSTRAINT FK_Data_CustomerPhotos_Data_Customers FOREIGN KEY (CustomerID_FK) REFERENCES InfinityRetailDB.SALES.Data_Customers(CustomerID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.SALES.Data_Customers foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_Customers ADD CONSTRAINT FK_Data_Customers_Config_SalePersons FOREIGN KEY (SalesPersonID_FK) REFERENCES InfinityRetailDB.SALES.Config_SalePersons(SalePersonID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_Customers ADD CONSTRAINT FK_Data_Customers_Data_Accounts FOREIGN KEY (AccountID_FK) REFERENCES InfinityRetailDB.Financial.Data_Accounts(AccountID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_Customers ADD CONSTRAINT FK_Data_Customers_RefCustomerCategories FOREIGN KEY (CustomerCategoryID_FK) REFERENCES InfinityRetailDB.SALES.RefCustomerCategories(CustomerCategoryID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_Customers ADD CONSTRAINT FK_Data_Customers_RefCustomerPriceTypes FOREIGN KEY (CustomerPriceTypeID_FK) REFERENCES InfinityRetailDB.SALES.RefCustomerPriceTypes(CustomerPriceTypeID_PK);


-- InfinityRetailDB.SALES.Data_SalesInvoiceItems foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoiceItems ADD CONSTRAINT FK_Data_SalesInvoiceItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoiceItems ADD CONSTRAINT FK_Data_SalesInvoiceItems_Data_SalesInvoices FOREIGN KEY (SalesInvoiceID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesInvoices(SalesInvoiceID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoiceItems ADD CONSTRAINT FK_Data_SalesInvoiceItems_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.SALES.Data_SalesInvoicePayments foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoicePayments ADD CONSTRAINT FK_Data_SalesInvoicePayments_Config_EPaymentTerminals FOREIGN KEY (EPaymentTerminalID_FK) REFERENCES InfinityRetailDB.SysConfig.Config_EPaymentTerminals(EPaymentTerminalID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoicePayments ADD CONSTRAINT FK_Data_SalesInvoicePayments_Data_SalesInvoices FOREIGN KEY (SalesInvoiceID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesInvoices(SalesInvoiceID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoicePayments ADD CONSTRAINT FK_Data_SalesInvoicePayments_RefPaymentMethods FOREIGN KEY (PaymentMethodID_FK) REFERENCES InfinityRetailDB.MyCompany.RefPaymentMethods(PaymentMethodID_PK);


-- InfinityRetailDB.SALES.Data_SalesInvoiceRefundSource foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoiceRefundSource ADD CONSTRAINT FK_Data_SalesInvoiceRefundSource_Data_SalesInvoiceItems FOREIGN KEY (SalesInvoiceItemID_PK) REFERENCES InfinityRetailDB.SALES.Data_SalesInvoiceItems(SalesInvoiceItemID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.SALES.Data_SalesInvoices foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_Config_SalePersons FOREIGN KEY (SalePersonID_FK) REFERENCES InfinityRetailDB.SALES.Config_SalePersons(SalePersonID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_Data_Customers FOREIGN KEY (CustomerID_FK) REFERENCES InfinityRetailDB.SALES.Data_Customers(CustomerID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_Data_POSTerminalShifts FOREIGN KEY (POSTerminalShiftID_FK) REFERENCES InfinityRetailDB.POS.Data_POSTerminalShifts(POSTerminalShiftID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesInvoices ADD CONSTRAINT FK_Data_SalesInvoices_RefSalesInvoiceStates FOREIGN KEY (SalesInvoiceStateID_FK) REFERENCES InfinityRetailDB.SALES.RefSalesInvoiceStates(SalesInvoiceStateID_PK);


-- InfinityRetailDB.SALES.Data_SalesOrderActions foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderActions ADD CONSTRAINT Sales_FK_Data_SalesOrderActions_Data_SalesOrders FOREIGN KEY (SalesOrderID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesOrders(SalesOrderID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderActions ADD CONSTRAINT Sales_FK_Data_SalesOrderActions_RefDocumentStates FOREIGN KEY (CurrentDocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);


-- InfinityRetailDB.SALES.Data_SalesOrderItems foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderItems ADD CONSTRAINT Sales_FK_Data_SalesOrderItems_Data_Products FOREIGN KEY (ProductID_FK) REFERENCES InfinityRetailDB.Inventory.Data_Products(ProductID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderItems ADD CONSTRAINT Sales_FK_Data_SalesOrderItems_Data_SalesOrders FOREIGN KEY (SalesOrderID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesOrders(SalesOrderID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderItems ADD CONSTRAINT Sales_FK_Data_SalesOrderItems_RefUOMs FOREIGN KEY (UnitID_FK) REFERENCES InfinityRetailDB.Inventory.RefUOMs(UOMID_PK);


-- InfinityRetailDB.SALES.Data_SalesOrderPayments foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderPayments ADD CONSTRAINT Sales_FK_Data_SalesOrderPayments_Data_SalesOrders FOREIGN KEY (SalesOrderID_FK) REFERENCES InfinityRetailDB.SALES.Data_SalesOrders(SalesOrderID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrderPayments ADD CONSTRAINT Sales_FK_Data_SalesOrderPayments_RefPaymentMethods FOREIGN KEY (PaymentMethodID_FK) REFERENCES InfinityRetailDB.MyCompany.RefPaymentMethods(PaymentMethodID_PK);


-- InfinityRetailDB.SALES.Data_SalesOrders foreign keys

ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrders ADD CONSTRAINT Sales_FK_Data_SalesOrders_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrders ADD CONSTRAINT Sales_FK_Data_SalesOrders_RefDocumentStates FOREIGN KEY (DocumentStateID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentStates(DocumentStateID_PK);
ALTER TABLE InfinityRetailDB.SALES.Data_SalesOrders ADD CONSTRAINT Sales_FK_Data_SalesOrders_RefDocumentTypes FOREIGN KEY (DocumentTypeID_FK) REFERENCES InfinityRetailDB.MyCompany.RefDocumentTypes(DocumentTypeID_PK);


-- SALES.Config_View_Discounts source

ALTER VIEW SALES.Config_View_Discounts
AS
SELECT     SALES.Config_Discounts.DiscountID_PK, SALES.Config_Discounts.DiscountTypeID_FK, SALES.Config_Discounts.DiscountDescription, 
                      SALES.Config_Discounts.DiscountValue, SALES.Config_Discounts.DiscountMaxValue, SALES.Config_Discounts.IsFixedDiscount, 
                      SALES.Config_Discounts.IsRequestCustomer, SALES.Config_Discounts.MinAmountToApply, SALES.Config_Discounts.IsUsedPerItem, 
                      SALES.Config_Discounts.IsUsedPerTransaction, SALES.Config_Discounts.IsActive, SALES.Config_Discounts.RoundDiscountTotalCeiling, 
                      SALES.Config_Discounts.RoundDiscountTotalToUp, MyCompany.RefDiscountTypes.DiscountTypeCaption
FROM         SALES.Config_Discounts INNER JOIN
                      MyCompany.RefDiscountTypes ON SALES.Config_Discounts.DiscountTypeID_FK = MyCompany.RefDiscountTypes.DiscountTypeID_PK;


-- SALES.Data_View_CustomerPaymentAppointments source

ALTER VIEW [SALES].[Data_View_CustomerPaymentAppointments]
AS 
SELECT     SALES.Data_CustomerPaymentAppointments.CustomerPAppointmentID_PK, SALES.Data_CustomerPaymentAppointments.BranchID_FK, 
                      SALES.Data_CustomerPaymentAppointments.PAppointmentDate, SALES.Data_CustomerPaymentAppointments.PAppointmentDescription, 
                      SALES.Data_CustomerPaymentAppointments.CustomerID_FK, SALES.Data_CustomerPaymentAppointments.SalesInvoiceID_FK, 
                      SALES.Data_CustomerPaymentAppointments.SalesInvoiceNumber, SALES.Data_CustomerPaymentAppointments.PaymentAmount, 
                      SALES.Data_CustomerPaymentAppointments.IsDone, SALES.Data_CustomerPaymentAppointments.PaymentVoucherID_FK, 
                      SALES.Data_CustomerPaymentAppointments.CreatedByUserID, SALES.Data_CustomerPaymentAppointments.CreatedByUserName, 
                      SALES.Data_CustomerPaymentAppointments.CreatedDate, SALES.Data_CustomerPaymentAppointments.ModifiedByUserID, 
                      SALES.Data_CustomerPaymentAppointments.ModifiedByUserName, SALES.Data_CustomerPaymentAppointments.ModifiedDate, 
                      SALES.Data_Customers.CustomerName, SALES.Data_SalesInvoices.InvoiceNumber, SALES.Data_SalesInvoices.SalesInvoiceDate
FROM         SALES.Data_Customers INNER JOIN
                      SALES.Data_CustomerPaymentAppointments ON 
                      SALES.Data_Customers.CustomerID_PK = SALES.Data_CustomerPaymentAppointments.CustomerID_FK LEFT OUTER JOIN
                      SALES.Data_SalesInvoices ON SALES.Data_CustomerPaymentAppointments.SalesInvoiceID_FK = SALES.Data_SalesInvoices.SalesInvoiceID_PK;


-- SALES.Data_View_Customers source

ALTER VIEW [SALES].[Data_View_Customers]
AS
SELECT     SALES.Data_Customers.CustomerID_PK, SALES.Data_Customers.AccountID_FK, SALES.Data_Customers.CustomerCategoryID_FK, 
                      SALES.Data_Customers.CustomerCompanyID_FK, SALES.Data_Customers.SalesPersonID_FK, SALES.Data_Customers.CustomerName, 
                      SALES.Data_Customers.CustomerDOB, SALES.Data_Customers.CustomerAddressLine1, SALES.Data_Customers.CustomerAddressLine2, 
                      SALES.Data_Customers.CustomerAddressLine3, SALES.Data_Customers.CustomerPhone, SALES.Data_Customers.CustomerMobilePhone, 
                      SALES.Data_Customers.CustomerFaxNumber, SALES.Data_Customers.CustomerEmail, SALES.Data_Customers.CustomerSkype, 
                      SALES.Data_Customers.IsActiveAccount, SALES.Data_Customers.CustomerPriceTypeID_FK, SALES.Data_Customers.CustomerPricePercentage, 
                      SALES.Data_Customers.IsAllowCreditSales, SALES.Data_Customers.CustomerCreditLimitValue, SALES.Data_Customers.CustomerCreditLimitAction, 
                      SALES.Data_Customers.CustomerOutstanding, SALES.Data_Customers.CustomerPoints, SALES.Data_Customers.IsEntitlePoints, 
                      SALES.Data_Customers.CustomerExtraInformation1, SALES.Data_Customers.CustomerExtraInformation2, SALES.Data_Customers.CustomerExtraInformation3, 
                      SALES.Data_Customers.CustomerNote, SALES.Data_Customers.LastSalesTransactionDate, SALES.Data_Customers.AccountLastActivationDate, 
                      SALES.Data_Customers.AccountLastDeActivationDate, SALES.Data_Customers.TotalSalesAmount, SALES.Data_Customers.TotalInvoicesCount, 
                      SALES.Data_Customers.OverallInvoiceAverage, SALES.Data_Customers.TotalDiscountAmount, SALES.Data_Customers.TotalRefundAmount, 
                      SALES.Data_Customers.CreatedByUserID, SALES.Data_Customers.CreatedByUserName, SALES.Data_Customers.CreatedDate, 
                      SALES.Data_Customers.ModifiedByUserID, SALES.Data_Customers.ModifiedByUserName, SALES.Data_Customers.ModifiedDate, 
                      SALES.RefCustomerCategories.CustomerCategoryCaption, SALES.Config_SalePersons.SalePersonName, SALES.Config_SalePersons.SalePersonPhone, 
                      SALES.Config_SalePersons.SalePersonAddress, SALES.RefCustomerPriceTypes.CustomerPriceTypeCaption, SALES.Data_Customers.LastRefundTransactionDate, 
                      SALES.Data_Customers.LastOrderTransactionDate, SALES.Data_Customers.MemberShipCode, SALES.Data_Customers.IsUsePrePaidCard, 
                      SALES.Data_Customers.IsPrePaidCardExpiryDate, SALES.Data_Customers.PrePaidCardExpiryDate, SALES.Data_Customers.AccountExpiryDate
FROM         SALES.Data_Customers INNER JOIN
                      SALES.Config_SalePersons ON SALES.Data_Customers.SalesPersonID_FK = SALES.Config_SalePersons.SalePersonID_PK INNER JOIN
                      SALES.RefCustomerCategories ON SALES.Data_Customers.CustomerCategoryID_FK = SALES.RefCustomerCategories.CustomerCategoryID_PK INNER JOIN
                      SALES.RefCustomerPriceTypes ON SALES.Data_Customers.CustomerPriceTypeID_FK = SALES.RefCustomerPriceTypes.CustomerPriceTypeID_PK;


-- SALES.Data_View_SalesInvoiceEPayments source

ALTER VIEW [SALES].[Data_View_SalesInvoiceEPayments]
AS
SELECT     SALES.Data_SalesInvoicePayments.SalesInvoicePaymentID_PK, SALES.Data_SalesInvoicePayments.EPaymentTransactionReference, 
                      SALES.Data_SalesInvoicePayments.EPaymentVoucherAmount, SALES.Data_SalesInvoicePayments.EPaymentVoucherLocCurrencyAmount, 
                      SALES.Data_SalesInvoicePayments.LocCurrencyPaymentAmount, SALES.Data_SalesInvoicePayments.EPaymentVoucherNote, 
                      SALES.Data_SalesInvoicePayments.EPaymentUpdatedByUserName, SALES.Data_SalesInvoicePayments.EPaymentUpdatedByUserID, 
                      SALES.Data_SalesInvoicePayments.EpaymentUpdateddate, SALES.Data_View_SalesInvoices.SalesInvoiceDate, SALES.Data_View_SalesInvoices.BranchName, 
                      SALES.Data_View_SalesInvoices.InvoiceNumber, SALES.Data_View_SalesInvoices.DocumentTypeCaption, 
                      SALES.Data_View_SalesInvoices.SalesInvoiceStateCaption, MyCompany.RefView_PaymentMethods.PaymentMethodTypeCaption, 
                      SALES.Data_SalesInvoicePayments.PaymentMethodID_FK, MyCompany.RefView_PaymentMethods.PaymentMethodCaption, 
                      MyCompany.RefView_PaymentMethods.CurrencyID_FK, MyCompany.RefView_PaymentMethods.CurrencyName, 
                      MyCompany.RefView_PaymentMethods.PaymentMethodTypeID_FK, SALES.Data_View_SalesInvoices.DocumentTypeID_FK, 
                      SALES.Data_View_SalesInvoices.SalesInvoiceStateID_FK, SALES.Data_View_SalesInvoices.SalesInvoiceID_PK, 
                      SALES.Data_SalesInvoicePayments.SalesInvoiceID_FK, SALES.Data_View_SalesInvoices.POSTerminalShiftID_FK, 
                      SysConfig.Config_EPaymentTerminals.EPaymentTerminalNo, SysConfig.Config_EPaymentTerminals.EPaymentTerminalBank, 
                      SALES.Data_SalesInvoicePayments.EPaymentTerminalID_FK,SALES.Data_View_SalesInvoices.LocationID_FK, SALES.Data_View_SalesInvoices.BranchID_FK
FROM         SALES.Data_SalesInvoicePayments INNER JOIN
                      MyCompany.RefView_PaymentMethods ON 
                      SALES.Data_SalesInvoicePayments.PaymentMethodID_FK = MyCompany.RefView_PaymentMethods.PaymentMethodID_PK INNER JOIN
                      SALES.Data_View_SalesInvoices ON SALES.Data_SalesInvoicePayments.SalesInvoiceID_FK = SALES.Data_View_SalesInvoices.SalesInvoiceID_PK LEFT OUTER JOIN
                      SysConfig.Config_EPaymentTerminals ON 
                      SALES.Data_SalesInvoicePayments.EPaymentTerminalID_FK = SysConfig.Config_EPaymentTerminals.EPaymentTerminalID_PK;


-- SALES.Data_View_SalesInvoiceItems source

ALTER VIEW [SALES].[Data_View_SalesInvoiceItems]
AS
SELECT     SALES.Data_SalesInvoiceItems.SalesInvoiceItemID_PK, SALES.Data_SalesInvoiceItems.SalesInvoiceID_FK, SALES.Data_SalesInvoiceItems.ProductID_FK, 
                      SALES.Data_SalesInvoiceItems.QYT, SALES.Data_SalesInvoiceItems.UnitID_FK, SALES.Data_SalesInvoiceItems.UnitBaseQYT, 
                      SALES.Data_SalesInvoiceItems.UnitCost, SALES.Data_SalesInvoiceItems.UnitPrice, SALES.Data_SalesInvoiceItems.SubTotal, 
                      SALES.Data_SalesInvoiceItems.DiscountPersentage, SALES.Data_SalesInvoiceItems.DiscountAmount, SALES.Data_SalesInvoiceItems.ExpireDate, 
                      SALES.Data_SalesInvoiceItems.ItemNote, SALES.Data_SalesInvoiceItems.CreatedByUserID, SALES.Data_SalesInvoiceItems.CreatedByUserName, 
                      SALES.Data_SalesInvoiceItems.Createddate, SALES.Data_SalesInvoiceItems.modifiedByUserID, SALES.Data_SalesInvoiceItems.modifiedByUserName, 
                      SALES.Data_SalesInvoiceItems.modifiedDate, Inventory.Data_Products.ProductCode, Inventory.Data_Products.ProductName, 
                      Inventory.Data_Products.SalesDecription, Inventory.Data_Products.ProductShortName, Inventory.RefUOMs.UOMName, Inventory.Data_Products.ProductTypeID_FK, 
                      SALES.Data_SalesInvoiceItems.IsQYTDelivered, Inventory.Data_Products.LogicalOrderPrinter1ID, Inventory.Data_Products.LogicalOrderPrinter2ID, 
                      Inventory.Data_Products.IsNonDiscountableItem, Inventory.Data_Products.ISCostHidden, Inventory.Data_Products.SalesPoints, 
                      SALES.Data_SalesInvoiceItems.TotalSalesPoints, SALES.Data_SalesInvoiceItems.SerialNo, Inventory.Data_Products.IsHasSerialNO, 
                      SALES.Data_SalesInvoiceItems.PackageUnitID_FK, SALES.Data_SalesInvoiceItems.PackageUnitBaseQYT
FROM         SALES.Data_SalesInvoiceItems INNER JOIN
                      Inventory.Data_Products ON SALES.Data_SalesInvoiceItems.ProductID_FK = Inventory.Data_Products.ProductID_PK INNER JOIN
                      Inventory.RefUOMs ON SALES.Data_SalesInvoiceItems.UnitID_FK = Inventory.RefUOMs.UOMID_PK;


-- SALES.Data_View_SalesInvoicePayments source

ALTER VIEW SALES.Data_View_SalesInvoicePayments
AS
SELECT     SALES.Data_SalesInvoicePayments.SalesInvoicePaymentID_PK, SALES.Data_SalesInvoicePayments.SalesInvoiceID_FK, 
                      SALES.Data_SalesInvoicePayments.PaymentMethodID_FK, SALES.Data_SalesInvoicePayments.CurrencyXchangeRate, 
                      SALES.Data_SalesInvoicePayments.PaymentAmount, SALES.Data_SalesInvoicePayments.LocCurrencyPaymentAmount, 
                      SALES.Data_SalesInvoicePayments.PaymentNote, SALES.Data_SalesInvoicePayments.CreatedByUserID, SALES.Data_SalesInvoicePayments.CreatedByUserName, 
                      SALES.Data_SalesInvoicePayments.Createddate, SALES.Data_SalesInvoicePayments.modifiedByUserID, SALES.Data_SalesInvoicePayments.modifiedByUserName, 
                      SALES.Data_SalesInvoicePayments.modifiedDate, MyCompany.RefView_PaymentMethods.PaymentMethodCaption, 
                      MyCompany.RefView_PaymentMethods.CurrencyID_FK, MyCompany.RefView_PaymentMethods.CurrencyName, 
                      MyCompany.RefView_PaymentMethods.PaymentMethodTypeID_FK, MyCompany.RefView_PaymentMethods.PaymentMethodTypeCaption
FROM         SALES.Data_SalesInvoicePayments INNER JOIN
                      MyCompany.RefView_PaymentMethods ON 
                      SALES.Data_SalesInvoicePayments.PaymentMethodID_FK = MyCompany.RefView_PaymentMethods.PaymentMethodID_PK;


-- SALES.Data_View_SalesInvoiceRefundSource source

ALTER VIEW [SALES].[Data_View_SalesInvoiceRefundSource]
AS
SELECT     SALES.Data_SalesInvoiceRefundSource.SalesInvoiceItemID_PK, SALES.Data_SalesInvoiceRefundSource.SalesInvoiceID_FK, 
                      SALES.Data_SalesInvoiceRefundSource.ProductID_FK, SALES.Data_SalesInvoiceRefundSource.QYT, SALES.Data_SalesInvoiceRefundSource.UnitID_FK, 
                      SALES.Data_SalesInvoiceRefundSource.UnitBaseQYT, SALES.Data_SalesInvoiceRefundSource.UnitCost, SALES.Data_SalesInvoiceRefundSource.UnitPrice, 
                      SALES.Data_SalesInvoiceRefundSource.SubTotal, SALES.Data_SalesInvoiceRefundSource.DiscountPersentage, 
                      SALES.Data_SalesInvoiceRefundSource.DiscountAmount, SALES.Data_SalesInvoiceRefundSource.ExpireDate, SALES.Data_SalesInvoiceRefundSource.ItemNote, 
                      SALES.Data_SalesInvoiceRefundSource.IsQYTDelivered, SALES.Data_SalesInvoiceRefundSource.CreatedByUserID, 
                      SALES.Data_SalesInvoiceRefundSource.CreatedByUserName, SALES.Data_SalesInvoiceRefundSource.Createddate, 
                      SALES.Data_SalesInvoiceRefundSource.modifiedByUserID, SALES.Data_SalesInvoiceRefundSource.modifiedByUserName, 
                      SALES.Data_SalesInvoiceRefundSource.modifiedDate, Inventory.Data_View_Products.ProductCode, Inventory.Data_View_Products.ProductName, 
                      Inventory.RefUOMs.UOMName, Inventory.Data_View_Products.ProductTypeID_FK, Inventory.Data_View_Products.IsNonDiscountableItem
FROM         SALES.Data_SalesInvoiceRefundSource INNER JOIN
                      Inventory.RefUOMs ON SALES.Data_SalesInvoiceRefundSource.UnitID_FK = Inventory.RefUOMs.UOMID_PK INNER JOIN
                      Inventory.Data_View_Products ON SALES.Data_SalesInvoiceRefundSource.ProductID_FK = Inventory.Data_View_Products.ProductID_PK;


-- SALES.Data_View_SalesInvoices source

ALTER VIEW [SALES].[Data_View_SalesInvoices]
AS
SELECT     MyCompany.RefDocumentTypes.DocumentTypeCaption, SALES.RefSalesInvoiceStates.SalesInvoiceStateCaption, SALES.Data_Customers.CustomerName, 
                      SALES.Config_SalePersons.SalePersonName, MyCompany.Config_View_Branchs.BranchName, SALES.Data_SalesInvoices.SalesInvoiceID_PK, 
                      SALES.Data_SalesInvoices.BranchID_FK, SALES.Data_SalesInvoices.SalesInvoiceDate, SALES.Data_SalesInvoices.CustomerID_FK, 
                      SALES.Data_SalesInvoices.CashCustomerName, SALES.Data_SalesInvoices.SalePersonID_FK, SALES.Data_SalesInvoices.DocumentTypeID_FK, 
                      SALES.Data_SalesInvoices.SalesInvoiceStateID_FK, SALES.Data_SalesInvoices.InvoiceNumber, SALES.Data_SalesInvoices.InvoiceSubTotal, 
                      SALES.Data_SalesInvoices.InvoiceDiscountTotal, SALES.Data_SalesInvoices.InvoiceNetTotal, SALES.Data_SalesInvoices.Notes, 
                      SALES.Data_SalesInvoices.WsID_FK, SALES.Data_SalesInvoices.PaymentCount, SALES.Data_SalesInvoices.PaymentCaption, SALES.Data_SalesInvoices.Cash, 
                      SALES.Data_SalesInvoices.Change, SALES.Data_SalesInvoices.TransactionBarcode, SALES.Data_SalesInvoices.CreatedByUserID, 
                      SALES.Data_SalesInvoices.CreatedByUserName, SALES.Data_SalesInvoices.Createddate, SALES.Data_SalesInvoices.modifiedByUserID, 
                      SALES.Data_SalesInvoices.modifiedByUserName, SALES.Data_SalesInvoices.modifiedDate, SALES.Data_SalesInvoices.POSTerminalShiftID_FK, 
                      SALES.Data_SalesInvoices.OrderNumber, SALES.Data_SalesInvoices.OrderType, SALES.Data_SalesInvoices.LocationID_FK, 
                      SALES.Data_SalesInvoices.CustomerPriceTypeID_FK, SALES.Data_SalesInvoices.CustomerDiscountDefaultValue, 
                      SALES.Data_SalesInvoices.CustomerDiscountUsedAsPersentage, POS.Data_POSTerminalShifts.InfinityModule, POS.Data_POSTerminalShifts.OpendByUserName, 
                      POS.Data_POSTerminalShifts.OpenDate, POS.Data_POSTerminalShifts.IsClosed, POS.Data_POSTerminalShifts.IsPosted, SALES.Data_SalesInvoices.IsSynced, 
                      MyCompany.Config_BranchLocations.LocationCode, MyCompany.Config_BranchLocations.LocationName, SALES.Data_SalesInvoices.SourceInvoiceID_FK, 
                      SALES.Data_Customers.CustomerMobilePhone, SALES.Data_SalesInvoices.DeliveryNotePrintCount
FROM         SALES.Data_SalesInvoices INNER JOIN
                      MyCompany.RefDocumentTypes ON SALES.Data_SalesInvoices.DocumentTypeID_FK = MyCompany.RefDocumentTypes.DocumentTypeID_PK INNER JOIN
                      SALES.RefSalesInvoiceStates ON SALES.Data_SalesInvoices.SalesInvoiceStateID_FK = SALES.RefSalesInvoiceStates.SalesInvoiceStateID_PK AND 
                      SALES.Data_SalesInvoices.SalesInvoiceStateID_FK = SALES.RefSalesInvoiceStates.SalesInvoiceStateID_PK AND 
                      SALES.Data_SalesInvoices.SalesInvoiceStateID_FK = SALES.RefSalesInvoiceStates.SalesInvoiceStateID_PK INNER JOIN
                      SALES.Data_Customers ON SALES.Data_SalesInvoices.CustomerID_FK = SALES.Data_Customers.CustomerID_PK AND 
                      SALES.Data_SalesInvoices.CustomerID_FK = SALES.Data_Customers.CustomerID_PK AND 
                      SALES.Data_SalesInvoices.CustomerID_FK = SALES.Data_Customers.CustomerID_PK INNER JOIN
                      SALES.Config_SalePersons ON SALES.Data_SalesInvoices.SalePersonID_FK = SALES.Config_SalePersons.SalePersonID_PK AND 
                      SALES.Data_SalesInvoices.SalePersonID_FK = SALES.Config_SalePersons.SalePersonID_PK AND 
                      SALES.Data_SalesInvoices.SalePersonID_FK = SALES.Config_SalePersons.SalePersonID_PK INNER JOIN
                      MyCompany.Config_View_Branchs ON SALES.Data_SalesInvoices.BranchID_FK = MyCompany.Config_View_Branchs.BranchID_PK INNER JOIN
                      POS.Data_POSTerminalShifts ON SALES.Data_SalesInvoices.POSTerminalShiftID_FK = POS.Data_POSTerminalShifts.POSTerminalShiftID_PK INNER JOIN
                      MyCompany.Config_BranchLocations ON SALES.Data_SalesInvoices.LocationID_FK = MyCompany.Config_BranchLocations.LocationID_PK;

-- DROP SCHEMA SYNC;

CREATE SCHEMA SYNC;
-- InfinityRetailDB.SYNC.Data_ChangesStore definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SYNC.Data_ChangesStore;

CREATE TABLE InfinityRetailDB.SYNC.Data_ChangesStore (
	ChangesStoreID_PK bigint IDENTITY(1,1) NOT NULL,
	[Source] nvarchar(25) COLLATE Arabic_CI_AS NOT NULL,
	[DateTime] datetime NOT NULL,
	Operation char(1) COLLATE Arabic_CI_AS NOT NULL,
	RowId bigint NOT NULL,
	TableName nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	TableSchema nvarchar(25) COLLATE Arabic_CI_AS NOT NULL,
	TSQLQuery nvarchar(MAX) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Data_ChangesStore PRIMARY KEY (ChangesStoreID_PK)
);

-- DROP SCHEMA SysConfig;

CREATE SCHEMA SysConfig;
-- InfinityRetailDB.SysConfig.Config_EPaymentTerminals definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysConfig.Config_EPaymentTerminals;

CREATE TABLE InfinityRetailDB.SysConfig.Config_EPaymentTerminals (
	EPaymentTerminalID_PK int IDENTITY(1,1) NOT NULL,
	EPaymentTerminalNo nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	EPaymentTerminalBank nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Config_EPaymentTerminals PRIMARY KEY (EPaymentTerminalID_PK)
);


-- InfinityRetailDB.SysConfig.Config_Workstations definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysConfig.Config_Workstations;

CREATE TABLE InfinityRetailDB.SysConfig.Config_Workstations (
	WsID_PK tinyint IDENTITY(1,1) NOT NULL,
	BranchID_FK int NOT NULL,
	WsPhysicalAddress nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	WsName nvarchar(250) COLLATE Arabic_CI_AS NOT NULL,
	BarcodeReaderPort nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CashDrawerPort nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CashDrawerPrinterName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	CashDrawerPrinterhDC int NOT NULL,
	DisableToStartNextTransaction bit NOT NULL,
	CustomerDisplayPort nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CustomerDisplayCommandsType nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CustomerDisplay_WellcomMessage nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	DispalyDuringSales nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	DispalyAfterSales nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CustomerDisplay_GoodByMessage nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	ReceiptPrinterName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	ReceiptPrinterhDC int NOT NULL,
	InvoicePrinterName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	InvoicePrinterhDC int NOT NULL,
	LablePrinterName nvarchar(150) COLLATE Arabic_CI_AS NOT NULL,
	LablePrinterhDC int NOT NULL,
	InvoiceSize nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	InvoiceSizeEnableToChangeDuringSales bit NOT NULL,
	MyDefaultPOSScreenID_FK int NOT NULL,
	IsPOSTransactionsClosed bit DEFAULT 0 NOT NULL,
	MyPriceLevel tinyint DEFAULT 1 NOT NULL,
	MyPaymentMethodID_FK nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	IsOutOfOrder bit NOT NULL,
	MyLastInvoiceID_PK int NOT NULL,
	IconSize tinyint NOT NULL,
	HideCommandsIcons bit DEFAULT 0 NOT NULL,
	POS_ItemListFontSize tinyint DEFAULT 16 NOT NULL,
	POS_ScreenButtonsFontSize tinyint DEFAULT 9 NOT NULL,
	POS_CommandButtonsFontSize tinyint DEFAULT 9 NOT NULL,
	POS_TotalsFontSize tinyint DEFAULT 20 NOT NULL,
	POS_BranchHeadFontSize tinyint DEFAULT 26 NOT NULL,
	POS_ItemListFontName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'Adobe Arabic' NOT NULL,
	POS_ScreenButtonsFontName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'Tahoma' NOT NULL,
	POS_CommandButtonsFontName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'Tahoma' NOT NULL,
	POS_TotalsFontName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'Adobe Arabic' NOT NULL,
	POS_BranchHeadFontName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT N'Adobe Arabic' NOT NULL,
	A4InvoicePaperSource tinyint DEFAULT 0 NOT NULL,
	A5InvoicePaperSource tinyint DEFAULT 0 NOT NULL,
	PaymentReceiptPaperSize nvarchar(15) COLLATE Arabic_CI_AS DEFAULT N'A5_SIZE' NOT NULL,
	PaymentReceiptPaperSource tinyint DEFAULT 0 NOT NULL,
	ReceiptPrinter2Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	PrintReceipt2AsSummary bit DEFAULT 0 NOT NULL,
	MyProductGroupID_FK int DEFAULT 0 NOT NULL,
	OrderPrinter1Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter2Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter3Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter4Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter5Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	CustomerDisplay_WellcomMessage2 nvarchar(20) COLLATE Arabic_CI_AS DEFAULT N'' NOT NULL,
	LocationID_FK int DEFAULT 1 NOT NULL,
	OrderPrinter6Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter7Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter8Name nvarchar(150) COLLATE Arabic_CI_AS DEFAULT N'NON' NOT NULL,
	OrderPrinter1PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter2PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter3PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter4PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter5PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter6PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter7PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	OrderPrinter8PrintCustomerCopy bit DEFAULT 0 NOT NULL,
	MaxHoldInvoicesCount int DEFAULT 10 NOT NULL,
	HoldInvoicesAccessLevel int DEFAULT 1 NOT NULL,
	RejectAccessToOtherPOSHeldInvoices bit DEFAULT 0 NOT NULL,
	PrintHoldTransactionAsOrder bit DEFAULT 0 NOT NULL,
	SupportUnPostedTransactionOrderNumber bit DEFAULT 0 NOT NULL,
	CONSTRAINT IX_Config_Workstations UNIQUE (WsPhysicalAddress),
	CONSTRAINT PK_Config_Workstations PRIMARY KEY (WsID_PK)
);


-- InfinityRetailDB.SysConfig.ScaleDevice definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysConfig.ScaleDevice;

CREATE TABLE InfinityRetailDB.SysConfig.ScaleDevice (
	ScaleDeviceID_PK int IDENTITY(1,1) NOT NULL,
	ScaleDeviceName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	BranchID_FK int NOT NULL,
	DepartmentID_FK int NOT NULL,
	ScaleType nvarchar(50) COLLATE Arabic_CI_AS NULL,
	ScaleIPTCP nvarchar(15) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_ScaleDevice PRIMARY KEY (ScaleDeviceID_PK)
);


-- InfinityRetailDB.SysConfig.Config_Workstations foreign keys

ALTER TABLE InfinityRetailDB.SysConfig.Config_Workstations ADD CONSTRAINT FK_Config_Workstations_Config_BranchLocations FOREIGN KEY (LocationID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_BranchLocations(LocationID_PK);


-- InfinityRetailDB.SysConfig.ScaleDevice foreign keys

ALTER TABLE InfinityRetailDB.SysConfig.ScaleDevice ADD CONSTRAINT FK_ScaleDevice_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);

-- DROP SCHEMA SysPermissions;

CREATE SCHEMA SysPermissions;
-- InfinityRetailDB.SysPermissions.Data_UserSessions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Data_UserSessions;

CREATE TABLE InfinityRetailDB.SysPermissions.Data_UserSessions (
	SessionID_PK bigint IDENTITY(1,1) NOT NULL,
	UserID_FK int NOT NULL,
	LoginPC nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	LoginModule tinyint NOT NULL,
	SessionLoginTime datetime NOT NULL,
	SessionLogOutTime datetime NOT NULL,
	CONSTRAINT PK_Data_UserSessions PRIMARY KEY (SessionID_PK)
);


-- InfinityRetailDB.SysPermissions.Log_SyncAgentActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Log_SyncAgentActions;

CREATE TABLE InfinityRetailDB.SysPermissions.Log_SyncAgentActions (
	SyncAgent_ActionID bigint IDENTITY(1,1) NOT NULL,
	ActionDateTime datetime NOT NULL,
	ActionType nvarchar(20) COLLATE Arabic_CI_AS NOT NULL,
	ActionLayer nvarchar(10) COLLATE Arabic_CI_AS NOT NULL,
	ActionDescription nvarchar(MAX) COLLATE Arabic_CI_AS NULL,
	CONSTRAINT PK_Log_SyncAgentActions PRIMARY KEY (SyncAgent_ActionID)
);


-- InfinityRetailDB.SysPermissions.Log_UserErrors definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Log_UserErrors;

CREATE TABLE InfinityRetailDB.SysPermissions.Log_UserErrors (
	ErrorLogID bigint IDENTITY(1,1) NOT NULL,
	ErrorNumber bigint DEFAULT 0 NOT NULL,
	ErrorTime datetime NOT NULL,
	UMSErrorLayer nvarchar(5) COLLATE Arabic_CI_AS DEFAULT '' NOT NULL,
	UMSProject nvarchar(25) COLLATE Arabic_CI_AS DEFAULT '' NOT NULL,
	UMSModuleName nvarchar(50) COLLATE Arabic_CI_AS DEFAULT '' NOT NULL,
	ErrorMessage nvarchar(MAX) COLLATE Arabic_CI_AS NOT NULL,
	UserID_FK smallint DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Log_Errors PRIMARY KEY (ErrorLogID)
);


-- InfinityRetailDB.SysPermissions.RefGroupTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.RefGroupTypes;

CREATE TABLE InfinityRetailDB.SysPermissions.RefGroupTypes (
	GroupTypeID_PK tinyint NOT NULL,
	GroupTypeName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	GroupTypeLevel tinyint NULL,
	CONSTRAINT PK_RefGroupType PRIMARY KEY (GroupTypeID_PK)
);


-- InfinityRetailDB.SysPermissions.RefMainActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.RefMainActions;

CREATE TABLE InfinityRetailDB.SysPermissions.RefMainActions (
	MainActionID_PK smallint NOT NULL,
	MainActionCode nvarchar(200) COLLATE Arabic_CI_AS NOT NULL,
	MainActionName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefMainActions PRIMARY KEY (MainActionID_PK)
);


-- InfinityRetailDB.SysPermissions.RefSubActionTypes definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.RefSubActionTypes;

CREATE TABLE InfinityRetailDB.SysPermissions.RefSubActionTypes (
	SubActionType tinyint NOT NULL,
	SubActionTypeCaption nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_RefSubActionTypes PRIMARY KEY (SubActionType)
);


-- InfinityRetailDB.SysPermissions.Data_Groups definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Data_Groups;

CREATE TABLE InfinityRetailDB.SysPermissions.Data_Groups (
	GroupID_PK int IDENTITY(1,1) NOT NULL,
	GroupName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	GroupEname nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	GrouptypeID_FK tinyint NULL,
	CONSTRAINT PK_Groups PRIMARY KEY (GroupID_PK),
	CONSTRAINT UniqueKey_CommitteeName UNIQUE (GroupName),
	CONSTRAINT FK_Data_Groups_RefGroupTypes FOREIGN KEY (GrouptypeID_FK) REFERENCES InfinityRetailDB.SysPermissions.RefGroupTypes(GroupTypeID_PK)
);


-- InfinityRetailDB.SysPermissions.RefSubActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.RefSubActions;

CREATE TABLE InfinityRetailDB.SysPermissions.RefSubActions (
	SubActionID_PK int NOT NULL,
	SubActionCode nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	SubActionName nvarchar(100) COLLATE Arabic_CI_AS NOT NULL,
	MainActionID_FK smallint NOT NULL,
	Insert_Option bit DEFAULT 1 NOT NULL,
	Update_Option bit DEFAULT 1 NOT NULL,
	Delete_Option bit DEFAULT 1 NOT NULL,
	Query_Option bit DEFAULT 1 NOT NULL,
	Print_Option bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Validities PRIMARY KEY (SubActionID_PK),
	CONSTRAINT FK_RefSubActions_RefMainActions FOREIGN KEY (MainActionID_FK) REFERENCES InfinityRetailDB.SysPermissions.RefMainActions(MainActionID_PK)
);


-- InfinityRetailDB.SysPermissions.Config_GroupDataAccessPermissions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Config_GroupDataAccessPermissions;

CREATE TABLE InfinityRetailDB.SysPermissions.Config_GroupDataAccessPermissions (
	GroupDataAccessPermissionID_PK int IDENTITY(1,1) NOT NULL,
	GroupID_FK int NOT NULL,
	SubActionID_FK int NOT NULL,
	AllowToQuery bit NOT NULL,
	AllowToInsert bit NOT NULL,
	AllowToUpdate bit NOT NULL,
	AllowToDelete bit NOT NULL,
	AllowToPrint bit NOT NULL,
	CONSTRAINT IX_Config_GroupDataAcesses UNIQUE (GroupID_FK,SubActionID_FK),
	CONSTRAINT PK_User_Validities PRIMARY KEY (GroupDataAccessPermissionID_PK),
	CONSTRAINT FK_Config_GroupDataAcesses_Data_Groups FOREIGN KEY (GroupID_FK) REFERENCES InfinityRetailDB.SysPermissions.Data_Groups(GroupID_PK),
	CONSTRAINT FK_Config_GroupDataAcesses_RefSubActions FOREIGN KEY (SubActionID_FK) REFERENCES InfinityRetailDB.SysPermissions.RefSubActions(SubActionID_PK)
);


-- InfinityRetailDB.SysPermissions.Data_UserSessionActions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Data_UserSessionActions;

CREATE TABLE InfinityRetailDB.SysPermissions.Data_UserSessionActions (
	UserSessionActionID_PK bigint IDENTITY(1,1) NOT NULL,
	UserSessionActionDate datetime NOT NULL,
	SessionID_FK bigint NOT NULL,
	SubActionID_FK int NOT NULL,
	SubActionType tinyint NOT NULL,
	ActionDescription nvarchar(350) COLLATE Arabic_CI_AS NOT NULL,
	ActionProductID_FK bigint NULL,
	ActionProductName nvarchar(100) COLLATE Arabic_CI_AS NULL,
	ActionOldValue decimal(15,3) NULL,
	ActionNewValue decimal(15,3) NULL,
	ActionValueType tinyint NULL,
	CONSTRAINT PK_Data_UserSessionActions PRIMARY KEY (UserSessionActionID_PK),
	CONSTRAINT FK_Data_UserSessionActions_Data_UserSessions FOREIGN KEY (SessionID_FK) REFERENCES InfinityRetailDB.SysPermissions.Data_UserSessions(SessionID_PK),
	CONSTRAINT FK_Data_UserSessionActions_RefSubActionTypes FOREIGN KEY (SubActionType) REFERENCES InfinityRetailDB.SysPermissions.RefSubActionTypes(SubActionType),
	CONSTRAINT FK_Data_UserSessionActions_RefSubActions FOREIGN KEY (SubActionID_FK) REFERENCES InfinityRetailDB.SysPermissions.RefSubActions(SubActionID_PK)
);
 CREATE NONCLUSTERED INDEX IX_Data_UserSessionActions_SessionID_FK ON InfinityRetailDB.SysPermissions.Data_UserSessionActions (  SessionID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_UserSessionActions_SubActionID_FK ON InfinityRetailDB.SysPermissions.Data_UserSessionActions (  SubActionID_FK ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Data_UserSessionActions_SubActionType ON InfinityRetailDB.SysPermissions.Data_UserSessionActions (  SubActionType ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- InfinityRetailDB.SysPermissions.Config_GroupUsers definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Config_GroupUsers;

CREATE TABLE InfinityRetailDB.SysPermissions.Config_GroupUsers (
	GroupUserID_PK int IDENTITY(1,1) NOT NULL,
	GroupID_FK int NOT NULL,
	UserID_FK int NOT NULL,
	CONSTRAINT IX_Config_GroupUsers UNIQUE (GroupID_FK,UserID_FK),
	CONSTRAINT PK_Config_GroupUsers PRIMARY KEY (GroupUserID_PK)
);


-- InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions;

CREATE TABLE InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions (
	UserDataAccessPermissionID_PK int IDENTITY(1,1) NOT NULL,
	UserID_FK int NOT NULL,
	MainActionID_FK smallint NOT NULL,
	SubActionID_FK bigint NOT NULL,
	AllowToAccess bit NOT NULL,
	CONSTRAINT PK_Config_UserDataAccessPermissions PRIMARY KEY (UserDataAccessPermissionID_PK),
	CONSTRAINT UK_Config_UserDataAcessesPermissions UNIQUE (UserID_FK,MainActionID_FK,SubActionID_FK)
);


-- InfinityRetailDB.SysPermissions.Data_Users definition

-- Drop table

-- DROP TABLE InfinityRetailDB.SysPermissions.Data_Users;

CREATE TABLE InfinityRetailDB.SysPermissions.Data_Users (
	UserID_PK int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(50) COLLATE Arabic_CI_AS NULL,
	username nvarchar(30) COLLATE Arabic_CI_AS NULL,
	Password nvarchar(30) COLLATE Arabic_CI_AS NULL,
	Email nvarchar(30) COLLATE Arabic_CI_AS NULL,
	Phone nvarchar(30) COLLATE Arabic_CI_AS NULL,
	UserAddress nvarchar(100) COLLATE Arabic_CI_AS NULL,
	IsAproved bit NULL,
	IsHasLimitedDataAccess bit DEFAULT 0 NOT NULL,
	AdminPermissionCode nvarchar(25) COLLATE Arabic_CI_AS NULL,
	BranchID_FK int NULL,
	CONSTRAINT PK_User PRIMARY KEY (UserID_PK)
);


-- InfinityRetailDB.SysPermissions.Config_GroupUsers foreign keys

ALTER TABLE InfinityRetailDB.SysPermissions.Config_GroupUsers ADD CONSTRAINT FK_Config_GroupUsers_Data_Groups FOREIGN KEY (GroupID_FK) REFERENCES InfinityRetailDB.SysPermissions.Data_Groups(GroupID_PK) ON DELETE CASCADE;
ALTER TABLE InfinityRetailDB.SysPermissions.Config_GroupUsers ADD CONSTRAINT FK_Config_GroupUsers_Data_Users FOREIGN KEY (UserID_FK) REFERENCES InfinityRetailDB.SysPermissions.Data_Users(UserID_PK) ON DELETE CASCADE;


-- InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions foreign keys

ALTER TABLE InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions ADD CONSTRAINT FK_Config_UserDataAcessesPermissions_Data_Users FOREIGN KEY (UserID_FK) REFERENCES InfinityRetailDB.SysPermissions.Data_Users(UserID_PK);
ALTER TABLE InfinityRetailDB.SysPermissions.Config_UserDataAccessPermissions ADD CONSTRAINT FK_Config_UserDataAcessesPermissions_RefMainActions FOREIGN KEY (MainActionID_FK) REFERENCES InfinityRetailDB.SysPermissions.RefMainActions(MainActionID_PK);


-- InfinityRetailDB.SysPermissions.Data_Users foreign keys

ALTER TABLE InfinityRetailDB.SysPermissions.Data_Users ADD CONSTRAINT FK_Data_Users_Config_Branchs FOREIGN KEY (BranchID_FK) REFERENCES InfinityRetailDB.MyCompany.Config_Branchs(BranchID_PK);


-- SysPermissions.Config_View_GroupDataAccessPermissions source

ALTER VIEW [SysPermissions].[Config_View_GroupDataAccessPermissions]
AS
SELECT     SysPermissions.Config_GroupDataAccessPermissions.GroupDataAccessPermissionID_PK, 
                      SysPermissions.Config_GroupDataAccessPermissions.GroupID_FK, SysPermissions.Config_GroupDataAccessPermissions.SubActionID_FK, 
                      SysPermissions.Config_GroupDataAccessPermissions.AllowToQuery, SysPermissions.Config_GroupDataAccessPermissions.AllowToInsert, 
                      SysPermissions.Config_GroupDataAccessPermissions.AllowToUpdate, SysPermissions.Config_GroupDataAccessPermissions.AllowToDelete, 
                      SysPermissions.Config_GroupDataAccessPermissions.AllowToPrint, SysPermissions.RefSubActions.SubActionCode, 
                      SysPermissions.RefSubActions.SubActionName, SysPermissions.RefMainActions.MainActionCode, SysPermissions.RefMainActions.MainActionName, 
                      SysPermissions.RefSubActions.MainActionID_FK
FROM         SysPermissions.Config_GroupDataAccessPermissions INNER JOIN
                      SysPermissions.RefSubActions ON 
                      SysPermissions.Config_GroupDataAccessPermissions.SubActionID_FK = SysPermissions.RefSubActions.SubActionID_PK INNER JOIN
                      SysPermissions.RefMainActions ON SysPermissions.RefSubActions.MainActionID_FK = SysPermissions.RefMainActions.MainActionID_PK;


-- SysPermissions.Data_View_Users source

ALTER VIEW [SysPermissions].[Data_View_Users]
AS
SELECT     UserID_PK, FullName, username, Password, Email, Phone, IsAproved, UserAddress, IsHasLimitedDataAccess, AdminPermissionCode, BranchID_FK
FROM         SysPermissions.Data_Users;

-- DROP SCHEMA SysPublic;

CREATE SCHEMA SysPublic;

-- DROP SCHEMA Utilities;

CREATE SCHEMA Utilities;
-- InfinityRetailDB.Utilities.Data_ImporedProducts definition

-- Drop table

-- DROP TABLE InfinityRetailDB.Utilities.Data_ImporedProducts;

CREATE TABLE InfinityRetailDB.Utilities.Data_ImporedProducts (
	ImportedProductID_PK bigint IDENTITY(1,1) NOT NULL,
	ProductCode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	ProductName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	SubDepartment nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	ProductGroup nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	ProductTrademark nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	InventoryUnit nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	UnitBarcode nvarchar(50) COLLATE Arabic_CI_AS NOT NULL,
	PurchaseCost decimal(9,3) NOT NULL,
	UnitPrice1 decimal(9,3) NOT NULL,
	UnitPrice2 decimal(9,3) NOT NULL,
	UnitPrice3 decimal(9,3) NOT NULL,
	UnitPrice4 decimal(9,3) NOT NULL,
	QYT decimal(9,3) NOT NULL,
	ProductShortName nvarchar(75) COLLATE Arabic_CI_AS NOT NULL,
	SalesDecription nvarchar(300) COLLATE Arabic_CI_AS NOT NULL,
	PurchaseDescription nvarchar(300) COLLATE Arabic_CI_AS NOT NULL,
	manfuctureCode nvarchar(30) COLLATE Arabic_CI_AS NOT NULL,
	IsVeryfied bit NOT NULL,
	RejectReasonCaption nvarchar(300) COLLATE Arabic_CI_AS NOT NULL,
	CONSTRAINT PK_Data_ImporedProducts PRIMARY KEY (ImportedProductID_PK)
);

-- DROP SCHEMA ZSCHEMA;

CREATE SCHEMA ZSCHEMA;
-- InfinityRetailDB.ZSCHEMA.cus_credit_debit definition

-- Drop table

-- DROP TABLE InfinityRetailDB.ZSCHEMA.cus_credit_debit;

CREATE TABLE InfinityRetailDB.ZSCHEMA.cus_credit_debit (
	rec_id int NOT NULL,
	CUS_ID int NOT NULL,
	[date] datetime NULL,
	amount_type tinyint NULL,
	INVOICE_ID int NOT NULL,
	amount_val decimal(18,3) DEFAULT 0 NULL,
	credit_amount decimal(18,3) DEFAULT 0 NOT NULL,
	debit_amount decimal(18,3) DEFAULT 0 NOT NULL,
	oper_id smallint DEFAULT 0 NOT NULL,
	SALESMAN_ID tinyint DEFAULT 0 NOT NULL,
	CONSTRAINT PK_cus_credit_debit PRIMARY KEY (rec_id)
);


-- InfinityRetailDB.ZSCHEMA.source_credit_debit definition

-- Drop table

-- DROP TABLE InfinityRetailDB.ZSCHEMA.source_credit_debit;

CREATE TABLE InfinityRetailDB.ZSCHEMA.source_credit_debit (
	rec_id int NOT NULL,
	sour_ID int NOT NULL,
	[date] datetime NULL,
	amount_type smallint NULL,
	amount_val decimal(18,3) DEFAULT 0 NULL,
	INVOICEID int NULL,
	credit_amount decimal(18,3) DEFAULT 0 NOT NULL,
	debit_amount decimal(18,3) DEFAULT 0 NOT NULL,
	oper_id smallint DEFAULT 0 NOT NULL,
	CONSTRAINT PK_source_credit_debit PRIMARY KEY (rec_id)
);