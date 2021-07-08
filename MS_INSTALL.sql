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
--	EXTEND_ID int NULL,
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
    MAIN_ID int NULL,
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
   -- NEW_YEAR    int NULL,
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

DROP TABLE StroyInvest.dbo.AIP;    
CREATE TABLE StroyInvest.dbo.AIP
    (
    ID    int NOT NULL, 
    YEAR  int NULL, 
    );
	
DROP TABLE StroyInvest.dbo.COB_AIP_LINK;    
CREATE TABLE StroyInvest.dbo.COB_AIP_LINK
    (
    COB_ID    int NOT NULL, 
    AIP_ID    int NOT NULL,
    );
    
DROP TABLE StroyInvest.dbo.PPM;    
CREATE TABLE StroyInvest.dbo.PPM
    (
    CALENDAR_ID INT NULL, 
    VALUE INT NULL, 
    YEAR INT NULL, 
    IS_CURR INT NULL, 
    DOC_NUMBER varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    );    
    
DROP TABLE StroyInvest.dbo.VALUE_PLAN;    
CREATE TABLE StroyInvest.dbo.VALUE_PLAN
    (
    MAIN_ID INT NULL, 
    VALUE INT NULL, 
    YEAR INT NULL, 
    IS_CURR INT NULL, 
    CALENDAR_ID INT NULL,
    );        

DROP TABLE StroyInvest.dbo.GRBS;    
CREATE TABLE StroyInvest.dbo.GRBS
    (
    ID INT NULL, 
    NAME varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    );  
                                              
DROP TABLE StroyInvest.dbo.COB_GRBS_LINK;    
CREATE TABLE StroyInvest.dbo.COB_GRBS_LINK
    (
    COB_ID INT NULL, 
    GRBS_ID INT NULL,
    );  

DROP TABLE StroyInvest.dbo.PREGRBS;    
CREATE TABLE StroyInvest.dbo.PREGRBS
    (
    ID INT NULL, 
    NAME varchar(4000) COLLATE Cyrillic_General_CI_AS NULL,
    );  
                 
  
DROP TABLE StroyInvest.dbo.COB_PREGRBS_LINK;    
CREATE TABLE StroyInvest.dbo.COB_PREGRBS_LINK
    (
    COB_ID INT NULL, 
    PREGRBS_ID INT NULL,
    );  

DROP TABLE StroyInvest.dbo.V3_CALENDAR;    
CREATE TABLE StroyInvest.dbo.V3_CALENDAR
    (
    ID INT NULL, 
    YEAR INT NULL, 
    QUARTER INT NULL, 
    MONTH INT NULL, 
    DAY INT NULL, 
    DT DATE NULL, 
    );          
    
DROP TABLE StroyInvest.dbo.COB_PP_LINK;    
CREATE TABLE StroyInvest.dbo.COB_PP_LINK
    (
    COB_ID INT NULL, 
    PP_ID INT NULL, 
    );          
    
DROP TABLE StroyInvest.dbo.MAIN_CALENDAR_LINK_ALT;    
CREATE TABLE StroyInvest.dbo.MAIN_CALENDAR_LINK_ALT
    (
    MAIN_ID INT NULL, 
    CALENDAR_ID INT NULL, 
    );         
    
DROP TABLE StroyInvest.dbo.V3_EXTEND;    
CREATE TABLE StroyInvest.dbo.V3_EXTEND
    (
    COB_ID INT NULL, 
    ID INT NULL, 
    COB_TYPE_ID INT NULL, 
    IS_CONTR INT NULL, 
    D_YEAR INT NULL, 
    STOP_CONSTR INT NULL, 
    START_CONSTR INT NULL, 
    M_DATE INT NULL, 
    NUM_LAG INT NULL, 
    EXTEND_ID INT NULL, 
    );         

DROP TABLE StroyInvest.dbo.V3_MAIN;    
CREATE TABLE StroyInvest.dbo.V3_MAIN
    (
    ID INT NULL, 
    TITLE_NUMBER INT NULL, 
    FINANCING_SOURCE_ID INT NULL, 
    MSK_GOV_PROGRAM_ID INT NULL, 
    POWER_ID INT NULL, 
    TITLE_STATE_ID INT NULL, 
    VALUE_FULL INT NULL, 
    VALUE_DONE INT NULL, 
    VALUE_CONTR INT NULL, 
    EXTEND_ID INT NULL, 
    );   

                                          
 DROP TABLE StroyInvest.dbo.V4_EXTEND_FINAL;    
 CREATE TABLE StroyInvest.dbo.V4_EXTEND_FINAL
    (
    ID INT NULL, 
	COB_TYPE_ID INT NULL, 
	IS_CONTR INT NULL, 
	D_YEAR INT NULL, 
	START_CONSTR INT NULL, 
	STOP_CONSTR INT NULL, 
	NUM_LAG NUMBER INT NULL, 
    );   
   
                                             
 DROP TABLE StroyInvest.dbo.V4_MAIN_FINAL;    
 CREATE TABLE StroyInvest.dbo.V4_MAIN_FINAL
    (
    ID INT NULL, 
	CALENDAR_ID INT NULL, 
	TITLE_NUMBER INT NULL, 
	FINANCING_SOURCE_ID INT NULL, 
	MSK_GOV_PROGRAM_ID INT NULL, 
	POWER_ID INT NULL, 
	TITLE_STATE_ID INT NULL, 
	VALUE_FULL INT NULL, 
	VALUE_DONE INT NULL, 
	VALUE_CONTR INT NULL, 
	EXTEND_ID INT NULL, 
    );       
    
DROP TABLE StroyInvest.dbo.V4_VALUE_PLAN;    
 CREATE TABLE StroyInvest.dbo.V4_VALUE_PLAN
    (
       MAIN_ID INT NULL, 
	VALUE INT NULL, 
	YEAR INT NULL, 
	IS_CURR INT NULL, 
    );       
    

    
    

    
    
    
    
    
    
    