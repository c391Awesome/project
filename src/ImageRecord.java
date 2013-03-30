package ca.awesome;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Calendar;
//import java.util.Date;

import oracle.sql.*;
import oracle.jdbc.*;

import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.*;
import org.apache.commons.fileupload.*;

public class ImageRecord {

	private int record_id;
	private int image_id;
	private BufferedImage full;
	private BufferedImage regular;
	private BufferedImage thumbnail;

	public ImageRecord (int record_id, int image_id, BufferedImage full,
			BufferedImage regular, BufferedImage thumbnail) {
		this.record_id = record_id;
		this.image_id = image_id;
		this.full = full;
		this.regular = regular;
		this.thumbnail = thumbnail;
	}

	public int getRecordId() {
		if (record_id == 0) {
			throw new MissingFieldException("record_id", this);
		}
		return record_id;
	}

	public int getImageId() {
		if (image_id == 0) {
			throw new MissingFieldException("image_id", this);
		}
		return image_id;
	}

	public BufferedImage getFull() {
		if (full == null) {
			throw new MissingFieldException("full", this);
		}
		return full;
	}

	public BufferedImage getRegular() {
		if (regular == null) {
			throw new MissingFieldException("regular", this);
		}
		return regular;
	}
	
	public BufferedImage getThumbnail() {
		if (thumbnail == null) {
			throw new MissingFieldException("thumbnail", this);
		}
		return thumbnail;
	}

	public boolean insertImage(DatabaseConnection connection) {

	    	try {	
			ResultSet results = null;

			//Insert an empty blob into the table first. Note that you have to 
	    		//use the Oracle specific function empty_blob() to create an empty blob
			PreparedStatement statement1 = null;
			statement1 = connection.prepareStatement(
				"INSERT INTO pacs_images VALUES( ?, ?, "
				+"empty_blob(), empty_blob() ,empty_blob())"
			);
			statement1.setInt(1, getRecordId());
			statement1.setInt(2, getImageId());
			statement1.executeUpdate();
			/*	
			Statement statement = null;    		
			statement.execute(
				"INSERT INTO pacs_images VALUES( "+record_id+", "
				+image_id+", empty_blob(), empty_blob() ,empty_blob())"
			);
			*/

			// to retrieve the lob_locator 
	    		// use "FOR UPDATE" in the select statement
			PreparedStatement statement2 = null;
			statement2 = connection.prepareStatement(
				"SELECT full_size, regular_size, thumbnail"
				+ " FROM pacs_images WHERE image_id =? FOR UPDATE"
			);
			statement2.setInt(1, getImageId());
			results = statement2.executeQuery();
			/*
	    		String cmd = "SELECT full_size, regular_size, thumbnail"
				+ "FROM pacs_images WHERE image_id = "+image_id+" FOR UPDATE";
	    		results = statement.executeQuery(cmd);
			*/
	
	    		results.next();
	    		BLOB fullBlob = ((OracleResultSet)results).getBLOB(1);
			BLOB regularBlob = ((OracleResultSet)results).getBLOB(2);
			BLOB thumbnailBlob = ((OracleResultSet)results).getBLOB(3);
			
			//Write the image to the blob object
	    		OutputStream outstream1 = fullBlob.getBinaryOutputStream();
	    		ImageIO.write(full, "jpg", outstream1);
			OutputStream outstream2 = regularBlob.getBinaryOutputStream();
	    		ImageIO.write(regular, "jpg", outstream2);
			OutputStream outstream3 = thumbnailBlob.getBinaryOutputStream();
	    		ImageIO.write(thumbnail, "jpg", outstream3);	

	    		outstream1.close();
			outstream2.close();
			outstream3.close();
			return true;
		} catch (SQLException e) {
			throw new RuntimeException("failed to insertImage()", e);
		} catch (IOException e) {
			throw new RuntimeException("failed to insertImage()", e);
		} finally {
			connection.close();
		}
	}

	/*
	 * Find the list of image ids from the database with the record_id provided.
	 */
	public static ArrayList<Integer> findImageIdByRecordId (int record_id,
		DatabaseConnection connection) {
		
		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select image_id from pacs_images where"
				+ " record_id = " + record_id
			);
			ArrayList<Integer> image_id = new ArrayList<Integer>();
			while (results != null && results.next()) {
				image_id.add(results.getInt(1));
			}
			return image_id;
		} catch (SQLException e) {
			throw new RuntimeException("failed to findImageIdByRecordId()", e);
		} finally {
			connection.close();
		}
	}

}
	
	
		
