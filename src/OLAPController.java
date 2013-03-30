package ca.awesome;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Calendar;
import java.util.Collection;
import java.util.Iterator;

public class OLAPController extends Controller {

	public static final String PATIENT_FIELD = "PATIENT_BOX";
	public static final String TESTTYPE_FIELD = "TYPE_BOX";
	public static final String TIMEPERIOD_FIELD = "PERIOD";
	

	public String patientBox = "";
	public String testTypeBox = "";
	public String timeBox = "";
	
	public OLAPController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// POST analysisInput.jsp
	public boolean attemptGetOLAP() {
		DatabaseConnection connection = getDatabaseConnection();
		try {
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			patientBox = request.getParameter(PATIENT_FIELD);
			testTypeBox = request.getParameter(TESTTYPE_FIELD);
			timeBox = request.getParameter(TIMEPERIOD_FIELD);

			if (patientBox != "" && testTypeBox != "") {
			// for each patient and test type
				OLAPbyPatientAndTestType(connection);
			} else if (patientBox != "" && testTypeBox == "") {
			// for each patient, all type
				OLAPbyPatient(connection);
			} else if (patientBox == "" && testTypeBox != "") {
			// for each test type, all patient
				OLAPbyTestType(connection);
			}

			connection.commit();
			return true;
		} catch (Exception e) {
			connection.rollback();
			return false;
		} finally {
			connection.setAllowClose(true);
			connection.close();
		}
		
	}

	public boolean OLAPbyPatientAndTestType(DatabaseConnection connection) {
		try {
		

			return true;
		} catch (Exception e) {
			throw new RuntimeException("failed to OLAPbyPatientAndTestType()", e);
		} finally {
			connection.close();
		}
	}

	public boolean OLAPbyPatient(DatabaseConnection connection) {
		try {

			return true;
		} catch (Exception e) {
			throw new RuntimeException("failed to OLAPbyPatient()", e);
		} finally {
			connection.close();
		}
	}
	
	public boolean OLAPbyTestType(DatabaseConnection connection) {
		try {

			return true;
		} catch (Exception e) {
			throw new RuntimeException("failed to OLAPbyTestType()", e);
		} finally {
			connection.close();
		}
	}
}
