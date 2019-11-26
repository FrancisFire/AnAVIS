package com.github.francisfire.anavis.models;

public class Donor {

	private String mail;
	private Office officePoint;
	private boolean canDonate;

	public Donor() {
	}
	
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

	public void setMail(String mail) {
		this.mail = mail;
	}

	public Office getOfficePoint() {
		return officePoint;
	}

	public void setOfficePoint(Office officePoint) {
		this.officePoint = officePoint;
	}

	public boolean isCanDonate() {
		return canDonate;
	}

	public void setCanDonate(boolean canDonate) {
		this.canDonate = canDonate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((mail == null) ? 0 : mail.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Donor other = (Donor) obj;
		if (mail == null) {
			if (other.mail != null) {
				return false;
			}
		} else if (!mail.equals(other.mail)) {
			return false;
		}
		return true;
	}

}