DECLARE
    tmp_current_user varchar2(64);
    tmp_is_objects number;
BEGIN
    SELECT username INTO tmp_current_user FROM user_users;
    
/* CREATE LOG*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'LOG';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.LOG CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.LOG  (
                                                ID NUMBER(10,0) NOT NULL ENABLE, 
                                                MSG_TYPE VARCHAR2(20 BYTE), 
                                                DT DATE DEFAULT sysdate, 
                                                METOD VARCHAR2(64 BYTE), 
                                                MSG VARCHAR2(4000 BYTE), 
                                                CONSTRAINT LOG_PK PRIMARY KEY (ID))
                                                TABLESPACE USERS';
                                                
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.LOG.MSG_TYPE IS ''' || 'Тип сообщения' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.LOG.DT IS ''' || 'дата/время' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.LOG.METOD IS ''' || 'вызываемый метод' || '''';
   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.LOG.MSG IS ''' || 'сообщение' || '''';
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_LOG';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_LOG';
    END IF; 
   EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_LOG  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE' ;
 
 /* CREATE EXTEND*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'EXTEND';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.EXTEND CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.EXTEND  (
                                                ID NUMBER(10,0) NOT NULL ENABLE, 
                                                START_CONSTR NUMBER, 
                                                STOP_CONSTR NUMBER, 
                                                NUM_LAG NUMBER, 
                                                DELIVERY_DATE NUMBER, 
                                                YEAR_DP NUMBER,
                                                CONSTRAINT EXTEND_PK PRIMARY KEY (ID))
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.START_CONSTR IS ''' || 'Год начала строительства' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.STOP_CONSTR IS ''' || 'Год окончания строительства' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.NUM_LAG IS ''' || 'Количество переносов сдачи объекта' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.DELIVERY_DATE IS ''' || 'Год сдачи объекта' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.EXTEND.YEAR_DP IS ''' || 'Год полной поставки мощностей' || '''';
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = tmp_current_user AND sequence_name = 'SEQ_EXTEND';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_EXTEND';
    END IF; 
   EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_EXTEND  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE';
   
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
                                                CONSTRAINT C_CALENDAR_PK PRIMARY KEY (ID))';

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

/* CREATE MAIN*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MAIN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN CASCADE CONSTRAINTS';
    END IF; 
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN 
                                            (	ID NUMBER NOT NULL ENABLE, 
                                            CALENDAR_ID NUMBER, 
                                            TITLE_NUMBER NUMBER, 
                                            FINANCING_SOURCE_ID NUMBER,
-- 24.05.2021 удален по новым условиям 
                                           -- MS_ID NUMBER, 
                                            EXTEND_ID NUMBER, 
                                            POWER_ID NUMBER, 
                                            TITLE_STATE_ID NUMBER, 
                                            VALUE_FULL NUMBER, 
                                            VALUE_DONE NUMBER, 
                                            VALUE_CURR NUMBER, 
                                            CONSTRAINT MAIN_PK PRIMARY KEY (ID))
                                            TABLESPACE USERS' ;
    
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.CALENDAR_ID IS ''' || 'ID календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.TITLE_NUMBER IS ''' || '	Номер титула' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.FINANCING_SOURCE_ID IS ''' || 'Тип финансирования ' || '''';    
--    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.MS_ID IS ''' || 'Источник финансов' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.EXTEND_ID IS ''' || 'Постоянный блок данных для объекта на дату' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.POWER_ID IS ''' || 'Мощности' || '''';
    --       EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.FINANCING_SOURCE_ID IS ''' || 'Внешний ключ на таблицу FINANCING_SOURCE' || '''';
    --       EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.MAIN.MSK_GOV_PROGRAM_ID IS ''' || 'Внешний ключ на таблицу MSK_GOV_PROGRAM' || '''';
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

/* RUN */
PROCEDURE RUN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create GET_POWER */
PROCEDURE GET_POWER;
-----------------------------------------------------------------------------------------------------------------------------------------------------

