package com.github.francisfire.anavis.models;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Office {

	private String name;
	private Set<TimeSlot> donationTimeTables;

	public Office() {
	}

	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public Office(String name) {
		this.name = name;
		this.donationTimeTables = new HashSet<>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<TimeSlot> getDonationTimeTables() {
		return donationTimeTables;
	}

	public void setDonationTimeTables(Set<TimeSlot> donationTimeTables) {
		this.donationTimeTables = donationTimeTables;
	}

	public boolean addTimeSlot(TimeSlot timeSlot) {
		return donationTimeTables.add(timeSlot);
	}

	public boolean increaseSlotByDate(Date dateTime) {
		TimeSlot slot = donationTimeTables.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.increaseSlots();
		}
	}

	public boolean isDateAvalaible(Date dateTime) {
		TimeSlot slot = donationTimeTables.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.isDateAvalaible();
		}
	}

	public boolean decreaseSlotByDate(Date dateTime) {
		TimeSlot slot = donationTimeTables.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.decreaseSlots();
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		Office other = (Office) obj;
		if (name == null) {
			if (other.name != null) {
				return false;
			}
		} else if (!name.equals(other.name)) {
			return false;
		}
		return true;
	}

}