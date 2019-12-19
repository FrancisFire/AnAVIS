package com.github.francisfire.anavis.models;

import java.util.Date;

public class TimeSlot {
	private Date dateTime;
	private int donorSlots;

	public TimeSlot(Date dateTime, int donorSlots) {
		this.dateTime = dateTime;
		this.donorSlots = donorSlots;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public int getDonorSlot() {
		return this.donorSlots;
	}

	public void setDonorSlot(int slots) {
		this.donorSlots = slots;
	}

	public boolean isDateAvalaible() {
		return donorSlots > 0;
	}

	public boolean increaseSlots() {
		this.donorSlots++;
		return true;
	}
	
	public boolean decreaseSlots() {
		if(this.donorSlots == 0) {
			return false;
		} else {
			this.donorSlots--;
			return true;
		}
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dateTime == null) ? 0 : dateTime.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TimeSlot other = (TimeSlot) obj;
		if (dateTime == null) {
			if (other.dateTime != null)
				return false;
		} else if (!dateTime.equals(other.dateTime))
			return false;
		return true;
	}
}
