DROP TABLE StroyInvest.dbo.CALENDAR; 
CREATE TABLE StroyInvest.dbo.CALENDAR (
	ID int NULL,
	[YEAR] int NULL,
	QUARTER int NULL,
	[MONTH] int NULL,
	[DAY] int NULL,
	DT date NULL
);

DROP TABLE StroyInvest.dbo.MAIN;
CREATE TABLE StroyInvest.dbo.MAIN (
	ID int NOT NULL,
	CALENDAR_ID int NULL,
	TITLE_NUMBER int NULL,
	FINANCING_SOURCE_ID int NULL,
	MSK_GOV_PROGRAM_ID int NULL,
	EXTEND_ID int NULL,
	POWER_ID int NULL,
	TITLE_STATE_ID int NULL,
	VALUE_FULL float NULL,
	VALUE_DONE float NULL,
	VALUE_CURR float NULL
);

DROP TABLE StroyInvest.dbo.TITLE;
CREATE TABLE StroyInvest.dbo.TITLE (
	TITLE_NUMBER int NOT NULL,
	TITLE_TYPE_ID int NULL,
	COB_ID int NULL,
	NAME varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
	ADDRESS varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
	START_YEAR int NULL,
	FINISH_YEAR int NULL
);

DROP TABLE StroyInvest.dbo.EXTEND;
CREATE TABLE StroyInvest.dbo.EXTEND  (
    ID int NOT NULL, 
    START_CONSTR int NULL, 
    STOP_CONSTR int NULL, 
    NUM_LAG int NULL, 
    DELIVERY_DATE int NULL, 
    COB_TYPE_ID        int NULL
);

DROP TABLE StroyInvest.dbo.POWER;    
CREATE TABLE StroyInvest.dbo.POWER
   (ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    RESULT_AIP_ID         int NULL
    );
    
    DROP TABLE StroyInvest.dbo.MONTH;    
    CREATE TABLE StroyInvest.dbo.MONTH
   (ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );

DROP TABLE StroyInvest.dbo.FINANCING_SOURCE;    
CREATE TABLE StroyInvest.dbo.FINANCING_SOURCE
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );

DROP TABLE StroyInvest.dbo.RESULT_AIP;    
CREATE TABLE StroyInvest.dbo.RESULT_AIP
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    UNIT    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );

DROP TABLE StroyInvest.dbo.MSK_GOV_PROGRAM;    
CREATE TABLE StroyInvest.dbo.MSK_GOV_PROGRAM
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );

DROP TABLE StroyInvest.dbo.GP;    
CREATE TABLE StroyInvest.dbo.GP
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );

DROP TABLE StroyInvest.dbo.GP_LF;    
CREATE TABLE StroyInvest.dbo.GP_LF
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL
    );
    
DROP TABLE StroyInvest.dbo.PP;    
CREATE TABLE StroyInvest.dbo.PP
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    GP_LF_ID    int NULL, 
    );
	
DROP TABLE StroyInvest.dbo.PREGP;    
CREATE TABLE StroyInvest.dbo.PREGP
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    GP_ID    int NULL, 
    );
	
DROP TABLE StroyInvest.dbo.COB_PREGP_LINK;    
CREATE TABLE StroyInvest.dbo.COB_PREGP_LINK
    (
    COB_ID    int NOT NULL, 
    PREGP_ID    int NULL, 
    );

DROP TABLE StroyInvest.dbo.MAIN_PP_LINK;    
CREATE TABLE StroyInvest.dbo.MAIN_PP_LINK
    (
    MAIN_ID    int NOT NULL, 
    PP_ID    int NULL, 
    );

DROP TABLE StroyInvest.dbo.AO;    
CREATE TABLE StroyInvest.dbo.AO
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    );

DROP TABLE StroyInvest.dbo.DISTR;    
CREATE TABLE StroyInvest.dbo.DISTR
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    AO_ID    int NULL, 
    );

DROP TABLE StroyInvest.dbo.COB_DISTR_LINK;    
CREATE TABLE StroyInvest.dbo.COB_DISTR_LINK
    (
    COB_ID    int NULL, 
    DISTR_ID    int NULL, 
    );

DROP TABLE StroyInvest.dbo.COB;    
CREATE TABLE StroyInvest.dbo.COB
    (
    ID   int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    ADDRESS                varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    CENTER_LATITUDE        float NULL, 
    CENTER_LONGITUDE       float NULL,
 --   COB_TYPE_ID        int NULL, 
 --   START_YEAR        int NULL,
 --   FINISH_YEAR        int NULL,
    NEW_YEAR    int NULL,
    );  

DROP TABLE StroyInvest.dbo.TITLE_STATE;    
CREATE TABLE StroyInvest.dbo.TITLE_STATE
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    );

DROP TABLE StroyInvest.dbo.TITLE_TYPE;    
CREATE TABLE StroyInvest.dbo.TITLE_TYPE
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    );
	
DROP TABLE StroyInvest.dbo.COB_TYPE;    
CREATE TABLE StroyInvest.dbo.COB_TYPE
    (
    ID    int NOT NULL, 
    NAME    varchar(4000) COLLATE Cyrillic_General_CI_AS NULL, 
    );

    