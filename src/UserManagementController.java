package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Collection;


public class UserManagementController extends Controller {
	public static final String PATIENT_FIELD = "PATIENT";
	public static final String DOCTOR_FIELD = "DOCTOR";

	public Collection<User> users = new ArrayList<User>();
	public Collection<User> doctors = new ArrayList<User>();

	public UserManagementController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}
};
