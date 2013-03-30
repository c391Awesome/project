package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Collection;
import java.util.ArrayList;


public class SearchController extends Controller {
	public static String QUERY_FIELD = "QUERY";
	public static String START_FIELD = "TIME_FROM";
	public static String END_FIELD = "TIME_UNTIL";

	public Collection<Record> results;
	public SearchQuery query;

	public SearchController(ServletContext context,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		super(context, request, response, session);
		results = new ArrayList<Record>();
	}

	public boolean doSearch() {
		query = new SearchQuery(request.getParameter(QUERY_FIELD));
		query.setStart(parseDateOrGetNull(request.getParameter(START_FIELD)));
		query.setEnd(parseDateOrGetNull(request.getParameter(END_FIELD)));

		results = query.executeSearch(getDatabaseConnection());

		return true;
	}

	public Date parseDateOrGetNull(String date) {
		try {
			return parseDate(date);
		} catch (Exception e) {
			return null;
		}
	}
}
