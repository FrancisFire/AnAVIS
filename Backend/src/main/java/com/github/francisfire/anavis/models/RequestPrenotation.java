package com.github.francisfire.anavis.models;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.NoArgsConstructor;

@NoArgsConstructor
@Document(collection = "requestprenotation")
public class RequestPrenotation extends Prenotation {
	public RequestPrenotation(String id, String officeId, String donorId, Date hour) {
		super(id, officeId, donorId, hour);
	}
}
