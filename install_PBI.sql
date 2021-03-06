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
    
 /* CREATE EXTEND*/    
--------------------------------------------------------------------------------------------------------------    
/*    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'EXTEND';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.EXTEND CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.EXTEND  (
                                                ID NUMBER(10,0) NOT NULL ENABLE,
												MAIN_ID NUMBER,
                                                START_CONSTR NUMBER, 
                                                STOP_CONSTR NUMBER, 
                                                NUM_LAG NUMBER, 
                                                DELIVERY_DATE NUMBER, 
                                                COB_TYPE_ID        NUMBER,
												CONSTRAINT "EXTEND_PK" PRIMARY KEY ("ID")
                                                )
                                                TABLESPACE USERS';
	EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."EXTEND_INDEX1" ON "PBI"."EXTEND" ("START_CONSTR", "MAIN_ID")';
	EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."EXTEND_INDEX2" ON "PBI"."EXTEND" ("MAIN_ID")';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.START_CONSTR IS ''' || 'Год начала строительства' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.STOP_CONSTR IS ''' || 'Год окончания строительства' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.NUM_LAG IS ''' || 'Количество переносов сдачи объекта' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.DELIVERY_DATE IS ''' || 'Год сдачи объекта' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.MAIN_ID IS ''' || 'Ссылка на main' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.COB_TYPE_ID IS ''' || 'Тип объекта' || '''';
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_EXTEND';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_EXTEND';
    END IF; 
   EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_EXTEND  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE';
   */
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
   --EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.COB_TYPE_ID IS ''' || 'Тип объекта' || '''';
   --EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.START_YEAR IS ''' || 'Год рождения объекта' || '''';  
   --EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.FINISH_YEAR IS ''' || 'Год реализации объекта' || ''''; 
   --EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.COB.NEW_YEAR IS ''' || 'Год, в котором объект стал новым' || ''''; 
  
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

/* CREATE MAIN_PP_LINK*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MAIN_PP_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN_PP_LINK CASCADE CONSTRAINTS';
    END IF;

  /*  EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN_PP_LINK
                                               (MAIN_ID   NUMBER, 
                                                PP_ID                     NUMBER
                                                )';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN_PP_LINK.MAIN_ID IS ''' || 'Внешний ключ на таблицу MAIN' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN_PP_LINK.PP_ID IS ''' || 'Внешний ключ на таблицу PP' || '''';*/

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

/* CREATE MAIN*/    
--------------------------------------------------------------------------------------------------------------    
/*    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MAIN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN 
                                            (	ID NUMBER NOT NULL ENABLE, 
                                            CALENDAR_ID NUMBER, 
                                            TITLE_NUMBER NUMBER, 
                                            FINANCING_SOURCE_ID NUMBER,
-- 24.05.2021 удален по новым условиям 
                                            MSK_GOV_PROGRAM_ID NUMBER, 
-- 16.06.2021 удален по новым условиям      EXTEND_ID NUMBER, 
                                            POWER_ID NUMBER, 
                                            TITLE_STATE_ID NUMBER, 
                                            VALUE_FULL NUMBER, 
                                            VALUE_DONE NUMBER, 
                                            VALUE_CURR NUMBER, 
                                            CONSTRAINT MAIN_PK PRIMARY KEY (ID))
                                            TABLESPACE USERS' ;
											
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_MAIN_CALENDAR_ID ON PBI.MAIN (CALENDAR_ID)'; 
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_MAIN_INDEX2 ON PBI.MAIN (TITLE_NUMBER, CALENDAR_ID)'; 
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_MAIN_INDEX3 ON PBI.MAIN (TITLE_NUMBER, ID, CALENDAR_ID)';
	EXECUTE IMMEDIATE 'CREATE INDEX PBI.INX_TITLE_NUMBER ON PBI.MAIN (TITLE_NUMBER)';
    
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.CALENDAR_ID IS ''' || 'ID календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.TITLE_NUMBER IS ''' || '	Номер титула' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.FINANCING_SOURCE_ID IS ''' || 'Тип финансирования ' || '''';    
--    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.MS_ID IS ''' || 'Источник финансов' || '''';
--    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.EXTEND_ID IS ''' || 'Постоянный блок данных для объекта на дату' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.POWER_ID IS ''' || 'Мощности' || '''';
    --       EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.FINANCING_SOURCE_ID IS ''' || 'Внешний ключ на таблицу FINANCING_SOURCE' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.MSK_GOV_PROGRAM_ID IS ''' || 'Внешний ключ на таблицу MSK_GOV_PROGRAM' || '''';
    --       EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.PP_ID IS ''' || 'Внешний ключ на таблицу PP' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.TITLE_STATE_ID IS ''' || 'Состояние титула' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.VALUE_FULL IS ''' || 'Полный объем' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.VALUE_DONE IS ''' || 'Выполнение в прошлых годах' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.VALUE_CURR IS ''' || 'План на текущий год ' || '''';
    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_MAIN';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_MAIN';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_MAIN  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE' ;
*/
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
   
