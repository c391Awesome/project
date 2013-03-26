package ca.awesome;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Calendar;
//import java.util.Date;

public class Record {
	
	private int record_id;
	private String patient_name;
	private String doctor_name;
	private String radiologist_name;
	private String test_type;
	private Date prescribing_date;
	private Date test_date;
	private String diagnosis;
	private String description;

	public Record (int id, String patient, String doctor, String radiologist,
			String test_type, Date prescribing, Date test_date,
			String diagnosis, String description) {
		this.record_id = id;
		this.patient_name = patient;
		this.doctor_name = doctor;
		this.radiologist_name = radiologist;
		this.test_type = test_type;
		this.prescribing_date = prescribing;
		this.test_date = test_date;
		this.diagnosis = diagnosis;
		this.description = description;
	}

	public int getRecordId() {
		if (record_id == 0) {
			throw new MissingFieldException("record_id", this);
		}
		return record_id;
	}

	public String getPatient() {
		if (patient_name == null) {
			throw new MissingFieldException("patient_name", this);
		}
		return patient_name;
	}
	
	public String getDoctor() {
		if (doctor_name == null) {
			throw new MissingFieldException("doctor_name", this);
		}
		return doctor_name;
	}

	public String getRadiologist() {
		if (radiologist_name == null) {
			throw new MissingFieldException("radiologist_name", this);
		}
		return radiologist_name;
	}

	public String getTestType() {
		if (test_type == null) {
			throw new MissingFieldException("test_type", this);
		}
		return test_type;
	}

	public Date getPrescribingDate() {
		if (prescribing_date == null) {
			throw new MissingFieldException("prescribing_date", this);
		}
		return prescribing_date;
	}

	public Date getTestDate() {
		if (test_date == null) {
			throw new MissingFieldException("test_date", this);
		}
		return test_date;
	}

	public String getDiagnosis() {
		if (diagnosis == null) {
			throw new MissingFieldException("diagnosis", this);
		}
		return diagnosis;
	}

	public String getDescription() {
		if (description == null) {
			throw new MissingFieldException("description", this);
		}
		return description;
	}

	public boolean insert(DatabaseConnection connection) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"insert into record"
				+ " (record_id, patient_name, doctor_name, radiologist_name,"
				+ " test_type, prescribing_date, test_date, diagnosis, description)"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)"
			);
			statement.setInt(1, getRecordId());
			statement.setString(2, getPatient());
			statement.setString(3, getDoctor());
			statement.setString(4, getRadiologist());
			statement.setString(5, getTestType());
			statement.setDate(6, getPrescribingDate());
			statement.setDate(7, getTestDate());
			statement.setString(8, getDiagnosis());
			statement.setString(9, getDescription());
		
			return (statement.executeUpdate() == 1);
		} catch (SQLException e) {
			throw new RuntimeException("failed to insert()", e);
		} finally {
			connection.close();
		}
	}

	static Collection<Record> findRecordByDiagnosisAndTime(String diagnosis,
			Date start, Date end, DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, description"
				+ " from radiology_record where diagnosis=?"
				+ " and test_date>=? and test_date<=?"
			);
			statement.setString(1, diagnosis);
			statement.setDate(2, start);
			statement.setDate(3, end);
			results = statement.executeQuery();
			
			ArrayList<Record> record = new ArrayList<Record>();

			while (results != null && results.next()) {
				int id = results.getInt(1);
				String patient = results.getString(2);
				String doctor = results.getString(3);
				String radiologist = results.getString(4);
				String test_type = results.getString(5);
				Date prescribing = results.getDate(6);
				Date test_date = results.getDate(7);
				String description = results.getString(8);

				record.add(new Record(id, patient, doctor, radiologist,
						test_type, prescribing, test_date,
						diagnosis, description));
			}

			return record;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findRecordByDiagnosisAndTime()", e);
		} finally {
			connection.close();
		}
	}


	public static Record getEmptyRecord() {
		Date prescribing = new Date(Calendar.getInstance().getTimeInMillis());
		Date test = new Date(Calendar.getInstance().getTimeInMillis());
		Record record = new Record(0, "", "", "", ""
			, prescribing, test, "", "");
		return record;
	}


}
