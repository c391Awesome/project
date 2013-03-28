package ca.awesome;

import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;


public class UserManagementController extends Controller {
	public static final String PATIENT_FIELD = "PATIENT";
	public static final String DOCTOR_FIELD = "DOCTOR";
	public static final String USERNAME_FIELD = "USERNAME";
	public static final String PASSWORD_FIELD = "PASSWORD";
	public static final String USER_TYPE_FIELD = "USER_TYPE";
	public static final String FIRSTNAME_FIELD = "FIRSTNAME";
	public static final String LASTNAME_FIELD = "LASTNAME";
	public static final String ADDRESS_FIELD = "ADDRESS";
	public static final String EMAIL_FIELD = "EMAIL";
	public static final String PHONE_FIELD = "PHONE";
	public static final String REGISTERED_FIELD = "REGISTERED";

	// view data
	public Collection<User> patients = new ArrayList<User>();
	public Collection<User> doctors = new ArrayList<User>();
	public Collection<User> users = new ArrayList<User>();

	public String doctorName = "";
	public String patientName = "";
	public String userName = "";
	public User selectedUser = User.getEmptyUser();

	public UserManagementController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// GET userManagementConsole.jsp
	public void getManagementConsole() {
		users = User.findAllUserNames(getDatabaseConnection());
	}

	// GET editUser.jsp
	public void getEditUser() {
		userName = request.getParameter(USERNAME_FIELD);
		selectedUser = User.findUserByName(userName, getDatabaseConnection());
		if (!selectedUser.loadPersonalInfo(getDatabaseConnection())) {
			selectedUser.addEmptyPersonalInfo();
		}
		doctors = FamilyDoctor.getDoctorNamesForPatient(userName,
			getDatabaseConnection());
	}

	// POST editUser.jsp
	public boolean attemptUpdateUser() {
		userName = request.getParameter(USERNAME_FIELD).trim();
		String password = request.getParameter(PASSWORD_FIELD).trim();
		Integer userClass = Integer.parseInt(request.getParameter(USER_TYPE_FIELD));
		Date registered = parseDate(request.getParameter(REGISTERED_FIELD));

		DatabaseConnection connection = getDatabaseConnection();
		try {
			// TODO: locking?
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			User newUser = new User(userName, password, userClass, registered);

			newUser.update(connection);
			newUser.updatePersonalInfo(
				request.getParameter(FIRSTNAME_FIELD),
				request.getParameter(LASTNAME_FIELD),
				request.getParameter(ADDRESS_FIELD),
				request.getParameter(EMAIL_FIELD),
				request.getParameter(PHONE_FIELD),
				connection
			);

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

	// GET createUser
	public void getCreateUser() {
	}

	// POST createUser.jsp
	public boolean attemptCreateUser() {
		userName = request.getParameter(USERNAME_FIELD).trim();
		String password = request.getParameter(PASSWORD_FIELD).trim();
		Integer userClass = Integer.parseInt(request.getParameter(USER_TYPE_FIELD));
		Date registered = new Date(Calendar.getInstance().getTimeInMillis());

		User newUser = new User(userName, password, userClass, registered);
		newUser.addPersonalInfo(
			request.getParameter(FIRSTNAME_FIELD),
			request.getParameter(LASTNAME_FIELD),
			request.getParameter(ADDRESS_FIELD),
			request.getParameter(EMAIL_FIELD),
			request.getParameter(PHONE_FIELD)
		);

		DatabaseConnection connection = getDatabaseConnection();
		try {
			connection.setAutoCommit(false);
			connection.setAllowClose(false);

			newUser.insert(connection);
			newUser.insertPersonalInfo(connection);

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

	// GET assignDoctor.jsp
	public void getAssignDoctor() {
		userName = request.getParameter(PATIENT_FIELD);
		patientName = userName;
		doctors = FamilyDoctor.getAssignableDoctorsForPatient(userName,
					getDatabaseConnection());
	}

	// POST assignDoctor.jsp
	public boolean attemptAssignDoctor() {
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

	// GET unassignDoctor.jsp
	public void getUnassignDoctor() {
		patientName = request.getParameter(PATIENT_FIELD);
		userName = patientName;
		doctors = FamilyDoctor.getDoctorNamesForPatient(patientName,
					getDatabaseConnection(context));
	}

	// POST unassignDoctor.jsp
	public boolean attemptUnassignDoctor() {
		patientName = request.getParameter(PATIENT_FIELD);
		userName = patientName;
		doctorName = request.getParameter(DOCTOR_FIELD);

		FamilyDoctor assignment = new FamilyDoctor();
		assignment.setDoctor(doctorName);
		assignment.setPatient(patientName);
		return assignment.delete(getDatabaseConnection());
	}
};
