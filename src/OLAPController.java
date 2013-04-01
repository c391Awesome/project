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
	public static final String NONE = "NONE";
	public static final String YEARLY_PERIOD = "YEARLY";
	public static final String MONTHLY_PERIOD = "MONTHLY";
	public static final String WEEKLY_PERIOD = "WEEKLY";
	public static final String ONE_PATIENT = "ONE_PATIENT";
	public static final String ONE_TESTTYPE = "ONE_TYPE";
	

	public String patientBox = "";
	public String testTypeBox = "";
	public String timeBox = "";
	public int totalImageCount = 0;

	public String onePatient = "";
	public String oneTestType = "";

	//public int resultSize = 0;

	public Collection<User> patients = new ArrayList<User>();
	public ArrayList<String> testTypes = new ArrayList<String>();
	
	public OLAPController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// GET analysisInput.jsp
	public void setDropBoxValue() {
		patients = User.findUsersByType(User.PATIENT_T,
					getDatabaseConnection(context));
		testTypes = Record.getAllTestType(getDatabaseConnection(context));
	}

	// POST analysisInput.jsp
	// can not choose all patient and one specific patient at the same time
	// and can not choose all test type and one specific test type at the same time
	public boolean getInput() {
		patientBox = request.getParameter(PATIENT_FIELD);
		testTypeBox = request.getParameter(TESTTYPE_FIELD);
		timeBox = request.getParameter(TIMEPERIOD_FIELD);
		onePatient = request.getParameter(ONE_PATIENT);
		oneTestType = request.getParameter(ONE_TESTTYPE);

		if (patientBox != null && !onePatient.equals(NONE)) {
			return false;
		}
		if (testTypeBox != null && !oneTestType.equals(NONE)) {
			return false;
		}
		if (!onePatient.equals(NONE)) {
			patientBox = PATIENT_FIELD;	
		}
		if (!oneTestType.equals(NONE)) {
			testTypeBox = TESTTYPE_FIELD;	
		}
		return true;
	}

	// POST analysisInput.jsp
	public ArrayList<String> attemptGetOLAP() {
		DatabaseConnection connection = getDatabaseConnection();
		try {
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			OLAPOperation OLAP = new OLAPOperation();

			OLAP.setCubeTable(connection);

			//totalImageCount = OLAP.getTotal(connection);
			
			if (patientBox != null && testTypeBox == null && timeBox.equals(NONE)) {
			// for each patient, all type, all time
				OLAP.setQueryResult(OLAP.byPatient(connection));

			} else if (patientBox != null && testTypeBox == null && timeBox.equals(YEARLY_PERIOD)) {
			// for each patient, all type, drill down to year
				OLAP.setQueryResult(OLAP.byPatientYear(connection));

			} else if (patientBox != null && testTypeBox == null && timeBox.equals(MONTHLY_PERIOD)) {
			// for each patient, all type, drill down to month
				OLAP.setQueryResult(OLAP.byPatientMonth(connection));

			} else if (patientBox != null && testTypeBox == null && timeBox.equals(WEEKLY_PERIOD)) {
			// for each patient, all type, drill down to week
				OLAP.setQueryResult(OLAP.byPatientWeek(connection));

			} else if (patientBox == null && testTypeBox != null && timeBox.equals(NONE)) {
			// for each test type, all patient, all time
				OLAP.setQueryResult(OLAP.byTestType(connection));

			} else if (patientBox == null && testTypeBox != null && timeBox.equals(YEARLY_PERIOD)) {
			// for each test type, all patient, drill down to year
				OLAP.setQueryResult(OLAP.byTestTypeYear(connection));

			} else if (patientBox == null && testTypeBox != null && timeBox.equals(MONTHLY_PERIOD)) {
			// for each test type, all patient, drill down to month
				OLAP.setQueryResult(OLAP.byTestTypeMonth(connection));

			} else if (patientBox == null && testTypeBox != null && timeBox.equals(WEEKLY_PERIOD)) {
			// for each test type, all patient, drill down to week
				OLAP.setQueryResult(OLAP.byTestTypeWeek(connection));

			} if (patientBox != null && testTypeBox != null && timeBox.equals(NONE)) {
			// for each patient and test type, all time
				OLAP.setQueryResult(OLAP.byBoth(connection));

			} else if (patientBox != null && testTypeBox != null && timeBox.equals(YEARLY_PERIOD)) {
			// for each patient and test type, drill down to year
				OLAP.setQueryResult(OLAP.byBothYear(connection));

			} else if (patientBox != null && testTypeBox != null && timeBox.equals(MONTHLY_PERIOD)) {
			// for each patient and test type, drill down to month
				OLAP.setQueryResult(OLAP.byBothMonth(connection));

			} else if (patientBox != null && testTypeBox != null && timeBox.equals(WEEKLY_PERIOD)) {
			// for each patient and test type, drill down to week
				OLAP.setQueryResult(OLAP.byBothWeek(connection));

			} else if (patientBox == null && testTypeBox == null && timeBox.equals(YEARLY_PERIOD)) {
			// all patient and test type, drill down to year
				OLAP.setQueryResult(OLAP.byYear(connection));

			} else if (patientBox == null && testTypeBox == null && timeBox.equals(MONTHLY_PERIOD)) {
			// all patient and test type, drill down to month
				OLAP.setQueryResult(OLAP.byMonth(connection));

			} else if (patientBox == null && testTypeBox == null && timeBox.equals(WEEKLY_PERIOD)) {
			// all patient and test type, drill down to week
				OLAP.setQueryResult(OLAP.byWeek(connection));
			}

//			resultSize = queryResultFilter(OLAP.getQueryResult()).size();

			return queryResultFilter(OLAP.getQueryResult());
			//return OLAP.getQueryResult();
		} catch (Exception e) {
			connection.rollback();
			throw new RuntimeException("failed to attemptGetOLAP()", e);
		} finally {
			connection.setAllowClose(true);
			connection.close();
		}
		
	}

	public ArrayList<String> queryResultFilter(ArrayList<String> result) {
		ArrayList<Integer> badRow = new ArrayList<Integer>();
		//specific patient
		if (!onePatient.equals(NONE) && !result.get(3).equals(" ") &&
				oneTestType.equals(NONE)) {
			for (int i=result.size()-6; i>=0; i=i-6) {
				if (!(result.get(i+3)).equals(onePatient))
					badRow.add(i);
			}
			for (Integer row : badRow) {
				result.subList(row.intValue(), row.intValue()+6).clear();
			}
		}
		//specific test type
		else if (!oneTestType.equals(NONE) && !result.get(4).equals(" ") &&
				onePatient.equals(NONE)) {
			for (int i=result.size()-6; i>=0; i=i-6) {
				if (!(result.get(i+4)).equals(oneTestType))
					badRow.add(i);
			}
			for (Integer row : badRow) {
				result.subList(row.intValue(), row.intValue()+6).clear();
			}
		}
		//specific patient and test type
		else if (!onePatient.equals(NONE) && !oneTestType.equals(NONE) &&
				!result.get(3).equals(" ") && !result.get(4).equals(" ")) {
			for (int i=result.size()-6; i>=0; i=i-6) {
				if (!(result.get(i+4)).equals(oneTestType) ||
					!(result.get(i+3)).equals(onePatient))
					badRow.add(i);
			}
			for (Integer row : badRow) {
				result.subList(row.intValue(), row.intValue()+6).clear();
			}
		}
		totalImageCount = getImageCount(result);
		return result;
	}

	public int getImageCount(ArrayList<String> result) {
		int count = 0;
		for (int i=5; i<=result.size()-1; i=i+6) {
			count = count + Integer.parseInt(result.get(i));
		}
		return count;
	}
}
