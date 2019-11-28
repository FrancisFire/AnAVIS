package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

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

}