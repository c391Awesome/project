package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

public class ReportGen {

	private String diagnosisName;
	private String fromDate;
	private String toDate;
	private ArrayList<String> queryResult;

	public ReportGen(String diagnosis, String fromDate, String toDate) {
		this.diagnosisName = diagnosis;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.queryResult = new ArrayList<String>();
	}

	public ArrayList<String> getArrayList() {
		return queryResult;
	}

	public boolean getQueryResult(DatabaseConnection connection) {
		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select first_name, last_name, address, phone, test_date"
				+ " from persons, radiology_record where persons.user_name = radiology_record.patient_name" 
				+ " and radiology_record.diagnosis = '" + diagnosisName + "'"
				//+ "' and radiology_record.test_date > '" + fromDate
				//+ "' and radiology_record.test_date < '" + toDate + "'"
			);
			
			if (results == null || !results.next()) {
				//throw new RuntimeException("failed to getQueryResult()");
				System.out.println("No result is found!");
				return false;
			}
			
			while(results.next()){

         		//Retrieve by column name
         		queryResult.add(results.getString("first_name"));
         		queryResult.add(results.getString("last_name"));
         		queryResult.add(results.getString("address"));
         		queryResult.add(results.getString("phone"));
				queryResult.add(results.getDate("test_date").toString());
      		}
			connection.close();
			return true;
		} catch (SQLException e) {
			connection.close();
			throw new RuntimeException("failed to getQueryResult()", e);
		}

	}
	
}


