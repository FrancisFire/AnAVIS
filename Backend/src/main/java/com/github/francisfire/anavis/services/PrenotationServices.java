package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.RequestPrenotation;

public class PrenotationServices {

	private static PrenotationServices instance;
	private Set<ActivePrenotation> prenotations;

	private PrenotationServices() {
		this.prenotations = new HashSet<>();
	}

	/**
	 * Creates an instance of the class the first time it is used and returns the
	 * class instance
	 * 
	 * @return the class instance
	 */
	public static PrenotationServices getInstance() {
		if (instance == null) {
			instance = new PrenotationServices();
		}

		return instance;
	}

	/**
	 * Adds a prenotation to the prenotation collection from the request that has
	 * been passed as an input to the method. Decreases the time slot of the office.
	 * 
	 * @throws NullPointerException if request is null
	 * @param request the request from where data has been taken to create the
	 *                prenotation
	 * @return true if the prenotation wasn't already present in the collection and
	 *         timeslot was available and has been correctly decreased, false
	 *         otherwise
	 */
	public boolean addPrenotation(RequestPrenotation request) {
		Objects.requireNonNull(request);
		if (OfficeServices.getInstance().decreaseTimeslotByOffice(request.getHour(), request.getOfficeId())) {
			ActivePrenotation prenotation = new ActivePrenotation(request.getId(), request.getOfficeId(),
					request.getDonorId(), request.getHour());
			return prenotations.add(prenotation);
		}
		return false;
	}

	/**
	 * Returns a view of the collection of prenotations, modifying this view won't
	 * have effects on the original collection, however modifying the objects in it
	 * will have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the prenotation collection
	 */
	public Set<ActivePrenotation> getPrenotations() {
		return new HashSet<>(prenotations);
	}

	/**
	 * Adds a prenotation to the prenotation collection and decreases by one the
	 * cardinality of the office timeslot at the date of prenotation
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to add
	 * @return true if the collection didn't contain the added prenotation and a
	 *         timeslot was present
	 */
	public boolean addPrenotation(ActivePrenotation prenotation) {
		Objects.requireNonNull(prenotation);
		Date date = prenotation.getHour();
		String officeId = prenotation.getOfficeId();
		return OfficeServices.getInstance().decreaseTimeslotByOffice(date, officeId) && prenotations.add(prenotation);
	}

	/**
	 * Removes the prenotation assigned to the prenotationId from the prenotation
	 * collection and increases by one the cardinality of the timeslot of the office
	 * at the date of prenotation
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId the id of the prenotation to remove
	 * @return true if the collections contained the prenotation and the timeslot
	 *         was succesfully increased
	 */
	public boolean removePrenotation(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null) {
			return false;
		}
		Date date = prenotation.getHour();
		String officeId = prenotation.getOfficeId();
		return OfficeServices.getInstance().increaseTimeslotByOffice(date, officeId)
				&& prenotations.remove(getPrenotationInstance(prenotationId));
	}

	/**
	 * Updates the prenotation passed in input to the method in the prenotation
	 * collection, increases by one the cardinality of the timeslot of the office
	 * from the old prenotation and decreases the one associated to the new
	 * prenotation
	 * 
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to update
	 * @return true if prenotation was present and updates succesfully and timeslots
	 *         have been modified successfully, false otherwise
	 */
	public boolean updatePrenotation(ActivePrenotation prenotation) {
		Objects.requireNonNull(prenotation);
		ActivePrenotation oldPrenotation = getPrenotationInstance(prenotation.getId());
		if (oldPrenotation == null) {
			return false;
		}
		Date oldDate = oldPrenotation.getHour();
		String oldOffice = oldPrenotation.getOfficeId();

		Date newDate = prenotation.getHour();
		String newOffice = prenotation.getOfficeId();
		if (OfficeServices.getInstance().decreaseTimeslotByOffice(newDate, newOffice)) {
			return prenotations.remove(prenotation) && prenotations.add(oldPrenotation)
					&& OfficeServices.getInstance().increaseTimeslotByOffice(oldDate, oldOffice);
		} else {
			return false;
		}
	}

	/**
	 * Returns a collection of prenotations related to an office passed in input
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of prenotations related to the office passed in input
	 */
	public Set<ActivePrenotation> getPrenotationsByOffice(String officeId) {
		Objects.requireNonNull(officeId);
		return prenotations.stream().filter(prenotation -> prenotation.getOfficeId().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a collection of prenotations related to a donor passed in input
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId id of the donor
	 * @return a collection of prenotations related to the donor passed in input
	 */
	public Set<ActivePrenotation> getPrenotationsByDonor(String donorId) {
		Objects.requireNonNull(donorId);
		return prenotations.stream().filter(prenotation -> prenotation.getDonorId().equalsIgnoreCase(donorId))
				.collect(Collectors.toSet());
	}

	/**
	 * Accepts the changes made to the prenotation associated to the id given to the
	 * method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the prenotation
	 * @return false if prenotation was present and not already confirmed, true
	 *         otherwise
	 */
	public boolean acceptPrenotationChange(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null || prenotation.isConfirmed()) {
			return false;
		}
		getPrenotationInstance(prenotationId).setConfirmed(true);
		return true;
	}

	/**
	 * Denies the changes made to the prenotation associated to the id given to the
	 * method and deletes such prenotation
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the prenotation
	 * @return true if prenotation was present and succesfully removed, false
	 *         otherwise
	 */
	public boolean denyPrenotationChange(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null || prenotation.isConfirmed()) {
			return false;
		}
		return this.removePrenotation(prenotationId);
	}

	/**
	 * Gets the ActivePrenotation instance associated to the id that has been passed
	 * in input to the method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the request
	 * @return the Prenotation object if present in the collection, null otherwise
	 */
	public ActivePrenotation getPrenotationInstance(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		return prenotations.stream().filter(prenotation -> prenotation.getId().equals(prenotationId)).findFirst()
				.orElse(null);
	}

	/**
	 * Closes the currently active prenotation associated to the id that has been
	 * passed in input to the method
	 * 
	 * 
	 * @param prenotationId id of the prenotation that needs to be closed
	 * @param reportId      id of the report associated to the prenotation
	 * @return true if prenotation was present and succesfully closed, false
	 *         otherwise
	 */
	public boolean closePrenotation(String prenotationId, String reportId) {
		Objects.requireNonNull(prenotationId);
		Objects.requireNonNull(reportId);
		ActivePrenotation toClose = this.getPrenotationInstance(prenotationId);
		if (this.removePrenotation(prenotationId)) {
			return DonationServices.getInstance().addDonation(toClose, reportId);
		} else {
			return false;
		}
	}

}