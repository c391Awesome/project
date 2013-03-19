package ca.awesome;

public class MissingFieldException extends RuntimeException {
	public MissingFieldException(String field, Object model) {
		super(field + " not loaded on model of type \""
				+ model.getClass().getCanonicalName() + "\"");
	}
};
	
