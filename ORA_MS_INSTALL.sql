create or replace PACKAGE GET_MSSQL_2v AS 

PROCEDURE run;

END GET_MSSQL_2v;
/

create or replace PACKAGE BODY GET_MSSQL_2V AS

	PROCEDURE run 
	AS
	tmp_count NUMBER;
	test_count NUMBER;
	BEGIN
	-- INSERT MS SQL CALENDAR
		DELETE FROM "dbo"."CALENDAR"@POWERBI;
		COMMIT;

        FOR v_rec IN (SELECT  id,    year,    quarter,    month,    day FROM  pbi.calendar) 
        LOOP
            INSERT INTO  "dbo"."CALENDAR"@POWERBI VALUES v_rec;
        END LOOP;  
		COMMIT;
		
        SELECT COUNT(*) INTO tmp_count FROM "dbo"."CALENDAR"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
		SELECT COUNT(*) INTO test_count FROM  "dbo"."CALENDAR"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.CALENDAR: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;

		-- INSERT MS SQL MAIN
		DELETE FROM "dbo"."MAIN"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  id,    calendar_id,    title_id,    ms_id,    annex_id,    power_id,    title_state_id, to_char(value_full + dbms_random.value,'0999999999.99'), 
			to_char(value_done + dbms_random.value,'0999999999.99'), to_char(value_curr + dbms_random.value,'0999999999.99') 
			FROM  pbi.main)
		LOOP
			INSERT INTO  "dbo"."MAIN"@POWERBI VALUES v_rec;      
			COMMIT;
		END LOOP;
		COMMIT;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."MAIN"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
        
        SELECT COUNT(*) INTO test_count FROM  "dbo"."MAIN"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
			
		-- INSERT MS SQL TITLE
		DELETE FROM "dbo"."TITLE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.title) 
		LOOP
			INSERT INTO  "dbo"."TITLE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE( 'INSERT PBI.TITLE');

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."TITLE"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."TITLE"@POWERBI;
        INSERT INTO log (id, msg_type, metod, msg) 
        VALUES ( pbi.Seq_Log.NEXTVAL, 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
	
	END RUN;
	
END GET_MSSQL_2V;