END;
/
create or replace PACKAGE GET_PBI_2V AS 

/* create PBI_CALENDAR*/
PROCEDURE GET_CALENDAR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create PBI_MAIN */
PROCEDURE GET_MAIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_TITLE */
PROCEDURE GET_TITLE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_FINANCING_SOURCE */
PROCEDURE GET_FINANCING_SOURCE;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_EXTEND */
PROCEDURE GET_EXTEND;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_EXTEND_BOM */
PROCEDURE GET_EXTEND_BOM;
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

/* create MAIN_PP_LINK */
PROCEDURE GET_MAIN_PP_LINK;
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

-- ВСПМОГАТЕЛЬНАЯ
FUNCTION get_distr(pcod_id in number) RETURN NUMBER;
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

END GET_PBI_2V;

/

create or replace PACKAGE BODY GET_PBI_2V AS

-- ВСПМОГАТЕЛЬНАЯ
FUNCTION get_distr(pcod_id in number) RETURN NUMBER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp number;
BEGIN
/*    SELECT DISTINCT   
    (SELECT DISTINCT id  FROM pbi.pbi_distr WHERE ao_id = distr_id AND id < 100) t  INTO tmp
FROM(
  SELECT cob_id, get_cob_v2.get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
  from 
    (
        SELECT  cc.cob_id, adm.adm_region_id
        FROM stroy.cob c
            LEFT JOIN stroy.cob_card cc ON c.id=cc.cob_id
            LEFT JOIN stroy.cob_title ct ON ct.cob_id =c.id
            LEFT JOIN stroy.title t ON t.TITLE_NUMBER = ct.TITLE_NUMBER
            LEFT JOIN stroy.TITLE_ADM_REGION adm ON adm.TITLE_ID = t.ID
            JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID
        WHERE cc.date_to is null
            AND t.year>=2014
            AND t.STAGE_ID = 95
            AND t.TITLE_TYPE_ID in (1,2,3)
            AND t.STATE_ID != 4
            AND reg.delete_date is null
            AND c.id = pcod_id
    ) 
 union   
      SELECT cob_id, get_cob_v2.get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
  from 
    (
        SELECT  cc.cob_id, adm.adm_region_id
        FROM stroy.cob c
            LEFT JOIN stroy.cob_card cc ON c.id=cc.cob_id
            LEFT JOIN stroy.cob_title ct ON ct.cob_id =c.id
            LEFT JOIN stroy.title t ON t.TITLE_NUMBER = ct.TITLE_NUMBER
            LEFT JOIN STROY.title_adm_region_detail adm ON adm.TITLE_ID = t.ID
            JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID
        WHERE cc.date_to is null
            AND t.year>=2014
            AND t.STAGE_ID = 95
            AND t.TITLE_TYPE_ID in (1,2,3)
            AND t.STATE_ID != 4
           AND reg.delete_date is null
           AND c.id = pcod_id
    ) )
WHERE ROWNUM = 1;
    return tmp;
EXCEPTION WHEN OTHERS THEN
    RETURN 0;*/
null;
END get_distr;


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

/* create MAIN_PP_LINK */
PROCEDURE GET_MAIN_PP_LINK_old
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp_count number;
     tmp number;
     v_pp NUMBER;
