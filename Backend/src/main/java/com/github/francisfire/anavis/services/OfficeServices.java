package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.repository.OfficeRepository;

import lombok.NonNull;

@Service
public class OfficeServices {
	@Autowired
	private OfficeRepository repository;

	/**
	 * Adds an office to the office collections
	 * 
	 * @throws NullPointerException if office is null
	 * @param office that will be added to the collection
	 * @return true if the office wasn't already in the set and has been added,
	 *         false otherwise
	 */
	public boolean addOffice(@NonNull Office office) {
		if (repository.existsById(office.getId())) {
			return false;
		} else {
			repository.insert(office);
			return true;
		}
	}

	/**
	 * Returns a view of the collection of offices, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the office collection
	 */
	public Set<Office> getOffices() {
		return new HashSet<>(repository.findAll());
	}

	/**
	 * Returns a set of dates in which prenotations can be made, associated to the
	 * office whose id has been passed as an input to the function
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId the id of the office
	 * @return the set of Date objects in which prenotations can be made
	 */
	public Set<TimeSlot> getDonationsTimeTable(@NonNull String officeId) {
		Office office = getOfficeInstance(officeId);
		return (office == null) ? new HashSet<>() : getOfficeInstance(officeId).getDonationTimeTable();
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
	public boolean addTimeslotByOffice(@NonNull TimeSlot timeSlot, @NonNull String officeId) {
		Office office = getOfficeInstance(officeId);
		if (office.addTimeSlot(timeSlot)) {
			repository.save(office);
			return true;
		} else {
			return false;
		}
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
	public boolean increaseTimeslotByOffice(@NonNull Date date, @NonNull String officeId) {
		Office office = getOfficeInstance(officeId);
		if (office.increaseSlotByDate(date)) {
			repository.save(office);
			return true;
		} else {
			return false;
		}
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
	public boolean decreaseTimeslotByOffice(@NonNull Date date, @NonNull String officeId) {
		Office office = getOfficeInstance(officeId);
		if (office.decreaseSlotByDate(date)) {
			repository.save(office);
			return true;
		} else {
			return false;
		}
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
	public boolean isDateAvailableByOffice(@NonNull Date date, @NonNull String officeId) {
		Office office = getOfficeInstance(officeId);
		return office.isDateAvailable(date);
	}

	/**
	 * Removes the office assigned to the officeId 
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId the id of the office to remove
	 * @return true if the collections contained the office
	 */
	public boolean removeOffice(@NonNull String officeId) {
		if (repository.existsById(officeId)) {
			repository.delete(getOfficeInstance(officeId));
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Gets the Office instance from the id which has been passed as an input to the
	 * method. Returns null if such office hasn'b been found in the collection.
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return the Office instance, or null if such instance hasn't been found
	 */
	public Office getOfficeInstance(@NonNull String officeId) {
		return repository.findById(officeId).orElse(null);
	}
}