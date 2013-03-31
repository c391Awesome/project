package ca.awesome;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Calendar;
//import java.util.Date;

import oracle.sql.*;
import oracle.jdbc.*;

import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import org.apache.commons.fileupload.*;
import java.io.*;

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

	private ArrayList<Integer> image_id;

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
		//this.image_id = image_id;
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

	public ArrayList<Integer> getImage_id() {

		if (image_id == null) {
			throw new MissingFieldException("image_id", this);
		}
		return image_id;	
	}

	public boolean insert(DatabaseConnection connection) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"insert into radiology_record"
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

	/*
	 * Find a record from the database with the record_id provided.
	 */
	public static Record findRecordById(int record_id,
		DatabaseConnection connection) {

		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select patient_name, doctor_name, radiologist_name,"
				+ " test_type, prescribing_date, test_date, diagnosis, description"
				+ " from radiology_record where record_id = " + record_id
			);
			
			if (results == null || !results.next()) {
				return null;
			}
			String patient = results.getString(1);
			String doctor = results.getString(2);
			String radiologist = results.getString(3);
			String test_type = results.getString(4);
			Date prescribing = results.getDate(5);
			Date test_date = results.getDate(6);
			String diagnosis = results.getString(7);
			String description = results.getString(8);

			//ArrayList<Integer> image_id = new ArrayList<Integer>();
			//image_id = findImageIdByRecordId(record_id, connection);

			return new Record(record_id, patient, doctor, radiologist,
					test_type, prescribing, test_date,
					diagnosis, description);
		} catch (SQLException e) {
			throw new RuntimeException("failed to findRecordById()", e);
		} finally {
			connection.close();
		}
	}

	/*
	 * Find a list of record from the database with diagnosis
	 * and time period provided.
	 */
	public static Collection<Record> findRecordByDiagnosisAndTime(String diagnosis,
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

				//ArrayList<Integer> image_id = new ArrayList<Integer>();
				//image_id = findImageIdByRecordId(id, connection);

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

	/*
	 * Find a list of record from the database with patient name provided.
	 */
	public static Collection<Record> findRecordByPatient(String patient,
			DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, diagnosis, description"
				+ " from radiology_record where patient_name=?"
			);
			statement.setString(1, patient);
			results = statement.executeQuery();
			
			ArrayList<Record> record = new ArrayList<Record>();

			while (results != null && results.next()) {
				int id = results.getInt(1);
				String doctor = results.getString(3);
				String radiologist = results.getString(4);
				String test_type = results.getString(5);
				Date prescribing = results.getDate(6);
				Date test_date = results.getDate(7);
				String diagnosis = results.getString(8);
				String description = results.getString(9);

				//ArrayList<Integer> image_id = new ArrayList<Integer>();
				//image_id = findImageIdByRecordId(id, connection);

				record.add(new Record(id, patient, doctor, radiologist,
						test_type, prescribing, test_date,
						diagnosis, description));
			}

			return record;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findRecordByPatient()", e);
		} finally {
			connection.close();
		}
	}

	/*
	 * Find a list of record from the database with doctor name provided.
	 */
	public static Collection<Record> findRecordByDoctor(String doctor,
			DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, diagnosis, description"
				+ " from radiology_record where doctor_name=?"
			);
			statement.setString(1, doctor);
			results = statement.executeQuery();
			
			ArrayList<Record> record = new ArrayList<Record>();

			while (results != null && results.next()) {
				int id = results.getInt(1);
				String patient = results.getString(2);
				String radiologist = results.getString(4);
				String test_type = results.getString(5);
				Date prescribing = results.getDate(6);
				Date test_date = results.getDate(7);
				String diagnosis = results.getString(8);
				String description = results.getString(9);

				//ArrayList<Integer> image_id = new ArrayList<Integer>();
				//image_id = findImageIdByRecordId(id, connection);

				record.add(new Record(id, patient, doctor, radiologist,
						test_type, prescribing, test_date,
						diagnosis, description));
			}

			return record;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findRecordByDoctor()", e);
		} finally {
			connection.close();
		}
	}


	/*
	 * Find a list of record from the database with radiologist name provided.
	 */
	public static Collection<Record> findRecordByRadiologist(String radiologist,
			DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, diagnosis, description"
				+ " from radiology_record where radiologist_name=?"
			);
			statement.setString(1, radiologist);
			results = statement.executeQuery();
			
			ArrayList<Record> record = new ArrayList<Record>();

			while (results != null && results.next()) {
				int id = results.getInt(1);
				String patient = results.getString(2);
				String doctor = results.getString(3);
				String test_type = results.getString(5);
				Date prescribing = results.getDate(6);
				Date test_date = results.getDate(7);
				String diagnosis = results.getString(8);
				String description = results.getString(9);

				//ArrayList<Integer> image_id = new ArrayList<Integer>();
				//image_id = findImageIdByRecordId(id, connection);

				record.add(new Record(id, patient, doctor, radiologist,
						test_type, prescribing, test_date,
						diagnosis, description));
			}

			return record;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findRecordByRadiologist()", e);
		} finally {
			connection.close();
		}
	}

	/*
	 * Get a list of all records from the database.
	 */
	public static Collection<Record> getAllRecord(DatabaseConnection connection) {
		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, diagnosis, description"
				+ " from radiology_record"
			);
			
			ArrayList<Record> record = new ArrayList<Record>();

			while (results != null && results.next()) {
				int id = results.getInt(1);
				String patient = results.getString(2);
				String doctor = results.getString(3);
				String radiologist = results.getString(4);
				String test_type = results.getString(5);
				Date prescribing = results.getDate(6);
				Date test_date = results.getDate(7);
				String diagnosis = results.getString(8);
				String description = results.getString(9);

				//ArrayList<Integer> image_id = new ArrayList<Integer>();
				//image_id = findImageIdByRecordId(id, connection);

				record.add(new Record(id, patient, doctor, radiologist,
						test_type, prescribing, test_date,
						diagnosis, description));
			}

			return record;
		} catch (SQLException e) {
			throw new RuntimeException("failed to getAllRecord()", e);
		} finally {
			connection.close();
		}
	}


	/*
	 * Create a record where all fields are at default values.
	 */
	public static Record getEmptyRecord() {
		Date prescribing = new Date(Calendar.getInstance().getTimeInMillis());
		Date test = new Date(Calendar.getInstance().getTimeInMillis());
		//ArrayList<Integer> image = new ArrayList<Integer>();
		Record record = new Record(0, "", "", "", ""
			, prescribing, test, "", "");
		return record;
	}

	/*
	 * Find the list of image ids from the database with the record_id provided.
	 */
	public boolean loadImageIds (DatabaseConnection connection) {
		
		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select image_id from pacs_images where"
				+ " record_id = " + record_id
			);
			image_id = new ArrayList<Integer>();
			while (results != null && results.next()) {
				image_id.add(results.getInt(1));
			}
			return true;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findImageIdByRecordId()", e);
		} finally {
			connection.close();
		}
	}

}
