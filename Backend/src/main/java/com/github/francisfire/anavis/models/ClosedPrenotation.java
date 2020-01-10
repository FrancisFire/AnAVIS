package com.github.francisfire.anavis.models;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Document(collection = "closedprenotation")
public class ClosedPrenotation extends Prenotation {

	private String reportId;

	public ClosedPrenotation(String id, String officeMail, String donorMail, Date hour, String reportId) {
		super(id, officeMail, donorMail, hour);
		this.reportId = reportId;
	}
}
