package com.github.francisfire.anavis.models;

import java.util.Date;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Document(collection = "donationreport")
public class DonationReport {

	@EqualsAndHashCode.Include
	@Id
	private String reportId;
	private byte[] reportFile;
	private String donorMail;
	private String officeMail;
	private Date date;

	public DonationReport(String donorMail, String officeMail, Date date) {
		this.donorMail = donorMail;
		this.officeMail = officeMail;
		this.date = date;
	}

}
