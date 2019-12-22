package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;

@Service
public class OfficeServices {

	private Set<Office> offices;

	private OfficeServices() {
		this.offices = new HashSet<>();
	}

	/**
	 * Adds an office to the office collections
	 * 
	 * @throws NullPointerException if office is null
	 * @param office that will be added to the collection
	 * @return true if the office wasn't already in the set and has been added,
	 *         false otherwise
	 */
	public boolean addOffice(Office office) {
		return offices.add(Objects.requireNonNull(office));
	}

	/**
	 * Returns a view of the collection of offices, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the office collection
	 */
	public Set<Office> getOffices() {
		return new HashSet<>(offices);
	}

	/**
	 * Returns a set of dates in which prenotations can be made, associated to the
	 * office whose id has been passed as an input to the function
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId the id of the office
	 * @return the set of Date objects in which prenotations can be made
	 */
	public Set<TimeSlot> getDonationsTimeTable(String officeId) {
		Office office = getOfficeInstance(Objects.requireNonNull(officeId));
		return (office == null) ? new HashSet<>() : getOfficeInstance(officeId).getDonationTimeTables();
	}

	/**
	 * Gets the Office instance from the id which has been passed as an input to the
	 * method. Returns null if such office hasn'b been found in the collection.
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return the Office instance, or null if such instance hasn't been found
	 */
	public Office getOfficeInstance(String officeId) {
		Objects.requireNonNull(officeId);
		return offices.stream().filter(office -> office.getId().equals(officeId)).findFirst().orElse(null);
	}

	/**
	 * 
	 * Adds a new date, hour and number of prenotations' slots to the office
	 * specified by an officeId through the TimeSlot object that is requested as an
	 * argument
	 * 
	 * @param timeSlot that contains the date, hour and number of reserved
	 *                 prenotations
	 * @param officeId associated to the office that needs to have a new TimeSlot
	 *                 object inserted
	 * @return true if the office associated with the officeId didn't have already
	 *         registered a TimeSlot object associated with the same hour and date,
	 *         false otherwise
	 */
	public boolean addTimeslotByOffice(TimeSlot timeSlot, String officeId) {
		Objects.requireNonNull(timeSlot);
		Office office = getOfficeInstance(Objects.requireNonNull(officeId));
		return office.addTimeSlot(timeSlot);
	}

	/**
	 * Increases by one unit the number of left available prenotations' slots
	 * associated with a date and hour
	 * 
	 * 
	 * @param date     that contains the date and hour that need to have the number
	 *                 of left available prenotations increased
	 * @param officeId associated to the office that needs to have increased the
	 *                 number of left available prenotations' slots associated with
	 *                 a date and hour
	 * @return true if it is possible to increase the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean increaseTimeslotByOffice(Date date, String officeId) {
		Objects.requireNonNull(date);
		Office office = getOfficeInstance(Objects.requireNonNull(officeId));
		return office.increaseSlotByDate(date);
	}

	/**
	 * Decreases by one unit the number of left available prenotations' slots
	 * associated with a date and hour
	 * 
	 * 
	 * @param date     that contains the date and hour that need to have the number
	 *                 of left available prenotations decreased
	 * @param officeId associated to the office that needs to have decreased the
	 *                 number of left available prenotations' slots associated with
	 *                 a date and hour
	 * @return true if it is possible to decrease the number of left available
	 *         prenotations, false otherwise
	 */
	public boolean decreaseTimeslotByOffice(Date date, String officeId) {
		Objects.requireNonNull(date);
		Office office = getOfficeInstance(Objects.requireNonNull(officeId));
		return office.decreaseSlotByDate(date);
	}

	/**
	 * Checks if there are any left available prenotations' slots associated with a
	 * date and hour
	 * 
	 * @param date     that contains the date and hour
	 * @param officeId associated to the office of which a date needs to be verified
	 * @return true is there are available prenotations' slots with the date and
	 *         hour in the office associated by the officeId specified, false
	 *         otherwise
	 */
	public boolean isDateAvailableByOffice(Date date, String officeId) {
		Objects.requireNonNull(date);
		Office office = getOfficeInstance(Objects.requireNonNull(officeId));
		return office.isDateAvailable(date);
	}
}