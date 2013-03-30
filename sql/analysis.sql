select R.patient_name, R.test_type, R.test_date, count(I.image_id) from radiology_record R, pacs_images I where R.record_id = I.record_id group by cube (R.patient_name, R.test_type, R.test_date);