BEGIN
null;
 /*   EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_PP_LINK ' ;
	
    FOR x IN 
        (
            WITH dat AS
                (
                SELECT distinct main.id main_id,  max(t.id) as title_id
                FROM stroy.title t 
                    INNER JOIN pbi.main ON t.title_number = main.title_number 
                    INNER JOIN pbi.calendar c ON c.id = main.calendar_id                   
                WHERE-- t.state_id =3 --and t.title_number =43385
                      c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
                      AND t.YEAR >=2014
                     AND t.STAGE_ID =95
                GROUP BY main.id
                )    
                SELECT 		
                    bc.state_program_id, dat.main_id
                FROM stroy.cob_title ct 
                JOIN stroy.title t ON ct.title_number = t.title_number
                JOIN dat ON t.id = dat.title_id
                JOIN stroy.build_indicator bi ON bi.title_id = t.id AND bi.build_indicator_type_id =3
                JOIN stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
                JOIN stroy.budget_classifier bc ON bc.id = bic.budget_classifier_id
                WHERE 
                    t.YEAR >=2014
                    AND t.STAGE_ID =95
        )
        LOOP
            BEGIN
                SELECT MAX(cc.id) INTO v_pp
                FROM  stroy.state_program cc
                WHERE parent_id IS NOT NULL
                START WITH id = x.state_program_id
                CONNECT BY NOCYCLE PRIOR cc.parent_id = cc.id;  
                
                INSERT INTO main_pp_link (main_id, pp_id) 
                VALUES(x.main_id, v_pp);
            EXCEPTION WHEN OTHERS THEN
                null;
            END;
        END LOOP;
    COMMIT;
	INSERT INTO main_pp_link (main_id, pp_id) 
	SELECT id, 1 FROM main WHERE power_id is null
	minus
	SELECT main_id, 1 FROM main_pp_link;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN_PP_LINK', 'INSERT PBI.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');*/
END GET_MAIN_PP_LINK_OLD;

/* create MAIN_PP_LINK */
PROCEDURE GET_MAIN_PP_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp_count number;
     tmp number;
BEGIN
null;
/*
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_PP_LINK ' ;
	
	INSERT INTO main_pp_link (main_id, pp_id) 
	WITH
    dat as
        (
        SELECT distinct main.id,  max(t.id) as title_id
         --   FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, t.year ORDER BY t.date_from desc) AS tmax
        FROM stroy.title t 
            INNER JOIN pbi.main ON t.title_number = main.title_number 
            INNER JOIN pbi.calendar c ON c.id = main.calendar_id   
 
        WHERE t.state_id =3 --and t.title_number =43385
            AND  c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
            AND t.YEAR >=2014
                     AND t.STAGE_ID =95
        GROUP BY main.id
        )
	SELECT 
		dat.id main_id,
		sp2.id pp_id
	FROM stroy.COB_TITLE ct 
	JOIN stroy.TITLE t ON ct.TITLE_NUMBER = t.TITLE_NUMBER
	INNER JOIN dat ON dat.title_id = t.id
	JOIN stroy.BUILD_INDICATOR bi ON bi.TITLE_ID = t.ID AND bi.BUILD_INDICATOR_TYPE_ID =3
	JOIN stroy.BUILD_INDICATOR_CLASSIFIER bic ON bic.id = bi.BUILD_INDICATOR_CLASSIFIER_ID
	JOIN stroy.BUDGET_CLASSIFIER bc ON bc.ID = bic.BUDGET_CLASSIFIER_ID 
	JOIN stroy.STATE_PROGRAM sp ON bc.STATE_PROGRAM_ID = sp.ID 
	JOIN stroy.STATE_PROGRAM sp2 ON sp.PARENT_ID = sp2.id
	JOIN stroy.STATE_PROGRAM sp3 ON sp2.PARENT_ID = sp3.id
	WHERE 
        t."YEAR" >=2014
	    AND t.STAGE_ID =95;
    
	INSERT INTO main_pp_link (main_id, pp_id) 
	SELECT id, 1 FROM main WHERE power_id is null
	minus
	SELECT main_id, 1 FROM main_pp_link;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN_PP_LINK', 'INSERT PBI.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');*/
END GET_MAIN_PP_LINK;

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

