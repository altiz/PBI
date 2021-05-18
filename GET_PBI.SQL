begin
    EXECUTE IMMEDIATE ' ALTER TABLE PBI.pbi_main_months  ADD NUM_LAG  number;';
EXCEPTION WHEN OTHERS THEN
    null;
end;

/

create or replace PACKAGE     GET_PBI AS 

-- загрузка PBI_GP
PROCEDURE GET_PBI_GP;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- загрузка PBI_COB
PROCEDURE GET_PBI_COB;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- загрузка PBI_PREGP
PROCEDURE GET_PBI_PREGP;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- загрузка PBI_COB_PREGP_LINK
PROCEDURE GET_PBI_COB_PREGP_LINK;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- загрузка PBI_COB_DISTR_LINK
PROCEDURE GET_PBI_COB_DISTR_LINK;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- КОРРЕКТИРОВКА
PROCEDURE GET_PBI_CORRECT;
-----------------------------------------------------------------------------------------------------------------------------------------------------
/* create PBI_CALENDAR_V3 */
PROCEDURE GET_CALENDAR;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- загрузка PBI_MAIN_MONTHS
PROCEDURE GET_PBI_MAIN_MONTHS;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GET_PREGP(pcosts_classifier_id IN NUMBER) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION get_distr(pcod_id in number) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GET_CURRENT_TITLE_YEAR(pcob_id IN NUMBER) RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GET_SUMM_FOR_TITLE(ptitle in NUMBER, dt date) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GET_SUMM_FOR_TITLE_44(ptitle in NUMBER) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- ЗАПУСК
PROCEDURE DATA_INSERT;
-----------------------------------------------------------------------------------------------------------------------------------------------------

END GET_PBI;

/

create or replace PACKAGE BODY     GET_PBI AS



PROCEDURE DATA_INSERT
as
    err_msg VARCHAR2(4000);
    str VARCHAR2(4000) := 'START';
BEGIN
    INSERT INTO pbi_log ( id,  log_text)
    VALUES (SEQ_LOG.NEXTVAL, 'START');
    COMMIT;
--------------------------------------------------------
    get_pbi_cob;
    get_pbi_gp;
    get_pbi_pregp;
    get_pbi_cob_pregp_link;
    get_pbi_cob_distr_link;

--------------------------------------------------------

     /*INSERT PBI.PBI_DISTR*/     
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_DISTR ' ;
    INSERT INTO pbi.pbi_distr ( id, name, ao_id)
    SELECT DISTINCT a.pbi_distr_id, adm.name, get_cob_v2.get_adm_reg_by_adm_id(a.pbi_distr_id,2)  
    FROM pbi.pbi_cob_distr_link a
    JOIN stroy.adm_region  adm ON adm.id=a.pbi_distr_id;
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_DISTR');      
    str := 'INSERT PBI.PBI_DISTR';

     /*INSERT PBI.PBI_AO*/   
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.pbi_AO ' ;
    INSERT INTO pbi.pbi_ao ( id,  name)
    SELECT DISTINCT ao_id,adm.name
    FROM pbi.pbi_distr a
    JOIN stroy.adm_region  adm ON adm.id=a.ao_id;
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_AO');   
     str := 'INSERT PBI.PBI_AO';

    /*INSERT PBI.PBI_MAIN*/  
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_MAIN ' ;
    pbi.get_cob_v2.calc_pbi_main_loop;
    pbi.get_cob_v2.fill_pbi_main_loop;
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_MAIN');  
     str := 'INSERT PBI.PBI_MAIN';

    /*PBI.PBI_POWER*/
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_POWER ' ;
    INSERT INTO PBI.PBI_POWER ( id,  name)
    SELECT id, name FROM stroy.power;   
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_POWER');  
    str := 'INSERT PBI.PBI_POWER';

    /*pbi_pp*/
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_PP ' ;
    INSERT INTO pbi_pp(id, name, pbi_gp_id)
    SELECT sp.id, sp.name, gp.id
    FROM stroy.state_program sp
    INNER JOIN pbi_gp gp ON sp.parent_id = gp.id ;
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_PP');      
    str := 'INSERT PBI.PBI_PP';

    /*pbi_pp*/        
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_COB_TYPE ' ;
    INSERT INTO PBI.PBI_COB_TYPE 
    SELECT id, name from STROY.COB_TYPE;
    DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.PBI_COB_TYPE');      
    str := 'INSERT PBI.PBI_COB_TYPE';

    get_pbi_correct;
    str := 'INSERT PBI.get_pbi_correct';
    get_calendar;
    str := 'INSERT PBI.get_calendar';
    get_pbi_main_months;
    str := 'INSERT PBI.get_pbi_main_months';


    INSERT INTO pbi_log ( id,  log_text)
    VALUES (SEQ_LOG.NEXTVAL, 'STOP');
    COMMIT;
    INSERT INTO pbi_log ( id,  log_text)
    VALUES (SEQ_LOG.NEXTVAL, str);
    COMMIT;
