DECLARE 
    tmp_current_user varchar2(64);
    tmp_is_objects number;
BEGIN

    BEGIN
    FOR x in (SELECT table_name FROM all_tables WHERE owner = 'PBI' AND table_name like 'PBI_%')
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || x.table_name;
    END LOOP;
    commit;
    END;
   
    SELECT username INTO tmp_current_user FROM user_users;
    
 
   /* CREATE TITLE*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'TITLE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TITLE CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TITLE
                                               (TITLE_NUMBER   NUMBER, 
                                                TITLE_TYPE_ID    NUMBER, 
                                                COB_ID                  NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE), 
                                                ADDRESS               VARCHAR2(4000 BYTE),
                                                START_YEAR        NUMBER, 
                                                FINISH_YEAR        NUMBER
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.TITLE_NUMBER IS ''' || 'Номер титула' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.TITLE_TYPE_ID IS ''' || 'Тип титула' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.COB_ID IS ''' || 'Номер объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.NAME IS ''' || 'Наименование титула' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.ADDRESS IS ''' || 'Адрес титула' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.START_YEAR IS ''' || 'Год рождения титула' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE.FINISH_YEAR IS ''' || 'Год реализации титула' || '''';
   

   /* CREATE COB*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB
                                               (ID   NUMBER, 
                                                NAME    VARCHAR2(4000 BYTE), 
                                                ADDRESS                VARCHAR2(4000 BYTE), 
                                                CENTER_LATITUDE        NUMBER, 
                                                CENTER_LONGITUDE       NUMBER
                                                --COB_TYPE_ID        NUMBER, 
                                                --START_YEAR        NUMBER,
												--FINISH_YEAR        NUMBER,
                                                --NEW_YEAR NUMBER
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.ID IS ''' || 'ID объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.NAME IS ''' || 'Название объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.ADDRESS IS ''' || 'Адрес объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.CENTER_LATITUDE IS ''' || 'Координата широты' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.CENTER_LONGITUDE IS ''' || 'Координата долготы' || '''';
 
  
/* CREATE CALENDAR*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'CALENDAR';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.CALENDAR CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.CALENDAR
                                               (ID NUMBER, 
                                                YEAR NUMBER, 
                                                QUARTER NUMBER, 
                                                MONTH NUMBER, 
                                                DAY NUMBER, 
                                                DT DATE,
                                                CONSTRAINT C_CALENDAR_PK_ PRIMARY KEY (ID))';
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_CALENDAR_DT_ ON PBI.CALENDAR (DT)';
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_CALENDAR_DT_ID_ ON PBI.CALENDAR (DT, ID)';
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_CALENDAR_YEAR_ID_ ON PBI.CALENDAR (YEAR, ID)';


   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.CALENDAR.ID IS ''' || 'Идентификатор календаря' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.CALENDAR.YEAR IS ''' || 'Год календаря' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.CALENDAR.QUARTER IS ''' || 'Квартар календаря' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.CALENDAR.MONTH IS ''' || 'Месяц календаря' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.CALENDAR.DAY IS ''' || 'Последний день месяца' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.CALENDAR  IS ''' || 'Табица календаря для PBI' || '''';
    
   /* CREATE POWER*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'POWER';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.POWER CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.POWER
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE), 
                                                RESULT_AIP_ID        NUMBER
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.POWER.NAME IS ''' || 'Название мощности' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.POWER.RESULT_AIP_ID IS ''' || 'Ожидаемый результат АИП' || '''';

    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_POWER';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_POWER';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_POWER  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE' ;
    
       /* CREATE MONTH*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MONTH';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MONTH CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MONTH
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                

   /* CREATE RESULT_AIP*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'RESULT_AIP';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.RESULT_AIP CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.RESULT_AIP
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE), 
                                                UNIT             VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.RESULT_AIP.NAME IS ''' || 'Название мощности' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.RESULT_AIP.UNIT IS ''' || 'Название единицы измерения' || '''';
   
      /* CREATE TITLE_STATE*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'TITLE_STATE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TITLE_STATE CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TITLE_STATE
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE_STATE.NAME IS ''' || 'Название' || '''';

/* CREATE MAIN_PREGP_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_PREGP_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_PREGP_LINK CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_PREGP_LINK
                                               (COB_ID   NUMBER, 
                                                PREGP_ID                     NUMBER
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_PREGP_LINK.COB_ID IS ''' || 'Внешний ключ на таблицу COB' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_PREGP_LINK.PREGP_ID IS ''' || 'Внешний ключ на таблицу PP' || '''';

/* CREATE MSK_GOV_PROGRAM */    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MSK_GOV_PROGRAM';
       
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MSK_GOV_PROGRAM  CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MSK_GOV_PROGRAM 
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MSK_GOV_PROGRAM .NAME IS ''' || '	Название программы правительства Москвы' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MSK_GOV_PROGRAM .ID IS ''' || 'ID программы правительства Москвы' || '''';


/* CREATE GP */    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'GP';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.GP  CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.GP 
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GP .NAME IS ''' || '	Название программы ГП' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GP .ID IS ''' || 'ID программы правительства ' || '''';

/* CREATE TITLE_STATE */    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'TITLE_STATE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TITLE_STATE  CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TITLE_STATE 
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE_STATE .NAME IS ''' || '	Название статуса' || '''';

/* CREATE TITLE_TYPE */    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'TITLE_TYPE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TITLE_TYPE  CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TITLE_TYPE 
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.TITLE_TYPE .NAME IS ''' || '	Название типа' || '''';

