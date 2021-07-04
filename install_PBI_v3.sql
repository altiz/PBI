DECLARE 
    tmp_current_user varchar2(64);
    tmp_is_objects number;
BEGIN
   
    SELECT username INTO tmp_current_user FROM user_users;
    
 /* CREATE GRBS*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'GRBS';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.GRBS CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.GRBS  (
                                                COB_ID NUMBER(10,0),
												NAME VARCHAR2(4000)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GRBS.COB_ID IS ''' || '	Внешний ключ на таблицу COB' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.GRBS.NAME IS ''' || 'Название ГРБС' || '''';

 /* CREATE PREGRBS*/    
--------------------------------------------------------------------------------------------------------------    
    SELECT COUNT(*) INTO tmp_is_objects FROM all_tables WHERE owner = tmp_current_user AND table_name = 'PREGRBS';
    
    IF tmp_is_objects != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE  PBI.PREGRBS CASCADE CONSTRAINTS';
    END IF;
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.PREGRBS  (
                                                COB_ID NUMBER(10,0),
												NAME VARCHAR2(4000)
                                                )
                                                TABLESPACE USERS';
                                                
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGRBS.COB_ID IS ''' || '	Внешний ключ на таблицу COB' || '''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PBI.PREGRBS.NAME IS ''' || 'Название Заказчика' || '''';

END;

begin
    EXECUTE IMMEDIATE 'drop table PBI.TMP_TITLE_IOT';
    EXECUTE IMMEDIATE 'CREATE TABLE PBI.TMP_TITLE_IOT
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
                                                CONSTRAINT TMP_TITLE_IOT_PK PRIMARY KEY (TITLE_ID, CALENDAR_ID))
                                                organization index';
end;

-- 1
declare 
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.TMP_TITLE_IOT ' ;
    INSERT INTO pbi.tmp_title_iot
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
            AND c.dt between t.date_from and nvl(t.date_to, to_date(to_char(t.year) || '-12-31','YYYY-MM-DD'))
            AND t.state_id != 4
        GROUP BY t.id, t.title_number, t.year, t.msk_gov_program_id, c.id, t.state_id, cct.cob_id, t.date_from, t.date_to, c.dt, t.delivery_date
    )
    WHERE rn = 1
    ORDER BY title_number, calendar_id;
    commit;
    SELECT COUNT(*) INTO tmp_count FROM pbi.tmp_title_iot;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.TMP_TITLE_IOT', 'INSERT PBI.TMP_TITLE_IOT: ' || to_char(tmp_count) || ' (ROWS)');
    commit;
END;
/
-- 2
DECLARE 
    start_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_day number;
    tmp_date date;
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.V3_CALENDAR ' ;
    tmp_date := start_date - 1;
    select  round(sysdate - to_date('01.12.2013','dd.mm.yyyy'))  into n_day from dual;
    for x in 1..n_day
    loop
        tmp_date := tmp_date + 1;     
        INSERT INTO pbi.v3_calendar (id, year, quarter, month, day, dt)
        VALUES (to_char(tmp_date, 'yyyymmdd'), to_char(tmp_date, 'yyyy'), to_char(trunc(tmp_date, 'q'),'q'), to_char(tmp_date, 'mm'), to_char(tmp_date, 'dd'), tmp_date);
    end loop;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.calendar;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_CALENDAR', 'INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
END;

--3
DECLARE
-----------------------------------------------------------------------------------------------------------------------------------------------------
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.V3_MAIN__' ;
    EXECUTE IMMEDIATE 'ALTER TABLE V3_MAIN DROP CONSTRAINT INX_V3_MAIN___PK';