/*    FOR x IN 
    (
         SELECT ct.cob_id,
            (select new_year from stroy.mv_cob_kind mck WHERE  mck.id = ct.cob_id) as NEW_YEAR
        FROM
            stroy.title t
            INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
        WHERE
            t.stage_id = 95
            AND t.state_id = 3
            AND t.year >= 2014
        group by ct.cob_id
    )
    LOOP
        UPDATE pbi.cob
        SET START_YEAR = x.first_dt, 
            FINISH_YEAR = x.last_dt,
            NEW_YEAR = x.NEW_YEAR
        WHERE id = x.cob_id;
    END LOOP;*/
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
 /*   INSERT INTO pbi.cob_distr_link(cob_id,distr_id)
    SELECT d.id, get_distr(d.id)
    from 
    (
    select DISTINCT id
    from
        pbi.cob 
        minus
     select DISTINCT c.id
    from
        pbi.cob c,
        pbi.cob_distr_link cdl
    where 
        cdl.cob_id = c.id
    ) d; */

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
    /*
	SELECT DISTINCT
	  sp2.id,
	  '('||sp2.VALUE ||') '||sp2.NAME  AS PP,
	  CASE 
		WHEN sp3.source_id IS NULL THEN sp3.id 
		ELSE sp4.id 
	  END AS GP_LF
	FROM stroy.COB_TITLE ct 
	JOIN stroy.title t ON ct.TITLE_NUMBER = t.TITLE_NUMBER 
	JOIN stroy.build_indicator bi ON bi.TITLE_ID = t.ID AND bi.BUILD_INDICATOR_TYPE_ID =3
	JOIN stroy.build_indicator_classifier bic ON bic.id = bi.BUILD_INDICATOR_CLASSIFIER_ID
	JOIN stroy.budget_classifier bc ON bc.ID = bic.BUDGET_CLASSIFIER_ID 
	JOIN stroy.state_program sp ON bc.STATE_PROGRAM_ID = sp.ID 
	JOIN stroy.state_program sp2 ON sp.PARENT_ID = sp2.id
	JOIN stroy.state_program sp3 ON sp2.PARENT_ID = sp3.id
	LEFT JOIN stroy.state_program sp4 ON sp3.SOURCE_ID = sp4.id
	WHERE 1=1
	  AND t."YEAR" >=2014
	  AND t.STAGE_ID =95;*/
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

/* create GET_EXTEND */
PROCEDURE GET_EXTEND
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    min_year NUMBER;
    max_year NUMBER;
    n_extehd_id NUMBER;
    tmp_max number;
    tmp_year number;
    tmp_k number;
    tmp_cob number;
    tmp_end_year number;
    tmp_count NUMBER;
    com_ number := 0;
