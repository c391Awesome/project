/*
list of SQL queries used in OLAPOperation class
*/

drop table temp;

drop table OLAPcube;

/*temp*/
create table temp as select R.patient_name, R.test_type, to_char(R.test_date, 'yyyy') as year, to_char(R.test_date, 'mm') as month, to_char(R.test_date, 'ww') as week, I.image_id from radiology_record R, pacs_images I where R.record_id = I.record_id;

/*cube*/
create table OLAPcube as select patient_name, test_type, year, month, week, count(image_id) as image_count from temp group by cube (patient_name, test_type, year, month, week);

/*total*/
select image_count from OLAPcube where patient_name is NULL and test_type is NULL and year is NULL and month is NULL and week is NULL;

/*for each patient*/
select patient_name, image_count from OLAPcube where patient_name is not NULL and test_type is NULL and year is NULL and month is NULL and week is NULL order by patient_name;

/*for each patient for each year*/
select year, patient_name, image_count from OLAPcube where patient_name is not NULL and test_type is NULL and year is not NULL and month is NULL and week is NULL order by year, patient_name;

/*for each patient for each year for each month*/
select year, month, patient_name, image_count from OLAPcube where patient_name is not NULL and test_type is NULL and year is not NULL and month is not NULL and week is NULL order by year, month, patient_name;

/*for each patient for each year for each month for each week*/
select year, month, week, patient_name, image_count from OLAPcube where patient_name is not NULL and test_type is NULL and year is not NULL and month is not NULL and week is not NULL order by year, month, week, patient_name;

/*for each test type*/
select test_type, image_count from OLAPcube where patient_name is NULL and test_type is not NULL and year is NULL and month is NULL and week is NULL order by test_type;

/*for each test type for each year*/
select year, test_type, image_count from OLAPcube where patient_name is NULL and test_type is not NULL and year is not NULL and month is NULL and week is NULL order by year, test_type;

/*for each test type for each year for each month*/
select year, month, test_type, image_count from OLAPcube where patient_name is NULL and test_type is not NULL and year is not NULL and month is not NULL and week is NULL order by year, month, test_type;

/*for each test type for each year for each month for each week*/
select year, month, week, test_type, image_count from OLAPcube where patient_name is NULL and test_type is not NULL and year is not NULL and month is not NULL and week is not NULL order by year, month, week, test_type;

/*for each patient for each test type*/
select patient_name, test_type, image_count from OLAPcube where year is NULL and month is NULL and week is NULL and patient_name is not NULL and test_type is not NULL order by patient_name, test_type;

/*for each patient for each test type for each year*/
select year, patient_name, test_type, image_count from OLAPcube where year is not NULL and month is NULL and week is NULL and patient_name is not NULL and test_type is not NULL order by year, patient_name, test_type;

/*for each patient for each test type for each year for each month*/
select year, month, patient_name, test_type, image_count from OLAPcube where year is not NULL and month is not NULL and week is NULL and patient_name is not NULL and test_type is not NULL order by year, month, patient_name, test_type;

/*for each patient for each test type for each year for each month for each week*/
select year, month, week, patient_name, test_type, image_count from OLAPcube where year is not NULL and month is not NULL and week is not NULL and patient_name is not NULL and test_type is not NULL order by year, month, week, patient_name, test_type;

/*for each year*/
select year, image_count from OLAPcube where year is not NULL and month is NULL and week is NULL and patient_name is NULL and test_type is NULL order by year;

/*for each year for each month*/
select year, month, image_count from OLAPcube where year is not NULL and month is not NULL and week is NULL and patient_name is NULL and test_type is NULL order by year, month;

/*for each year for each month for each week*/
select year, month, week, image_count from OLAPcube where year is not NULL and month is not NULL and week is not NULL and patient_name is NULL and test_type is NULL order by year, month, week;