EXCEPTION WHEN OTHERS THEN
     err_msg := SQLERRM;
    ROLLBACK;
    INSERT INTO pbi_log ( id,  log_text)
    VALUES (SEQ_LOG.NEXTVAL, str || err_msg);
    COMMIT;
END DATA_INSERT;

-- загрузка PBI_COB
PROCEDURE GET_PBI_COB
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_COB ' ;
    INSERT INTO pbi.pbi_cob ( id,  name, address, center_latitude, center_longitude, PGEGP_id, delivery_date, cob_type, is_done)
    WITH v_title AS
    (
        SELECT t.id, t.title_number, t.delivery_date, t.title_name AS name, t.title_address
        FROM stroy.title t,
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
             t.id = dat.id
             AND dat.rn = 1
        ORDER BY t.title_number
    )
    SELECT MIN(c.id), MIN(cc.name), MIN(cc.address), 
        ROUND(AVG(tge.center_latitude), 4), ROUND(AVG(tge.center_longitude), 4),
        NVL(pbi.get_cob_v2.get_gov_prog_by_cost (MAX(NVL(tc.costs_classifier_id,2891))),2891 ) cost_id,
        MAX(extract (year from vt.delivery_date)),
         (SELECT CASE 
                            WHEN mck.is_big = 1 THEN 1 
                            WHEN mck.new_year = EXTRACT(YEAR FROM sysdate) THEN 2 
                            WHEN mck.new_year < EXTRACT(YEAR FROM sysdate) THEN 3 
                            WHEN mck.new_year > EXTRACT(YEAR FROM sysdate) THEN 4 
                        end
        FROM 
            stroy.mv_cob_kind mck  where mck.id = c.id) cob_type,
       GET_CURRENT_TITLE_YEAR(c.id)  is_done
    FROM stroy.cob c    
        INNER JOIN stroy.cob_card cc ON cc.cob_id = c.id
        INNER JOIN stroy.cob_title ct ON ct.cob_id = c.id
        INNER JOIN v_title vt ON vt.title_number = ct.title_number
        LEFT JOIN stroy.title_geodata_egip tge ON tge.title_number = ct.title_number
        LEFT JOIN stroy.title_costs_classifier tc ON tc.title_id = vt.id
    GROUP BY c.id
    ORDER BY c.id;

    FOR x IN 
    (
        SELECT 
            cob_id, dt
        FROM
        (
            SELECT ct.cob_id, t.year, max(to_number(to_char(tt.end_date,'YYYY'))) dt,
             row_number() over (partition by ct.cob_id order by  t.year desc) as RN
            FROM
                stroy.title t
                INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
                INNER JOIN stroy.title_term tt ON tt.title_id = t.id
            WHERE
                 tt.title_term_type_id = 1
                AND t.delete_date is null
                --AND t.year = max(t.year)
                AND t.date_to is null
                AND t.stage_id = 95
                AND t.title_type_id in (1,2,3)
                AND t.state_id = 3
            group by ct.cob_id, t.year
        )
        WHERE rn = 1
    )
    LOOP
        UPDATE pbi.pbi_cob
        SET finish_constraction = x.dt
        WHERE id = x.cob_id;
    END LOOP;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_cob;
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.PBI_COB: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_COB;