/* CREATE GP_LF */    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'GP_LF';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.GP_LF  CASCADE CONSTRAINTS';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE PBI.GP_LF 
                                               (ID   NUMBER, 
                                                NAME                     VARCHAR2(4000 BYTE)
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GP_LF .NAME IS ''' || '	Название программы ГП' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GP_LF .ID IS ''' || 'ID программы правительства ' || '''';

/* CREATE FINANCING_SOURCE*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'FINANCING_SOURCE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.FINANCING_SOURCE CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.FINANCING_SOURCE
                                                (
                                                    ID NUMBER(28,0) NOT NULL ENABLE, 
                                                    NAME VARCHAR2(256 BYTE) NOT NULL ENABLE, 
                                                    CONSTRAINT FINANCING_SOURCE_2_PK PRIMARY KEY (ID)
                                                )';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.FINANCING_SOURCE.ID IS ''' || 'Первичный ключ таблицы.' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.FINANCING_SOURCE.NAME IS ''' || 'Наименование источника финансирования.' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.FINANCING_SOURCE  IS ''' || 'Источники финансирования' || '''';

/* CREATE COB_TYPE*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_TYPE';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_TYPE CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_TYPE
                                                (
                                                    ID NUMBER(28,0) NOT NULL ENABLE, 
                                                    NAME VARCHAR2(256 BYTE) NOT NULL ENABLE
                                                )';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_TYPE.ID IS ''' || 'Первичный ключ таблицы.' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_TYPE.NAME IS ''' || 'Наименование типа обьекта' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.COB_TYPE  IS ''' || 'Тип обьекта' || '''';

/* CREATE PP*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'PP';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.PP CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.PP
                                                (
                                                    ID NUMBER(28,0) NOT NULL ENABLE, 
                                                    NAME VARCHAR2(4000 BYTE) NOT NULL ENABLE, 
                                                    GP_LF_ID NUMBER
                                                )';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PP.ID IS ''' || 'ID подпрограммы' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PP.NAME IS ''' || 'Название подпрограммы' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PP.GP_LF_ID IS ''' || 'Госпрограмма' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.PP  IS ''' || 'Подрограмма' || '''';
	
	
/* CREATE PREGP*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'PREGP';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.PREGP CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.PREGP
                                                (
                                                    ID NUMBER(28,0) NOT NULL ENABLE, 
                                                    NAME VARCHAR2(4000 BYTE) NOT NULL ENABLE, 
                                                    GP_ID NUMBER
                                                )';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGP.ID IS ''' || 'ID подпрограммы' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGP.NAME IS ''' || 'Название подпрограммы' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGP.GP_ID IS ''' || 'Госпрограмма' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.PREGP  IS ''' || 'Подрограмма' || '''';

  /* CREATE AO*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'AO';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.AO CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.AO
                                               (ID NUMBER, 
                                                NAME VARCHAR2(4000 BYTE) ,
                                                CONSTRAINT C_AO_COLUMN_PK PRIMARY KEY (ID))';

   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.AO.ID IS ''' || 'Идентификатор административного округа' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.AO.NAME IS ''' || 'Наименование административного округа' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.AO  IS ''' || 'Табица административных округов' || '''';

  /* CREATE DISTR*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'DISTR';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.DISTR CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.DISTR
                                               (ID NUMBER, 
                                                NAME VARCHAR2(4000 BYTE), 
                                                AO_ID number,
                                                CONSTRAINT C_DISTR_COLUMN_PK PRIMARY KEY (ID))';

   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.DISTR.ID IS ''' || 'Идентификатор района' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.DISTR.NAME IS ''' || 'Наименование района' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.DISTR.AO_ID IS ''' || 'Ид округа' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.DISTR  IS ''' || 'Табица административных районов для PBI' || '''';

  /* CREATE COB_DISTR_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_DISTR_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_DISTR_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_DISTR_LINK
                                               (COB_ID NUMBER, 
                                                DISTR_ID NUMBER)';

   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_DISTR_LINK.COB_ID IS ''' || 'Идентификатор объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_DISTR_LINK.DISTR_ID IS ''' || 'Наименование района' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.DISTR  IS ''' || 'Табица связи объектов и административных районов для PBI' || '''';

  /* CREATE COB_AIP_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_AIP_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_AIP_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_AIP_LINK
                                               (COB_ID NUMBER, 
                                                AIP_ID NUMBER)';

   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_AIP_LINK.COB_ID IS ''' || 'Идентификатор объекта' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_AIP_LINK.AIP_ID IS ''' || 'Идентификатор АИП' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.COB_AIP_LINK  IS ''' || 'Табица связи объектов и АИП для PBI' || '''';

  /* CREATE AIP*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'AIP';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.AIP CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.AIP
                                               (ID NUMBER, 
                                                YEAR NUMBER)';

   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.AIP.ID IS ''' || 'Идентификатор АИП' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.AIP.YEAR IS ''' || 'Наименование района' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.AIP  IS ''' || 'Табица АИП для PBI' || '''';   
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_AIP';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_AIP';
    END IF; 
   EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_AIP  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE';
   
     /* CREATE EXTEND*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'EXTEND';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.EXTEND CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.EXTEND  (
                                                ID NUMBER,
												COB_TYPE_ID NUMBER,
												IS_CONTR NUMBER,
												D_YEAR NUMBER,
												START_CONSTR NUMBER,
												STOP_CONSTR NUMBER,
												NUM_LAG NUMBER
                                                )
                                                TABLESPACE USERS';


  /* CREATE MAIN*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MAIN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN  (
												ID NUMBER,
												CALENDAR_ID NUMBER,
												TITLE_NUMBER NUMBER,
												FINANCING_SOURCE_ID NUMBER,
												MSK_GOV_PROGRAM_ID NUMBER,
												POWER_ID NUMBER,
												TITLE_STATE_ID NUMBER,
												VALUE_FULL NUMBER,
												VALUE_DONE NUMBER,
												VALUE_CONTR NUMBER,
												EXTEND_ID NUMBER
                                                )
                                                TABLESPACE USERS';
    
 
  /* CREATE PPM*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'PPM';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.PPM CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.PPM  (
                                                CALENDAR_ID NUMBER, 
                                                VALUE NUMBER, 
                                                YEAR NUMBER, 
                                                IS_CURR NUMBER, 
                                                DOC_NUMBER VARCHAR2(4000 BYTE)
                                                )
                                                TABLESPACE USERS';

  /* CREATE VALUE_PLAN*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'VALUE_PLAN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.VALUE_PLAN CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.VALUE_PLAN  (
                                                MAIN_ID NUMBER, 
                                                VALUE NUMBER, 
                                                YEAR NUMBER, 
                                                IS_CURR NUMBER
                                                )
                                                TABLESPACE USERS'; 
    
 /* CREATE GRBS*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'GRBS';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.GRBS CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.GRBS  (
                                                ID NUMBER(10,0),
												NAME VARCHAR2(4000)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GRBS.NAME IS ''' || 'Название ГРБС' || '''';
    
 /* CREATE COB_GRBS_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_GRBS_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_GRBS_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_GRBS_LINK  (
                                                COB_ID NUMBER(10,0),
												GRBS_ID NUMBER(10,0)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_GRBS_LINK.COB_ID IS ''' || '	Внешний ключ на таблицу COB' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_GRBS_LINK.GRBS_ID IS ''' || 'Внешний ключ на таблицу ГРБС' || '''';

 /* CREATE PREGRBS*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'PREGRBS';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.PREGRBS CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.PREGRBS  (
                                                ID NUMBER(10,0),
												NAME VARCHAR2(4000)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGRBS.NAME IS ''' || 'Название Заказчика' || '''';

     /* CREATE PREGRBS*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_PREGRBS_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_PREGRBS_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_PREGRBS_LINK  (
                                                COB_ID NUMBER(10,0),
												PREGRBS_ID NUMBER(10)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_PREGRBS_LINK.COB_ID IS ''' || '	Внешний ключ на таблицу COB' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB_PREGRBS_LINK.PREGRBS_ID IS ''' || 'Внешний ключ на таблицу Заказчика' || '''';   
  
    
    /* CREATE COB_PP_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'COB_PP_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.COB_PP_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.COB_PP_LINK
                                           ( 	COB_ID NUMBER, 
                                                PP_ID NUMBER
                                               )  
                                              TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.COB_PP_LINK  IS ''' || 'Связь коба и PP' || '''';

   
END;
/
create or replace PACKAGE GET_PBI_4V AS 

-- version 5

/* create PBI_CALENDAR*/
PROCEDURE GET_CALENDAR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_TITLE */
PROCEDURE GET_TITLE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_FINANCING_SOURCE */
PROCEDURE GET_FINANCING_SOURCE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* RUN */
PROCEDURE RUN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_POWER */
PROCEDURE GET_POWER;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create RESULT_AIP */
PROCEDURE GET_RESULT_AIP;
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка PBI_GP
PROCEDURE GET_GP;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create COB_PREGP_LINK */
PROCEDURE GET_COB_PREGP_LINK;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_COB */
PROCEDURE GET_COB;
----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка COB_DISTR_LINK
PROCEDURE GET_COB_DISTR_LINK;
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка DISTR
PROCEDURE GET_DISTR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка AO
PROCEDURE GET_AO;
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка GET_TITLE_TYPE
PROCEDURE GET_TITLE_TYPE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- загрузка GET_TITLE_STATE
PROCEDURE GET_TITLE_STATE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_ALL_DISTR */
PROCEDURE GET_ALL_DISTR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*Вычисляет подрограмму*/
FUNCTION GET_PREGP(pcosts_classifier_id IN NUMBER) RETURN NUMBER;

function get_adm_reg_by_adm_id(p_adm_id number, type_adm_in number ) return number;

/* create V3_CALENDAR */
PROCEDURE GET_V3_CALENDAR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create COB_PP_LINK */
PROCEDURE GET_COB_PP_LINK;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create GRBS */
PROCEDURE GET_GRBS;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create PREGRBS */
PROCEDURE GET_PREGRBS;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create DELETE */
PROCEDURE DELETE_FINAL;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create GET_PPM */
PROCEDURE GET_PPM;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create VALUE_PLAN */
PROCEDURE GET_VALUE_PLAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create TMP_$TMP_$_MAIN */
PROCEDURE GET_TMP_$_MAIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create TMP_$TMP_$_EXTEND */
PROCEDURE GET_TMP_$_EXTEND;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_EXTEND*/
PROCEDURE GET_EXTEND;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_MAIN*/
PROCEDURE GET_MAIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------


END GET_PBI_4V;

/

create or replace PACKAGE BODY GET_PBI_4V AS

function get_adm_reg_by_adm_id(p_adm_id number, type_adm_in number )
    return number is
    v_adm_region_id number;
    v_exception exception;
  begin

SELECT A.ID
INTO V_ADM_REGION_ID
FROM STROY.ADM_REGION A
WHERE TYPE = TYPE_ADM_IN --AND DELETE_DATE IS NULL
START WITH ID = p_adm_id
CONNECT BY NOCYCLE PRIOR A.ADM_REGION_ID = A.ID;


    return v_adm_region_id;
  exception
    when NO_DATA_FOUND then
begin
SELECT A.ID
INTO V_ADM_REGION_ID
FROM STROY.ADM_REGION A
WHERE TYPE = 2 --AND DELETE_DATE IS NULL
START WITH ID = P_ADM_ID
CONNECT BY NOCYCLE PRIOR A.ADM_REGION_ID = A.ID;
  exception
    when NO_DATA_FOUND then
    V_ADM_REGION_ID:=0;
end;
    return V_ADM_REGION_ID;
      --raise_application_error( -20000, sqlerrm(sqlcode));
  end get_adm_reg_by_adm_id;
  
/*Вычисляет подрограмму*/
FUNCTION GET_PREGP(pcosts_classifier_id IN NUMBER) RETURN NUMBER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    res_id number;
BEGIN
    SELECT MIN(cc.id) INTO res_id 
    FROM  stroy.costs_classifier cc
    WHERE costs_classifier_id IS NOT NULL
    START WITH id = pcosts_classifier_id
    CONNECT BY NOCYCLE PRIOR cc.costs_classifier_id = cc.id;      
    RETURN res_id;
EXCEPTION WHEN OTHERS THEN
    RETURN 0;
END GET_PREGP;

/* create CALENDAR */
PROCEDURE GET_CALENDAR
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number;
    tmp date;
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.CALENDAR ' ;
    select round(MONTHS_BETWEEN(last_day(sysdate), to_date('01.12.2013','dd.mm.yyyy'))) into n_months  from dual;
    for x in 1..n_months
    loop
        tmp := last_day(add_months(new_date, x));     
        INSERT INTO calendar (id, year, quarter, month, day, dt)
        VALUES(to_char(tmp, 'yyyymmdd'), to_char(tmp, 'yyyy'), to_char(trunc(tmp, 'q'),'q'), to_char(tmp, 'mm'), to_char(tmp, 'dd'), tmp);
    end loop;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.calendar;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_CALENDAR', 'INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
END GET_CALENDAR;

/* create COB_PREGP_LINK */
PROCEDURE GET_COB_PREGP_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp_count number;
     tmp number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_PREGP_LINK ' ;
     INSERT INTO pbi.COB_PREGP_LINK (cob_id, pregp_id)

    SELECT DISTINCT c_id, pregp_id FROM
         (
        SELECT DISTINCT c.id c_id, get_pregp(cct.id) pregp_id
        FROM stroy.cob c    
            INNER JOIN stroy.cob_card cc ON cc.cob_id = c.id
            INNER JOIN stroy.cob_title ct ON ct.cob_id = c.id
            INNER JOIN v_title vt ON vt.title_number = ct.title_number
            LEFT JOIN stroy.title_costs_classifier tc ON tc.title_id = vt.id
            LEFT JOIN stroy.costs_classifier cct ON tc.costs_classifier_id = cct.id
        WHERE
            cc.date_to is null
        )
    WHERE pregp_id IS NOT NULL
    ORDER BY c_id;  
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.cob_pregp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_COB_PREGP_LINK', 'INSERT PBI.cob_pregp_link: ' || to_char(tmp_count) || ' (ROWS)');
END GET_COB_PREGP_LINK;

/* create GET_TITLE */
PROCEDURE GET_TITLE
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TITLE ' ;
    INSERT INTO title (title_number, title_type_id, cob_id,name,  start_year, finish_year) 
    SELECT DISTINCT t.title_number,
        (SELECT DISTINCT LAST_VALUE(tt.title_type_id) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
        FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as title_type_id,
        cc.cob_id,
        (SELECT DISTINCT FIRST_VALUE(tt.title_name) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from DESC) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) AS name,
        (SELECT DISTINCT FIRST_VALUE(tt.year) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as start_year,
        (SELECT MAX(tt.year) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as finish_year
        FROM   stroy.title t
        INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
        INNER JOIN stroy.cob_card cc ON cc.cob_id = ct.cob_id    
    WHERE  
        t.stage_id = 95
        AND t.state_id = 3;
        --AND t.title_number in (43385, 154796, 155177, 109157, 59048, 250866, 700858, 156645,156646,700181,700182,700987,700988,700989,700990,700991,700992,700993,700994,700995,701417,702949,702950,702951,702952);
       begin
        FOR x in (
                SELECT st.title_address, t.title_number
                FROM stroy.title st,
                        pbi.title t ,
                        (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                        FROM stroy.title stt
                        WHERE
                            stt.year >= 2014
                            AND stt.stage_id = 95
                            AND stt.state_id = 3
                        ) dat                
                    WHERE   
                         st.id = dat.id
                         and st.title_number = t.title_number
                         AND dat.rn = 1)
        loop
            update pbi.title
            set address = x.title_address
            where title_number = x.title_number;
        end loop;
        end;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.title;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_TITLE', 'INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
END GET_TITLE;

-- /* create GET_COB */
PROCEDURE GET_COB
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB ' ;
    INSERT INTO pbi.cob ( ID, NAME, ADDRESS, CENTER_LATITUDE, CENTER_LONGITUDE )
    WITH v_title AS
    (
        SELECT tt.id, tt.title_number, tt.delivery_date, tt.title_name AS name, tt.title_address
        FROM stroy.title tt,
            (
            SELECT t.id,  t.title_number,
                   row_number() over (partition by t.title_number order by t.year desc, t.date_from desc) as RN
            FROM stroy.title t
            WHERE
                t.year >= 2014
                AND t.delete_date is null
                AND t.stage_id = 95
                AND t.title_type_id in (1,2,3)
                AND t.state_id != 4
            ) dat
        WHERE   
             tt.id = dat.id
             AND dat.rn = 1
        ORDER BY tt.title_number
    )
    SELECT c.id, cc.name, cc.address,     
        ROUND(AVG(tge.center_latitude), 4), ROUND(AVG(tge.center_longitude), 4)
    FROM stroy.cob c    
        INNER JOIN stroy.cob_card cc ON cc.cob_id = c.id
        AND cc.date_to is NULL
        INNER JOIN stroy.cob_title ct ON ct.cob_id = c.id
        INNER JOIN v_title vt ON vt.title_number = ct.title_number
        LEFT JOIN stroy.title_geodata_egip tge ON  tge.title_number = vt.title_number
        AND tge.date_to is null
        LEFT JOIN stroy.title_costs_classifier tc ON tc.title_id = vt.id
    GROUP BY c.id, cc.name, cc.address
    ORDER BY c.id;

    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.cob;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_COB', 'INSERT PBI.COB: ' || to_char(tmp_count) || ' (ROWS)');
END GET_COB;

-- загрузка COB_DISTR_LINK
PROCEDURE GET_COB_DISTR_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_DISTR_LINK' ;
    INSERT INTO pbi.cob_distr_link(cob_id, distr_id) 
    SELECT DISTINCT  cob_id, distr_id
    FROM
        (
        SELECT DISTINCT  cob_id, get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
        FROM 
            (
            SELECT  cc.cob_id, adm.adm_region_id
            FROM stroy.cob c
                INNER JOIN stroy.cob_card cc ON c.id=cc.cob_id
                INNER JOIN stroy.cob_title ct ON ct.cob_id =c.id
                INNER JOIN v_title vt ON vt.title_number = ct.TITLE_NUMBER
                LEFT JOIN stroy.TITLE_ADM_REGION adm ON adm.TITLE_ID = vt.ID                    
                JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID                   
            WHERE 
                cc.date_to is null
                AND reg.delete_date is null
                AND reg .type = 3
                AND reg.adm_region_id != reg.id
        ) 
        UNION   
        SELECT DISTINCT cob_id, get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
        FROM 
            (
            SELECT  cc.cob_id, adm.adm_region_id
            FROM stroy.cob c
                LEFT JOIN stroy.cob_card cc ON c.id=cc.cob_id
                LEFT JOIN stroy.cob_title ct ON ct.cob_id =c.id
                INNER JOIN v_title vt ON vt.title_number = ct.TITLE_NUMBER
                LEFT JOIN STROY.title_adm_region_detail adm ON adm.TITLE_ID = vt.ID
                JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID
            WHERE cc.date_to is null
                AND reg.adm_region_id != reg.id
                AND reg .type = 3
                AND reg.delete_date is null
        )
    )
    ORDER BY cob_id;
 
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.cob_distr_link;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.COB_DISTR_LINK', 'INSERT PBI.COB_DISTR_LINK: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_COB_DISTR_LINK;

-- загрузка AO
PROCEDURE GET_AO
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.AO' ;
    
    INSERT INTO pbi.ao ( id,  name)
    select distinct reg.id, reg.name from 
     stroy.title t 
      JOIN stroy.TITLE_ADM_REGION adm ON adm.TITLE_ID = t.ID
      JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID
      WHERE reg.type = 2
     union 
     select distinct reg.id, reg.name from 
         stroy.title t 
      JOIN STROY.title_adm_region_detail adm ON adm.TITLE_ID = t.ID
      JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID
      WHERE reg.type = 2;

    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.ao;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.AO', 'INSERT PBI.AO: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_AO;

-- загрузка DISTR
PROCEDURE GET_DISTR
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.DISTR' ;
    
    INSERT INTO pbi.distr ( id, name, ao_id)
    SELECT DISTINCT a.distr_id, adm.name, get_adm_reg_by_adm_id(a.distr_id,2)  
    FROM pbi.cob_distr_link a
    JOIN stroy.adm_region  adm ON adm.id=a.distr_id;

    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.DISTR;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.DISTR', 'INSERT PBI.DISTR: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_DISTR;

/* create GET_FINANCING_SOURCE */
PROCEDURE GET_FINANCING_SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.FINANCING_SOURCE ' ;
    INSERT INTO financing_source (id, name) SELECT id, name FROM stroy.financing_source;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.financing_source;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_FINANCING_SOURCE', 'INSERT PBI.FINANCING_SOURCE: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
END GET_FINANCING_SOURCE;

/* create GET_POWER */
PROCEDURE GET_POWER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.POWER' ;
    INSERT INTO power (id, name, result_aip_id) 
    SELECT power_id, name, result_aip_entity_id
    FROM
    (
        SELECT DISTINCT m.power_id, p.name, psp.result_aip_entity_id,
        DENSE_RANK() OVER (PARTITION BY psp.power_id ORDER BY psp.power_id, psp.result_aip_entity_id) AS rn
        FROM pbi.main m
            LEFT JOIN stroy.power_state_program psp ON psp.power_id = m.power_id
            INNER JOIN stroy.power p ON p.id = m.power_id
        WHERE m.power_id IS NOT NULL
    )
    WHERE rn = 1;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.power;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_POWER', 'INSERT PBI.POWER: ' || to_char(tmp_count) || ' (ROWS)');
END GET_POWER;

/* create RESULT_AIP */
PROCEDURE GET_RESULT_AIP
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.RESULT_AIP ' ;
    INSERT INTO pbi.result_aip (id, name, unit) SELECT id, name, name_unit FROM stroy.result_aip;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.result_aip;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_RESULT_AIP', 'INSERT PBI.RESULT_AIP: ' || to_char(tmp_count) || ' (ROWS)');
END GET_RESULT_AIP;

/* create MSK_GOV_PROGRAM */
PROCEDURE GET_MSK_GOV_PROGRAM
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MSK_GOV_PROGRAM ' ;
    INSERT INTO pbi.msk_gov_program (id, name) SELECT id, name FROM stroy.msk_gov_program;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.msk_gov_program;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MSK_GOV_PROGRAM', 'INSERT PBI.MSK_GOV_PROGRAM: ' || to_char(tmp_count) || ' (ROWS)');
END GET_MSK_GOV_PROGRAM;

/* create PP */
PROCEDURE GET_PP
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
	tmp NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PP' ;
	INSERT INTO pp (id, name, gp_lf_id) 
    SELECT DISTINCT
	  sp.id,
	  '('||sp.VALUE ||') '||sp.NAME  AS PP,
      CASE 
		WHEN sp.parent_id IS NULL THEN sp.id 
		ELSE sp.parent_id 
	  END AS GP_LF
FROM
    cob_pp_link	 ml
	JOIN stroy.state_program sp ON sp.id = ml.pp_id ;
   
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pp;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2VGET_PP', 'INSERT PBI.PP: ' || to_char(tmp_count) || ' (ROWS)');
	END GET_PP;

/* create PREGP */
PROCEDURE GET_PREGP 
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
	tmp NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PREGP' ;
    FOR x IN ( SELECT distinct cc.id, '('||cc.code ||') '|| cc.name as name
                        FROM stroy.costs_classifier cc
                        INNER JOIN cob_pregp_link mpl ON mpl.pregp_id = cc.id)
    LOOP
        BEGIN
                SELECT
                    distinct FIRST_VALUE(cc.id) OVER (ORDER BY cc.id)  as pp_id INTO tmp
                FROM 
                    stroy.costs_classifier cc 
                START WITH cc.id = x.id
                CONNECT BY NOCYCLE PRIOR cc.costs_classifier_id = cc.id;                
            EXCEPTION WHEN OTHERS THEN
                 tmp := 1;
            END;
            INSERT INTO PBI.PREGP (id, name, gp_id) 
            VALUES (x.id, x.name, tmp);
    END LOOP;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pregp;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.PREGP', 'INSERT PBI.PREGP: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PREGP;

-- загрузка GP
PROCEDURE GET_GP
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.GP' ;
    INSERT INTO pbi.gp(ID,name) 
    select  DISTINCT cc.id, '('||stt.VALUE ||') '||stt.NAME 
    from pregp p 
    inner join stroy.costs_classifier cc on p.gp_id = cc.id
    INNER JOIN stroy.state_program stt ON cc.state_program_id = stt.id;

    INSERT INTO pbi.gp(ID,name) 
    SELECT  cc.id, cc.NAME FROM stroy.costs_classifier cc,
    (select  p.gp_id as id from pregp p
    minus
    select id as id  from gp) dat
    WHERE dat.id = cc.id ;

    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.gp;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_GP', 'INSERT PBI.GP: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_GP;

-- загрузка GET_TITLE_TYPE
PROCEDURE GET_TITLE_TYPE
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TITLE_TYPE' ;
    INSERT INTO pbi.title_type(ID,name) 
    VALUES(1, 'СМР');
	
	INSERT INTO pbi.title_type(ID,name) 
    VALUES(2, 'СМР');
	
	INSERT INTO pbi.title_type(ID,name) 
    VALUES(3, 'ПИР');
    
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.title_type;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_TITLE_TYPE', 'INSERT PBI.TITLE_TYPE: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_TITLE_TYPE;

-- загрузка GET_TITLE_STATE
PROCEDURE GET_TITLE_STATE
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TITLE_STATE' ;
    INSERT INTO pbi.title_state(ID,name) 
    SELECT id, caption FROM stroy.title_state;
    
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.title_state;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_TITLE_STATE', 'INSERT PBI.TITLE_STATE: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_TITLE_STATE;

-- загрузка GP
PROCEDURE GET_GP_LF
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.GP_LF' ;
    INSERT INTO pbi.gp_lf(ID,name) 
    SELECT DISTINCT stt.id, '('||stt.VALUE ||') '||stt.NAME 
    FROM stroy.costs_classifier cc
        INNER JOIN stroy.state_program stt ON cc.state_program_id = stt.id
    WHERE cc.state_program_id IS NOT NULL 
        AND cc.costs_classifier_id IS NULL;

    INSERT INTO pbi.gp_lf(ID,name) 
    select DISTINCT stt.id, '('||stt.VALUE ||') '||stt.NAME  
    from  stroy.state_program stt 
    where id in (select GP_LF_ID from pp minus select id from gp_lf);

    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.gp_lf;    
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_GP', 'INSERT PBI.GP_LF: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_GP_LF;

/* create GET_ALL_DISTR */
PROCEDURE GET_ALL_DISTR
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_id number := 1000000;
    SUBTYPE ao IS VARCHAR2(64);
    TYPE distr IS TABLE OF NUMBER INDEX BY ao;
   tmp_link distr;
   t ao;
   temp_id number;
    
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.DISTR' ;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_DISTR_LINK' ;
    FOR x IN
        (
        WITH dat as
            (
                SELECT c.id as cob_id, t.id title_id
                FROM  cob c
                    INNER JOIN stroy.cob_title ct ON ct.cob_id = c.id
                    INNER JOIN v_title t ON t.title_number = ct.title_number
              --  WHERE t.STAGE_ID = 95
                       -- AND t.id = 1765032
            )
        SELECT distinct dat.cob_id, ar.id distr, ar.name, get_adm_reg_by_adm_id(ar.id,2) ao
        FROM  dat
            LEFT JOIN stroy.title_adm_region_detail tard ON tard.title_id = dat.title_id 
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 3
        UNION
        SELECT distinct dat.cob_id, ar.id, ar.name, get_adm_reg_by_adm_id(ar.id,2) 
        FROM  dat
            LEFT JOIN stroy.title_adm_region tard ON tard.title_id = dat.title_id 
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 3
        )
    LOOP
        IF x.distr is not null and x.name is not null and x.ao != 0
        THEN        
            INSERT INTO pbi.cob_distr_link(cob_id, distr_id) 
            VALUES(x.cob_id, x.distr);
        END IF;
    END LOOP;
    
   begin
    FOR x IN
        (
            WITH dat as
                (
                    SELECT c.cob_id as cob_id, t.id title_id
                    FROM  
                        (
                        select id cob_id from cob
                        minus
                        select cob_id from cob_distr_link 
                        ) c
                        INNER JOIN stroy.cob_title ct ON ct.cob_id = c.cob_id
                        INNER JOIN v_title t ON t.title_number = ct.title_number
                   -- WHERE t.STAGE_ID = 95
                            --AND t.id = 1765032
                )
            SELECT dat.cob_id, ar.id, ar.name, get_adm_reg_by_adm_id(ar.id,2) ao
            FROM  dat
                LEFT JOIN stroy.title_adm_region_detail tard ON tard.title_id = dat.title_id
                LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
                  AND ar."TYPE" = 2
            UNION 
            SELECT distinct dat.cob_id, ar.id, ar.name, get_adm_reg_by_adm_id(ar.id,2) 
            FROM dat
                LEFT JOIN stroy.title_adm_region tard ON tard.title_id = dat.title_id
                LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
                  AND ar."TYPE" = 2
        )
        LOOP
            IF x.id is not null and x.name is not null and x.ao != 0
            THEN
                BEGIN
                    DBMS_OUTPUT.PUT_LINE(';');
                    temp_id := tmp_link(to_char(x.ao));  
                    DBMS_OUTPUT.PUT_LINE(temp_id);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    tmp_id := tmp_id + 1;
                    DBMS_OUTPUT.PUT_LINE('a');
                    tmp_link(to_char(x.ao)) := tmp_id;
                    temp_id := tmp_id;
                    INSERT INTO pbi.distr(id, name, ao_id) 
                    VALUES(tmp_id, 'Район не указан', x.ao);
                END;            
                
                INSERT INTO pbi.cob_distr_link(cob_id, distr_id) 
                VALUES(x.cob_id, temp_id);
            END IF;
        END LOOP;
    end;
    
    FOR x IN
    (
        WITH dat as
            (
                SELECT c.id as cob_id, t.id title_id
                FROM  cob c
                    INNER JOIN stroy.cob_title ct ON ct.cob_id = c.id
                    INNER JOIN v_title t ON t.title_number = ct.title_number
                --WHERE t.STAGE_ID = 95
            )
        SELECT ar.id, ar.name, get_adm_reg_by_adm_id(ar.id,2) ao
        FROM  dat
            LEFT JOIN stroy.title_adm_region_detail tard ON tard.title_id = dat.title_id 
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 3
        UNION
        SELECT ar.id, ar.name, get_adm_reg_by_adm_id(ar.id,2) ao
        FROM  dat
            LEFT JOIN stroy.title_adm_region tard ON tard.title_id = dat.title_id 
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 3
            )
    LOOP
        IF x.id is not null and x.name is not null and x.ao != 0
        THEN
            INSERT INTO pbi.distr(id, name, ao_id) 
            VALUES(x.id, x.name, x.ao);
        END IF;
    END LOOP;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.distr;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.DISTR', 'INSERT PBI.DISTR: ' || to_char(tmp_count) || ' (ROWS)');
    SELECT COUNT(*) INTO tmp_count FROM pbi.cob_distr_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.COB_DISTR_LINK', 'INSERT PBI.COB_DISTR_LINK: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
END GET_ALL_DISTR;

PROCEDURE NO_COB
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_cob_id NUMBER := 1000000;
    title_address VARCHAR2(4000);
    tmp number;
BEGIN
    FOR x in (
        SELECT tt.id, tt.title_number, tt.delivery_date, tt.title_name AS name, tt.title_address
        FROM stroy.title tt,
            (
            SELECT t.id,  t.title_number,
                   row_number() over (partition by t.title_number order by t.year desc, t.date_from desc) as RN
            FROM stroy.title t
            WHERE
                t.year >= 2014
                AND t.delete_date is null
                AND t.stage_id = 95
                AND t.title_type_id in (1,2,3)
                AND t.state_id != 4
            ) dat
        WHERE   
             tt.id = dat.id
             AND dat.rn = 1
             AND NOT EXISTS (SELECT 1 FROM stroy.cob_title cc WHERE cc.title_number = tt.title_number)
        ORDER BY tt.title_number)
    LOOP
         tmp_cob_id := tmp_cob_id + 1;
         INSERT INTO title (title_number, title_type_id, cob_id,name,  start_year, finish_year) 
            SELECT DISTINCT t.title_number,
                (SELECT DISTINCT LAST_VALUE(tt.title_type_id) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) FROM stroy.title tt
                    WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as title_type_id,
                tmp_cob_id,
                (SELECT DISTINCT FIRST_VALUE(tt.title_name) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from DESC) FROM stroy.title tt
                    WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) AS name,
                 (SELECT DISTINCT FIRST_VALUE(tt.year) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from) FROM stroy.title tt
                    WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as start_year,
                (SELECT MAX(tt.year) FROM stroy.title tt
                    WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as finish_year
                FROM   stroy.title t
            WHERE  
                t.stage_id = 95
                AND t.title_number = x.title_number
                AND t.state_id = 3;
                
        begin
        FOR xx in (
                SELECT st.title_address, t.title_number
                FROM stroy.title st,
                        pbi.title t ,
                        (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                        FROM stroy.title stt
                        WHERE
                            stt.year >= 2014
                            AND stt.stage_id = 95
                            AND stt.state_id = 3
                        ) dat                
                    WHERE   
                         st.id = dat.id
                         and st.title_number = t.title_number
                        and st.title_number = x.title_number
                         AND dat.rn = 1)
        loop
            update pbi.title
            set address = xx.title_address
            where title_number = xx.title_number;
        end loop;
        end;
        SELECT count(*) INTO tmp FROM title WHERE cob_id = tmp_cob_id;
        IF tmp > 0 THEN
            INSERT INTO pbi.cob ( ID, name)
            VALUES (tmp_cob_id, 'Не распределенные титула');
        END IF;
    END LOOP;
    COMMIT;
END NO_COB ;

/* create VALUE_PLAN */
PROCEDURE GET_VALUE_PLAN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.VALUE_PLAN';
    
    EXECUTE IMMEDIATE '
    INSERT INTO pbi.VALUE_PLAN (MAIN_ID,  VALUE, "YEAR", IS_CURR)
       WITH predtitle AS (
SELECT t.id, 
	t.date_from,
	DECODE(EXTRACT (YEAR FROM t.DATE_TO),t.YEAR,t.DATE_TO,NULL) AS DATE_TO,
	t.TITLE_NUMBER,
	t.YEAR
FROM stroy.TITLE t 
WHERE 1=1
  --AND TITLE_NUMBER=43778 
  and STAGE_ID =95
  AND t."YEAR" >=2014
  AND t.STATE_ID =3
  AND t."YEAR" = EXTRACT (YEAR FROM t.DATE_FROM)
  AND t.id IN (SELECT max(t2.id) 
  -- выбираем только последние версии, если за день начинается несколько титулов
				FROM stroy.TITLE t2
				WHERE 1=1
					AND t2."YEAR" >=2014
					AND t2.STAGE_ID = 95
				GROUP BY t2.TITLE_NUMBER, TO_CHAR(t2.DATE_FROM,''yyyymmdd''))
),
dat AS (
-- считаем начальные цифры
SELECT ct.COB_ID,
	vc.id AS M_DATE,
	vc."YEAR" AS M_YEAR,
	pt.TITLE_NUMBER,
	bic.financing_source_id,
    bc.EXPENCE_KIND,
	CASE 
        WHEN biv."YEAR" = pt."YEAR" then  biv.value 
	END AS VALUE_CURR_1_EL,
	CASE 
        WHEN biv."YEAR" = pt."YEAR"+1 then  biv.value 
	END AS VALUE_CURR_2_EL,
	CASE 
        WHEN biv."YEAR" = pt."YEAR"+2 then  biv.value 
	END AS VALUE_CURR_3_EL,
	CASE 
        WHEN biv."YEAR" = pt."YEAR"+3 then  biv.value 
	END AS VALUE_CURR_4_EL
FROM stroy.COB_TITLE ct 
JOIN predtitle pt ON ct.TITLE_NUMBER = pt.TITLE_NUMBER
	join stroy.build_indicator bi ON bi.title_id = pt.id
		AND bi.build_indicator_type_id IN ( 3 )
        -- мощности (6) и деньги (3)
	join stroy.build_indicator_value biv ON biv.build_indicator_id = bi.id
         /* план не текущий год (1)*/
		AND biv.build_indicator_value_type_id IN ( 1)
        AND biv.quarter_number IS NULL
left join stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
LEFT JOIN stroy.BUDGET_CLASSIFIER bc ON bc.id = bic.BUDGET_CLASSIFIER_ID 
-- находим даты календаря, в которые существовали нужные нам версии титулов и которые присутсвуют в main таблице
JOIN pbi.CALENDAR vc ON vc.DT BETWEEN pt.DATE_FROM AND nvl(pt.date_to, to_date(pt.year||''-12-31'',''YYYY-MM-DD''))
	AND vc.ID IN (SELECT vm2.CALENDAR_ID FROM pbi.TMP_$_MAIN vm2 WHERE vm2.TITLE_NUMBER = pt.TITLE_NUMBER AND  vm2.cob_id =ct.COB_ID )
	),
curr_sum AS(
-- считаем агрегаты
SELECT COB_ID,
	M_DATE,
	TITLE_NUMBER,
	M_YEAR,
	financing_source_id,
    sum(VALUE_CURR_1_EL) AS VALUE_CURR_1,
    SUM(VALUE_CURR_2_EL) AS VALUE_CURR_2,
    SUM(VALUE_CURR_3_EL) AS VALUE_CURR_3,
    SUM(VALUE_CURR_4_EL) AS VALUE_CURR_4
FROM dat
GROUP BY  COB_ID,
	M_DATE,
	TITLE_NUMBER,
	M_YEAR,
	financing_source_id),
sum_trans AS (
--транспонируем и склеиваем таблицу
SELECT financing_source_id, COB_ID, M_DATE, TITLE_NUMBER, NVL(VALUE_CURR_1,0) AS VALUE, M_YEAR AS YEAR, 1 AS IS_CURR FROM curr_sum
UNION ALL
SELECT financing_source_id, COB_ID, M_DATE, TITLE_NUMBER, NVL(VALUE_CURR_2,0) AS VALUE, M_YEAR+1, null FROM curr_sum
UNION ALL
SELECT financing_source_id, COB_ID, M_DATE, TITLE_NUMBER, NVL(VALUE_CURR_3,0) AS VALUE, M_YEAR+2, null FROM curr_sum
UNION ALL
SELECT financing_source_id, COB_ID, M_DATE, TITLE_NUMBER, NVL(VALUE_CURR_4,0) AS VALUE, M_YEAR+3, null FROM curr_sum)
-- забираем соответсвующие ID из таблицы MAIN
SELECT vmg.ID AS main_id,
	sum_trans.VALUE,
	sum_trans."YEAR",
	sum_trans.IS_CURR
FROM sum_trans
JOIN pbi.TMP_$_MAIN vmg ON vmg.COB_ID = sum_trans.COB_ID 
	and vmg.CALENDAR_ID = sum_trans.M_DATE
	AND vmg.FINANCING_SOURCE_ID = sum_trans.FINANCING_SOURCE_ID 
	AND vmg.TITLE_NUMBER = sum_trans.TITLE_NUMBER';
         
END GET_VALUE_PLAN;

/* create V3_CALENDAR */
PROCEDURE GET_V3_CALENDAR
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    start_date date := to_date('01.01.2014','dd.mm.yyyy');
    n_day number;
    tmp_date date;
    tmp_count number;
BEGIN
  --  EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.V3_CALENDAR ' ;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.CALENDAR ' ;
    tmp_date := start_date - 1;
    select  round(sysdate - to_date('01.01.2014','dd.mm.yyyy'))  into n_day from dual;
    for x in 1..n_day
    loop
        tmp_date := tmp_date + 1;     
    --    INSERT INTO pbi.v3_calendar (id, year, quarter, month, day, dt)
    --    VALUES (to_char(tmp_date, 'yyyymmdd'), to_char(tmp_date, 'yyyy'), to_char(trunc(tmp_date, 'q'),'q'), to_char(tmp_date, 'mm'), to_char(tmp_date, 'dd'), tmp_date);
        
        INSERT INTO pbi.calendar (id, year, quarter, month, day, dt)
        VALUES (to_char(tmp_date, 'yyyymmdd'), to_char(tmp_date, 'yyyy'), to_char(trunc(tmp_date, 'q'),'q'), to_char(tmp_date, 'mm'), to_char(tmp_date, 'dd'), tmp_date);
    end loop;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.calendar;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_CALENDAR', 'INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
--    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
END GET_V3_CALENDAR;

/*create COB_PP_LINK */
PROCEDURE GET_COB_PP_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.cob_pp_link ' ;
	INSERT INTO cob_pp_link  
	WITH
    dat2 as
        (
                  SELECT st.title_address, t.title_number, t.id title_id
                FROM stroy.title st,
                        stroy.title t ,
                        (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                        FROM stroy.title stt
                        WHERE
                            stt.year >= 2014
                            AND stt.stage_id = 95
                            AND stt.state_id = 3
                        ) dat                
                    WHERE   
                         st.id = dat.id
                         and st.title_number = t.title_number
                         AND dat.rn = 1
            )
	SELECT distinct ct.cob_id,
		sp2.id pp_id
	FROM stroy.COB_TITLE ct 
	JOIN stroy.TITLE t ON ct.TITLE_NUMBER = t.TITLE_NUMBER
	INNER JOIN dat2 ON dat2.title_id = t.id
	JOIN stroy.BUILD_INDICATOR bi ON bi.TITLE_ID = t.ID AND bi.BUILD_INDICATOR_TYPE_ID =3
	JOIN stroy.BUILD_INDICATOR_CLASSIFIER bic ON bic.id = bi.BUILD_INDICATOR_CLASSIFIER_ID
	JOIN stroy.BUDGET_CLASSIFIER bc ON bc.ID = bic.BUDGET_CLASSIFIER_ID 
	JOIN stroy.STATE_PROGRAM sp ON bc.STATE_PROGRAM_ID = sp.ID 
	JOIN stroy.STATE_PROGRAM sp2 ON sp.PARENT_ID = sp2.id
	JOIN stroy.STATE_PROGRAM sp3 ON sp2.PARENT_ID = sp3.id
	WHERE 
        t."YEAR" >=2014
	    AND t.STAGE_ID =95;
	commit;
    SELECT COUNT(*) INTO tmp_count FROM pbi.cob_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.COB_PP_LINK', 'INSERT PBI.COB_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');
END GET_COB_PP_LINK;

/*create GRBS */
PROCEDURE GET_GRBS
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
     tmp_count number;
     tmp number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.GRBS ' ;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_GRBS_LINK ' ;
    INSERT INTO pbi.cob_grbs_link  
        WITH
    dat2 as
        (
                SELECT  dat.id title_id, title_number
                FROM 
                    (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                        FROM stroy.title stt
                        WHERE
                            stt.year >= 2014
                            AND stt.stage_id = 95
                            AND stt.state_id = 3
                        ) dat                
                    WHERE   
                         dat.rn = 1
            )
    SELECT ct.cob_id,
        o.id
    FROM  dat2
        INNER JOIN stroy.cob_title ct ON dat2.title_number = ct.title_number 
        JOIN stroy.title_subject_org tso ON tso.title_id = dat2.title_id
            AND tso.Organization_Role_Type_Id = 2
            AND tso.is_main = 'Y'
        JOIN stroy.organization o ON o.ID = tso.organization_id 
    WHERE 1=1 
    GROUP BY ct.cob_id , o.id;
    
    INSERT INTO PBI.GRBS
    SELECT distinct o.id, o.full_name
    FROM pbi.cob_grbs_link cgl
    INNER JOIN stroy.organization o ON o.id = cgl.grbs_id ;
	commit;
    SELECT COUNT(*) INTO tmp_count FROM pbi.grbs;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GRBS', 'INSERT PBI.GRBS: ' || to_char(tmp_count) || ' (ROWS)');
END GET_GRBS;

/*create PREGRBS */
PROCEDURE GET_PREGRBS
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
     tmp_count number;
     tmp number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PREGRBS ' ;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_PREGRBS_LINK ' ;
    INSERT INTO pbi.cob_pregrbs_link  
    WITH
    dat2 as
        (
                SELECT  dat.id title_id, title_number
                FROM 
                    (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                        FROM stroy.title stt
                        WHERE
                            stt.year >= 2014
                            AND stt.stage_id = 95
                            AND stt.state_id = 3
                        ) dat                
                    WHERE   
                         dat.rn = 1
            )
    SELECT ct.cob_id,
        o.id
    FROM  dat2
        INNER JOIN stroy.cob_title ct ON dat2.title_number = ct.title_number 
        JOIN stroy.title_subject_org tso ON tso.title_id = dat2.title_id
            AND tso.Organization_Role_Type_Id = 3
        JOIN stroy.organization o ON o.ID = tso.organization_id 
    WHERE 1=1 
    GROUP BY ct.cob_id , o.id;
    
    INSERT INTO PBI.PREGRBS
    SELECT distinct o.id, o.full_name
    FROM pbi.cob_pregrbs_link cgl
    INNER JOIN stroy.organization o ON o.id = cgl.pregrbs_id ;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pregrbs;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.PREGRBS', 'INSERT PBI.PREGRBS: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PREGRBS;

/*create GET_PPM */
PROCEDURE GET_PPM
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
     tmp_count number;
     tmp number;
BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.PPM';
INSERT INTO  PPM 
WITH el_values AS (
SELECT 
	DOC.DOC_NUMBER, 
	DOC.DOC_DATE,
	CASE 
        WHEN BA."YEAR" = EXTRACT (YEAR FROM doc.DOC_DATE)then  BA.AMOUNT * 1000000
	END AS VALUE_PPM_1_EL,
	CASE 
        WHEN BA."YEAR" = EXTRACT (YEAR FROM doc.DOC_DATE)+1 then  BA.AMOUNT * 1000000
	END AS VALUE_PPM_2_EL,
	CASE 
        WHEN BA."YEAR" = EXTRACT (YEAR FROM doc.DOC_DATE)+2 then  BA.AMOUNT * 1000000
	END AS VALUE_PPM_3_EL,
	CASE 
        WHEN BA."YEAR" = EXTRACT (YEAR FROM doc.DOC_DATE)+3 then  BA.AMOUNT * 1000000
	END AS VALUE_PPM_4_EL 
FROM stroy.BUDGET_ALLOCATION BA
JOIN stroy.DOCUMENT DOC ON BA.DOCUMENT_ID = DOC.ID),
sum_ppm AS (SELECT DOC_NUMBER, 
	DOC_DATE,
	SUM(VALUE_PPM_1_EL) AS VALUE_PPM_1,
	SUM(VALUE_PPM_2_EL) AS VALUE_PPM_2,
	SUM(VALUE_PPM_3_EL) AS VALUE_PPM_3,
	SUM(VALUE_PPM_4_EL) AS VALUE_PPM_4
FROM el_values
GROUP BY DOC_NUMBER, 
	DOC_DATE
),
sum_ppm_trans AS (
SELECT DOC_NUMBER, DOC_DATE, VALUE_PPM_1 AS VALUE, EXTRACT (YEAR FROM DOC_DATE) AS YEAR, 1 AS IS_CURR FROM sum_ppm
UNION ALL
SELECT DOC_NUMBER, DOC_DATE, VALUE_PPM_2 AS VALUE, EXTRACT (YEAR FROM DOC_DATE)+1 AS YEAR, null FROM sum_ppm
UNION ALL
SELECT DOC_NUMBER, DOC_DATE, VALUE_PPM_3 AS VALUE, EXTRACT (YEAR FROM DOC_DATE)+2 AS YEAR, null FROM sum_ppm
UNION ALL
SELECT DOC_NUMBER, DOC_DATE, VALUE_PPM_4 AS VALUE, EXTRACT (YEAR FROM DOC_DATE)+3 AS YEAR, null FROM sum_ppm)
SELECT vc.id AS CALENDAR_ID,
	sum_ppm_trans.VALUE,
	sum_ppm_trans."YEAR",
	sum_ppm_trans.IS_CURR,
	sum_ppm_trans.DOC_NUMBER
FROM sum_ppm_trans
JOIN pbi.CALENDAR vc ON vc.dt = DOC_DATE;
END GET_PPM;

/*create DELETE */
PROCEDURE DELETE_FINAL
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
BEGIN

    DELETE FROM TITLE t 
    WHERE t.TITLE_NUMBER NOT IN (SELECT m.TITLE_NUMBER FROM MAIN m);
    
    DELETE FROM COB c
    WHERE c.ID NOT IN (SELECT t.COB_ID FROM TITLE t);
    
    DELETE FROM COB_DISTR_LINK cdl 
    WHERE cdl.COB_ID NOT IN (SELECT id FROM cob);
    
    DELETE FROM DISTR d
    WHERE d.ID NOT IN (SELECT cdl.DISTR_ID FROM COB_DISTR_LINK cdl);
    
    DELETE FROM AO a 
    WHERE a.ID NOT IN (SELECT d.AO_ID FROM DISTR d);
    
    DELETE FROM COB_PREGP_LINK cpl 
    WHERE cpl.COB_ID NOT IN (SELECT id FROM cob);
    
    DELETE FROM PREGP p
    WHERE p.ID NOT IN (SELECT cpl.PREGP_ID FROM COB_PREGP_LINK cpl);
    
    DELETE FROM GP g 
    WHERE g.ID NOT IN (SELECT p.GP_ID FROM PREGP p);
    
    DELETE FROM COB_AIP_LINK cal 
    WHERE cal.COB_ID NOT IN (SELECT id FROM cob);
    
    DELETE FROM COB_PP_LINK cpl2
    WHERE cpl2.cob_id NOT IN  (SELECT id FROM cob);
    
    DELETE FROM PP pp
    WHERE pp.ID NOT IN (SELECT cpl2.PP_ID FROM COB_PP_LINK cpl2);
    
    DELETE FROM GP_LF gl 
    WHERE gl.ID NOT IN (SELECT p.GP_LF_ID FROM PP p);
    
    DELETE FROM COB_GRBS_LINK cgl
    WHERE cgl.cob_id NOT IN  (SELECT id FROM cob);
    
    DELETE FROM GRBS gr
    WHERE gr.ID NOT IN (SELECT cgl.GRBS_ID FROM COB_GRBS_LINK cgl);
    
    DELETE FROM COB_PREGRBS_LINK cpgl
    WHERE cpgl.cob_id NOT IN  (SELECT id FROM cob);
    
    DELETE FROM PREGRBS pgr
    WHERE pgr.ID NOT IN (SELECT cpgl.PREGRBS_ID FROM COB_PREGRBS_LINK cpgl);


    BEGIN
    FOR x in (SELECT table_name FROM all_tables WHERE owner = 'PBI' AND table_name like 'TMP_$%')
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || x.table_name;
    END LOOP;
    commit;
    END;

END DELETE_FINAL;

/* create TMP_$TMP_$_MAIN */
PROCEDURE GET_TMP_$_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'TMP_$_MAIN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TMP_$_MAIN CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE pbi.TMP_$_MAIN AS
		WITH predtitle AS (
SELECT t.id, 
	t.date_from,
	DECODE(EXTRACT (YEAR FROM t.DATE_TO),t.YEAR,t.DATE_TO,NULL) AS DATE_TO,
	t.TITLE_NUMBER,
	CASE 
		WHEN t.IS_RSI_O = ''Y'' THEN 5
		WHEN t.IS_MFZPD = ''Y'' THEN 4
		WHEN t.IS_RSI = ''Y'' THEN 3
		WHEN t.IS_RENOVATION = ''Y'' THEN 2
		ELSE 1
	END AS msk_gov_program_id,
	t.state_id,
	t.YEAR,
	t.STAGE_ID
FROM stroy.TITLE t 
WHERE 1=1
  --AND TITLE_NUMBER=703649 
	and STAGE_ID =95
	AND t."YEAR" >=2014
	AND t."YEAR" = EXTRACT (YEAR FROM t.DATE_FROM)
	-- выбираем только последние версии, если за день начинаетс¤ несколько титулов
	AND t.id IN (SELECT max(t2.id) 
				FROM (
					SELECT t.id, t.TITLE_NUMBER, t.DATE_FROM 
					FROM stroy.title t 
					WHERE t."YEAR" >=2014 
						AND t.STAGE_ID = 95) t2
				GROUP BY t2.TITLE_NUMBER, TO_CHAR(t2.DATE_FROM,''yyyymmdd''))
),
title_date AS (
SELECT pt.id,
	MAX(vc.DT) AS M_DATE
FROM predtitle pt 
JOIN pbi.CALENDAR vc ON vc.DT BETWEEN pt.DATE_FROM AND nvl(pt.date_to, to_date(pt.year||''-12-31'',''YYYY-MM-DD''))
WHERE pt."YEAR" >=2014
	AND pt.STAGE_ID =95
GROUP BY pt.id,
	vc."MONTH"
UNION 
SELECT pt.id,
	min(c.DT) AS M_DATE 
FROM predtitle pt 
JOIN pbi.CALENDAR c ON c.DT BETWEEN pt.DATE_FROM AND nvl(pt.date_to, to_date(pt.year||''-12-31'',''YYYY-MM-DD''))
WHERE pt."YEAR" >=2014
	AND pt.STAGE_ID =95
GROUP BY pt.id),
dat AS (
SELECT 	M_DATE,
	t3.TITLE_NUMBER,   
    t3.msk_gov_program_id AS MS,
    NVL(bic.financing_source_id,0) AS FS, -- 0 дл¤ мощностей
    p.id power_id,
    t3.state_id title_state_id,
    bc.EXPENCE_KIND, -- дл¤ случа¤, когда в титуле 2 »‘ идентичные по цифрам,
	CASE -- предельники
		WHEN  build_indicator_type_id = 3 AND build_indicator_value_type_id = 3 then  biv.value
		WHEN  build_indicator_type_id = 6 AND build_indicator_value_type_id = 2 then  biv.value 
	END AS VALUE_FULL_EL,
	CASE -- выполнение
		WHEN  build_indicator_type_id = 3 AND build_indicator_value_type_id = 4 then  biv.value 
        WHEN  build_indicator_type_id = 6 AND build_indicator_value_type_id = 4 then  biv.value 
	END AS VALUE_DONE_EL,
	CASE -- контрактуемый лимит
        WHEN  build_indicator_type_id = 3 AND build_indicator_value_type_id = 1 AND (bc.EXPENCE_KIND IN (323, 414, 411) OR bc.EXPENCE_KIND LIKE ''2__'') then  biv.value 
	END AS VALUE_CONTR_EL 
FROM stroy.COB_TITLE ct 
JOIN predtitle t3 ON ct.TITLE_NUMBER = t3.TITLE_NUMBER 
JOIN title_date ON title_date.ID = t3.id  -- размазываем значение версии титула на все дни, в которые она действует
join stroy.build_indicator bi ON bi.title_id = t3.id
-- нужно учесть что исключены мощности (6)
	AND bi.build_indicator_type_id IN ( 3, 6 )
        -- мощности (6) и деньги (3)
	join stroy.build_indicator_value biv ON biv.build_indicator_id = bi.id
         /* план не текущий год (1). по ѕ—ƒ (2) контрактна¤ цена (3) и выполнено (4) */
		AND biv.build_indicator_value_type_id IN ( 1, 2, 3, 4 )
        AND ( biv.year IS NULL OR biv.year = t3.year )
        AND biv.quarter_number IS NULL
left join stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
left join stroy.power p ON p.id = bic.power_id 
left join stroy.economical_classifier ec ON ec.id = bic.economical_classifier_id
LEFT JOIN stroy.BUDGET_CLASSIFIER bc ON bc.id = bic.BUDGET_CLASSIFIER_ID 
),
dat_gr AS (
-- считаем агрегаты дл¤ итоговых строк таблицы
SELECT M_DATE,
	TITLE_NUMBER,   
    MAX(MS) AS MS,
    FS,
    power_id,
    MAX(title_state_id) AS title_state_id,
    nullif(sum(VALUE_FULL_EL),0) AS VALUE_FULL,
    nullif(SUM(VALUE_DONE_EL),0) AS VALUE_DONE,
    nullif(SUM(VALUE_CONTR_EL),0) AS VALUE_CONTR
FROM dat
GROUP BY  M_DATE,
	TITLE_NUMBER, 
    FS,
    power_id),
fs_date AS (
-- нахожу корректную дату начала каждого FC в титуле
SELECT 
  min(M_DATE) AS min_FC_date,
  FS,
  TITLE_NUMBER
FROM (SELECT M_DATE, FS, TITLE_NUMBER FROM dat_gr WHERE VALUE_FULL IS NOT NULL AND TITLE_STATE_ID = 3 AND POWER_ID IS NULL)   
GROUP BY FS,
  TITLE_NUMBER),
power_date AS (
-- нахожу корректную дату начала каждой мощности в титуле
SELECT 
  min(M_DATE) AS min_power_date,
  power_id,
  TITLE_NUMBER
FROM (SELECT M_DATE, POWER_ID, TITLE_NUMBER FROM dat_gr WHERE VALUE_FULL IS NOT NULL AND TITLE_STATE_ID = 3 AND POWER_ID IS NOT NULL) 
GROUP BY power_id,
  TITLE_NUMBER),
min_date_titles AS (
-- нахожу дату, после которой данные в титуле считаютс¤ валидными
SELECT min(min_FC_date) AS min_title_date,
	TITLE_NUMBER
FROM fs_date
GROUP BY TITLE_NUMBER
),
full_table AS (
-- собираю полную итоговую таблицу
SELECT dat_power.m_date,
 	EXTRACT (MONTH FROM M_DATE) AS "MONTH",
	EXTRACT (YEAR FROM M_DATE) AS "YEAR" ,
	dat_power.TITLE_NUMBER,
	dat_power.MS AS MSK_GOV_PROGRAM_ID,
	dat_power.FS AS FINANCING_SOURCE_ID,
	dat_power.POWER_ID,
	dat_power.TITLE_STATE_ID,
	dat_power.VALUE_FULL,
	dat_power.VALUE_DONE,
	dat_power.VALUE_CONTR
FROM dat_gr dat_power 
-- оставл¤ю правильные мощности
JOIN power_date ON dat_power.TITLE_NUMBER = power_date.TITLE_NUMBER
	AND dat_power.M_DATE >= power_date.min_power_date
	AND dat_power.POWER_ID = power_date.POWER_ID
JOIN min_date_titles ON min_date_titles.TITLE_NUMBER = power_date.TITLE_NUMBER	
	AND dat_power.M_DATE >= min_date_titles.min_title_date
UNION ALL 
SELECT	dat_fs.m_date,
 	EXTRACT (MONTH FROM M_DATE) AS "MONTH",
	EXTRACT (YEAR FROM M_DATE) AS "YEAR" ,
	dat_fs.TITLE_NUMBER,
	dat_fs.MS AS MSK_GOV_PROGRAM_ID,
	dat_fs.FS AS FINANCING_SOURCE_ID,
	dat_fs.POWER_ID,
	dat_fs.TITLE_STATE_ID,
	dat_fs.VALUE_FULL,
	dat_fs.VALUE_DONE,
	dat_fs.VALUE_CONTR
FROM dat_gr dat_fs
-- оставл¤ю правильные деньги
JOIN fs_date ON dat_fs.TITLE_NUMBER = fs_date.TITLE_NUMBER
	AND dat_fs.M_DATE >= fs_date.min_FC_date
	AND dat_fs.FS = fs_date.FS),
min_date_title_year AS (
SELECT min(m_date) AS M_DATE,
	TITLE_NUMBER,
	"YEAR" 
FROM (SELECT m_date, TITLE_NUMBER, "YEAR" FROM full_table WHERE "YEAR" >=2015)
GROUP BY TITLE_NUMBER,
	"YEAR"),
max_date_titles AS (
SELECT max(m_date) AS max_title_date,
	TITLE_NUMBER,
	"MONTH",
	"YEAR"
FROM (SELECT m_date, TITLE_NUMBER, "MONTH",	"YEAR" FROM full_table) 
GROUP BY TITLE_NUMBER,
	"MONTH",
	"YEAR"
),
fin_table AS(
-- оставл¤ю в таблице только данные на титул на конец мес¤ца. если верси¤ титуал кончилась до конца мес¤ца, то считаем на этот день
SELECT ft.m_date,
	ft."MONTH",
	ft."YEAR",
	ft.TITLE_NUMBER,
	ft.FINANCING_SOURCE_ID,
	ft.MSK_GOV_PROGRAM_ID,
	ft.POWER_ID,
	ft.TITLE_STATE_ID,
	ft.VALUE_FULL,
	ft.VALUE_DONE,
	ft.VALUE_CONTR
FROM full_table ft	
JOIN max_date_titles ON ft.TITLE_NUMBER = max_date_titles.TITLE_NUMBER
	AND ft.m_date = max_date_titles.max_title_date
UNION 
-- добавл¤ем дно - начало действи¤ самой первой корректной версии титула
SELECT ft.m_date,
	ft."MONTH",
	ft."YEAR",
	ft.TITLE_NUMBER,
	ft.FINANCING_SOURCE_ID,
	ft.MSK_GOV_PROGRAM_ID,
	ft.POWER_ID,
	ft.TITLE_STATE_ID,
	ft.VALUE_FULL,
	ft.VALUE_DONE,
	ft.VALUE_CONTR
FROM full_table ft
JOIN min_date_titles ON ft.TITLE_NUMBER = min_date_titles.TITLE_NUMBER
	AND ft.m_date = min_date_titles.min_title_date	
UNION 
-- добавл¤ем дату начала титулов в каждом году, отличном от 2014
SELECT ft.m_date,
	ft."MONTH",
	ft."YEAR",
	ft.TITLE_NUMBER,
	ft.FINANCING_SOURCE_ID,
	ft.MSK_GOV_PROGRAM_ID,
	ft.POWER_ID,
	ft.TITLE_STATE_ID,
	ft.VALUE_FULL,
	ft.VALUE_DONE,
	ft.VALUE_CONTR
FROM full_table ft
JOIN min_date_title_year ON ft.TITLE_NUMBER = min_date_title_year.TITLE_NUMBER
	AND ft.m_date = min_date_title_year.m_date
	AND ft."YEAR" = min_date_title_year."YEAR"
)
-- добавл¤ю ID, замен¤ю отсутсвующие финансовые значени¤ нул¤ми
SELECT ROWNUM ID,
	ct.COB_ID,
 	TO_CHAR(m_date, ''yyyymmdd'') AS CALENDAR_ID,
	"MONTH",
	"YEAR",
	ct.TITLE_NUMBER,
	FINANCING_SOURCE_ID,
	MSK_GOV_PROGRAM_ID,
	POWER_ID,
	TITLE_STATE_ID,
	nvl(VALUE_FULL,0) as VALUE_FULL,
	nvl(VALUE_DONE,0) as VALUE_DONE,
	nvl(VALUE_CONTR,0) as VALUE_CONTR
FROM fin_table
JOIN stroy.COB_TITLE ct ON ct.TITLE_NUMBER = fin_table.TITLE_NUMBER';
END GET_TMP_$_MAIN;

/* create TMP_$_EXTEND */
PROCEDURE GET_TMP_$_EXTEND
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'TMP_$_EXTEND';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TMP_$_EXTEND CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE pbi.TMP_$_EXTEND AS
            WITH predtitle AS (
SELECT t.id, 
	t.date_from,
	DECODE(EXTRACT (YEAR FROM t.DATE_TO),t.YEAR,t.DATE_TO,NULL) AS DATE_TO,
	t.TITLE_NUMBER,
	t.DELIVERY_DATE,
	t.YEAR
FROM stroy.TITLE t 
WHERE 1=1
  --AND TITLE_NUMBER=43778 
  and STAGE_ID =95
  AND t."YEAR" >=2014
  AND t.STATE_ID =3
  AND t."YEAR" = EXTRACT (YEAR FROM t.DATE_FROM)
  AND t.id IN (SELECT max(t2.id) 
  -- выбираем только последние версии, если за день начинается несколько титулов
				FROM stroy.TITLE t2
				WHERE 1=1
					AND t2."YEAR" >=2014
					AND t2.STAGE_ID = 95
				GROUP BY t2.TITLE_NUMBER, TO_CHAR(t2.DATE_FROM,''yyyymmdd''))
),
cal_y AS (
--получаем список годов календаря
SELECT DISTINCT c."YEAR" AS C_YEAR
FROM pbi.CALENDAR c ),
first_titles AS (
-- получаем последнюю включенную в АИП версию титула каждого коба в каждом году году 
select cy.C_YEAR,
	pt."YEAR",
	pt.TITLE_NUMBER,
	pt.id,
	FIRST_VALUE(pt.id) OVER (PARTITION BY pt.TITLE_NUMBER, year ORDER BY pt.DATE_FROM desc) AS TITLE_MAX,
	ct.COB_ID,
	pt.DELIVERY_DATE,
	tt.END_DATE 
FROM cal_y cy
JOIN stroy.COB_TITLE ct ON 1=1
JOIN predtitle pt ON pt.TITLE_NUMBER = ct.TITLE_NUMBER 
JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = pt.ID AND tt.TITLE_TERM_TYPE_ID =1  -- сроки строительства
WHERE pt."YEAR" < cy.C_YEAR
),
stop_con AS (
-- считаем год сдачи для коба в каждом году ниже текущего
SELECT C_YEAR,
	"YEAR",
	COB_ID,
	max(EXTRACT (YEAR FROM nvl(DELIVERY_DATE,END_DATE))) as STOP_YEAR -- если у титула не заполнен год сдачи, то ставим год окончания строительства
FROM first_titles
WHERE id = title_max -- данные берем в последних версиях титула в каждом году. если титул в год не приехал, то его пропускаем
GROUP BY C_YEAR,
	"YEAR",
	COB_ID),
year_num_lag AS (
-- считаем количество переносов сроков строительства в каждом из годов существания титулов коба (в конце года у всех титулов коба год сдачи был равен текущему)
SELECT C_YEAR,
	cob_ID,
	count(*) AS NUM_LAG_YEAR
FROM stop_con
WHERE YEAR = STOP_YEAR
GROUP BY C_YEAR,
	cob_ID),
dat AS (
-- готовим исходник для заполнения таблицы extend
SELECT ct.COB_ID,
  vc.id AS M_DATE,
  vc."YEAR" AS M_YEAR,
  pt.DELIVERY_DATE,
  tt.END_DATE,
  tt.START_DATE,
  DECODE(NVL(sum(fp.AMOUNT) over(PARTITION BY pt."YEAR" , ct.COB_ID),0)*NVL(sum(contr.id) over(PARTITION BY vc.id),0),0,null,1) AS IS_CONTR, -- проверяем чтоб хоть у одного титула объекта был ненуллевой финплан в году
  -- и наличие заключенного контракта в нужном статусе на дату
  CASE 
  -- определяем типы объектов
    WHEN mck.is_big = 1 THEN 1 
    WHEN mck.new_year = EXTRACT(YEAR FROM vc.dt) THEN 2 
    WHEN mck.new_year < EXTRACT(YEAR FROM vc.dt) THEN 3 
    WHEN mck.new_year > EXTRACT(YEAR FROM vc.dt) THEN 4 
  END AS COB_TYPE_ID
FROM stroy.COB_TITLE ct 
JOIN predtitle pt ON ct.TITLE_NUMBER = pt.TITLE_NUMBER 
LEFT JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = pt.ID 
  AND tt.TITLE_TERM_TYPE_ID =1
-- находим даты календаря, в которые существовали нужные нам версии титулов
JOIN pbi.CALENDAR vc ON vc.DT BETWEEN pt.DATE_FROM AND nvl(pt.date_to, to_date(pt.year||''-12-31'',''YYYY-MM-DD''))
	AND vc.ID IN (SELECT vm2.CALENDAR_ID FROM pbi.TMP_$_MAIN vm2 WHERE vm2.TITLE_NUMBER = pt.TITLE_NUMBER AND  vm2.cob_id =ct.COB_ID )
JOIN stroy.MV_COB_KIND mck ON mck.ID = ct.COB_ID
LEFT JOIN stroy.FINANCIAL_PlAN fp ON
	fp.TITLE_NUMBER = pt.TITLE_NUMBER
	AND fp.BUDGET_YEAR = pt.YEAR
	-- контрактуемые КБК контрактов
	AND (fp.kbk LIKE ''%323___''
	OR fp.kbk LIKE ''%414___''
	OR fp.kbk LIKE ''%411___''
	OR fp.kbk LIKE ''%2_____'')
  -- контракты в нужном нам статусе
LEFT JOIN stroy.contract contr ON fp.CONTRACT_ID = contr.ID
	AND contr.CONTRACT_STATUS_ID IN (1, 500074)
	-- вот тут мы проверяем чтоб дата заключения контракта была не старше даты календаря
	AND contr.CONTRACT_DATE <= vc.DT
),
gp_extend AS(
-- готовим данные для расчета, считаем значение столбцов таблицы EXTEND
SELECT row_number() OVER(ORDER BY COB_ID) AS ID,
	COB_ID,
	max(COB_TYPE_ID) AS COB_TYPE_ID,
	max(IS_CONTR) AS IS_CONTR,
	MAX(EXTRACT (YEAR FROM nvl(DELIVERY_DATE,END_DATE))) AS D_YEAR,
	MAX(EXTRACT (YEAR FROM END_DATE)) AS STOP_CONSTR,
	min(EXTRACT (YEAR FROM START_DATE)) AS START_CONSTR,
	M_DATE AS CALENDAR_ID,
	max(M_YEAR) AS M_YEAR
FROM dat
GROUP BY COB_ID,
	M_DATE
)
SELECT gp_extend.ID,
	gp_extend.CALENDAR_ID,
	gp_extend.COB_ID,
	gp_extend.COB_TYPE_ID,
	gp_extend.IS_CONTR,
	gp_extend.D_YEAR,
	gp_extend.STOP_CONSTR,
	gp_extend.START_CONSTR,
	nvl(NUM_LAG_YEAR,0) AS NUM_LAG,
	MIN(gp_extend.id) over(PARTITION by gp_extend.COB_ID, gp_extend.COB_TYPE_ID, gp_extend.IS_CONTR, gp_extend.D_YEAR, gp_extend.STOP_CONSTR, gp_extend.START_CONSTR ) AS extend_ID
FROM gp_extend 
-- цепляем таблицу нумлага к extend
LEFT JOIN year_num_lag ON year_num_lag.C_YEAR=gp_extend.M_YEAR 
	AND year_num_lag.COB_ID=gp_extend.COB_ID';
			
END GET_TMP_$_EXTEND;

/* create GET_MAIN*/
PROCEDURE GET_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
   
    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.MAIN';
    EXECUTE IMMEDIATE '
	INSERT INTO pbi.MAIN (ID, CALENDAR_ID, TITLE_NUMBER, FINANCING_SOURCE_ID, MSK_GOV_PROGRAM_ID, POWER_ID, TITLE_STATE_ID, VALUE_FULL, VALUE_DONE, VALUE_CONTR, EXTEND_ID)
		SELECT vmg.ID,
			vmg.CALENDAR_ID,
			vmg.TITLE_NUMBER,
			vmg.FINANCING_SOURCE_ID,
			vmg.MSK_GOV_PROGRAM_ID,
			vmg.POWER_ID,
			vmg.TITLE_STATE_ID,
			vmg.VALUE_FULL,
			vmg.VALUE_DONE,
			vmg.VALUE_CONTR,
			ve.EXTEND_ID 
		FROM pbi.TMP_$_MAIN vmg 
		JOIN pbi.TMP_$_EXTEND ve ON ve.COB_ID = vmg.COB_ID 
			AND ve.CALENDAR_id = vmg.CALENDAR_ID';
END GET_MAIN;	

/* create GET_EXTEND*/
PROCEDURE GET_EXTEND
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
   
    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.EXTEND';
    EXECUTE IMMEDIATE '
	INSERT INTO pbi.EXTEND (id, COB_TYPE_ID, IS_CONTR, D_YEAR,  START_CONSTR, STOP_CONSTR, NUM_LAG)
	SELECT ve.ID,
		ve.COB_TYPE_ID,
		ve.IS_CONTR,
		ve.D_YEAR,
		ve.START_CONSTR,
		ve.STOP_CONSTR,
		ve.NUM_LAG 
	FROM pbi.TMP_$_EXTEND ve 
	WHERE ve.ID = ve.EXTEND_ID';
END GET_EXTEND;					


/* RUN */
PROCEDURE RUN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
BEGIN
/* create PBI_CALENDAR_V3 */
    GET_CALENDAR;
/* create COB_PREGP_LINK */
	GET_COB_PREGP_LINK;
/* create GET_TITLE */
    GET_TITLE;
/* create GET_FINANCING_SOURCE */
    GET_FINANCING_SOURCE;
/* create GET_POWER */
    GET_POWER;
/* create RESULT_AIP */
    GET_RESULT_AIP;
/* create PP */    
    GET_PP;
/* create PREGP */    
    GET_PREGP;
/* create PBI_GP */    
    GET_GP;
/* create GP_LF */    
    GET_GP_LF;
/* create MSK_GOV_PROGRAM */
    GET_MSK_GOV_PROGRAM;
/* create COB_PREGP_LINK */
	GET_COB_PREGP_LINK;
/* create COB */
	GET_COB;    
/* create GET_ALL_DISTR */
    GET_ALL_DISTR;
-- загрузка AO
    GET_AO;
    NO_COB;
-- загрузка GET_TITLE_TYPE
    GET_TITLE_TYPE;
-- загрузка GET_TITLE_STATE
    GET_TITLE_STATE;
-----------------------------------------------------------------------------------------------------------------------------------------------------
    
    INSERT INTO gp(id, name)
    VALUES(1, 'Внебюжетное финансирование');

    INSERT INTO gp_lf(id, name)
    VALUES(1, 'Внебюжетное финансирование');

    INSERT INTO pp(id, name, gp_lf_id)
    VALUES(1, 'Внебюжетное финансирование', 1);
    
    UPDATE pbi.cob_distr_link
    SET distr_id = 0
    WHERE distr_id is null;

    --INSERT INTO pbi.distr ( id, name, ao_id)
    --VALUES (0,  'Район не указан',  0);

    INSERT INTO pbi.AO ( id, name)
    VALUES (0,  'АО не указан');
    
    INSERT INTO financing_source (id, name) 
    VALUES(0, 'Мощности');
	
	DELETE FROM FINANCING_SOURCE fs
	WHERE not exists (SELECT 1 FROM MAIN m WHERE m.FINANCING_SOURCE_ID = fs.id);
    
  
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_TYPE ' ;
    INSERT INTO PBI.COB_TYPE 
    SELECT id, name from STROY.COB_TYPE;
    
    INSERT INTO pbi.cob_type ( id, name)
    VALUES (5,  'Не распределенные');
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MONTH ' ;
    INSERT INTO  MONTH 
    SELECT DISTINCT EXTRACT(MONTH FROM dt),
    to_char(dt,'MONTH','NLS_DATE_LANGUAGE = RUSSIAN')
    from calendar
    order by 1;
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.AIP ' ;   
    INSERT INTO AIP
    SELECT  row_number() over (order by dat.YEAR desc) rn, dat.YEAR
    FROM(
    SELECT  distinct  t."YEAR" year
        FROM stroy.cob_title ct 
        JOIN stroy.title t ON t.title_number = ct.title_number 
        WHERE 1=1
          AND t."YEAR" >=2014
          AND t.stage_id =95
          AND t.state_id = 3
          AND t.date_to IS NULL
        GROUP BY ct.cob_id,
           t."YEAR"
    order by  t."YEAR" ) dat ;
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.COB_AIP_LINK ' ;
    INSERT INTO PBI.COB_AIP_LINK
    SELECT ct.cob_id,  aip.id 
    FROM stroy.cob_title ct 
    JOIN stroy.title t ON t.title_number = ct.title_number 
    JOIN pbi.aip aip ON  aip.year = t.year
    WHERE 1=1
      AND t."YEAR" >=2014
      AND t.stage_id =95
      AND t.state_id = 3
      AND t.date_to IS NULL
    ORDER BY ct.cob_id,
       t."YEAR";
	
    COMMIT;
	
	    /* create V3_CALENDAR */
    GET_V3_CALENDAR;
    
    /* create TMP_$TMP_$_MAIN */
	GET_TMP_$_MAIN;

    /* create TMP_$TMP_$_EXTEND */
        GET_TMP_$_EXTEND;
        
    /* create GET_EXTEND*/
        GET_EXTEND;
    
    /* create GET_MAIN*/
        GET_MAIN;
     
    /*create COB_PP_LINK */
    GET_COB_PP_LINK;
    
    /*create GRBS */
    GET_GRBS;
    
    /*create PREGRBS */
    GET_PREGRBS;
    
    /*create GET_PPM */
    GET_PPM;
    
    /* create VALUE_PLAN */
    GET_VALUE_PLAN;
    
    /*create DELETE */
    DELETE_FINAL;
	
END RUN;

END GET_PBI_4V;
/