BEGIN
/*	INSERT INTO extend (id, start_constr, stop_constr, main_id)
	SELECT pbi.seq_extend.nextval, min_, max_, id
	FROM
	(
	SELECT 
			 m.calendar_id, c.year,  ct.cob_id, m.title_number, to_number(to_char(min(tt.start_date),'YYYY')) min_, to_number(to_char(max(tt.end_date),'YYYY')) max_, m.id
		FROM stroy.title t
			INNER JOIN stroy.title_term  tt on t.id=tt.title_id
			INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number   
			INNER JOIN main m ON m.title_number = t.title_number 
			inner join pbi.calendar c ON  m.calendar_id = c.id
		WHERE 
			 tt.title_term_type_id = 1
			AND t.stage_id = 95
			AND t.title_type_id in (1, 2, 3)
			AND t.year >= 2014
		  --  AND ct.cob_id = x.cob_id
			AND c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
			group by m.calendar_id, c.year,  ct.cob_id, m.title_number, m.id
		);
        
	BEGIN
	FOR x in 
		(
		SELECT  DISTINCT ex.id, m.calendar_id, c.year,  cct.cob_id, m.title_number,
		  (SELECT CASE 
									WHEN mck.is_big = 1 THEN 1 
									WHEN mck.new_year = EXTRACT(YEAR FROM c.dt) THEN 2 
									WHEN mck.new_year < EXTRACT(YEAR FROM c.dt) THEN 3 
									WHEN mck.new_year > EXTRACT(YEAR FROM c.dt) THEN 4 
								end
				FROM 
					stroy.mv_cob_kind mck  where mck.id = cct.cob_id) cob_type
		FROM pbi.main m
		INNER JOIN pbi.calendar c ON  m.calendar_id = c.id
		INNER JOIN pbi.extend ex ON ex.main_id = m.id
		INNER JOIN stroy.cob_title cct ON  cct.title_number = m.title_number
		INNER JOIN stroy.title t ON t.title_number =  m.title_number
		WHERE
			t.year >= 2014
			--AND t.delete_date is null
			AND t.stage_id = 95
			AND t.title_type_id in (1,2,3)
			--AND t.state_id != 4
			AND c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year || '-12-31','YYYY-MM-DD'))
		)
	LOOP
		UPDATE extend
		SET cob_type_id = x.cob_type
		WHERE id = x.id;
	END LOOP;
	commit;
	END;
    
	BEGIN
	FOR x in 
		(
			with 
				dat as (
					SELECT t.year ,
						t.id,
						ex.id ex_id,
						FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, t.year ORDER BY t.date_from desc) AS tmax,
						ct.cob_id,
						tt.end_date 
					FROM stroy.cob_title ct 
						LEFT JOIN stroy.title t ON t.title_number = ct.title_number 
						LEFT JOIN stroy.title_term tt ON tt.Title_Id = t.ID AND tt.title_term_type_id =1                                    
						INNER JOIN main m ON m.title_number =  t.title_number
						INNER JOIN  pbi.calendar c ON m.calendar_id = c.id
						INNER JOIN extend ex ON ex.main_id = m.id
					WHERE t.stage_id =95
						AND t.state_id =3
					 --   AND ct.cob_id = x.cob_id
						AND t.year BETWEEN 2014 and 2022
						AND t.year < c.year
				),
				dat1 AS (
					SELECT dat.year, ex_id,
						max(EXTRACT(YEAR FROM end_date)) OVER(PARTITION BY cob_id, year) as fin_y--,
						--COB_ID,
					   -- FIRST_VALUE(year) over(PARTITION BY cob_id ORDER BY year desc) AS cfy
					FROM dat
					WHERE dat.id=tmax
				)
				select  ex_id, max(fin_y) d  from dat1
				group by ex_id
		)
	LOOP
		UPDATE extend
		SET delivery_date = x.d
		WHERE id = x.ex_id;
	END LOOP;
	commit;
	END;

	BEGIN
	FOR x in 
		(
	  WITH dat as (
			SELECT t."YEAR" ,  t.id,
				FIRST_VALUE(t.id) OVER (PARTITION BY t.TITLE_NUMBER, t.year ORDER BY t.DATE_FROM desc) AS tmax,
				ct.COB_ID,
				ex.id ex_id,
				tt.END_DATE,
				CASE 
					WHEN t.DELIVERY_DATE IS NULL THEN EXTRACT(YEAR FROM END_DATE)
					ELSE EXTRACT (YEAR FROM t.DELIVERY_DATE)
				END AS DY
			FROM stroy.COB_TITLE ct 
			LEFT JOIN stroy.TITLE t ON t.TITLE_NUMBER = ct.TITLE_NUMBER 
			LEFT JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = t.ID AND tt.TITLE_TERM_TYPE_ID =1
			INNER JOIN main m ON m.title_number = t.title_number 
			INNER JOIN pbi.calendar c ON  m.calendar_id = c.id
			INNER JOIN pbi.extend ex ON ex.main_id = m.id
			WHERE t.STAGE_ID =95
			  AND t.STATE_ID =3
			  AND t."YEAR" BETWEEN 2014 and c.year
			),
			dat1 AS (
			select dat."YEAR",
			  max(DY) OVER(PARTITION BY cob_id, YEAR) as FIN_Y,
			  COB_ID, ex_id,
			  FIRST_VALUE(YEAR) over(PARTITION BY cob_id ORDER BY YEAR desc) AS CFY
			FROM dat
			WHERE dat.id=tmax
			)
			SELECT ex_id, COB_ID,
			  COUNT(*) AS DR
			FROM dat1
			WHERE YEAR=FIN_Y
			  AND fin_y<>cfy
			GROUP BY ex_id, COB_ID
		)
	LOOP
		UPDATE extend
		SET num_lag = x.DR
		WHERE id = x.ex_id;
		

	END LOOP;    
		UPDATE extend
		SET num_lag = 0
		WHERE num_lag is null;
	END;

    SELECT COUNT(*) INTO tmp_count FROM pbi.extend;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_EXTEND', 'INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
*/
    null;
END GET_EXTEND;

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

