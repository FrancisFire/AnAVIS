package com.github.francisfire.anavis.models;

import java.util.Date;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = "report")
public class DonationReport {

	@Id
	private String reportId;
	@Field
	private Binary reportFile;
	@Field
	private String donorId;
	@Field
	private String officeId;
	@Field
	private Date date;

	public DonationReport() {
	}

	public DonationReport(String donorId, String officeId, Date date) {
		this.donorId = donorId;
		this.officeId = officeId;
		this.date = date;
	}

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	public String getDonorId() {
		return donorId;
	}

	public void setDonorId(String donorId) {
		this.donorId = donorId;
	}

	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Binary getReportFile() {
		return reportFile;
	}

	public void setReportFile(Binary reportFile) {
		this.reportFile = reportFile;
	}

}
