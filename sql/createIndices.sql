CREATE INDEX searchIndex ON radiology_record(patient_name, diagnosis, description)
	INDEXTYPE IS CTXSYS.CONTEXT;
