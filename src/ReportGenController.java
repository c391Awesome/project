package ca.awesome;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Calendar;
import java.util.Collection;
import java.util.Iterator;

import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

//import oracle.sql.*;
//import oracle.jdbc.*;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

public class ReportGenController extends Controller {

	public static final String DIAGNOSIS_FIELD = "DIAGNOSIS";
	public static final String FROM_FIELD = "TIME_FROM";
	public static final String TO_FIELD = "TIME_UNTIL";

	public String diagnosis = "";
	public Date fromDate = null;
	public Date toDate = null;

	public ReportGenController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
	}

	// GET reportGen.jsp
	public void getParameters() {
		diagnosis = request.getParameter(DIAGNOSIS_FIELD);
		fromDate = parseDateOrGetNull(request.getParameter(FROM_FIELD));
		toDate = parseDateOrGetNull(request.getParameter(TO_FIELD));
	}

	// POST reportGen.jsp
	public ArrayList<String> attemptGenerateReport() {
		DatabaseConnection connection = getDatabaseConnection();
	
		ReportGen report = new ReportGen(diagnosis, fromDate, toDate);
		report.getQueryResult(connection);

		return report.getArrayList();
	}	

	public Date parseDateOrGetNull(String date) {
		try {
			return parseDate(date);
		} catch (Exception e) {
			return null;
		}
	}
	
}
