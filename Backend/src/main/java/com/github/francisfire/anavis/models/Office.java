package com.github.francisfire.anavis.models;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Office {

	@EqualsAndHashCode.Include
	private String id;
	private Set<TimeSlot> donationTimeTable;

	public Office(String name) {
		this.id = name;
		this.donationTimeTable = new HashSet<>();
	}

	/**
	 * Adds a new date, hour and number of prenotations' slots to the office
	 * timetable through the TimeSlot object that is requested as an argument
	 * 
	 * @param timeSlot that contains the date, hour and number of reserved
	 *                 prenotations
	 * @return true if the office didn't have already registered a TimeSlot object
	 *         associated with the same hour and date, false otherwise
	 */
	public boolean addTimeSlot(TimeSlot timeSlot) {
		return donationTimeTable.add(timeSlot);
	}

	/**
	 * Increases by one unit the number of left available prenotations' slots
	 * associated with a date and hour
	 * 
	 * @param dateTime that contains the date and hour that need to have the number
	 *                 of left available prenotations increased
	 * @return true if it is possible to increase the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean increaseSlotByDate(Date dateTime) {
		TimeSlot slot = donationTimeTable.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.increaseSlots();
		}
	}

	/**
	 * Decreases by one unit the number of left available prenotations' slots
	 * associated with a date and hour
	 * 
	 * @param dateTime that contains the date and hour that need to have the number
	 *                 of left available prenotations decreased
	 * @return true if it is possible to decrease the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean decreaseSlotByDate(Date dateTime) {
		TimeSlot slot = donationTimeTable.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.decreaseSlots();
		}
	}

	/**
	 * Checks if there are any left available prenotations' slots associated with a
	 * date and hour
	 * 
	 * @param dateTime that contains the date and hour
	 * @return true is there are available prenotations' slots with the date and
	 *         hour specified, false otherwise
	 */
	public boolean isDateAvailable(Date dateTime) {
		TimeSlot slot = donationTimeTable.stream().filter(timeslot -> timeslot.getDateTime().equals(dateTime))
				.findFirst().orElse(null);
		if (slot == null) {
			return false;
		} else {
			return slot.isDateAvailable();
		}
	}

}