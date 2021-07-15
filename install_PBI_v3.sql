DECLARE 
    tmp_current_user varchar2(64);
    tmp_is_objects number;
BEGIN
   
    SELECT username INTO tmp_current_user FROM user_users;
    
    
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
  

     /* CREATE GET_V3_CALENDAR*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'V3_CALENDAR';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.V3_CALENDAR CASCADE CONSTRAINTS';
    END IF;
 /*   EXECUTE IMMEDIATE 'CREATE TABLE PBI.V3_CALENDAR
                               (ID NUMBER, 
                                YEAR NUMBER, 
                                QUARTER NUMBER, 
                                MONTH NUMBER, 
                                DAY NUMBER, 
                                DT DATE, 
                                 CONSTRAINT C_V3_CALENDAR_PK PRIMARY KEY (ID))
                                 TABLESPACE USERS ';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.V3_CALENDAR  IS ''' || 'календарь версия 3' || '''';
    
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.V3_CALENDAR.ID IS ''' || 'Идентификатор календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.V3_CALENDAR.YEAR IS ''' || 'Год календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.V3_CALENDAR.QUARTER IS ''' || 'Квартар календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.V3_CALENDAR.MONTH IS ''' || 'Месяц календаря' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.V3_CALENDAR.DAY IS ''' || 'Последний день месяца' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.V3_CALENDAR  IS ''' || 'Табица календаря для PBI' || '''';*/
    
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
 
 /* CREATE MAIN_CALENDAR_LINK_ALT*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'MAIN_CALENDAR_LINK_ALT';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN_CALENDAR_LINK_ALT CASCADE CONSTRAINTS';
    END IF;
 /*   EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN_CALENDAR_LINK_ALT  (
                                                MAIN_ID NUMBER(10,0),
												CALENDAR_ID NUMBER(10,0)
                                                )
                                                TABLESPACE USERS';      */           
                                                
 /* CREATE V3_EXTEND*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'V3_EXTEND';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.V3_EXTEND CASCADE CONSTRAINTS';
    END IF;
/*    EXECUTE IMMEDIATE 'CREATE TABLE PBI.V3_EXTEND  (
                                                COB_ID NUMBER, 
                                                ID NUMBER, 
                                                COB_TYPE_ID NUMBER, 
                                                IS_CONTR NUMBER, 
                                                D_YEAR NUMBER, 
                                                STOP_CONSTR NUMBER, 
                                                START_CONSTR NUMBER, 
                                                M_DATE NUMBER, 
                                                NUM_LAG NUMBER, 
                                                EXTEND_ID NUMBER
                                               )  
                                               TABLESPACE USERS';     */                                                     

 /* CREATE V3_EXTEND*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'V3_MAIN';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.V3_MAIN CASCADE CONSTRAINTS';
    END IF;
 /*   EXECUTE IMMEDIATE 'CREATE TABLE PBI.V3_MAIN  (
                                                    ID NUMBER, 
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
                                               TABLESPACE USERS';   */
                                                
END;
/**********************************************************************************************************/
/

create or replace PACKAGE GET_PBI_3V AS 

/* create TMP_$_TITLE_IOT */
PROCEDURE GET_TMP_$_TITLE_IOT;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create V3_CALENDAR */
PROCEDURE GET_V3_CALENDAR;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create TMP_$1_MAIN */
PROCEDURE GET_TMP_$1_MAIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/* create TMP_$2_MAIN */
PROCEDURE GET_TMP_$2_MAIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*create TMP_$3_MAIN */
PROCEDURE GET_V3_MAIN;
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

/*create V3_EXTEND */
PROCEDURE GET_V3_EXTEND;
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

/*запуск сборки */
PROCEDURE RUN;
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

END GET_PBI_3V;
/**********************************************************************************************************/
/

create or replace PACKAGE BODY GET_PBI_3V AS

