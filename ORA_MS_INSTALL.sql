create or replace PACKAGE PBI.GET_MSSQL_2v AS  

PROCEDURE run;
PROCEDURE main_run;
PROCEDURE EXTEND_run;
PROCEDURE main_pp_link_run;


END GET_MSSQL_2v;
/

create or replace PACKAGE BODY PBI.GET_MSSQL_2V AS

	PROCEDURE run 
	AS
	tmp_count NUMBER;
	test_count NUMBER;
	BEGIN
	-- INSERT MS SQL CALENDAR
		DELETE FROM "dbo"."CALENDAR"@POWERBI;
		COMMIT;

        FOR v_rec IN (SELECT  id,    year,    quarter,    month,    day, dt FROM  pbi.calendar) 
        LOOP
            INSERT INTO  "dbo"."CALENDAR"@POWERBI VALUES v_rec;
        END LOOP;  
		COMMIT;
		
        SELECT COUNT(*) INTO tmp_count FROM "dbo"."CALENDAR"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.CALENDAR: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
		SELECT COUNT(*) INTO test_count FROM  "dbo"."CALENDAR"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.CALENDAR: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
			
		-- INSERT MS SQL TITLE
		DELETE FROM "dbo"."TITLE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.title) 
		LOOP
			INSERT INTO  "dbo"."TITLE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."TITLE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."TITLE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
         
         -- INSERT MS SQL POWER
		DELETE FROM "dbo"."POWER"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.POWER) 
		LOOP
			INSERT INTO  "dbo"."POWER"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."POWER"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.POWER: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."POWER"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.POWER: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;       
	
        -- INSERT MS SQL FINANCING_SOURCE
		DELETE FROM "dbo"."FINANCING_SOURCE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.FINANCING_SOURCE) 
		LOOP
			INSERT INTO  "dbo"."FINANCING_SOURCE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."FINANCING_SOURCE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.FINANCING_SOURCE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."FINANCING_SOURCE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.FINANCING_SOURCE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
        
        -- INSERT MS SQL RESULT_AIP
		DELETE FROM "dbo"."RESULT_AIP"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.RESULT_AIP) 
		LOOP
			INSERT INTO  "dbo"."RESULT_AIP"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."RESULT_AIP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.RESULT_AIP: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."RESULT_AIP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.RESULT_AIP: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;      
            
        -- INSERT MS SQL MSK_GOV_PROGRAM
		DELETE FROM "dbo"."MSK_GOV_PROGRAM"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.MSK_GOV_PROGRAM) 
		LOOP
			INSERT INTO  "dbo"."MSK_GOV_PROGRAM"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."MSK_GOV_PROGRAM"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MSK_GOV_PROGRAM: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."MSK_GOV_PROGRAM"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MSK_GOV_PROGRAM: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
        
        -- INSERT MS SQL GP
		DELETE FROM "dbo"."GP"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.GP) 
		LOOP
			INSERT INTO  "dbo"."GP"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."GP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.GP: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."GP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.GP: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
		
		-- INSERT MS SQL GP_LF
		DELETE FROM "dbo"."GP_LF"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.GP_LF) 
		LOOP
			INSERT INTO  "dbo"."GP_LF"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."GP_LF"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.GP_LF: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."GP_LF"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.GP_LF: ' || to_char(test_count) || ' (ROWS)');
		COMMIT; 
        
        -- INSERT MS SQL PP
		DELETE FROM "dbo"."PP"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.PP) 
		LOOP
			INSERT INTO  "dbo"."PP"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."PP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.PP: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."PP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.PP: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
        
		-- INSERT MS SQL PREGP
		DELETE FROM "dbo"."PREGP"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.PREGP) 
		LOOP
			INSERT INTO  "dbo"."PREGP"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."PREGP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.PREGP: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."PREGP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.PREGP: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
		
		-- INSERT MS SQL MAIN_PREGP_LINK
		DELETE FROM "dbo"."COB_PREGP_LINK"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.COB_PREGP_LINK) 
		LOOP
			INSERT INTO  "dbo"."COB_PREGP_LINK"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."COB_PREGP_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_PREGP_LINK: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."COB_PREGP_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_PREGP_LINK: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
        
		-- INSERT MS SQL AO
		DELETE FROM "dbo"."AO"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.AO) 
		LOOP
			INSERT INTO  "dbo"."AO"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."AO"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.AO: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."AO"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.AO: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;  
		
		-- INSERT MS SQL DISTR
		DELETE FROM "dbo"."DISTR"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.DISTR) 
		LOOP
			INSERT INTO  "dbo"."DISTR"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."DISTR"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.DISTR: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."DISTR"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.DISTR: ' || to_char(test_count) || ' (ROWS)');
		COMMIT; 
        
		-- INSERT MS SQL COB_DISTR_LINK
		DELETE FROM "dbo"."COB_DISTR_LINK"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.COB_DISTR_LINK) 
		LOOP
			INSERT INTO  "dbo"."COB_DISTR_LINK"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."COB_DISTR_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_DISTR_LINK: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."COB_DISTR_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_DISTR_LINK: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;

		-- INSERT MS SQL COB
		DELETE FROM "dbo"."COB"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT      id,   name,   address,  to_char(center_latitude,'099.99999'), to_char(center_longitude,'099.99999') FROM  pbi.COB) 
		LOOP
			INSERT INTO  "dbo"."COB"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."COB"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."COB"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;

		-- INSERT MS SQL TITLE_STATE
		DELETE FROM "dbo"."TITLE_STATE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.TITLE_STATE) 
		LOOP
			INSERT INTO  "dbo"."TITLE_STATE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."TITLE_STATE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE_STATE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."TITLE_STATE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE_STATE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;

		-- INSERT MS SQL TITLE_TYPE
		DELETE FROM "dbo"."TITLE_TYPE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.TITLE_TYPE) 
		LOOP
			INSERT INTO  "dbo"."TITLE_TYPE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."TITLE_TYPE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE_TYPE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."TITLE_TYPE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.TITLE_TYPE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
		
		-- INSERT MS SQL COB_TYPE
		DELETE FROM "dbo"."COB_TYPE"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.COB_TYPE) 
		LOOP
			INSERT INTO  "dbo"."COB_TYPE"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."COB_TYPE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_TYPE: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."COB_TYPE"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_TYPE: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
        
        		-- INSERT MS SQL MONTH
		DELETE FROM "dbo"."MONTH"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.MONTH) 
		LOOP
			INSERT INTO  "dbo"."MONTH"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."MONTH"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MONTH: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."MONTH"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MONTH: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
	END RUN;


	PROCEDURE main_run 
	AS
	tmp_count NUMBER;
	test_count NUMBER;
	BEGIN
		-- INSERT MS SQL MAIN
		DELETE FROM "dbo"."MAIN"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  id,    calendar_id,    title_number,  financing_source_id,  msk_gov_program_id,    power_id,    title_state_id, to_char(value_full,'0999999999999.999999'), 
			to_char(value_done,'0999999999999.999999'), to_char(value_curr,'0999999999999.999999') 
			FROM  pbi.main)
		LOOP
			INSERT INTO  "dbo"."MAIN"@POWERBI VALUES v_rec;      
		END LOOP;
		COMMIT;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."MAIN"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
        
        SELECT COUNT(*) INTO test_count FROM  "dbo"."MAIN"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
        
        		-- INSERT MS SQL AIP
		DELETE FROM "dbo"."AIP"@POWERBI;
		COMMIT;

		FOR v_rec IN (SELECT  * FROM  pbi.aip) 
		LOOP
			INSERT INTO  "dbo"."AIP"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."AIP"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.AIP: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
		-- INSERT MS SQL COB_AIP_LINK
		DELETE FROM "dbo"."COB_AIP_LINK"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.cob_aip_link) 
		LOOP
			INSERT INTO  "dbo"."COB_AIP_LINK"@POWERBI VALUES v_rec;
			COMMIT;
		END LOOP;

        SELECT COUNT(*) INTO tmp_count FROM "dbo"."COB_AIP_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.COB_AIP_LINK: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
        
	end main_run;


	PROCEDURE main_pp_link_run 
	AS
	tmp_count NUMBER;
	test_count NUMBER;
	BEGIN
	    -- INSERT MS SQL MAIN_PP_LINK
		DELETE FROM "dbo"."MAIN_PP_LINK"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.MAIN_PP_LINK) 
		LOOP
			INSERT INTO  "dbo"."MAIN_PP_LINK"@POWERBI VALUES v_rec;			
		END LOOP;
		COMMIT;
        SELECT COUNT(*) INTO tmp_count FROM "dbo"."MAIN_PP_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN_PP_LINK: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."MAIN_PP_LINK"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.MAIN_PP_LINK: ' || to_char(test_count) || ' (ROWS)');
		COMMIT; 
	end main_pp_link_run;

	PROCEDURE EXTEND_run 
	AS
	tmp_count NUMBER;
	test_count NUMBER;
	BEGIN
		-- INSERT MS SQL EXTEND
		DELETE FROM "dbo"."EXTEND"@POWERBI;
		COMMIT;
    
		FOR v_rec IN (SELECT  * FROM  pbi.EXTEND) 
		LOOP
			INSERT INTO  "dbo"."EXTEND"@POWERBI VALUES v_rec;			
		END LOOP;
		COMMIT;
        SELECT COUNT(*) INTO tmp_count FROM "dbo"."EXTEND"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.EXTEND: ' || to_char(tmp_count) || ' (ROWS)');
        COMMIT;
		
        SELECT COUNT(*) INTO test_count FROM  "dbo"."EXTEND"@POWERBI;
        INSERT INTO pbi_log.log ( msg_type, metod, msg) 
        VALUES ( 'I', 'GET_MSSQL_2V.RUN', 'INSERT dbo.EXTEND: ' || to_char(test_count) || ' (ROWS)');
		COMMIT;
	end EXTEND_run;
	
    
END GET_MSSQL_2V;