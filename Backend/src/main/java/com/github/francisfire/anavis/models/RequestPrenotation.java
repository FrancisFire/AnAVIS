package com.github.francisfire.anavis.models;

import java.util.Date;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class RequestPrenotation extends Prenotation {
	public RequestPrenotation(String id, String officeId, String donorId, Date hour) {
		super(id, officeId, donorId, hour);
	}
}
