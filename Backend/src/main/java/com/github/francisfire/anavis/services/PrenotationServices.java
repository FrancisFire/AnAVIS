package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;

import com.github.francisfire.anavis.models.Prenotation;
import com.github.francisfire.anavis.models.Request;

public class PrenotationServices {

	private static PrenotationServices instance;
	private List<Prenotation> prenotazioni;

	private PrenotationServices() {
		this.prenotazioni = new ArrayList<>();
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
	public boolean addPrenotazione(Request richiesta) {
		Prenotation prenotation = new Prenotation(richiesta.getId(), richiesta.getUfficio(), richiesta.getDonor(),
				richiesta.getHour());
		return prenotazioni.add(prenotation);
	}

}