package ca.awesome;

import java.util.Collection;
import java.util.ArrayList;
import java.sql.*;


public class SearchQuery {
	interface WhereClause {
		public String getClause();
		public int addData(PreparedStatement s, int position)
			throws SQLException;
	}

	private String searchTerms;
	private ArrayList<WhereClause> clauses;


	public SearchQuery(String terms, Date start, Date end) {
		searchTerms = terms;
		clauses = new ArrayList<WhereClause>();
		if (start != null)
			addClause(new PrescribedClause(start, ">="));
		if (end != null)
			addClause(new PrescribedClause(end, "<="));
	}

	public void addClause(WhereClause clause) {
		if (clause == null) {
			return;
		}
		this.clauses.add(clause);
	}

	public Collection<Record> executeSearch(DatabaseConnection connection) {
		PreparedStatement statement;
		ResultSet results;
		connection.setAllowClose(false);
		try {
			statement = buildStatement(connection);
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

				record.loadImageIds(connection);
				records.add(record);
			}

			return records;
		} catch (SQLException e) {
			// throw new RuntimeException("Error occurred in search", e);
			return new ArrayList<Record>();
		} finally {
			connection.setAllowClose(true);
			connection.close();
		}
	}

	private PreparedStatement buildStatement(DatabaseConnection connection)
			throws SQLException {

		StringBuilder builder = new StringBuilder();
		builder.append("SELECT record_id, patient_name, doctor_name,")
			.append(" radiologist_name, test_type, prescribing_date,")
			.append(" test_date, diagnosis, description FROM radiology_record ")
			.append(" WHERE (CONTAINS(patient_name, ?, 1) > 0")
			.append(" OR CONTAINS(diagnosis, ? , 2) > 0")
			.append(" OR CONTAINS(description, ? , 3) > 0)");

		for (WhereClause clause: clauses) {
			builder.append(clause.getClause());
		}

		builder.append(" ORDER BY 6*SCORE(1) + 3*SCORE(2) + SCORE(3)");

		PreparedStatement statement = connection.prepareStatement(
			builder.toString());

		int position = 1;
		statement.setString(position++, searchTerms);
		statement.setString(position++, searchTerms);
		statement.setString(position++, searchTerms);

		for (WhereClause clause: clauses) {
			position += clause.addData(statement, position);
		}

		return statement;
	}
	
	public static class PrescribedClause implements WhereClause {
		public Date date;
		public String comparator;

		public PrescribedClause(Date date, String comparator) {
			this.date = date;
			this.comparator = comparator;
		}

		@Override
		public String getClause() {
			return " AND prescribing_date " + comparator + " ? ";
		}

		@Override
		public int addData(PreparedStatement s, int position)
			throws SQLException {
			s.setDate(position, this.date);
			return 1;
		}
	}
};
