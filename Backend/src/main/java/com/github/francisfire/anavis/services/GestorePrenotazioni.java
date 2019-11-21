package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;

import com.github.francisfire.anavis.models.RichiestaPrenotazione;

public class GestorePrenotazioni {

	private static GestorePrenotazioni instance;
	//TODO add prenotazioni
	private List<RichiestaPrenotazione> prenotazioni;

	private GestorePrenotazioni() {
		this.prenotazioni = new ArrayList<>();
	}
	
	public static GestorePrenotazioni getInstance() {
		if(instance == null) {
			instance = new GestorePrenotazioni();
		}
		
		return instance;
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean addPrenotazione(RichiestaPrenotazione richiesta) {
		return prenotazioni.add(richiesta);
	}

}