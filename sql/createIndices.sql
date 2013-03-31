CREATE INDEX searchIndex0 ON radiology_record(patient_name)
INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX searchIndex1 ON radiology_record(diagnosis)
INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX searchIndex2 ON radiology_record(description)
INDEXTYPE IS CTXSYS.CONTEXT;


REM based on drjobdml.sql example script


declare
	job number;
begin
	dbms_job.submit(job, 'ctx_ddl.sync_index(''searchIndex0'');',
						interval=>'SYSDATE+240/1440');
	dbms_job.submit(job, 'ctx_ddl.sync_index(''searchIndex1'');',
						interval=>'SYSDATE+240/1440');
	dbms_job.submit(job, 'ctx_ddl.sync_index(''searchIndex2'');',
						interval=>'SYSDATE+240/1440');
end;

commit;
