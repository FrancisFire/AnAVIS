package com.github.francisfire.anavis.models;

import java.util.Date;

public class Request {

	private String id;
	private Office officePoint;
	private Donor donor;
	private Date hour;

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

	public Office getUfficio() {
		return this.officePoint;
	}

	public Donor getDonor() {
		return donor;
	}

	public Date getHour() {
		return this.hour;
	}

}