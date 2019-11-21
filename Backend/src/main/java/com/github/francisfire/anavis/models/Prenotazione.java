package com.github.francisfire.anavis.models;

import java.util.Date;

public class Prenotazione {

	private String id;
	private UfficioAVIS officePoint;
	private Donatore donor;
	private Date hour;

	public Prenotazione(String id, UfficioAVIS officePoint, Donatore donor, Date hour) {
		this.id = id;
		this.officePoint = officePoint;
		this.donor = donor;
		this.hour = hour;
	}

	public String getId() {
		return id;
	}

	public UfficioAVIS getOfficePoint() {
		return officePoint;
	}

	public Donatore getDonor() {
		return donor;
	}

	public Date getHour() {
		return hour;
	}

}
