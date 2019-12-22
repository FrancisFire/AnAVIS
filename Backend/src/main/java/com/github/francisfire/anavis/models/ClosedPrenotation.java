package com.github.francisfire.anavis.models;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ClosedPrenotation extends Prenotation {

	private String reportId;

	public ClosedPrenotation(String id, String officeId, String donorId, Date hour, String reportId) {
		super(id, officeId, donorId, hour);
		this.reportId = reportId;
	}
}
