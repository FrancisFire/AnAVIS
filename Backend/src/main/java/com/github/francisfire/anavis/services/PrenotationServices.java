package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.Prenotation;
import com.github.francisfire.anavis.models.Request;

public class PrenotationServices {

	private static PrenotationServices instance;
	private Set<Prenotation> prenotations;

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
	 * been passed as an input to the method.
	 * 
	 * @throws NullPointerException if request is null
	 * @param request the request from where data has been taken to create the
	 *                prenotation
	 * @return true if the prenotation wasn't already present in the collection,
	 *         false otherwise
	 */
	public boolean addPrenotation(Request request) {
		Objects.requireNonNull(request);
		Prenotation prenotation = new Prenotation(request.getId(), request.getOfficePoint(), request.getDonor(),
				request.getHour());
		return prenotations.add(prenotation);
	}

	/**
	 * Returns a view of the collection of prenotations, modifying this view won't
	 * have effects on the original collection, however modifying the objects in it
	 * will have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the prenotation collection
	 */
	public Set<Prenotation> getPrenotations() {
		return new HashSet<>(prenotations);
	}

	/**
	 * Adds a prenotation to the prenotation collection
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to add
	 * @return true if the collection didn't contain the added prenotation
	 */
	public boolean addPrenotation(Prenotation prenotation) {
		Objects.requireNonNull(prenotation);
		return prenotations.add(prenotation);
	}

	/**
	 * Removes the prenotation assigned to the prenotationId from the prenotation
	 * collection
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId the id of the prenotation to remove
	 * @return true if the collections contained the prenotation
	 */
	public boolean removePrenotation(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		return prenotations.remove(getPrenotationInstance(prenotationId));
	}

	/**
	 * Updates the prenotation passed in input to the method in the prenotation
	 * collection
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to update
	 * @return true if prenotation was present and updated successfully, false
	 *         otherwise
	 */
	public boolean updatePrenotation(Prenotation prenotation) {
		Objects.requireNonNull(prenotation);
		if (prenotations.remove(getPrenotationInstance(prenotation.getId()))) {
			return prenotations.add(prenotation);
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
	public Set<Prenotation> getPrenotationsByOffice(String officeId) {
		Objects.requireNonNull(officeId);
		return prenotations.stream()
				.filter(prenotation -> prenotation.getOfficePoint().getName().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a collection of prenotations related to a donor passed in input
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param donorId id of the donor
	 * @returna collection of prenotations related to the donor passed in input
	 */
	public Set<Prenotation> getPrenotationsByDonor(String donorId) {
		Objects.requireNonNull(donorId);
		return prenotations.stream().filter(prenotation -> prenotation.getDonor().getMail().equalsIgnoreCase(donorId))
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
		Prenotation prenotation = getPrenotationInstance(prenotationId);
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
		Prenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null || prenotation.isConfirmed()) {
			return false;
		}
		return prenotations.remove(getPrenotationInstance(prenotationId));
	}

	/**
	 * Gets the Prenotation instance associated to the id that has been passed in
	 * input to the method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the request
	 * @return the Prenotation object if present in the collection, null otherwise
	 */
	public Prenotation getPrenotationInstance(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		return prenotations.stream().filter(prenotation -> prenotation.getId().equals(prenotationId)).findFirst()
				.orElse(null);
	}

}