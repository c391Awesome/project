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
 *    GetOnePic?12:        sends the picture in thumbnail with photo_id = 12
 *    GetOnePic?regular12: sends the picture in regular with photo_id = 12
 *    GetOnePic?full12: sends the picture in full with photo_id = 12
 *
 *  @author  Li-Yan Yuan
 *  modified.
 *
 */
public class GetOnePic extends HttpServlet implements SingleThreadModel {

	private String imageID;
	private String size;

    /**
     *    This method first gets the query string indicating image_id,
     *    and then executes the query 
     *          select image from pacs_images where image_id = id_string   
     *    Finally, it sends the picture to the client
     */

    public void doGet(HttpServletRequest request,
		      HttpServletResponse response)
	throws ServletException, IOException {
		parseQueryString(request.getQueryString());
		
	
		ServletOutputStream out = response.getOutputStream();
	
		/*
		 *   to execute the given query
		 */
		DatabaseConnection conn = new DatabaseConnection();
		conn.initialize(getServletContext());
		conn.connect();

		try {
		    PreparedStatement statement = conn.prepareStatement(
				"select " + size + " from pacs_images where image_id=?"
			);
			statement.setString(1, imageID);

		    ResultSet results = statement.executeQuery();
	
		    if (results.next()) {
				response.setContentType("image/gif");
				streamBytes(results.getBinaryStream(1), out);
		   	} else {
				out.println("no picture available");
			}
		} catch(Exception ex) {
			throw new RuntimeException("failed to display image", ex);
		} finally {
			conn.close();
			out.close();
	    }
	}

	private void streamBytes(InputStream input, OutputStream out) {
		// stream blob byte by byte to output
		try {
			for (int b = input.read(); b != -1; b = input.read()) {
				out.write(b);
			}
			input.close();
		} catch (IOException e) {
			// what is there to do here?
		}
	}

	private void parseQueryString(String queryString) {
		if (queryString.startsWith("regular")) {
			size = "regular_size";
			imageID = queryString.substring("regular".length());
		} else if (queryString.startsWith("full")) {
			size = "full_size";
			imageID = queryString.substring("full".length());
		} else {
			size = "thumbnail";
			imageID = queryString;
		}
	}
}
