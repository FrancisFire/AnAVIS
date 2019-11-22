package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.Request;

public class RequestServices {

	private static RequestServices instance;
	private List<Request> requests;

	private RequestServices() {
		this.requests = new ArrayList<>();
	}

	public static RequestServices getInstance() {
		if (instance == null) {
			instance = new RequestServices();
		}

		return instance;
	}

	/**
	 * 
	 * @param request
	 */
	public boolean addRequest(Request request) {
		return requests.add(request);
	}

	/**
	 * 
	 * @param id
	 */
	public void removeRequest(String id) {
		requests.remove(getRequest(id));
	}

	/**
	 * 
	 * @param request
	 */
	public boolean approveRequest(String request) {
		// TODO - implement GestoreRichieste.approvaRichiesta
		throw new UnsupportedOperationException();
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	public boolean denyRequest(String request) {
		// TODO - implement GestoreRichieste.declinaRichiesta
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param officeName
	 */
	public List<Request> getRequests(String officeName) {
		return requests.stream().filter(richieste -> richieste.getOfficePoint().getName().equals(officeName))
				.collect(Collectors.toList());
	}

	/**
	 * 
	 * @param id
	 */
	public Request getRequest(String id) {
		return requests.stream().filter(richiesta -> richiesta.getId().equals(id)).findFirst().orElse(null);
	}

}