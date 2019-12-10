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
	 * TODO
	 * 
	 * @return
	 */
	public Set<Prenotation> getPrenotations() {
		return new HashSet<>(prenotations);
	}

	/**
	 * TODO
	 * 
	 * @param prenotation
	 * @return
	 */
	public boolean addPrenotation(Prenotation prenotation) {
		Objects.requireNonNull(prenotation);
		return prenotations.add(prenotation);
	}

	/**
	 * TODO
	 * 
	 * @param prenotationId
	 * @return
	 */
	public boolean removePrenotation(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		return prenotations.remove(getPrenotationInstance(prenotationId));
	}

	/**
	 * TODO
	 * 
	 * @param prenotationId
	 * @param prenotation
	 * @return
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
	 * TODO
	 * 
	 * @param officeId
	 * @return
	 */
	public Set<Prenotation> getPrenotationsByOffice(String officeId) {
		Objects.requireNonNull(officeId);
		return prenotations.stream()
				.filter(prenotation -> prenotation.getOfficePoint().getName().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * TODO
	 * 
	 * @param donorId
	 * @return
	 */
	public Set<Prenotation> getPrenotationsByDonor(String donorId) {
		Objects.requireNonNull(donorId);
		return prenotations.stream().filter(prenotation -> prenotation.getDonor().getMail().equalsIgnoreCase(donorId))
				.collect(Collectors.toSet());
	}

	/**
	 * TODO
	 * 
	 * @param prenotationId
	 * @return
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
	 * TODO
	 * 
	 * @param prenotationId
	 * @return
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
	 * TODO
	 * 
	 * @param prenotationId
	 * @return
	 */
	private Prenotation getPrenotationInstance(String prenotationId) {
		Objects.requireNonNull(prenotationId);
		return prenotations.stream().filter(prenotation -> prenotation.getId().equals(prenotationId)).findFirst()
				.orElse(null);
	}
	
	public void resetPrenotationServices() {
		instance = new PrenotationServices();
	}

}