/* create PBI_MAIN */
PROCEDURE GET_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
/*CURSOR title is     
    WITH 
    dat AS
        (
        SELECT t.id title_id, t.title_number, t.title_name, t.year, t.msk_gov_program_id, c.id calendar_id, t.state_id
        FROM   stroy.title t
            INNER JOIN calendar c ON c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
        WHERE  
            --c.year < EXTRACT(year FROM sysdate)
            t.stage_id = 95
-- есть сомнения  в значении = 3            
            --AND t.state_id = 3 
            --AND date_to IS NULL
            --AND t.id = 1446621 
           -- AND TITLE_NUMBER in (43385, 154796, 155177, 109157, 59048, 250866, 700858)
        ),
    dat2 AS
        (
        SELECT mgp.name                                  AS MGP_NAME,
            bi.build_indicator_type_id                AS RES_TYPE,
-- 24.05.2021 выпилил по новым условиям
            --Concat(bic.budget_classifier_id, ec.code) AS MS,
            dat.msk_gov_program_id AS MS,
            bc.EXPENCE_KIND,
            dat.title_number,
            biv.value,
            biv.build_indicator_value_type_id         AS VALUE_TYPE,
            bic.financing_source_id,
            p.id power_id,
            dat.title_id,
            dat.state_id title_state_id,
            dat.calendar_id
        FROM   dat
            join stroy.build_indicator bi ON bi.title_id = dat.title_id
-- нужно учесть что исключены мощности (6)
                AND bi.build_indicator_type_id IN ( 3, 6 )
        -- мощности (6) и деньги (3)
            join stroy.build_indicator_value biv ON biv.build_indicator_id = bi.id
         -- план не текущий год (1). по ПСД (2) контрактная цена (3) и выполнено (4) 
                AND biv.build_indicator_value_type_id IN ( 1, 2, 3, 4 )
                AND NVL(biv.value, 0)  > 0
                AND ( biv.year IS NULL OR biv.year = dat.year )
                AND biv.quarter_number IS NULL
            left join stroy.msk_gov_program mgp ON mgp.id = dat.msk_gov_program_id
            left join stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
            left join stroy.budget_classifier bc ON bc.id = bic.BUDGET_CLASSIFIER_ID
            left join stroy.economical_classifier ec ON ec.id = bic.economical_classifier_id
            left join stroy.power p ON p.id = bic.power_id
        ),
    dat3 as 
        (                       
        SELECT 
            dat2.calendar_id,
            dat2.mgp_name,
            dat2.ms,
            dat2.title_number,
            dat2.power_id,
            dat2.title_state_id,
            dat2.financing_source_id,
            CASE 
                WHEN  dat2.res_type = 3 AND dat2.value_type = 3 then dat2.value 
                WHEN  dat2.res_type = 6 AND dat2.value_type = 2 then dat2.value 
            END AS VALUE_FULL,
            CASE 
                WHEN  dat2.res_type = 3 AND dat2.value_type = 4 then dat2.value 
                WHEN  dat2.res_type = 6 AND dat2.value_type = 4 then dat2.value 
            END AS VALUE_DONE,
            CASE 
                WHEN  dat2.res_type = 3 AND dat2.value_type = 1 then dat2.value 
                WHEN  dat2.res_type = 6 AND dat2.value_type = 1 then dat2.value 
            END AS VALUE_CURR
        FROM   dat2
        WHERE NOT (value_type = 1 AND value = 0)
        GROUP  BY 
            dat2.calendar_id,
            dat2.mgp_name,
            dat2.res_type,
            dat2.financing_source_id,
            dat2.ms,
            dat2.title_number,          
            dat2.value_type,
            dat2.power_id,
            dat2.title_state_id,
            dat2.value
        ORDER  BY 
             dat2.calendar_id,
            dat2.res_type,
            dat2.power_id,
            dat2.value_type,
            dat2.title_state_id
        )
    SELECT 
        calendar_id,
        mgp_name,
        ms,
        title_number,
        financing_source_id,
        power_id,
        title_state_id,
        SUM(VALUE_FULL) + ROUND(dbms_random.value(1,99)/1000000, 6) full,
        SUM(VALUE_DONE) + ROUND(dbms_random.value(1,99)/1000000, 6) done,
        SUM(VALUE_CURR) + ROUND(dbms_random.value(1,99)/1000000, 6) curr
FROM DAT3
GROUP BY 
    calendar_id,
    mgp_name,
    ms,
    title_number,
    financing_source_id,
    power_id,
    title_state_id;*/
