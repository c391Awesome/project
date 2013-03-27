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

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

public class Image {

	private int record_id;
	private int image_id;
	private BufferedImage full;
	private BufferedImage regular;
	private BufferedImage thumbnail;

	public Image (int record_id, int image_id, BufferedImage full,
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
	
	
		
