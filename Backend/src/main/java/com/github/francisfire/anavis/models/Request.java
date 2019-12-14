package com.github.francisfire.anavis.models;

import java.util.Date;

public class Request {

	private String id;
	private String officeId;
	private String donorId;
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
	public Request(String id, String officePoint, String donor, Date hour) {
		this.id = id;
		this.officeId = officePoint;
		this.donorId = donor;
		this.hour = hour;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	public String getDonorId() {
		return donorId;
	}

	public void setDonorId(String donorId) {
		this.donorId = donorId;
	}

	public Date getHour() {
		return hour;
	}

	public void setHour(Date hour) {
		this.hour = hour;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		Request other = (Request) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id)) {
			return false;
		}
		return true;
	}

}