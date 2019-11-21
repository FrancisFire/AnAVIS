package com.github.francisfire.anavis.models;

import java.util.Date;

public class RichiestaPrenotazione {

	private String id;
	private UfficioAVIS officePoint;
	private Donatore donor;
	private Date hour;

	/**
	 * 
	 * @param id
	 * @param officePoint
	 * @param donor
	 * @param hour
	 */
	public RichiestaPrenotazione(String id, UfficioAVIS officePoint, Donatore donor, Date hour) {
		this.id = id;
		this.officePoint = officePoint;
		this.donor = donor;
		this.hour = hour;
	}

	public UfficioAVIS getUfficio() {
		return this.officePoint;
	}

	public Date getOraData() {
		return this.hour;
	}

}