-- загрузка PBI_GP
PROCEDURE GET_PBI_GP
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_GP ' ;
     INSERT INTO pbi.pbi_gp(ID,name) 
    SELECT DISTINCT
        stt.id, stt.name
    FROM stroy.costs_classifier cc
        INNER JOIN stroy.state_program stt ON cc.state_program_id = stt.id
    WHERE cc.state_program_id IS NOT NULL 
        AND cc.costs_classifier_id IS NULL;
    INSERT INTO pbi.pbi_gp(ID,name)
    SELECT cct.id cost_id, cct.name FROM  stroy.COSTS_CLASSIFIER cct where id in (2890, 2893, 3093);
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_gp;
    DBMS_OUTPUT.PUT_LINE( '2. INSERT PBI.pbi_gp: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_GP;

-- загрузка PBI_PREGP
PROCEDURE GET_PBI_PREGP
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_PREGP ' ;
    INSERT INTO pbi.pbi_pregp (id, name, pbi_gp_id)
    WITH v_title AS
    (
    SELECT
        t.id,
        t.title_number,   
        t.delivery_date,
        t.title_name AS name,
        t.title_address
    FROM stroy.title t,
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
         t.id = dat.id
         AND dat.rn = 1
    ORDER BY t.title_number
    )
    SELECT DISTINCT pregp_id, cct1.name, DECODE(pbi.get_cob_v2.get_gov_prog_by_cost( min(NVL( pregp_id, 2891))), 7733, 3093, pbi.get_cob_v2.get_gov_prog_by_cost( min(NVL( pregp_id, 2891)))) gp_id   FROM
     (
        SELECT c.id c_id, get_pbi.get_pregp(cct.id) pregp_id
        FROM stroy.cob c
            LEFT JOIN stroy.cob_card cc ON cc.cob_id = c.id
            LEFT JOIN stroy.cob_title ct ON ct.cob_id = c.id
            LEFT JOIN v_title t ON t.title_number = ct.title_number
            LEFT JOIN stroy.title_costs_classifier tc ON tc.title_id = t.id
            LEFT JOIN stroy.costs_classifier cct ON tc.costs_classifier_id = cct.id
        WHERE
            cc.date_to is null
        ORDER BY c.id 
    )
    JOIN stroy.costs_classifier cct1 ON cct1.id = pregp_id
    WHERE pregp_id IS NOT NULL
    GROUP BY pregp_id, cct1.name
    ORDER BY pregp_id; 
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_pregp;
    DBMS_OUTPUT.PUT_LINE( '3. INSERT PBI.pbi_pregp: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_PREGP;

-- загрузка PBI_COB_PREGP_LINK
PROCEDURE GET_PBI_COB_PREGP_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_COB_PREGP_LINK ' ;
    INSERT INTO pbi.pbi_cob_pregp_link (pbi_cob_id, pbi_pregp_id)

    SELECT DISTINCT c_id, pregp_id FROM
         (
        SELECT DISTINCT c.id c_id, get_pbi.get_pregp(cct.id) pregp_id
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
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_cob_pregp_link;
    DBMS_OUTPUT.PUT_LINE( '4. INSERT PBI.pbi_cob_pregp_link: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_COB_PREGP_LINK;

-- загрузка PBI_COB_DISTR_LINK
PROCEDURE GET_PBI_COB_DISTR_LINK
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_COB_DISTR_LINK ' ;
    INSERT INTO pbi.pbi_cob_distr_link(pbi_cob_id,pbi_distr_id) 
    SELECT DISTINCT  cob_id, distr_id
    FROM
        (
        SELECT DISTINCT  cob_id, get_cob_v2.get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
        FROM 
            (
            SELECT  cc.cob_id, adm.adm_region_id
            FROM stroy.cob c
                INNER JOIN stroy.cob_card cc ON c.id=cc.cob_id
                INNER JOIN stroy.cob_title ct ON ct.cob_id =c.id
                INNER JOIN v_title vt ON vt.title_number = ct.TITLE_NUMBER
                LEFT JOIN stroy.TITLE_ADM_REGION adm ON adm.TITLE_ID = vt.ID                    
                JOIN stroy.ADM_REGION  reg ON reg.id=adm.ADM_REGION_ID                   
            WHERE cc.date_to is null
                AND reg.delete_date is null
                AND reg.adm_region_id != reg.id
        ) 
        UNION   
        SELECT DISTINCT cob_id, get_cob_v2.get_adm_reg_by_adm_id(adm_region_id,3)  distr_id
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
                AND reg.delete_date is null
        )
    )
    ORDER BY cob_id;
    INSERT INTO pbi.pbi_cob_distr_link(pbi_cob_id,pbi_distr_id)
    SELECT d.id, get_distr(d.id)
    from 
    (
    select DISTINCT id
    from
        pbi.pbi_cob 
        minus
     select DISTINCT c.id
    from
        pbi.pbi_cob c,
        pbi.pbi_cob_distr_link cdl,
        pbi.pbi_distr d
    where 
        cdl.pbi_cob_id = c.id
        and cdl.pbi_distr_id = d.id
    ) d; 
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_cob_distr_link;
    DBMS_OUTPUT.PUT_LINE( '5. INSERT PBI.PBI_COB_DISTR_LINK: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_COB_DISTR_LINK;

-- КОРРЕКТИРОВКА
PROCEDURE GET_PBI_CORRECT
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
BEGIN
    INSERT INTO pbi_gp(id, name)
    VALUES(1, 'Внебюжетное финансирование');

    INSERT INTO pbi_pp(id, name, pbi_gp_id)
    VALUES(1, 'Внебюжетное финансирование', 1);

    INSERT INTO pbi.pbi_distr ( id, name, ao_id)
    (select rownum,  'Район не указан',  id from pbi.pbi_ao);

    UPDATE pbi.pbi_cob_distr_link
    SET pbi_distr_id = 0
    WHERE pbi_distr_id is null;

    INSERT INTO pbi.pbi_distr ( id, name, ao_id)
    VALUES (0,  'Район не указан',  0);

    INSERT INTO pbi.pbi_AO ( id, name)
    VALUES (0,  'АО не указан');
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_cob_pregp_link;
    DBMS_OUTPUT.PUT_LINE( '1. CORRECT: 7 (ROWS)');
END GET_PBI_CORRECT;

/* create PBI_CALENDAR_V3 */
PROCEDURE GET_CALENDAR
-----------------------------------------------------------------------------------------------------------------------------------------------------
as
    new_date date := to_date('01.12.2013','dd.mm.yyyy');
    n_months number := 96;
    tmp date;
    tmp_count number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_CALENDAR_V3 ' ;
    for x in 1..n_months
    loop
        tmp := last_day(add_months(new_date, x));     
        INSERT INTO pbi_calendar_v3 (id, year, quarter, month, day, dt)
        VALUES(to_char(tmp, 'yyyymmdd'), to_char(tmp, 'yyyy'), to_char(trunc(tmp, 'q'),'q'), to_char(tmp, 'mm'), to_char(tmp, 'dd'), tmp);
    end loop;
        COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.pbi_calendar_v3;
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.PBI_CALENDAR_V3: ' || to_char(tmp_count) || ' (ROWS)');
END GET_CALENDAR;

-- загрузка PBI_MAIN_MONTHS
PROCEDURE GET_PBI_MAIN_MONTHS
-----------------------------------------------------------------------------------------------------------------------------------------------------
    IS
    tmp_count number;
    n_cobid number;
    n_sum number;
    n_sum_44 number;
    n_vrtual_sum number;
    vc_virtual varchar2(1);
    tmp number := 0;
    max_year number := 0;
    min_year number := 0;
    err_msg varchar2(4000);
    TYPE MainIdList IS TABLE OF NUMBER;
    list_44 MainIdList := MainIdList();  
    mainId number;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PBI.PBI_MAIN_MONTHS ' ;
    FOR y IN (SELECT id FROM pbi.pbi_cob)
    LOOP  
        BEGIN
                n_vrtual_sum := 0;
                FOR x IN (SELECT * FROM pbi.pbi_calendar_v3 ORDER BY 1)
                LOOP
                    BEGIN
                        SELECT
                            to_number(to_char(min(tt.start_date),'YYYY')), to_number(to_char(max(tt.end_date),'YYYY')) into min_year, max_year
                        FROM stroy.cob c
                            LEFT JOIN stroy.cob_card cc on c.id=cc.cob_id
                            LEFT JOIN stroy.cob_title ct on ct.cob_id =c.id
                            JOIN stroy.title t on t.TITLE_NUMBER = ct.TITLE_NUMBER
                            JOIN stroy.title_term  tt on t.id=tt.title_id
                        WHERE cc.date_to is null
                            and t.delete_date is null
                            and t.year = x.year
                            and cc.cob_id = y.id
                            and  t.date_from <= to_date(x.year||'-12-31','YYYY-MM-DD')
                            and  to_date(x.year||'-12-31','YYYY-MM-DD') <= nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
                            and TT.TITLE_TERM_TYPE_ID = 1
                            and t.STAGE_ID = 95
                            and t.TITLE_TYPE_ID in (1, 2, 3)
                            and rownum < 2
                        GROUP BY cc.id
                        ORDER BY cc.id;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        min_year := 0;
                        max_year := 0;
                    END;

                    BEGIN
                        SELECT sum(get_pbi.GET_SUMM_FOR_TITLE(dat.title_id, x.dt))  INTO n_sum
                        FROM
                        (       
                            SELECT t.id title_id, 
                                ROW_NUMBER() OVER (PARTITION BY t.title_number ORDER BY t.date_from desc) RN
                            FROM 
                                stroy.title t
                                INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
                                LEFT JOIN stroy.cob_card cc on ct.cob_id = cc.cob_id
                            WHERE
                                            ct.cob_id = y.id
                                    AND t.year >= 2014
                                    --AND t.date_to is null
                                    AND t.delete_date is null  
                                    AND t.stage_id = 95
                                    AND t.title_type_id in (1,2,3)
                                    AND t.state_id != 4
                                    AND x.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
                        ) dat
                        WHERE
                            dat.rn = 1;
                    n_vrtual_sum := n_sum;    
                    vc_virtual := 'N';
                    EXCEPTION WHEN NO_DATA_FOUND then
                        n_sum := 0;-- n_vrtual_sum;
                        --vc_virtual := 'Y';
                    END;

        /*  _44_*/
                    BEGIN
                        SELECT sum(get_pbi.GET_SUMM_FOR_TITLE_44(dat.title_id))  INTO n_sum_44
                        FROM
                        (       
                            SELECT t.id title_id, 
                                ROW_NUMBER() OVER (PARTITION BY t.title_number ORDER BY t.date_from desc) RN
                            FROM 
                                stroy.title t
                                INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
                                LEFT JOIN stroy.cob_card cc on ct.cob_id = cc.cob_id
                            WHERE
                                            ct.cob_id = y.id
                                    AND t.year >= 2014
                                    --AND t.date_to is null
                                    AND t.delete_date is null  
                                    AND t.stage_id = 95
                                    AND t.title_type_id in (1,2,3)
                                    AND t.state_id = 4
                                AND x.dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'))
                        ) dat
                        WHERE
                            dat.rn = 1;
                    n_vrtual_sum := n_sum_44;    
                    vc_virtual := 'N';
                    EXCEPTION WHEN NO_DATA_FOUND then
                        n_sum_44 := 0;-- n_vrtual_sum;
                        vc_virtual := 'Y';
                    END;                    
                    mainId := pbi.seq_pbi_main_v2.NEXTVAL;
                    INSERT INTO pbi_main_months (id, cob_id, lf,   dt,   calendar_id, is_virtual, start_constr, stop_constr) 
                    VALUES (mainId, y.id, NVL(n_sum,0) + NVL(n_sum_44,0), x.dt, x.id, vc_virtual,  min_year, max_year);
                    --DBMS_OUTPUT.PUT_LINE(to_char(x.id) || '   '  ||  n_sum);
                    IF n_sum_44 = 0 AND vc_virtual = 'N' AND n_sum = 0
                    THEN
                        list_44.EXTEND(mainId);
                        DBMS_OUTPUT.PUT_LINE(mainId);
                    END IF;
                END LOOP;
            Commit; 
        EXCEPTION WHEN OTHERS THEN
            err_msg := SQLERRM;
            ROLLBACK;
            INSERT INTO pbi_log ( id,  log_text)
            VALUES (SEQ_LOG.NEXTVAL, substr(y.id || err_msg, 0, 4000));
            COMMIT;
        END;
    END LOOP;   
    COMMIT;


    FOR y IN (SELECT DISTINCT cob_id as id FROM pbi.pbi_main_months)
    LOOP
        BEGIN
        FOR x IN (SELECT * FROM pbi.pbi_main_months m WHERE cob_id = y.id ORDER BY id)
          LOOP
            IF x.lf != 0
            THEN
              UPDATE pbi.pbi_main_months
              SET 
                lf = x.lf,
                is_virtual = 'Y'
              WHERE id < x.id AND cob_id = y.id AND lf = 0;
              commit;
              EXIT;
            END IF;
          END LOOP;
        END;

        BEGIN
          FOR x IN (SELECT * FROM pbi.pbi_main_months m WHERE cob_id = y.id ORDER BY id DESC)
          LOOP
            IF x.lf != 0
            THEN
              UPDATE pbi.pbi_main_months
              SET lf = x.lf,
                is_virtual = 'Y'
              WHERE id > x.id AND cob_id = y.id AND lf = 0;
              commit;
              EXIT;
            END IF;
          END LOOP;
        END;
    END LOOP;
    COMMIT;

BEGIN
    FOR x IN (SELECT id, cob_id, lf FROM pbi.pbi_main_months ORDER  BY cob_id, id)
    LOOP
        IF x.lf = 0 THEN
            UPDATE pbi.pbi_main_months
            SET 
                lf = tmp,
                is_virtual = 'Y'
            WHERE id = x.id;
        ELSE
            tmp := x.lf;
        END IF;        
    END LOOP;
END;

FOR y IN (SELECT DISTINCT cob_id as id FROM pbi.pbi_main_months)
    LOOP
        BEGIN
        FOR x IN (SELECT * FROM pbi.pbi_main_months m WHERE cob_id = y.id ORDER BY id)
          LOOP
            IF x.start_constr != 0
            THEN
              UPDATE pbi.pbi_main_months
              SET 
                start_constr = x.start_constr,
                stop_constr = x.stop_constr
              WHERE id < x.id AND cob_id = y.id AND start_constr = 0;
              commit;
              EXIT;
            END IF;
          END LOOP;

          FOR x IN (SELECT * FROM pbi.pbi_main_months m WHERE cob_id = y.id ORDER BY id DESC)
          LOOP
            IF x.start_constr != 0
            THEN
              UPDATE pbi.pbi_main_months
              SET 
                start_constr = x.start_constr,
                stop_constr = x.stop_constr
              WHERE id > x.id AND cob_id = y.id AND start_constr = 0;
              commit;
              EXIT;
            END IF;
          END LOOP;
        END;
    END LOOP;
    IF list_44.COUNT != 0 THEN
        FOR x in list_44.FIRST .. list_44.LAST
        LOOP
            UPDATE pbi.pbi_main_months
                SET 
                    lf = 0,
                    is_virtual = 'N'
                WHERE id = list_44(x);
        END LOOP;
    END IF;
    COMMIT;
    SELECT COUNT(*) INTO tmp_count FROM pbi.PBI_MAIN_MONTHS;
    DBMS_OUTPUT.PUT_LINE( '1. INSERT PBI.PBI_MAIN_MONTHS: ' || to_char(tmp_count) || ' (ROWS)');
END GET_PBI_MAIN_MONTHS;


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

/*Вычисляет итулы текущего года*/
FUNCTION GET_CURRENT_TITLE_YEAR(pcob_id IN NUMBER) RETURN VARCHAR2
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp NUMBER;
BEGIN
    SELECT COUNT(*) INTO TMP
    FROM 
        stroy.title t
        INNER JOIN stroy.cob_title ct ON ct.title_number = t.title_number
    WHERE
            t.year = extract (year from sysdate)
        AND t.delete_date is null    
        AND t.date_to is null
        AND t.stage_id = 95
        AND t.title_type_id in (1,2,3)
        AND t.state_id = 3
        AND ct.cob_id = pcob_id;
    IF tmp = 0 
    THEN
        RETURN 'Y';
    ELSE 
         RETURN 'N';
    END IF;

EXCEPTION WHEN OTHERS THEN
    RETURN 'N';
END GET_CURRENT_TITLE_YEAR;

--ВЫЧИСЛЯЕТ СУММУ
FUNCTION GET_SUMM_FOR_TITLE(ptitle in NUMBER, dt in date) RETURN NUMBER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_sum number;
BEGIN
    SELECT sum(NVL(value,0)) INTO tmp_sum
    FROM 
        stroy.title t
        LEFT JOIN stroy.BUILD_INDICATOR BI ON bi.title_id=t.id
        LEFT JOIN stroy.BUILD_INDICATOR_VALUE BIV On biv.build_indicator_id=bi.id
    WHERE
            t.id = ptitle
            AND t.year >= 2014
            AND t.delete_date is null  
            --AND cc.date_to is null
            AND t.stage_id = 95
            AND t.title_type_id in (1,2,3)
            AND t.state_id in (3, 4)
            AND bi.BUILD_INDICATOR_TYPE_ID = 3
            AND biv.BUILD_INDICATOR_VALUE_TYPE_ID =3
            AND dt BETWEEN   t.date_from and  nvl(t.date_to, to_date(t.year||'-12-31','YYYY-MM-DD'));
    RETURN tmp_sum;
EXCEPTION WHEN OTHERS THEN
    RETURN 0;
END GET_SUMM_FOR_TITLE;

--ВЫЧИСЛЯЕТ СУММУ
FUNCTION GET_SUMM_FOR_TITLE_44(ptitle in NUMBER) RETURN NUMBER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp_sum number;
BEGIN
    SELECT sum(NVL(value,0)) INTO tmp_sum
    FROM 
        stroy.title t
        LEFT JOIN stroy.BUILD_INDICATOR BI ON bi.title_id=t.id
        LEFT JOIN stroy.BUILD_INDICATOR_VALUE BIV On biv.build_indicator_id=bi.id
    WHERE
            t.id = ptitle
            AND t.year >= 2014
            AND t.delete_date is null  
            AND biv.year = t.year
            AND t.stage_id = 95
            AND t.title_type_id in (1,2,3)
            AND t.state_id = 4
            AND bi.BUILD_INDICATOR_TYPE_ID = 3
            AND biv.BUILD_INDICATOR_VALUE_TYPE_ID =4;
    RETURN tmp_sum;
EXCEPTION WHEN OTHERS THEN
    RETURN 0;
END GET_SUMM_FOR_TITLE_44;

-- ВСПМОГАТЕЛЬНАЯ
FUNCTION get_distr(pcod_id in number) RETURN NUMBER
-----------------------------------------------------------------------------------------------------------------------------------------------------
IS
    tmp number;
BEGIN
    SELECT DISTINCT   
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
    RETURN 0;
END get_distr;

END GET_PBI;