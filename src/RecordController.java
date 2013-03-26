package ca.awesome;

import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

public class RecordController extends Controller {
	public static final String ID_FIELD = "RECORD_ID";
	public static final String PATIENT_FIELD = "PATIENT";
	public static final String DOCTOR_FIELD = "DOCTOR";
	public static final String RADIOLOGIST_FIELD = "RADIOLOGIST";
	public static final String TESTTYPE_FIELD = "TESTTYPE";
	public static final String DIAGNOSIS_FIELD = "DIAGNOSIS";
	public static final String DESCRIPTION_FIELD = "DESCRIPTION";
	public static final String PRESCRIBINGDATE_FIELD = "PRESCRIBINGDATE";
	public static final String TESTDATE_FIELD = "TESTDATE";

	//public Collection<Record> records = new ArrayList<Record>();
	//public Record newRecord = Record.getEmptyRecord();

	public RecordController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// POST insertRecord.jsp
	public boolean attemptInsertRecord() {
		Record newRecord = new Record(
			Integer.parseInt(request.getParameter(ID_FIELD)),
			request.getParameter(PATIENT_FIELD),
			request.getParameter(DOCTOR_FIELD),
			request.getParameter(RADIOLOGIST_FIELD),
			request.getParameter(TESTTYPE_FIELD),
			request.getParameter(PRESCRIBINGDATE_FIELD),
			request.getParameter(TESTDATE_FIELD),
			request.getParameter(DIAGNOSIS_FIELD),
			request.getParameter(DESCRIPTION_FIELD)
		);	
		DatabaseConnection connection = getDatabaseConnection();
		try {
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			Record.insert(connection);

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

	
}
