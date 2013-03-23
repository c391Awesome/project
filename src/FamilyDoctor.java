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
			throw new RuntimeException("failed to findUsersByType()", e);
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
	
}
