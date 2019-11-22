package com.github.francisfire.anavis.models;

public class Donor {

	private String mail;
	private Office officePoint;
	private boolean canDonate;

	/**
	 * 
	 * @param mail
	 * @param officePoint
	 */
	public Donor(String mail, Office officePoint) {
		this.mail = mail;
		this.officePoint = officePoint;
		this.canDonate = false;
	}

	public String getMail() {
		return mail;
	}

	public String getOfficeId() {
		return officePoint.getName();
	}
	
	public boolean canDonate() {
		return this.canDonate;
	}

}