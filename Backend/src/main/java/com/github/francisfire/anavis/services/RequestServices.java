package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.repository.RequestRepository;

import lombok.NonNull;

@Service
public class RequestServices {

	@Autowired
	private RequestRepository repository;
	@Autowired
	private PrenotationServices prenotationServices;
	@Autowired
	private DonorServices donorServices;
	@Autowired
	private OfficeServices officeServices;

	/**
	 * Adds the request passed in input to the method to the request collection
	 * 
	 * @throws NullPointerException if request is null
	 * @param request the request to add
	 * @return true if the request wasn't present in the collection the donor
	 *         associated with the request can donate and the date associated with
	 *         the request is legit, false otherwise
	 */
	public boolean addRequest(@NonNull RequestPrenotation request) {
		if (donorServices.checkDonationPossibility(request.getDonorMail())
				&& officeServices.isDateAvailableByOffice(request.getHour(), request.getOfficeMail())) {
			if (repository.existsById(request.getId())) {
				return false;
			}
			repository.insert(request);
			return true;
		}
		return false;
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
	public boolean removeRequest(@NonNull String requestId) {
		if (repository.existsById(requestId)) {
			repository.delete(getRequestInstance(requestId));
			return true;
		}
		return false;
	}

	/**
	 * Approves a request and makes it into a new prenotation
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId id of the request
	 * @return true if the donor associated with the request can donate and the
	 *         prenotation has been correctly added, false otherwise
	 */
	public boolean approveRequest(@NonNull String requestId) {
		RequestPrenotation toApprove = this.getRequestInstance(requestId);
		if (toApprove == null) {
			return false;
		}
		if (donorServices.checkDonationPossibility(toApprove.getDonorMail())) {
			repository.delete(toApprove);
			return prenotationServices.addPrenotation(toApprove);
		}
		return false;
	}

	/**
	 * Returns a view of the collection of requests, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the request collection
	 */
	public Set<RequestPrenotation> getRequests() {
		return new HashSet<>(repository.findAll());
	}

	/**
	 * Gets a collection of requests associated to the office whose id is the one
	 * passed in input to the function
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeMail id of the office
	 * @return a collection of requests associated to the office
	 */
	public Set<RequestPrenotation> getRequestsByOffice(@NonNull String officeMail) {
		return repository.findAll().stream().filter(request -> request.getOfficeMail().equals(officeMail))
				.collect(Collectors.toSet());
	}

	/**
	 * Gets a collection of requests associated to the donor whose id is the one
	 * passed in input to the function
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param donorMail id of the donor
	 * @return a collection of requests associated to the donor
	 */
	public Set<RequestPrenotation> getRequestsByDonor(@NonNull String donorMail) {
		return repository.findAll().stream().filter(request -> request.getDonorMail().equals(donorMail))
				.collect(Collectors.toSet());
	}

	/**
	 * Gets the RequestPrenotation instance associated to the id that has been
	 * passed in input to the method
	 * 
	 * @throws NullPointerException if requestId is null
	 * @param requestId id of the request
	 * @return the RequestPrenotation object if present in the collection, null
	 *         otherwise
	 */
	public RequestPrenotation getRequestInstance(@NonNull String requestId) {
		return repository.findById(requestId).orElse(null);
	}

}