END GET_PBI_2V;

/

create or replace PACKAGE BODY GET_PBI_2V AS

/* create CALENDAR */
PROCEDURE GET_CALENDAR
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp date;
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.CALENDAR ' ;
    for x in 1..n_months
    loop
        tmp := last_day(add_months(new_date, x));     
        INSERT INTO calendar (id, year, quarter, month, day, dt)
        VALUES(to_char(tmp, 'yyyymmdd'), to_char(tmp, 'yyyy'), to_char(trunc(tmp, 'q'),'q'), to_char(tmp, 'mm'), to_char(tmp, 'dd'), tmp);
    end loop;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.calendar;
    INSERT INTO log (id, msg_type, metod, msg) 
    VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_CALENDAR', 'INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
END GET_CALENDAR;

/* create GET_TITLE */
PROCEDURE GET_TITLE
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TITLE ' ;
    INSERT INTO title (title_number, title_type_id, cob_id,name,  address, start_year, finish_year) 
    SELECT DISTINCT t.title_number,
        (SELECT DISTINCT FIRST_VALUE(tt.title_type_id) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as title_type_id,
        cc.cob_id,
        (SELECT DISTINCT FIRST_VALUE(tt.title_name) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from DESC) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) AS name,
        (SELECT st.title_address FROM stroy.title st,
                (SELECT stt.id,  stt.title_number, row_number() over (partition by stt.title_number order by stt.year desc, stt.date_from desc) as RN
                FROM stroy.title stt
                WHERE
                    stt.year >= 2014
                    AND stt.stage_id = 95
                    AND stt.state_id = 3
                ) dat
            WHERE   
                 st.id = dat.id
                 AND st.title_number = t.title_number
                 AND dat.rn = 1
        ) title_address, 
        (SELECT DISTINCT FIRST_VALUE(tt.year) OVER(PARTITION BY tt.title_number ORDER BY tt.date_from) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as start_year,
        (SELECT MAX(tt.year) FROM stroy.title tt
            WHERE tt.stage_id = 95 AND tt.state_id = 3 AND tt.title_number = t.title_number) as finish_year
        FROM   stroy.title t
        INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
        INNER JOIN stroy.cob_card cc ON cc.cob_id = ct.cob_id    
    WHERE  
        t.stage_id = 95
        AND t.state_id = 3
        AND t.title_number in (43385, 154796, 155177, 109157, 59048, 250866, 700858, 156645,156646,700181,700182,700987,700988,700989,700990,700991,700992,700993,700994,700995,701417,702949,702950,702951,702952);
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.title;
    INSERT INTO log (id, msg_type, metod, msg) 
    VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_TITLE', 'INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
END GET_TITLE;

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
    INSERT INTO log (id, msg_type, metod, msg) 
    VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_FINANCING_SOURCE', 'INSERT PBI.FINANCING_SOURCE: ' || to_char(tmp_count) || ' (ROWS)');
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
            INNER JOIN stroy.power_state_program psp ON psp.power_id = m.power_id
            INNER JOIN stroy.power p ON p.id = m.power_id
        WHERE m.power_id IS NOT NULL
    )
    WHERE rn = 1;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.power;
    INSERT INTO log (id, msg_type, metod, msg) 
    VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_POWER', 'INSERT PBI.POWER: ' || to_char(tmp_count) || ' (ROWS)');
