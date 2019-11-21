package com.github.francisfire.anavis.services;

import com.github.francisfire.anavis.models.RichiestaPrenotazione;

public class GestoreRichieste {

	private static GestoreRichieste instance;
	private RichiestaPrenotazione[] richieste;

	public static RichiestaPrenotazione getInstance() {
		// TODO - implement GestoreRichieste.getInstance
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean addRichiesta(RichiestaPrenotazione richiesta) {
		// TODO - implement GestoreRichieste.addRichiesta
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param nomeUfficio
	 */
	public RichiestaPrenotazione[] getRichieste(String nomeUfficio) {
		return this.richieste;
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean approvaRichiesta(String richiesta) {
		// TODO - implement GestoreRichieste.approvaRichiesta
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param id
	 */
	public RichiestaPrenotazione getRichiesta(String id) {
		// TODO - implement GestoreRichieste.getRichiesta
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param id
	 */
	public void removeRichiesta(String id) {
		// TODO - implement GestoreRichieste.removeRichiesta
		throw new UnsupportedOperationException();
	}

}