/* create TMP_$_TITLE_IOT */
PROCEDURE GET_TMP_$_TITLE_IOT
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_is_objects  number;
BEGIN
   
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'TMP_$_TITLE_IOT';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TMP_$_TITLE_IOT CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TMP_$_TITLE_IOT
                                           (TITLE_ID NUMBER, 
                                            TITLE_NUMBER NUMBER, 
                                            YEAR NUMBER,
                                            MSK_GOV_PROGRAM_ID NUMBER,
                                            CALENDAR_ID NUMBER,
                                            STATE_ID NUMBER,
                                            COB_ID NUMBER,
                                            COB_TYPE NUMBER,
                                            DATE_FROM DATE, 
                                            DATE_TO DATE,    
                                            DATE_MIN NUMBER, 
                                            DATE_MAX NUMBER,
                                            D_YEAR NUMBER,
                                            CONSTRAINT TMP_$_TITLE_IOT_PK PRIMARY KEY (TITLE_ID, CALENDAR_ID))
                                            ORGANIZATION INDEX';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PBI.TMP_$_TITLE_IOT  IS ''' || 'Временная таблица титулов' || '''';

    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TMP_$_TITLE_IOT ' ;
    EXECUTE IMMEDIATE 'INSERT INTO pbi.TMP_$_TITLE_IOT
    SELECT title_id, title_number, year, msk_gov_program_id, calendar_id, state_id, cob_id, 
                 (SELECT CASE 
                                        WHEN mck.is_big = 1 THEN 1 
                                        WHEN mck.new_year = EXTRACT(YEAR FROM dt) THEN 2 
                                        WHEN mck.new_year < EXTRACT(YEAR FROM dt) THEN 3 
                                        WHEN mck.new_year > EXTRACT(YEAR FROM dt) THEN 4 
                                    end
                    FROM 
                        stroy.mv_cob_kind mck  where mck.id = cob_id) cob_type,
                date_from, date_to, date_min, date_max, EXTRACT(YEAR FROM delivery_date) as delivery_date
    FROM
    (
         SELECT  t.id title_id, t.title_number, t.year, t.msk_gov_program_id, c.id calendar_id, t.state_id, cct.cob_id, t.date_from, t.date_to, c.dt,
            MIN(EXTRACT(YEAR FROM tt.start_date)) date_min,  max(EXTRACT(YEAR FROM tt.end_date)) date_max, t.delivery_date,
               row_number() over (partition by t.title_number, c.id order by t.year desc, t.date_from desc) as RN
        FROM stroy.title t, v3_calendar c, stroy.cob_title cct, stroy.title_term  tt
        WHERE
            t.year >= 2014
            AND  cct.title_number = t.title_number
            AND t.id=tt.title_id
            AND tt.title_term_type_id = 1
            AND t.delete_date is null
            AND t.stage_id = 95
            AND t.title_type_id in (1,2,3)
            AND c.dt between t.date_from and nvl(t.date_to, to_date(to_char(t.year) || ''-12-31'',''YYYY-MM-DD''))
            AND t.state_id != 4
        GROUP BY t.id, t.title_number, t.year, t.msk_gov_program_id, c.id, t.state_id, cct.cob_id, t.date_from, t.date_to, c.dt, t.delivery_date
    )
    WHERE rn = 1
    ORDER BY title_number, calendar_id';
    commit;
END GET_TMP_$_TITLE_IOT;

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

/* create TMP_$1_MAIN */
PROCEDURE GET_TMP_$1_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_count number;
    tmp_constraints number;
    tmp_is_objects number;
BEGIN

    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'TMP_$1_MAIN';

    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TMP_$1_MAIN CASCADE CONSTRAINTS';
    END IF;


    SELECT COUNT(*) INTO tmp_is_objects FROM all_sequences WHERE sequence_owner = 'PBI' AND sequence_name = 'SEQ_V3_MAIN';
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP SEQUENCE  PBI.SEQ_V3_MAIN';
    END IF; 
   EXECUTE IMMEDIATE 'CREATE SEQUENCE  PBI.SEQ_V3_MAIN  MINVALUE 1 MAXVALUE 10000000000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE';

    EXECUTE IMMEDIATE '
    CREATE TABLE TMP_$1_MAIN AS 
       WITH predtitle AS (
        SELECT t.id, 
            t.date_from,
            DECODE(EXTRACT (YEAR FROM t.DATE_TO),t.YEAR,t.DATE_TO,NULL) AS DATE_TO,
            t.TITLE_NUMBER,
            t.msk_gov_program_id,
            t.state_id,
            t.YEAR,
            t.STAGE_ID
        FROM stroy.TITLE t 
        WHERE 1=1
          --AND TITLE_NUMBER=43778 
          and STAGE_ID =95
          AND t."YEAR" >=2014
          AND t."YEAR" = EXTRACT (YEAR FROM t.DATE_FROM)
          AND t.id IN (SELECT max(t2.id) 
          -- выбираем только последние версии, если за день начинаетс¤ несколько титулов
                        FROM stroy.TITLE t2
                        WHERE 1=1
                            AND t2."YEAR" >=2014
                            AND t2.STAGE_ID = 95
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
            EXTRACT (MONTH FROM M_DATE) AS "MONTH",
            EXTRACT (YEAR FROM M_DATE) AS "YEAR" ,
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
        left join stroy.economical_classifier ec ON ec.id = bic.economical_classifier_id
        left join stroy.power p ON p.id = bic.power_id 
        LEFT JOIN stroy.BUDGET_CLASSIFIER bc ON bc.id = bic.BUDGET_CLASSIFIER_ID 
        JOIN title_date ON title_date.ID = t3.id  -- размазываем значение версии титула на все дни, в которые она действует
        ),
        dat_gr AS (
        -- считаем агрегаты дл¤ итоговых строк таблицы
        SELECT M_DATE,
            "MONTH",
            "YEAR" ,
            TITLE_NUMBER,   
            MS,
            FS,
            power_id,
            title_state_id,
            nullif(sum(VALUE_FULL_EL),0) AS VALUE_FULL,
            nullif(SUM(VALUE_DONE_EL),0) AS VALUE_DONE,
            nullif(SUM(VALUE_CONTR_EL),0) AS VALUE_CONTR
        FROM dat
        GROUP BY  M_DATE,
            "MONTH",
            "YEAR" ,
            TITLE_NUMBER,   
            MS,
            FS,
            power_id,
            title_state_id),
        fs_date AS (
        -- нахожу корректную дату начала каждого FC в титуле
        SELECT 
          min(M_DATE) AS min_FC_date,
          FS,
          TITLE_NUMBER
        FROM dat_gr 
        WHERE VALUE_FULL IS NOT NULL 
          AND TITLE_STATE_ID = 3
          AND POWER_ID IS NULL 
        GROUP BY FS,
          TITLE_NUMBER),
        power_date AS (
        -- нахожу корректную дату начала каждой мощности в титуле
        SELECT 
          min(M_DATE) AS min_power_date,
          power_id,
          TITLE_NUMBER
        FROM dat_gr 
        WHERE VALUE_FULL IS NOT NULL 
          AND TITLE_STATE_ID = 3
          AND POWER_ID IS not NULL 
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
            "MONTH",
            "YEAR",
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
            "MONTH",
            "YEAR" ,
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
        FROM full_table
        WHERE "YEAR" >=2015
        GROUP BY TITLE_NUMBER,
            "YEAR"),
        fin_table AS(
        -- оставл¤ю в таблице только данные на титул на конец мес¤ца. если верси¤ титуал кончилась до конца мес¤ца, то считаем на этот день
        SELECT ct.COB_ID,
            max(ft.m_date) AS M_DATE,
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
        FROM stroy.COB_TITLE ct 
        JOIN full_table ft ON ct.TITLE_NUMBER = ft.TITLE_NUMBER
        GROUP BY ct.COB_ID,
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
        UNION 
        -- добавл¤ем дно - начало действи¤ самой первой корректной версии титула
        SELECT ct3.COB_ID,
            ft3.m_date,
            ft3."MONTH",
            ft3."YEAR",
            ft3.TITLE_NUMBER,
            ft3.FINANCING_SOURCE_ID,
            ft3.MSK_GOV_PROGRAM_ID,
            ft3.POWER_ID,
            ft3.TITLE_STATE_ID,
            ft3.VALUE_FULL,
            ft3.VALUE_DONE,
            ft3.VALUE_CONTR
        FROM stroy.COB_TITLE ct3 
        JOIN full_table ft3 ON ct3.TITLE_NUMBER = ft3.TITLE_NUMBER
        JOIN min_date_titles ON ft3.TITLE_NUMBER = min_date_titles.TITLE_NUMBER
            AND ft3.m_date = min_date_titles.min_title_date
        UNION 
        -- добавл¤ем дату начала титулов в каждом году, отличном от 2014
        SELECT ct3.COB_ID,
            ft3.m_date,
            ft3."MONTH",
            ft3."YEAR",
            ft3.TITLE_NUMBER,
            ft3.FINANCING_SOURCE_ID,
            ft3.MSK_GOV_PROGRAM_ID,
            ft3.POWER_ID,
            ft3.TITLE_STATE_ID,
            ft3.VALUE_FULL,
            ft3.VALUE_DONE,
            ft3.VALUE_CONTR
        FROM stroy.COB_TITLE ct3 
        JOIN full_table ft3 ON ct3.TITLE_NUMBER = ft3.TITLE_NUMBER
        JOIN min_date_title_year ON ft3.TITLE_NUMBER = min_date_title_year.TITLE_NUMBER
            AND ft3.m_date = min_date_title_year.m_date
            AND ft3."YEAR" = min_date_title_year."YEAR"
        )
        -- добавл¤ю ID, замен¤ю отсутсвующие финансовые значени¤ нул¤ми
        SELECT ROWNUM as ID,
            COB_ID,
            TO_CHAR(m_date, ''yyyymmdd'') AS CALENDAR_ID,
            "MONTH",
            "YEAR",
            TITLE_NUMBER,
            FINANCING_SOURCE_ID,
            MSK_GOV_PROGRAM_ID,
            POWER_ID,
            TITLE_STATE_ID,
            nvl(VALUE_FULL,0) as VALUE_FULL,
            nvl(VALUE_DONE,0) as VALUE_DONE,
            nvl(VALUE_CONTR,0) as VALUE_CONTR
        FROM fin_table';
    commit;
     EXECUTE IMMEDIATE 'ALTER TABLE TMP_$1_MAIN ADD CONSTRAINT INX_TMP_$1_MAIN_PK PRIMARY KEY (ID)';
     commit;
END GET_TMP_$1_MAIN;

/* create TMP_$2_MAIN */
PROCEDURE GET_TMP_$2_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_is_objects number;
    tmp_count number;
BEGIN
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'TMP_$2_MAIN';
        
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.TMP_$2_MAIN CASCADE CONSTRAINTS';
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE TMP_$2_MAIN AS
        select id, m_date,
        RANK() OVER (order by title_number,
        financing_source_id,
        msk_gov_program_id,
        power_id,
        title_state_id,
        value_full,
        value_done,
        value_contr
        ) rn,
        title_number,
        financing_source_id,
        msk_gov_program_id,
        power_id,
        title_state_id,
        value_full,
        value_done,
        value_contr
        from TMP_$1_MAIN';
        COMMIT;

END GET_TMP_$2_MAIN;

/*create TMP_$3_MAIN */
PROCEDURE GET_V3_MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_indexes number;
    tmp_constraints number;
    tmp_count number;
    tmp_is_objects number;
BEGIN

    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'v3_main';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.v3_main CASCADE CONSTRAINTS';
    END IF;    

    EXECUTE IMMEDIATE '
    INSERT INTO v3_main
    SELECT distinct rn, title_number, financing_source_id, msk_gov_program_id, power_id, title_state_id, value_full, value_done, value_contr, null    FROM   TMP_$2_MAIN';
 --   EXECUTE IMMEDIATE 'ALTER TABLE V3_MAIN ADD CONSTRAINT INX_V3_MAIN_PK PRIMARY KEY (ID)';
    commit;

-- сборка индексов
    SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'INX_MAIN_CALENDAR_LINK';
    IF tmp_constraints > 0 THEN
           EXECUTE IMMEDIATE 'DROP INDEX PBI.INX_MAIN_CALENDAR_LINK';
    END IF;

 /*   SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'MAIN_CALENDAR_LINK_ALT';
    IF tmp_constraints > 0 THEN
            EXECUTE IMMEDIATE 'DROP INDEX PBI.INX_MAIN_CALENDAR_LINK_ALT';
    END IF;
	commit;*/

    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = 'PBI' AND table_name = 'MAIN_CALENDAR_LINK';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.MAIN_CALENDAR_LINK CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.MAIN_CALENDAR_LINK  (
                                                MAIN_ID NUMBER(10,0),
												CALENDAR_ID NUMBER(10,0)
                                                )
                                                TABLESPACE USERS';      


-- склейка календаря
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_CALENDAR_LINK' ;
    EXECUTE IMMEDIATE 'INSERT INTO main_calendar_link 
    SELECT distinct rn, m_date FROM  TMP_$2_MAIN';
    commit;

--усеченная склейка календаря
 /*   EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_CALENDAR_LINK_ALT' ;
    EXECUTE IMMEDIATE 'INSERT INTO main_calendar_link_alt
    SELECT m_id, cal_id FROM 
    (
        SELECT mcl1.main_id AS m_id, vc.year,  vc.month, max(mcl1.CALENDAR_ID) AS cal_id
        FROM MAIN_CALENDAR_LINK mcl1
        JOIN V3_CALENDAR vc ON vc.ID = mcl1.CALENDAR_ID 
        GROUP BY mcl1.main_id, vc.year, vc.month
    )';
commit;*/
-- сборка индексов
 /*   SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'MAIN_CALENDAR_LINK_ALT';
    IF tmp_indexes = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_MAIN_CALENDAR_LINK_ALT" ON "PBI"."MAIN_CALENDAR_LINK_ALT" ("CALENDAR_ID", "MAIN_ID")';
    END IF;
	commit;*/
    
END GET_V3_MAIN;

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


/*create V3_EXTEND */
PROCEDURE GET_V3_EXTEND
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
     tmp_count number;
     tmp number;
     tmp_indexes number;
BEGIN

 /*   SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'INX_MAIN_CALENDAR_LINK_ALT';
    IF tmp_indexes = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_MAIN_CALENDAR_LINK_ALT" ON "PBI"."MAIN_CALENDAR_LINK_ALT" ("MAIN_ID")';
    END IF;
    
    SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'INX_V3_CALENDAR';
    IF tmp_indexes = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_V3_CALENDAR" ON "PBI"."V3_CALENDAR" ("ID", "DT")';
    END IF;    
    
    SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'INX_V3_MAIN';
    IF tmp_indexes = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_V3_MAIN" ON "PBI"."V3_MAIN" ("ID")';
    END IF;    

    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.V3_EXTEND';
    EXECUTE IMMEDIATE 'INSERT INTO pbi.V3_EXTEND (ID, COB_ID, COB_TYPE_ID, IS_CONTR, D_YEAR, STOP_CONSTR, START_CONSTR, M_DATE, NUM_LAG, EXTEND_ID)
            WITH cal_y AS (
            --получаем список годов календаря
            SELECT DISTINCT c."YEAR" AS C_YEAR
            FROM pbi.CALENDAR c ),
            first_titles AS (
            -- получаем последнюю включенную в АИП версию титула каждого коба в каждом году году 
            select cy.C_YEAR,
                t."YEAR",
                t.TITLE_NUMBER,
                t.id,
                FIRST_VALUE(t.id) OVER (PARTITION BY t.TITLE_NUMBER, year ORDER BY t.DATE_FROM desc) AS TITLE_MAX,
                ct.COB_ID,
                t.DELIVERY_DATE,
                tt.END_DATE 
            FROM cal_y cy
            JOIN stroy.COB_TITLE ct ON 1=1
            JOIN stroy.TITLE t ON t.TITLE_NUMBER = ct.TITLE_NUMBER 
            JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = t.ID AND tt.TITLE_TERM_TYPE_ID =1  -- сроки строительства
            WHERE t.STAGE_ID =95
              AND t.STATE_ID =3
              AND t."YEAR" >=2014
              AND t."YEAR" < cy.C_YEAR
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
              t.DELIVERY_DATE,
              tt.END_DATE,
              tt.START_DATE,
              DECODE(NVL(sum(fp.AMOUNT) over(PARTITION BY t."YEAR" , ct.COB_ID),0)*NVL(sum(contr.id) over(PARTITION BY vc.id),0),0,null,1) AS IS_CONTR, -- проверяем чтоб хоть у одного титула объекта был ненуллевой финплан в году
              -- и наличие заключенного контракта в нужном статусе на дату
              CASE 
              -- определяем типы объектов
                WHEN mck.is_big = 1 THEN 1 
                WHEN mck.new_year = EXTRACT(YEAR FROM vc.dt) THEN 2 
                WHEN mck.new_year < EXTRACT(YEAR FROM vc.dt) THEN 3 
                WHEN mck.new_year > EXTRACT(YEAR FROM vc.dt) THEN 4 
              END AS COB_TYPE_ID
            FROM stroy.COB_TITLE ct 
            JOIN stroy.TITLE t ON ct.TITLE_NUMBER = t.TITLE_NUMBER 
            LEFT JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = t.ID 
              AND tt.TITLE_TERM_TYPE_ID =1
            -- находим даты календаря, в которые существовали нужные нам версии титулов
            JOIN pbi.V3_CALENDAR vc ON vc.DT BETWEEN t.DATE_FROM AND nvl(t.date_to, to_date(t.year||''-12-31'',''YYYY-MM-DD''))
                AND vc.ID IN (
                --оставляем даты, в которые у коба в таблице main есть связь с календарем
                SELECT mcla.CALENDAR_ID 
                FROM pbi.COB c 
                JOIN pbi.TITLE t2 ON t2.COB_ID = c.ID 
                JOIN pbi.V3_MAIN vm ON vm.TITLE_NUMBER = t2.TITLE_NUMBER 
                JOIN pbi.MAIN_CALENDAR_LINK_ALT mcla ON mcla.MAIN_ID = vm.id
                WHERE c.ID =ct.COB_ID)
            JOIN stroy.MV_COB_KIND mck ON mck.ID = ct.COB_ID
            LEFT JOIN stroy.FINANCIAL_PlAN fp ON
                fp.TITLE_NUMBER = t.TITLE_NUMBER
                AND fp.BUDGET_YEAR = t.YEAR
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
            WHERE 1=1
              -- ограничение для отладки в 10 кобов
                --AND ct.cob_id = 4884
                AND t.id IN (SELECT DISTINCT first_value(tt2.id) OVER(PARTITION BY tt2.TITLE_NUMBER, tt2.DATE_FROM ORDER BY tt2.DATE_FROM desc)
                            FROM stroy.TITLE tt2
                            WHERE 1=1
                                AND tt2."YEAR" >=2014
                                AND tt2.STAGE_ID = 95)
            ),
            gp_extend AS(
            -- готовим данные для расчета, считаем значение столбцов таблицы EXTEND
            SELECT COB_ID,
                COB_TYPE_ID,
                IS_CONTR,
                MAX(EXTRACT (YEAR FROM nvl(DELIVERY_DATE,END_DATE))) AS D_YEAR,
                MAX(EXTRACT (YEAR FROM END_DATE)) AS STOP_CONSTR,
                min(EXTRACT (YEAR FROM START_DATE)) AS START_CONSTR,
                M_DATE,
                row_number() OVER(ORDER BY COB_ID) AS ID,
                M_YEAR
            FROM dat
            GROUP BY COB_ID,
                M_DATE,
                COB_TYPE_ID,
                IS_CONTR,
                M_YEAR
            )
            SELECT ID,
                gp_extend.COB_ID,
                COB_TYPE_ID,
                IS_CONTR,
                D_YEAR,
                STOP_CONSTR,
                START_CONSTR,
                M_DATE,
                nvl(NUM_LAG_YEAR,0) AS NUM_LAG,
                FIRST_VALUE(ID) OVER(PARTITION BY gp_extend.COB_ID,	COB_TYPE_ID,IS_CONTR,D_YEAR,STOP_CONSTR,START_CONSTR,NUM_LAG_YEAR ORDER BY M_DATE) AS EXTEND_ID
            FROM gp_extend
            -- цепляем таблицу нумлага к extend
            LEFT JOIN year_num_lag ON year_num_lag.C_YEAR=gp_extend.M_YEAR 
                AND year_num_lag.COB_ID=gp_extend.COB_ID';
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.v3_extend;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.V3_EXTEND', 'INSERT PBI.V3_EXTEND: ' || to_char(tmp_count) || ' (ROWS)');	

    BEGIN
    FOR x in (
        SELECT m.id, ve.EXTEND_ID 
            FROM stroy.COB c 
            JOIN PBI.TITLE t ON t.COB_ID = c.ID 
            JOIN PBI.v3_MAIN m ON m.TITLE_NUMBER = t.TITLE_NUMBER 
            JOIN PBI.MAIN_CALENDAR_LINK_ALT mcla ON m.ID = mcla.MAIN_ID 
            JOIN PBI.V3_EXTEND ve ON ve.COB_ID = c.ID AND ve.M_DATE = mcla.CALENDAR_ID
            )
    LOOP
        UPDATE v3_main SET extend_id = x.extend_id
        WHERE id = x.id;
    END LOOP;
    commit;
END;*/
null;
END GET_V3_EXTEND;


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
SELECT ROWNUM,
	ct.COB_ID,
 	TO_CHAR(m_date, ''yyyymmdd'') AS CALENDAR_ID,
	"MONTH",
	"YEAR",
	ct.TITLE_NUMBER,
	FINANCING_SOURCE_ID,
	MSK_GOV_PROGRAM_ID,
	POWER_ID,
	TITLE_STATE_ID,
	nvl(VALUE_FULL,0),
	nvl(VALUE_DONE,0),
	nvl(VALUE_CONTR,0)
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

/*запуск сборки */
PROCEDURE RUN
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_is_objects number;
    tmp_indexes number;
BEGIN
    
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
    
    /* create TMP_$_TITLE_IOT */
--    GET_TMP_$_TITLE_IOT;                        
    
    /* create TMP_$1_MAIN */
--    GET_TMP_$1_MAIN;
    
    /* create TMP_$2_MAIN */
--    GET_TMP_$2_MAIN;
    
    /*create TMP_$3_MAIN */
--    GET_V3_MAIN;
        
--    GET_V3_EXTEND  ;  
    
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
   
    
  /*  SELECT count(*) INTO tmp_indexes FROM all_indexes WHERE owner = 'PBI' AND index_name = 'INX_V3_CALENDAR';
    IF tmp_indexes > 0 THEN
        EXECUTE IMMEDIATE 'DROP INDEX "PBI"."INX_V3_CALENDAR"';
    END IF;   */
    


END RUN;

END GET_PBI_3V;
/