END GET_POWER;

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
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.EXTEND ' ;
    FOR x IN (SELECT  m.calendar_id,
                        (SELECT cct.cob_id FROM stroy.cob_title cct WHERE cct.title_number = m.title_number) cob_id
                      FROM pbi.main m ORDER BY id)
                LOOP
                    BEGIN
                        SELECT
                            to_number(to_char(min(tt.start_date),'YYYY')), to_number(to_char(max(tt.end_date),'YYYY')) into min_year, max_year
                        FROM stroy.title t
                            INNER JOIN stroy.title_term  tt on t.id=tt.title_id
                            INNER JOIN pbi.calendar c ON c.id = x.calendar_id
                            INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
                            --LEFT JOIN stroy.build_indicator bi ON bi.title_id = t.id
                            --LEFT JOIN stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
                        WHERE -- t.delete_date is null
                             tt.title_term_type_id = 1
                            AND t.stage_id = 95
                            AND t.title_type_id in (1, 2, 3)
                            AND t.year >= 2014
                            --AND bic.power_id = NVL(x.power_id, bic.power_id)
                            --AND bic.financing_source_id = NVL(x.financing_source_id, bic.financing_source_id)
                            --AND t.state_id = x.title_state_id
                            AND ct.cob_id = x.cob_id
                            AND c.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'));
                        n_extehd_id :=  pbi.seq_extend.nextval;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        min_year := 0;
                        max_year := 0;
                    END;

                    tmp_k := 0;
                    
                    FOR y IN (SELECT dt, id, year FROM pbi.calendar WHERE id < x.calendar_id ORDER BY id)
                    LOOP 
                    BEGIN
                        with 
                            dat as (
                                SELECT t.year ,
                                    t.id,
                                    FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, year ORDER BY t.date_from desc) AS tmax,
                                    ct.cob_id,
                                    tt.end_date 
                                FROM stroy.cob_title ct 
                                    LEFT JOIN stroy.title t ON t.title_number = ct.title_number 
                                    LEFT JOIN stroy.title_term tt ON tt.Title_Id = t.ID AND tt.title_term_type_id =1
                                WHERE t.stage_id =95
                                    AND t.state_id =3
                                    AND ct.cob_id = x.cob_id
                                    AND t.year BETWEEN 2014 and 2021
                                    AND  t.year < y.year
                            ),
                            dat1 AS (
                                SELECT dat.year,
                                    max(EXTRACT(YEAR FROM end_date)) OVER(PARTITION BY cob_id, year) as fin_y,
                                    COB_ID,
                                    FIRST_VALUE(year) over(PARTITION BY cob_id ORDER BY year desc) AS cfy
                                FROM dat
                                WHERE dat.id=tmax
                            ),
                            dat2 AS (
                                SELECT YEAR,
                                    fin_y,
                                    cob_id,
                                    RANK() OVER(PARTITION BY cob_id ORDER BY year) AS DR
                                FROM dat1
                                WHERE YEAR=FIN_Y
                                    --AND fin_y<>cfy
                                GROUP BY YEAR,
                                    fin_y,
                                    cob_id
                                ORDER BY cob_id
                            )
                        SELECT cob_id,  max(dr) INTO tmp_cob, tmp_k
                        FROM dat2 
                        GROUP BY 
                          cob_id
                        ORDER BY cob_id;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        tmp_k := 0;
                    END;
                    END LOOP;
                    
                    FOR y IN (SELECT dt, id, year FROM pbi.calendar WHERE id < x.calendar_id ORDER BY id)
                    LOOP 
                    BEGIN
                         with 
                            dat as (
                                SELECT t.year ,
                                    t.id,
                                    FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, year ORDER BY t.date_from desc) AS tmax,
                                    ct.cob_id,
                                    tt.end_date 
                                FROM stroy.cob_title ct 
                                    LEFT JOIN stroy.title t ON t.title_number = ct.title_number 
                                    LEFT JOIN stroy.title_term tt ON tt.Title_Id = t.ID AND tt.title_term_type_id =1
                                WHERE t.stage_id =95
                                    AND t.state_id =3
                                    AND ct.cob_id = x.cob_id
                                    AND t.year BETWEEN 2014 and 2021
                                    AND t.year < y.year
                            ),
                            dat1 AS (
                                SELECT dat.year,
                                    max(EXTRACT(YEAR FROM end_date)) OVER(PARTITION BY cob_id, year) as fin_y--,
                                    --COB_ID,
                                   -- FIRST_VALUE(year) over(PARTITION BY cob_id ORDER BY year desc) AS cfy
                                FROM dat
                                WHERE dat.id=tmax
                            )
                            select max(fin_y) INTO tmp_end_year from dat1;
                    
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        tmp_k := 0;
                    END;
                    END LOOP;

                    INSERT INTO extend (id, start_constr, stop_constr, num_lag, delivery_date) 
                    VALUES (n_extehd_id, min_year, max_year, tmp_k, tmp_end_year);
                    UPDATE main
                    SET extend_id = n_extehd_id
                    WHERE title_number in (SELECT title_number FROM stroy.cob_title WHERE cob_id = x.cob_id)
                        AND calendar_id = x.calendar_id;
                    
                    
            END LOOP;
            COMMIT;
            SELECT COUNT(*) INTO tmp_count FROM pbi.extend;
            INSERT INTO log (id, msg_type, metod, msg) 
            VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_EXTEND', 'INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
            DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.GET_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
            COMMIT;
