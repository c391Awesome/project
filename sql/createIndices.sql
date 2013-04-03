CREATE INDEX searchIndex0 ON radiology_record(patient_name)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'patient_name' 2

CREATE INDEX searchIndex1 ON radiology_record(diagnosis)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'diagnosis' 2

CREATE INDEX searchIndex2 ON radiology_record(description)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'description' 2
