package ca.awesome;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 *  This servlet sends the full size specified image in a separate browser
 *  stored in the table below to the client who requested the servlet.
 *
 *   CREATE TABLE pacs_images (
 *  	record_id   int,
 *  	image_id    int,
 *  	thumbnail   blob,
 *  	regular_size blob,
 *  	full_size    blob,
 *   	PRIMARY KEY(record_id,image_id),
 *   	FOREIGN KEY(record_id) REFERENCES radiology_record
 *    );
 *
 *  The request must come with a query string as follows:
 *    GetBigPic?12:        sends the image in full_size with image_id = 12
 *
 */
public class GetBigPic extends HttpServlet 
    implements SingleThreadModel {

    /**
     *    This method first gets the query string indicating image_id,
     *    and then executes the query 
     *          select full_size from pacs_images where image_id = id_string   
     *    Finally, it sends the picture to the client
     */

    public void doGet(HttpServletRequest request,
		      HttpServletResponse response)
	throws ServletException, IOException {
	
	//  construct the query  from the client's QueryString
	String id_string  = request.getQueryString();
	String query;

	query = "select full_size from pacs_images where image_id="
	        + id_string;

	//ServletOutputStream out = response.getOutputStream();
	PrintWriter out = response.getWriter();

	/*
	 *   to execute the given query
	 */
	DatabaseConnection conn = new DatabaseConnection(); 
	try {
	    Statement stmt = conn.createStatement();
	    ResultSet rset = stmt.executeQuery(query);
	    response.setContentType("text/html");

	    if ( rset.next() ) {
                out.println(
			"<html><head><title>"
			+id_string+ "</title>+</head>" 
			+"<body bgcolor=\"#000000\" text=\"#cccccc\">"
			+"<center><img src = \"GetOnePic?"+id_string
			+"\">" +"<h3>" + id_string + " </h3>" 
			+"</body></html>"
		);
            }
	    else
	      out.println("<html> Pictures are not avialable</html>");
	} catch( Exception ex ) {
	    out.println(ex.getMessage() );
	}
	// to close the connection
	finally {
		conn.close();
		/*
	    try {
		conn.close();
	    } catch ( SQLException ex) {
		out.println( ex.getMessage() );
	    }
		*/
	}
    }
}
