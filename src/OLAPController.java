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
	public static final String ALL_PERIOD = "NONE";
	public static final String YEARLY_PERIOD = "YEARLY";
	public static final String MONTHLY_PERIOD = "MONTHLY";
	public static final String WEEKLY_PERIOD = "WEEKLY";
	

	public String patientBox = "";
	public String testTypeBox = "";
	public String timeBox = "";
	public int totalImageCount = 0;
	
	public OLAPController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// GET analysisInput.jsp
	public void getInput() {
		patientBox = request.getParameter(PATIENT_FIELD);
		testTypeBox = request.getParameter(TESTTYPE_FIELD);
		timeBox = request.getParameter(TIMEPERIOD_FIELD);
	}

	// POST analysisInput.jsp
	public ArrayList<String> attemptGetOLAP() {
		DatabaseConnection connection = getDatabaseConnection();
		try {
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			OLAPOperation OLAP = new OLAPOperation();

			OLAP.setCubeTable(connection);
			totalImageCount = OLAP.getTotal(connection);
			
			if (patientBox != "" && testTypeBox == "" && timeBox == ALL_PERIOD) {
			// for each patient, all type, all time
				OLAP.setQueryResult(OLAP.byPatient(connection));

			} else if (patientBox != "" && testTypeBox == "" && timeBox == YEARLY_PERIOD) {
			// for each patient, all type, drill down to year
				OLAP.setQueryResult(OLAP.byPatientYear(connection));

			} else if (patientBox != "" && testTypeBox == "" && timeBox == MONTHLY_PERIOD) {
			// for each patient, all type, drill down to month
				OLAP.setQueryResult(OLAP.byPatientMonth(connection));

			} else if (patientBox != "" && testTypeBox == "" && timeBox == WEEKLY_PERIOD) {
			// for each patient, all type, drill down to week
				OLAP.setQueryResult(OLAP.byPatientWeek(connection));

			} else if (patientBox == "" && testTypeBox != "" && timeBox == ALL_PERIOD) {
			// for each test type, all patient, all time
				OLAP.setQueryResult(OLAP.byTestType(connection));

			} else if (patientBox == "" && testTypeBox != "" && timeBox == YEARLY_PERIOD) {
			// for each test type, all patient, drill down to year
				OLAP.setQueryResult(OLAP.byTestTypeYear(connection));

			} else if (patientBox == "" && testTypeBox != "" && timeBox == MONTHLY_PERIOD) {
			// for each test type, all patient, drill down to month
				OLAP.setQueryResult(OLAP.byTestTypeMonth(connection));

			} else if (patientBox == "" && testTypeBox != "" && timeBox == WEEKLY_PERIOD) {
			// for each test type, all patient, drill down to week
				OLAP.setQueryResult(OLAP.byTestTypeWeek(connection));

			} if (patientBox != "" && testTypeBox != "" && timeBox == ALL_PERIOD) {
			// for each patient and test type, all time
				OLAP.setQueryResult(OLAP.byBoth(connection));

			} else if (patientBox != "" && testTypeBox != "" && timeBox == YEARLY_PERIOD) {
			// for each patient and test type, drill down to year
				OLAP.setQueryResult(OLAP.byBothYear(connection));

			} else if (patientBox != "" && testTypeBox != "" && timeBox == MONTHLY_PERIOD) {
			// for each patient and test type, drill down to month
				OLAP.setQueryResult(OLAP.byBothMonth(connection));

			} else if (patientBox != "" && testTypeBox != "" && timeBox == WEEKLY_PERIOD) {
			// for each patient and test type, drill down to week
				OLAP.setQueryResult(OLAP.byBothWeek(connection));
			}
			return OLAP.getQueryResult();
		} catch (Exception e) {
			connection.rollback();
			throw new RuntimeException("failed to attemptGetOLAP()", e);
		} finally {
			connection.setAllowClose(true);
			connection.close();
		}
		
	}
}
