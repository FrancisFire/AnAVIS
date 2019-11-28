package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import com.github.francisfire.anavis.models.Office;

public class OfficeServices {

	private static OfficeServices instance;
	private Set<Office> offices;

	private OfficeServices() {
		this.offices = new HashSet<>();
	}

	/**
	 * Creates an instance of the class the first time it is used and returns the
	 * class instance
	 * 
	 * @return the class instance
	 */
	public static OfficeServices getInstance() {
		if (instance == null) {
			instance = new OfficeServices();
		}
		return instance;
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
	public Set<Date> getDonationsTimeTable(String officeId) {
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
		return offices.stream().filter(office -> office.getName().equals(officeId)).findFirst().orElse(null);
	}
}