package ca.awesome;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;


/*
 * 	attacks.
 */
public class FamilyDoctor {
	private String doctorUserName = null;
	private String patientUserName = null;

	FamilyDoctor() {
	}

	public void setDoctor(String doctor) {
		doctorUserName = doctor;
	}

	public void setPatient(String patient) {
		patientUserName = patient;
	}

	public boolean insert(DatabaseConnection connection) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"insert into family_doctor (doctor_name, patient_name) "
				+ "VALUES(?, ?)"
			);
			statement.setString(1, getDoctorUserName());
			statement.setString(2, getPatientUserName());
			return (statement.executeUpdate() == 1);
		} catch (SQLException e) {
			throw new RuntimeException("failed to insert family_doctor()", e);
		} finally {
			connection.close();
		}
	}

	public String getDoctorUserName() {
		if (doctorUserName == null) {
			throw new MissingFieldException("doctorUserName", this);
		}
		return doctorUserName;
	}

	public String getPatientUserName() {
		if (patientUserName == null) {
			throw new MissingFieldException("patientUserName", this);
		}
		return patientUserName;
	}

	public boolean delete(DatabaseConnection connection) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"DELETE FROM family_doctor WHERE " +
				"doctor_name=? AND patient_name=?"
			);
			statement.setString(1, doctorUserName);
			statement.setString(2, patientUserName);

			if (statement.executeUpdate() == 1) {
				return true;
			}
			return false;
		} catch (SQLException e) {
			throw new RuntimeException("failed to FamilyDoctor.delete()", e);
		} finally {
			connection.close();
		}
	}

	static public Collection<User> getAssignableDoctorsForPatient(
		String patientName, DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select user_name from users u " +
				"where u.class='d' AND NOT EXISTS( " +
				" select * from family_doctor d " +
				" where d.doctor_name=u.user_name " +
				" AND d.patient_name=?)"
			);
			statement.setString(1, patientName);
			results = statement.executeQuery();
			
			ArrayList<User> doctors  = new ArrayList<User>();

			while (results != null && results.next()) {
				String doctorName = results.getString(1);

				doctors.add(new User(doctorName, null, null, null));
			}

			return doctors;
		} catch (SQLException exception) {
			throw new RuntimeException("failed to getAssignableDoctorsForPatient()",
				exception);
		} finally {
			connection.close();
		}
	}

	static public Collection<User> getDoctorNamesForPatient(String patientName,
		DatabaseConnection connection) {
		ResultSet results = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
				"select doctor_name from family_doctor where patient_name=?"
			);
			statement.setString(1, patientName);
			results = statement.executeQuery();
			
			ArrayList<User> doctors  = new ArrayList<User>();

			while (results != null && results.next()) {
				String doctorName = results.getString(1);

				doctors.add(new User(doctorName, null, null, null));
			}

			return doctors;
		} catch (SQLException exception) {
			throw new RuntimeException("failed to getDoctorNamesForPatient()",
				exception);
		} finally {
			connection.close();
		}
	}
}
