package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.Request;

public class RequestServices {

	private static RequestServices instance;
	private Set<Request> requests;
	
	private RequestServices() {
		this.requests = new HashSet<>();
	}

	/**
	 * Creates an instance of the class the first time it is used and returns the
	 * class instance
	 * 
	 * @return the class instance
	 */
	public static RequestServices getInstance() {
		if (instance == null) {
			instance = new RequestServices();
		}

		return instance;
	}

	/**
	 * Adds the request passed in input to the method to the request collection
	 * 
	 * @throws NullPointerException if request is null
	 * @param request the request to add
	 * @return true if the request wasn't present in the collection, false otherwise
	 */
	public boolean addRequest(Request request) {
		return requests.add(Objects.requireNonNull(request));
	}

	/**
	 * Removes the request present in the collection associated to the id passed in
	 * input to the method
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId the request id
	 * @return true if the request was present in the set and eliminated, false
	 *         otherwise
	 */
	public boolean removeRequest(String requestId) {
		return requests.remove(getRequestInstance(Objects.requireNonNull(requestId)));

	}

	/**
	 * Approves a request and makes it into a new prenotation
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId id of the request
	 * @return false if the request object hasn't been found in the collection,
	 *         otherwise it returns the result of
	 *         PrenotationServices.addPrenotation()
	 */
	public boolean approveRequest(String requestId) {
		Objects.requireNonNull(requestId);
		Request toApprove = this.getRequestInstance(requestId);
		if (requests.remove(toApprove)) {
			return PrenotationServices.getInstance().addPrenotation(toApprove);
		}
		return false;
	}

	/**
	 * Denies a request and deletes it from the collection
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId id of the request
	 * @return false if requestId is null or the request object hasn't been found,
	 *         otherwise it returns true
	 */
	public boolean denyRequest(String requestId) {
		return requests.remove(this.getRequestInstance(Objects.requireNonNull(requestId)));
	}

	/**
	 * Returns a view of the collection of requests, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the request collection
	 */
	public Set<Request> getRequests() {
		return new HashSet<>(requests);
	}

	/**
	 * Gets a collection of requests associated to the office whose id is the one
	 * passed in input to the function
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return a collection of requests associated to the office
	 */
	public Set<Request> getRequestsByOffice(String officeId) {
		Objects.requireNonNull(officeId);
		return requests.stream().filter(request -> request.getOfficeId().equals(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Gets the Request instance associated to the id that has been passed in input
	 * to the method
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId id of the request
	 * @return the Request object if present in the collection, null otherwise
	 */
	public Request getRequestInstance(String requestId) {
		Objects.requireNonNull(requestId);
		return requests.stream().filter(request -> request.getId().equals(requestId)).findFirst().orElse(null);
	}

}