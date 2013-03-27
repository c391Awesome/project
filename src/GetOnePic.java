package ca.awesome;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


/**
 *  This servlet sends one picture stored in the table below to the client 
 *  who requested the servlet.
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
 *    GetOnePic?12:        sends the picture in thumnail with photo_id = 12
 *    GetOnePic?regular12: sends the picture in regular with photo_id = 12
 *
 *  @author  Li-Yan Yuan
 *  modified.
 *
 */
public class GetOnePic extends HttpServlet 
    implements SingleThreadModel {

    /**
     *    This method first gets the query string indicating image_id,
     *    and then executes the query 
     *          select image from pacs_images where image_id = id_string   
     *    Finally, it sends the picture to the client
     */

    public void doGet(HttpServletRequest request,
		      HttpServletResponse response)
	throws ServletException, IOException {
	
	//  construct the query  from the client's QueryString
	String id_string  = request.getQueryString();
	String query;

	if (id_string.startsWith("regular"))  
		query = "select regular_size from pacs_images where image_id=" 
			+ id_string.substring(7);
	else
	    query = "select thumbnail from pacs_images where image_id=" + id_string;

	ServletOutputStream out = response.getOutputStream();

	/*
	 *   to execute the given query
	 */
	DatabaseConnection conn = new DatabaseConnection();
	try {
	    Statement stmt = conn.createStatement();
	    ResultSet rset = stmt.executeQuery(query);

	    if ( rset.next() ) {
		response.setContentType("image/gif");
		InputStream input = rset.getBinaryStream(1);	    
		int imageByte;
		while((imageByte = input.read()) != -1) {
		    out.write(imageByte);
		}
		input.close();
	    } 
	    else 
		out.println("no picture available");
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
