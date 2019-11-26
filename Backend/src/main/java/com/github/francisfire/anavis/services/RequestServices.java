package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.Request;

public class RequestServices {

	private static RequestServices instance;
	private Set<Request> requests;

	private RequestServices() {
		this.requests = new HashSet<>();
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
		if (request == null)
			return false;
		return requests.add(request);
	}

	/**
	 * 
	 * @param request
	 */
	public boolean removeRequest(String request) {
		if (request == null || this.getRequestInstance(request) == null) {
			return false;
		} else {
			return requests.remove(getRequestInstance(request));
		}
	}

	/**
	 * 
	 * @param request
	 */
	public boolean approveRequest(String request) {
		Request toApprove = this.getRequestInstance(request);
		if (request == null || toApprove == null) {
			return false;
		} else {
			requests.remove(toApprove);
			return PrenotationServices.getInstance().addPrenotation(toApprove);
		}
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	public boolean denyRequest(String request) {
		Request toApprove = this.getRequestInstance(request);
		if (request == null || toApprove == null) {
			return false;
		} else {
			return requests.remove(toApprove);
		}
	}

	public Set<Request> getRequests() {
		return requests;
	}

	/**
	 * 
	 * @param officeName
	 */
	public Set<Request> getRequestsByOffice(String officeName) {
		return requests.stream().filter(richieste -> richieste.getOfficePoint().getName().equals(officeName))
				.collect(Collectors.toSet());
	}

	/**
	 * 
	 * @param id
	 */
	public Request getRequestInstance(String id) {
		return requests.stream().filter(richiesta -> richiesta.getId().equals(id)).findFirst().orElse(null);
	}

}