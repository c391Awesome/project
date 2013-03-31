package ca.awesome;

import java.util.Collection;
import java.util.ArrayList;
import java.sql.*;


public class SearchQuery {
	interface ResultFilter {
		boolean allow(Record record);
	}

	private String searchTerms;
	private Date start = null;
	private Date end = null;
	private ResultFilter filter;


	public SearchQuery(String terms) {
		this(terms, null, null);
	}

	public SearchQuery(String terms, Date start, Date end) {
		searchTerms = terms;
		filter = new AllowAllFilter();
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public void setFilter(ResultFilter filter) {
		this.filter = filter;
	}

	public void setSearchTerm(String term) {
		// split terms on whitespace using a regexp
		// String splitTerms[] = terms.split("\s+");
		// searchTerms.addAll(splitTerms);

		searchTerms = term;
	}

	public Collection<Record> executeSearch(DatabaseConnection connection) {
		PreparedStatement statement;
		ResultSet results;

		try {
			// TODO: don't use dates in query if dates are null
			statement = connection.prepareStatement(
				"SELECT record_id, patient_name, doctor_name,"
				+ " radiologist_name, test_type, prescribing_date,"
				+ " test_date, diagnosis, description FROM radiology_record "
				+ " WHERE ? <= prescribing_date AND prescribing_date <= ? "
				//+ " AND (CONTAINS(patient_name, ?, 1) > 0"
				//+ " OR CONTAINS(diagnosis, ? , 2) > 0"
				//+ " OR CONTAINS(description, ? , 3) > 0)"
				//+ " ORDER BY 6*SCORE(1) + 3*SCORE(2) + SCORE(3)"
			);

			statement.setDate(1, start);
			statement.setDate(2, end);
			//statement.setString(3, searchTerms);
			//statement.setString(4, searchTerms);
			//statement.setString(5, searchTerms);

			results = statement.executeQuery();

			ArrayList<Record> records = new ArrayList<Record>();
			while (results.next()) {
				Record record = new Record(
					results.getInt(1),
					results.getString(2),
					results.getString(3),
					results.getString(4),
					results.getString(5),
					results.getDate(6),
					results.getDate(7),
					results.getString(8),
					results.getString(9)
				);

				if (this.filter.allow(record)) {
					records.add(record);
				}
			}

			return records;
		} catch (SQLException e) {
			throw new RuntimeException("Error occurred in search", e);
		} finally {
			connection.close();
		}
	}

	private class AllowAllFilter implements ResultFilter {
		@Override
		public boolean allow(Record record) {
			return true;
		}
	}
};