INSERT INTO pbi.v3_main__ (calendar_id,  title_number, financing_source_id, power_id, title_state_id, start_constr, stop_constr, cob_type_id,  value_full,  value_done,  value_curr, msk_gov_program_id, d_year)
    WITH 
    dat2 AS
        (
        SELECT 
            bi.build_indicator_type_id                AS RES_TYPE,
-- 24.05.2021 выпилил по новым условиям
            --Concat(bic.budget_classifier_id, ec.code) AS MS,
            t.msk_gov_program_id AS MS,
            t.title_number,
            biv.value,
            biv.build_indicator_value_type_id         AS VALUE_TYPE,
            bic.financing_source_id,
            p.id power_id,
            t.title_id,
            t.state_id title_state_id,
            t.calendar_id,
            t.cob_id,
            t.cob_type,
            t.date_from,
            t.date_to,
            t.date_min start_constr,
            t.date_max stop_constr,
            t.d_year
        FROM  pbi.TMP_TITLE_IOT t  
            join stroy.build_indicator bi ON bi.title_id = t.title_id
-- нужно учесть что исключены мощности (6)
                AND bi.build_indicator_type_id IN ( 3, 6 )
        -- мощности (6) и деньги (3)
            join stroy.build_indicator_value biv ON biv.build_indicator_id = bi.id
         /* план не текущий год (1). по ПСД (2) контрактная цена (3) и выполнено (4) */
                AND biv.build_indicator_value_type_id IN ( 1, 2, 3, 4 )
                AND NVL(biv.value, 0)  > 0
                AND ( biv.year IS NULL OR biv.year = t.year )
                AND biv.quarter_number IS NULL
            left join stroy.build_indicator_classifier bic ON bic.id = bi.build_indicator_classifier_id
            left join stroy.economical_classifier ec ON ec.id = bic.economical_classifier_id
            left join stroy.power p ON p.id = bic.power_id                   
        ),
    dat3 as 
        (                       
        SELECT 
            dat2.calendar_id,
            dat2.ms,
            dat2.title_number,
            dat2.power_id,
            dat2.title_state_id,
            dat2.financing_source_id,
            dat2.cob_id,
            dat2.cob_type,
            dat2.date_from,
            dat2.date_to,
            dat2.start_constr,
            dat2.stop_constr,
            dat2.d_year,
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
            dat2.res_type,
            dat2.financing_source_id,
             dat2.cob_id,
            dat2.cob_type,
            dat2.date_from,
            dat2.date_to,
            dat2.start_constr,
            dat2.stop_constr,
            dat2.ms,
            dat2.title_number,          
            dat2.value_type,
            dat2.power_id,
            dat2.title_state_id,
            dat2.d_year,
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
        title_number,
        financing_source_id,
        power_id,
        title_state_id,
        start_constr,
        stop_constr,
        cob_type,   
        SUM(VALUE_FULL)  full,
        SUM(VALUE_DONE)  done,
        SUM(VALUE_CURR)  curr,
        ms,
        d_year
FROM DAT3
GROUP BY 
    calendar_id,
    ms,
    title_number,
    financing_source_id,
    power_id,
    title_state_id,
    cob_id,
        cob_type,
        date_from,
        date_to,
        start_constr,
        stop_constr,
        d_year;
    commit;
     EXECUTE IMMEDIATE 'ALTER TABLE v3_main__ ADD CONSTRAINT INX_V3_MAIN___PK PRIMARY KEY (ID)';
     commit;
    SELECT COUNT(*) INTO tmp_count FROM pbi.v3_main__;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.V3_MAIN__', 'INSERT PBI.V3_MAIN__: ' || to_char(tmp_count) || ' (ROWS)');
END;
/
--4
DECLARE
-----------------------------------------------------------------------------------------------------------------------------------------------------
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.v3_main_' ;
    INSERT INTO pbi.v3_main_
    SELECT id, calendar_id,
    RANK() OVER (order by title_number,
        financing_source_id,
        msk_gov_program_id,
        power_id,
        title_state_id,
        start_constr,
        stop_constr,
        cob_type_id,
        value_full,
        value_done,
        value_curr,
        d_year) dr,
            title_number,
        financing_source_id,
        msk_gov_program_id,
        power_id,
        title_state_id,
        start_constr,
        stop_constr,
        cob_type_id,
        value_full,
        value_done,
        value_curr,
        d_year
    FROM
        v3_main__;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.v3_main_;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.V3_MAIN_', 'INSERT PBI.V3_MAIN_: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.V3_MAIN_: ' || to_char(tmp_count) || ' (ROWS)');
END;
/
--5
DECLARE
-----------------------------------------------------------------------------------------------------------------------------------------------------
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE pbi.v3_main___' ;
    INSERT INTO v3_main___
    SELECT dr,  title_number,  financing_source_id,  msk_gov_program_id, power_id, title_state_id,  start_constr,  stop_constr,  cob_type_id, value_full,  value_done,   value_curr, d_year, max(calendar_id) calendar_id
    FROM   v3_main_
    group by  dr,  title_number,  financing_source_id,  msk_gov_program_id, power_id, title_state_id,  start_constr,  stop_constr,  cob_type_id, value_full,  value_done,   value_curr, d_year;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.v3_main_;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.V3_MAIN___', 'INSERT PBI.V3_MAIN___: ' || to_char(tmp_count) || ' (ROWS)');
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.V3_MAIN___: ' || to_char(tmp_count) || ' (ROWS)');
END;
/
BEGIN
-- сборка основной таблицы
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.V3_MAIN' ;
    EXECUTE IMMEDIATE 'ALTER TABLE V3_MAIN DROP CONSTRAINT INX_V3_MAIN_PK';
    INSERT INTO v3_main (    id,    title_number,    financing_source_id,    msk_gov_program_id,    power_id,    title_state_id,    start_constr,   stop_constr,   cob_type_id,   value_full,   value_done,   value_curr,    num_lag,    d_year)
    SELECT distinct   dr,  title_number,  financing_source_id,  msk_gov_program_id, power_id, title_state_id,  start_constr,  stop_constr,  cob_type_id, value_full,  value_done,   value_curr, null,  d_year
    FROM   v3_main_;
    EXECUTE IMMEDIATE 'ALTER TABLE V3_MAIN ADD CONSTRAINT INX_V3_MAIN_PK PRIMARY KEY (ID)';
    commit;

-- склейка календаря
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_CALENDAR_LINK' ;
    EXECUTE IMMEDIATE 'DROP INDEX "PBI"."INX_MAIN_CALENDAR_LINK"';
    INSERT INTO main_calendar_link 
    SELECT distinct dr, calendar_id FROM  v3_main_;
    commit;

--усеченная склейка календаря
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.MAIN_CALENDAR_LINK_ALT' ;
    EXECUTE IMMEDIATE 'DROP INDEX "PBI"."INX_MAIN_CALENDAR_LINK_ALT"';
    INSERT INTO main_calendar_link_alt
    SELECT m_id, cal_id FROM 
    (
        SELECT mcl1.main_id AS m_id, vc.year,  vc.month, max(mcl1.CALENDAR_ID) AS cal_id
        FROM MAIN_CALENDAR_LINK mcl1
        JOIN V3_CALENDAR vc ON vc.ID = mcl1.CALENDAR_ID 
        GROUP BY mcl1.main_id, vc.year, vc.month
    );
commit;

-- создание индексов
	EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_MAIN_CALENDAR_LINK" ON "PBI"."MAIN_CALENDAR_LINK" ("CALENDAR_ID", "MAIN_ID")';
    EXECUTE IMMEDIATE 'CREATE INDEX "PBI"."INX_MAIN_CALENDAR_LINK_ALT" ON "PBI"."MAIN_CALENDAR_LINK_ALT" ("CALENDAR_ID", "MAIN_ID")';

commit;
END;
/
BEGIN
EXECUTE IMMEDIATE 'update v3_main set num_lag = null';
FOR x in
(
	  WITH dat as (
			SELECT t."YEAR" ,  t.id,
				FIRST_VALUE(t.id) OVER (PARTITION BY t.TITLE_NUMBER, t.year ORDER BY t.DATE_FROM desc) AS tmax,
				ct.COB_ID,
				m.id main_id,
				tt.END_DATE,
                 mcla.calendar_id,
				CASE 
					WHEN t.DELIVERY_DATE IS NULL THEN EXTRACT(YEAR FROM END_DATE)
					ELSE EXTRACT (YEAR FROM t.DELIVERY_DATE)
				END AS DY
			FROM stroy.COB_TITLE ct 
			LEFT JOIN stroy.TITLE t ON t.TITLE_NUMBER = ct.TITLE_NUMBER 
			LEFT JOIN stroy.TITLE_TERM tt ON tt.TITLE_ID = t.ID AND tt.TITLE_TERM_TYPE_ID =1
			INNER JOIN v3_main m ON m.title_number = t.title_number 
            INNER JOIN pbi.main_calendar_link_alt mcla ON mcla.main_id = m.id
			INNER JOIN pbi.v3_calendar c ON  mcla.calendar_id = c.id
		--	INNER JOIN pbi.extend ex ON ex.main_id = m.id
			WHERE t.STAGE_ID =95
			  AND t.STATE_ID =3
			  AND t."YEAR" BETWEEN 2014 and c.year
              --and t.title_number  = 156179
			),
			dat1 AS (
			select dat."YEAR", main_id,
			  max(DY) OVER(PARTITION BY cob_id, YEAR) as FIN_Y,
			  cob_id, 
              calendar_id,
			  FIRST_VALUE(YEAR) over(PARTITION BY cob_id ORDER BY YEAR desc) AS CFY
			FROM dat
			WHERE dat.id=tmax
			)
            SELECT main_id , count(*) dr from (
                SELECT
                    dense_rank() over (partition by main_id, cob_id order by calendar_id) rd, main_id
                FROM dat1
                WHERE YEAR=FIN_Y
                  AND fin_y<>cfy)
            WHERE rd = 1
			GROUP BY  main_id
)
LOOP
    UPDATE v3_main
    SET num_lag = x.dr
WHERE
    id = x.main_id;
END LOOP;
UPDATE v3_main
		SET num_lag = 0
		WHERE num_lag is null;
COMMIT;
END;
/
BEGIN
FOR x in 
(
	with 
            dat as (
                SELECT t.year ,
                    t.id,
                    m.dr main_id,
                    FIRST_VALUE(t.id) OVER (PARTITION BY t.title_number, t.year ORDER BY t.date_from desc) AS tmax,
                    ct.cob_id,
                    tt.end_date 
                FROM stroy.cob_title ct 
                    LEFT JOIN stroy.title t ON t.title_number = ct.title_number 
                    LEFT JOIN stroy.title_term tt ON tt.Title_Id = t.ID AND tt.title_term_type_id =1                                    
                    INNER JOIN v3_main___ m ON m.title_number =  t.title_number
                    INNER JOIN  pbi.calendar c ON m.calendar_id = c.id                    
                WHERE t.stage_id =95
                    AND t.state_id =3
                 --   AND ct.cob_id = x.cob_id
                    AND t.year BETWEEN 2014 and 2022
                    AND t.year < c.year
            ),
            dat1 AS (
                SELECT dat.year, main_id,
                    max(EXTRACT(YEAR FROM end_date)) OVER(PARTITION BY cob_id, year) as fin_y--,
                FROM dat
                WHERE dat.id=tmax
            )
            select  main_id, max(fin_y) d  from dat1
            group by main_id
)
LOOP
    update v3_main
    set d_year = x.d
    where id = x.main_id;
END LOOP;
commit;
  UPDATE v3_main
    SET financing_source_id = 0
    WHERE financing_source_id is null;
    commit;
END;

BEGIN
for x in (
    with  dat as (
        select id, title_number, calendar_id from
        (
        select  m.id, m.title_number, mcla.calendar_id,
        row_number() over (partition by m.title_number order by mcla.calendar_id) rn
        from pbi.v3_main m
        inner join pbi.main_calendar_link_alt mcla ON mcla.main_id = m.id
        WHERE m.value_full is not null 
        AND m.TITLE_STATE_ID = 3
        AND m.POWER_ID IS NULL 
        order by 4, mcla.calendar_id,  m.title_number
        )
        WHERE rn = 1)
        select  m.id, m.title_number, mcla.calendar_id
        from pbi.v3_main m
        inner join dat ON dat.title_number = m.title_number 
        inner join pbi.main_calendar_link_alt mcla ON mcla.main_id = m.id
        where m.value_full is null and mcla.calendar_id < dat.calendar_id
    )
    LOOP
        delete from pbi.v3_main where id = x.id;
        delete from pbi.main_calendar_link_alt where main_id = x.id;
        delete from pbi.main_calendar_link where main_id = x.id;
    END LOOP;
    commit;
END; 
 
    
create or replace trigger PBI.NEWID_V3_MAIN 
 BEFORE INSERT ON v3_MAIN 
 FOR EACH ROW 
 BEGIN  
 if inserting then   
 if :NEW.ID is null or :NEW.ID<=0 then  
 select PBI.SEQ_MAIN.nextval into :NEW.ID from dual;   
 end if; 
 end if; 
 end;
 
 
 
 
  begin
--EXECUTE IMMEDIATE 'drop table PBI.V3_MAIN';
EXECUTE IMMEDIATE 'CREATE TABLE PBI.V3_MAIN 
                                            (	ID NUMBER NOT NULL ENABLE, 
                                            CALENDAR_ID NUMBER, 
                                            TITLE_NUMBER NUMBER, 
                                            FINANCING_SOURCE_ID NUMBER,
                                            MSK_GOV_PROGRAM_ID NUMBER, 
                                            EXTEND_ID NUMBER, 
                                            POWER_ID NUMBER, 
                                            TITLE_STATE_ID NUMBER, 
                                            START_CONSTR NUMBER, 
                                            STOP_CONSTR NUMBER, 
                                            COB_TYPE_ID        NUMBER,
                                            VALUE_FULL NUMBER, 
                                            VALUE_DONE NUMBER, 
                                            VALUE_CURR NUMBER, 
                                            CONSTRAINT V3_MAIN_PK PRIMARY KEY (ID))
                                            TABLESPACE USERS' ;
end;                                        
         
DECLARE
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp_count number;
     tmp number;
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
    
/*	INSERT INTO v3_main_pp_link (main_id, pp_id) 
	SELECT id, 1 FROM main WHERE power_id is null
	minus
	SELECT main_id, 1 FROM v3_main_pp_link;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN_PP_LINK', 'INSERT PBI.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');*/
END;

 
DECLARE
     tmp_count number;
     tmp number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.GRBS ' ;
    INSERT INTO pbi.grbs  
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
    SELECT ct.cob_id,
        o.full_name
    FROM stroy.cob_title ct 
        JOIN stroy.title t ON t.title_number = ct.Title_Number 
        JOIN dat2 ON dat2.title_id = t.id
        JOIN stroy.title_subject_org tso ON tso.title_id = t.ID 
            AND tso.Organization_Role_Type_Id = 2
            AND tso.is_main = 'Y'
        JOIN stroy.organization o ON o.ID = tso.organization_id 
    WHERE 1=1
    GROUP BY ct.cob_id , o.full_name;
/*	INSERT INTO v3_main_pp_link (main_id, pp_id) 
	SELECT id, 1 FROM main WHERE power_id is null
	minus
	SELECT main_id, 1 FROM v3_main_pp_link;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN_PP_LINK', 'INSERT PBI.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');*/
END;


DECLARE
     tmp_count number;
     tmp number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PREGRBS ' ;
    INSERT INTO pbi.pregrbs  
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
    SELECT ct.cob_id,
        o.full_name
    FROM stroy.cob_title ct 
        JOIN stroy.title t ON t.title_number = ct.Title_Number 
        JOIN dat2 ON dat2.title_id = t.id
        JOIN stroy.title_subject_org tso ON tso.title_id = t.ID 
            AND tso.Organization_Role_Type_Id = 3
    --      AND tso.is_main = 'Y'
        JOIN stroy.organization o ON o.ID = tso.organization_id 
    WHERE 1=1
    GROUP BY ct.cob_id , o.full_name;
/*	INSERT INTO v3_main_pp_link (main_id, pp_id) 
	SELECT id, 1 FROM main WHERE power_id is null
	minus
	SELECT main_id, 1 FROM v3_main_pp_link;
	COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.main_pp_link;
    INSERT INTO PBI_LOG.LOG (msg_type, metod, msg) 
    VALUES ('I', 'GET_PBI_2V.GET_MAIN_PP_LINK', 'INSERT PBI.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');*/
END;

