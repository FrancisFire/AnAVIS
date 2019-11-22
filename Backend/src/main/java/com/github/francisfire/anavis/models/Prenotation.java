package com.github.francisfire.anavis.models;

import java.util.Date;

public class Prenotation {

	private String id;
	private Office officePoint;
	private Donor donor;
	private Date hour;

	public Prenotation(String id, Office officePoint, Donor donor, Date hour) {
		this.id = id;
		this.officePoint = officePoint;
		this.donor = donor;
		this.hour = hour;
	}

	public String getId() {
		return id;
	}

	public Office getOfficePoint() {
		return officePoint;
	}

	public Donor getDonor() {
		return donor;
	}

	public Date getHour() {
		return hour;
	}

}
