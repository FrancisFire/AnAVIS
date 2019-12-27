package com.github.francisfire.anavis.models;

import java.util.Date;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Document(collection = "donationreport")
public class DonationReport {

	@Id
	private String reportId;
	private Binary reportFile;
	private String donorId;
	private String officeId;
	private Date date;

	public DonationReport(String donorId, String officeId, Date date) {
		this.donorId = donorId;
		this.officeId = officeId;
		this.date = date;
	}

}