BEGIN
/*	EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN' ;
    FOR x in title 
    LOOP
        IF NVL(x.full, 0) != 0 THEN
            INSERT INTO main (id, calendar_id,  title_number, financing_source_id, power_id, title_state_id,    value_full,  value_done,  value_curr, msk_gov_program_id)
            VALUES (pbi.seq_main.NEXTVAL, x.calendar_id, x.title_number, x.financing_source_id,  x.power_id, x.title_state_id, x.full, x.done, x.curr, x.ms);
        END IF;
    END LOOP;    
    
    UPDATE main
    SET financing_source_id = 0
    WHERE financing_source_id is null;
	
	DELETE FROM  pbi.main
	WHERE id in (
		SELECT m.id 
		FROM pbi.main m
		WHERE m.calendar_id < (SELECT min(mm.calendar_id) FROM pbi.main mm WHERE mm.financing_source_id != 0 and mm.title_number = m.title_number)
		AND m.power_id is not NULL
		);
    
    COMMIT;
--    EXECUTE IMMEDIATE 'CREATE INDEX title_number ON main(title_number)';
    SELECT COUNT(*) INTO tmp_count FROM pbi.main;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN', 'INSERT PBI.MAIN: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.GET_MAIN: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;*/
    null;
END GET_MAIN;

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
 /*   
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
        SELECT dat.cob_id, ar.id, ar.name, get_cob_v2.get_adm_reg_by_adm_id(ar.id,2) ao
        FROM  dat
            LEFT JOIN stroy.title_adm_region_detail tard ON tard.title_id = dat.title_id
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 2
        UNION 
        SELECT distinct dat.cob_id, ar.id, ar.name, get_cob_v2.get_adm_reg_by_adm_id(ar.id,2) 
        FROM dat
            LEFT JOIN stroy.title_adm_region tard ON tard.title_id = dat.title_id
            LEFT JOIN stroy.adm_region ar ON ar.ID = tard.adm_region_id 
              AND ar."TYPE" = 2
    )
    LOOP
        IF x.id is not null and x.name is not null and x.ao != 0
        THEN
            tmp_id := tmp_id + 1;
            INSERT INTO pbi.distr(id, name, ao_id) 
            VALUES(tmp_id, 'Район не указан', x.ao);
            
            INSERT INTO pbi.cob_distr_link(cob_id, distr_id) 
            VALUES(x.cob_id, tmp_id);
        END IF;
    END LOOP;*/
   
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

/* create GET_EXTEND_BOM */
PROCEDURE GET_EXTEND_BOM
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    min_year NUMBER;
    max_year NUMBER;
    n_extehd_id NUMBER;
    tmp_max number;
    tmp_year number;
    tmp_k number;
    tmp_cob number;
    tmp_end_year number;
    tmp_count NUMBER;
    com_ number := 0;
