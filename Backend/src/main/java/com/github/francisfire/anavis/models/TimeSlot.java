package com.github.francisfire.anavis.models;

import java.util.Date;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class TimeSlot {
	
	@EqualsAndHashCode.Include
	private Date dateTime;
	private int donorSlots;

	public TimeSlot(Date dateTime, int donorSlots) {
		this.dateTime = dateTime;
		this.donorSlots = donorSlots;
	}

	/**
	 * Checks if there are any left available prenotations' slots associated with
	 * this object
	 * 
	 * 
	 * @return true is there are available prenotations' slots with the date and
	 *         hour specified in this object, false otherwise
	 */
	public boolean isDateAvailable() {
		return donorSlots > 0;
	}

	/**
	 * Increases by one unit the number of left available prenotations' slots
	 * associated with this object
	 * 
	 * @return true if it is possible to increase the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean increaseSlots() {
		this.donorSlots++;
		return true;
	}

	/**
	 * Decreases by one unit the number of left available prenotations' slots
	 * associated with this object
	 * 
	 * @return true if it is possible to decrease the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean decreaseSlots() {
		if (this.donorSlots == 0) {
			return false;
		} else {
			this.donorSlots--;
			return true;
		}
	}
}
