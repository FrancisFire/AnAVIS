package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Set;

import com.github.francisfire.anavis.models.Prenotation;
import com.github.francisfire.anavis.models.Request;

public class PrenotationServices {

	private static PrenotationServices instance;
	private Set<Prenotation> prenotations;

	private PrenotationServices() {
		this.prenotations = new HashSet<>();
	}

	public static PrenotationServices getInstance() {
		if (instance == null) {
			instance = new PrenotationServices();
		}

		return instance;
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean addPrenotation(Request richiesta) {
		Prenotation prenotation = new Prenotation(richiesta.getId(), richiesta.getOfficePoint(), richiesta.getDonor(),
				richiesta.getHour());
		return prenotations.add(prenotation);
	}

}