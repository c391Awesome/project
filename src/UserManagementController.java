package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Collection;


public class UserManagementController extends Controller {
	public static final String PATIENT_FIELD = "PATIENT";
	public static final String DOCTOR_FIELD = "DOCTOR";

	// view data
	public Collection<User> patients = new ArrayList<User>();
	public Collection<User> doctors = new ArrayList<User>();

	public String doctorName = "";
	public String patientName = "";

	public UserManagementController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// GET assignDoctor.jsp
	public void getAssignDoctor() {
		patients = User.findUsersByType(User.PATIENT_T,
					getDatabaseConnection(context));
		doctors = User.findUsersByType(User.DOCTOR_T,
					getDatabaseConnection(context));
	}

	// POST assignDoctor.jsp
	public boolean attemptAssignDoctor() {
		// TODO: add triggers to make sure that we don't assign
		// multiple doctors per patient
		doctorName = request.getParameter(DOCTOR_FIELD);
		patientName = request.getParameter(PATIENT_FIELD);

		if (doctorName == null || doctorName.isEmpty()
			|| patientName == null || patientName.isEmpty()) {
			return false;
		}

		FamilyDoctor familyDoctor = new FamilyDoctor();
		familyDoctor.setDoctor(doctorName);
		familyDoctor.setPatient(patientName);

		return familyDoctor.insert(getDatabaseConnection());
	}
};
