Drop INDEX searchIndex0;
Drop INDEX searchIndex1;
Drop INDEX searchIndex2;

CREATE INDEX searchIndex0 ON radiology_record(patient_name)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'searchIndex0' 2

CREATE INDEX searchIndex1 ON radiology_record(diagnosis)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'searchIndex1' 2

CREATE INDEX searchIndex2 ON radiology_record(description)
INDEXTYPE IS CTXSYS.CONTEXT;
@drjobdml  'searchIndex2' 2
