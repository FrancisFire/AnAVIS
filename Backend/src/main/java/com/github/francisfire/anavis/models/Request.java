package com.github.francisfire.anavis.models;

import java.util.Date;

public class Request {

	private String id;
	private Office officePoint;
	private Donor donor;
	private Date hour;

	public Request() {
	}

	/**
	 * 
	 * @param id
	 * @param officePoint
	 * @param donor
	 * @param hour
	 */
	public Request(String id, Office officePoint, Donor donor, Date hour) {
		this.id = id;
		this.officePoint = officePoint;
		this.donor = donor;
		this.hour = hour;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Office getOfficePoint() {
		return officePoint;
	}

	public void setOfficePoint(Office officePoint) {
		this.officePoint = officePoint;
	}

	public Donor getDonor() {
		return donor;
	}

	public void setDonor(Donor donor) {
		this.donor = donor;
	}

	public Date getHour() {
		return hour;
	}

	public void setHour(Date hour) {
		this.hour = hour;
	}

}