END GET_EXTEND;
/* create PBI_MAIN */
PROCEDURE GET_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
CURSOR title is     
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
            AND TITLE_NUMBER in (43385, 154796, 155177, 109157, 59048, 250866, 700858)
        ),
    dat2 AS
        (
        SELECT mgp.name                                  AS MGP_NAME,
            bi.build_indicator_type_id                AS RES_TYPE,
-- 24.05.2021 выпилил по новым условиям
            Concat(bic.budget_classifier_id, ec.code) AS MS,
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
         /* план не текущий год (1). по ПСД (2) контрактная цена (3) и выполнено (4) */
                AND biv.build_indicator_value_type_id IN ( 1, 2, 3, 4 )
                AND NVL(biv.value, 0)  > 0
                AND ( biv.year IS NULL OR biv.year = dat.year )
                AND biv.quarter_number IS NULL
            left join stroy.msk_gov_program mgp ON mgp.id = dat.msk_gov_program_id
            left join stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
            left join stroy.economical_classifier ec ON ec.id = bic.economical_classifier_id
            left join stroy.power p ON p.id = bic.power_id
        ),
    dat3 as 
        (                       
        SELECT 
            dat2.calendar_id,
            dat2.mgp_name,
--            dat2.ms,
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
--            dat2.ms,
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
--        ms,
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
--    ms,
    title_number,
    financing_source_id,
    power_id,
    title_state_id;
BEGIN
    FOR x in title 
    LOOP
        IF NVL(x.full, 0) != 0 THEN
            INSERT INTO main (id, calendar_id,  title_number, financing_source_id, extend_id, power_id, title_state_id,    value_full,  value_done,  value_curr)
            VALUES (pbi.seq_main.NEXTVAL, x.calendar_id, x.title_number, x.financing_source_id,  null, x.power_id, x.title_state_id, x.full, x.done, x.curr);
        END IF;
    END LOOP;    
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main;
    INSERT INTO log (id, msg_type, metod, msg) 
    VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_PBI_2V.GET_MAIN', 'INSERT PBI.MAIN: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.GET_MAIN: ' || to_char(tmp_count) || ' (ROWS)');
    COMMIT;
END GET_MAIN;

/* RUN */
PROCEDURE RUN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
BEGIN
/* create PBI_CALENDAR_V3 */
    GET_CALENDAR;
/* create PBI_MAIN */
    GET_MAIN;
/* create GET_TITLE */
    GET_TITLE;
/* create GET_FINANCING_SOURCE */
    GET_FINANCING_SOURCE;
/* create GET_EXTEND */
    GET_EXTEND;
/* create GET_POWER */
    GET_POWER;
-----------------------------------------------------------------------------------------------------------------------------------------------------
    COMMIT;
END RUN;

END GET_PBI_2V;

/
-- RUN
BEGIN
    GET_PBI_2V.RUN;
-----------------------------------------------------------------------------------------------------------------------------------------------------
END;