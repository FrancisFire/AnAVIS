package com.github.francisfire.anavis.models;

import java.util.Date;

public class RequestPrenotation extends Prenotation {
	public RequestPrenotation(String id, String officeId, String donorId, Date hour) {
		super(id, officeId, donorId, hour);
	}
	
	public RequestPrenotation() {}
}
