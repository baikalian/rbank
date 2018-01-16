--- body section ---

pragma pl_sql(true);
	n	number;
	job_name	string;
	uinfo	rtl.users_info;
	b	boolean;
	P_JOB_CLASS string;
	P_REPEAT_ERROR number;
	P_INTERVAL memo;
	P_FIRST_TIME date;
	P_EXECUTE boolean;
	v_lock integer;
		
begin

	b := rtl.get_user_info(uinfo);
	P_JOB_CLASS := 'DEFAULT_JOB_CLASS';
	P_REPEAT_ERROR := 10;
	P_INTERVAL := 'SYSDATE + 30/86400';
	P_FIRST_TIME := sysdate;
	P_EXECUTE := FALSE;

	v_lock := executor.lock_open();

	for obj in ::[SYSTEM_JOBS] where obj.[SHORT_NAME] = 'TEST_1'  loop
		obj.[INTERVAL] := P_INTERVAL;
		obj.[EDIT#AUTO](obj.[NAME],P_FIRST_TIME,obj.[INTERVAL],P_EXECUTE,false);
		obj.[QUEUE] := [SYSTEM_JOBS].[JOB_LIB].get_default_queue;
		job_name := null;
		n := [SYSTEM_JOBS].[JOB_LIB].submit_scheduler_job(obj%id,obj.[FIRST_TIME],true,obj.[NODE],obj.[METHOD_CLASS],obj.[SHORT_NAME],job_name, P_JOB_CLASS);
		obj.[JOB] := n;
		obj.[SUBMIT_TIME]:= sysdate;
		obj.[SUBMIT_USER]:= substr(uinfo.ora_user||'.'||uinfo.os_user||'.'||uinfo.id,1,100);
		obj.[START_TIME] := NULL;
		obj.[STOP_TIME]  := NULL;
		obj.[TOTAL] := 0;
		obj.[SUCCESS] := 0;
		obj.[FAILURES]:= 0;
		obj.[JOB_STATE] := 0;
		obj.[REPEAT_ERROR] := P_REPEAT_ERROR;
		obj.[INFO]:= 'Run at '||to_char(obj.[SUBMIT_TIME],'DD/MM/YYYY HH24:MI:SS.')||NL$;
		dbms_scheduler.enable(job_name);
	end loop;
	rtl.close;
	null;
end;


--- local section---

public procedure submit_trc_jobs is

pragma pl_sql(true);
	n	number;
	job_name	string;
	uinfo	rtl.users_info;
	b	boolean;
	P_JOB_CLASS string;
	P_REPEAT_ERROR number;
	P_INTERVAL memo;
	P_FIRST_TIME date;
	P_EXECUTE boolean;
	v_lock integer;
	
begin

	b := rtl.get_user_info(uinfo);
	P_JOB_CLASS := 'DEFAULT_JOB_CLASS';
	P_REPEAT_ERROR := 10;
	P_INTERVAL := 'SYSDATE + 30/86400';
	P_FIRST_TIME := sysdate;
	P_EXECUTE := FALSE;
	
	v_lock := executor.lock_open();

	for obj in ::[SYSTEM_JOBS] where obj.[SHORT_NAME] = 'TEST_1'  loop
		obj.[INTERVAL] := P_INTERVAL;
		obj.[EDIT#AUTO](obj.[NAME],P_FIRST_TIME,obj.[INTERVAL],P_EXECUTE,false);
		obj.[QUEUE] := [SYSTEM_JOBS].[JOB_LIB].get_default_queue;
		job_name := null;
		n := [SYSTEM_JOBS].[JOB_LIB].submit_scheduler_job(obj%id,obj.[FIRST_TIME],true,obj.[NODE],obj.[METHOD_CLASS],obj.[SHORT_NAME],job_name, P_JOB_CLASS);
		obj.[JOB] := n;
		obj.[SUBMIT_TIME]:= sysdate;
		obj.[SUBMIT_USER]:= substr(uinfo.ora_user||'.'||uinfo.os_user||'.'||uinfo.id,1,100);
		obj.[START_TIME] := NULL;
		obj.[STOP_TIME]  := NULL;
		obj.[TOTAL] := 0;
		obj.[SUCCESS] := 0;
		obj.[FAILURES]:= 0;
		obj.[JOB_STATE] := 0;
		obj.[REPEAT_ERROR] := P_REPEAT_ERROR;
		obj.[INFO]:= 'Run at '||to_char(obj.[SUBMIT_TIME],'DD/MM/YYYY HH24:MI:SS.')||NL$;
		dbms_scheduler.enable(job_name);
	end loop;
	rtl.close;
	null;
end;
