create table temp as select R.patient_name, R.test_type, R.test_date, count(I.image_id) as image_count from radiology_record R, pacs_images I where R.record_id = I.record_id group by cube (R.patient_name, R.test_type, R.test_date);

select patient_name, image_count from temp where test_type is NULL and test_date is NULL;

select test_type, image_count from temp where patient_name is NULL and test_date is NULL;

select patient_name, test_type, image_count from temp where test_date is NULL and patient_name is not NULL and test_type is not NULL;

select test_date, image_count from temp where patient_name is NULL and test_type is NULL;
