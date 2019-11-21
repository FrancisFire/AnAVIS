package com.github.francisfire.anavis.models;

public class Donatore {

	private String mail;
	private UfficioAVIS officePoint;
	private boolean canDonate;

	/**
	 * 
	 * @param mail
	 * @param officePoint
	 */
	public Donatore(String mail, UfficioAVIS officePoint) {
		this.mail = mail;
		this.officePoint = officePoint;
	}

	public boolean canDonate() {
		return this.canDonate;
	}

	public String getOfficeId() {
		return officePoint.getName();
	}
	
	public String getMail() {
		return mail;
	}

}