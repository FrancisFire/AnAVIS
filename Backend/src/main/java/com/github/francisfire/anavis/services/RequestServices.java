package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.Request;

public class RequestServices {

	private static RequestServices instance;
	private List<Request> richieste;

	private RequestServices() {
		this.richieste = new ArrayList<>();
	}

	public static RequestServices getInstance() {
		if (instance == null) {
			instance = new RequestServices();
		}

		return instance;
	}

	/**
	 * 
	 * @param richiesta
	 */
	public boolean addRichiesta(Request richiesta) {
		return richieste.add(richiesta);
	}

	/**
	 * 
	 * @param id
	 */
	public void removeRichiesta(String id) {
		richieste.remove(getRichiesta(id));
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
	 * @param richiesta
	 * @return
	 */
	public boolean declinaRichiesta(String richiesta) {
		// TODO - implement GestoreRichieste.declinaRichiesta
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param nomeUfficio
	 */
	public List<Request> getRichieste(String nomeUfficio) {
		return richieste.stream().filter(richieste -> richieste.getUfficio().getName().equals(nomeUfficio))
				.collect(Collectors.toList());
	}

	/**
	 * 
	 * @param id
	 */
	public Request getRichiesta(String id) {
		return richieste.stream().filter(richiesta -> richiesta.getId().equals(id)).findFirst().orElse(null);
	}

}