package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.RichiestaPrenotazione;

public class GestoreRichieste {

	private static GestoreRichieste instance;
	private List<RichiestaPrenotazione> richieste;

	private GestoreRichieste() {
		this.richieste = new ArrayList<>();
	}

	public static GestoreRichieste getInstance() {
		if (instance == null) {
			instance = new GestoreRichieste();
		}

		return instance;
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean addRichiesta(RichiestaPrenotazione richiesta) {
		return richieste.add(richiesta);
	}

	/**
	 * 
	 * @param nomeUfficio
	 */
	public List<RichiestaPrenotazione> getRichieste(String nomeUfficio) {
		return richieste.stream().filter(richieste -> richieste.getUfficio().getName().equals(nomeUfficio))
				.collect(Collectors.toList());
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
		return richieste.stream().filter(richiesta -> richiesta.getId().equals(id)).findFirst().orElse(null);
	}

	/**
	 * 
	 * @param id
	 */
	public void removeRichiesta(String id) {
		richieste.remove(getRichiesta(id));
	}

}