BEGIN
/*
BEGIN
  
    INSERT INTO extend (id, start_constr, stop_constr, main_id, cob_type_id)    
    SELECT pbi.seq_extend.nextval, min_, max_, id, 5
	FROM
	(
	SELECT 
			 m.calendar_id, c.year,  ct.id cob_id, m.title_number, to_number(to_char(min(tt.start_date),'YYYY')) min_, to_number(to_char(max(tt.end_date),'YYYY')) max_, m.id
		FROM stroy.title t
            inner join pbi.title tt ON tt.title_number = t.title_number
			INNER JOIN stroy.title_term  tt on t.id=tt.title_id
			INNER JOIN cob ct ON ct.id = tt.cob_id   
			INNER JOIN main m ON m.title_number = t.title_number 
			inner join pbi.calendar c ON  m.calendar_id = c.id
		WHERE 
			 tt.title_term_type_id = 1
			AND t.stage_id = 95
			AND t.title_type_id in (1, 2, 3)
			AND t.year >= 2014
            AND tt.cob_id >= 1000000
		  --  AND ct.cob_id = x.cob_id
			AND c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
			group by m.calendar_id, c.year,  ct.id, m.title_number, m.id
		);

	FOR x in 
		(
	with 
				dat as (
					SELECT t.year ,
						t.id,
						ex.id ex_id,
						FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, t.year ORDER BY t.date_from desc) AS tmax,
                        tt.cob_id,
						tt.end_date 
					FROM stroy.title t 
						LEFT JOIN stroy.title_term tt ON tt.Title_Id = t.ID AND tt.title_term_type_id =1                                    
						INNER JOIN main m ON m.title_number =  t.title_number
                        INNER JOIN pbi.title tt ON tt.title_number = t.title_number
						INNER JOIN  pbi.calendar c ON m.calendar_id = c.id
						INNER JOIN extend ex ON ex.main_id = m.id
					WHERE t.stage_id =95
						AND t.state_id =3
                         AND tt.cob_id >= 1000000
						AND t.year BETWEEN 2014 and 2022
						AND t.year < c.year
				),
				dat1 AS (
					SELECT dat.year, ex_id,
						max(EXTRACT(YEAR FROM end_date)) OVER(PARTITION BY cob_id, year) as fin_y--,
						--COB_ID,
					   -- FIRST_VALUE(year) over(PARTITION BY cob_id ORDER BY year desc) AS cfy
					FROM dat
					WHERE dat.id=tmax
				)
				select  ex_id, max(fin_y) d  from dat1
				group by ex_id
    		)
	LOOP
		UPDATE extend
		SET delivery_date = x.d
		WHERE id = x.ex_id;
	END LOOP;
	commit;

	FOR x in 
		( 
  WITH dat as (
			SELECT t."YEAR" ,  t.id,
				FIRST_VALUE(t.id) OVER (PARTITION BY t.TITLE_NUMBER, t.year ORDER BY t.DATE_FROM desc) AS tmax,
				tt.COB_ID,
				ex.id ex_id,
				tt.END_DATE,
				CASE 
					WHEN t.DELIVERY_DATE IS NULL THEN EXTRACT(YEAR FROM END_DATE)
					ELSE EXTRACT (YEAR FROM t.DELIVERY_DATE)
				END AS DY
			FROM stroy.TITLE t 
			LEFT JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = t.ID AND tt.TITLE_TERM_TYPE_ID =1
			INNER JOIN main m ON m.title_number = t.title_number 
			INNER JOIN pbi.calendar c ON  m.calendar_id = c.id
            INNER JOIN pbi.title tt ON tt.title_number = t.title_number
			INNER JOIN pbi.extend ex ON ex.main_id = m.id
			WHERE t.STAGE_ID =95
			  AND t.STATE_ID =3
              AND tt.cob_id >= 1000000
			  AND t."YEAR" BETWEEN 2014 and c.year
			),
			dat1 AS (
			select dat."YEAR",
			  max(DY) OVER(PARTITION BY cob_id, YEAR) as FIN_Y,
			  COB_ID, ex_id,
			  FIRST_VALUE(YEAR) over(PARTITION BY cob_id ORDER BY YEAR desc) AS CFY
			FROM dat
			WHERE dat.id=tmax
			)
			SELECT ex_id, COB_ID,
			  COUNT(*) AS DR
			FROM dat1
			WHERE YEAR=FIN_Y
			  AND fin_y<>cfy
			GROUP BY ex_id, COB_ID
		)
	LOOP
		UPDATE extend
		SET num_lag = x.DR
		WHERE id = x.ex_id;
		

	END LOOP;    
		UPDATE extend
		SET num_lag = 0
		WHERE num_lag is null;
	END;
    

    SELECT COUNT(*) INTO tmp_count FROM pbi.extend;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_EXTEND', 'INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;*/
    null;

END GET_EXTEND_BOM;


/* RUN */
PROCEDURE RUN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
BEGIN
/* create PBI_CALENDAR_V3 */
    GET_CALENDAR;
/* create PBI_MAIN */
  --  GET_MAIN;
/* create MAIN_PP_LINK */
  --  GET_MAIN_PP_LINK;
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
-- загрузка COB_DISTR_LINK
--    GET_COB_DISTR_LINK;
-- загрузка DISTR
--    GET_DISTR;
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
    
--    DELETE FROM extend fs
--	WHERE not exists (SELECT 1 FROM MAIN m WHERE m.extend_id = fs.id);
    
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
	
	/* create GET_EXTEND */
--   GET_EXTEND;
   
/* create GET_EXTEND_BOM */
 --   GET_EXTEND_BOM;
    
    COMMIT;
END RUN;

END GET_PBI_2V;

/
-- RUN
BEGIN
    null;
--    GET_PBI_2V.RUN;
-----------------------------------------------------------------------------------------------------------------------------------------------------
END;