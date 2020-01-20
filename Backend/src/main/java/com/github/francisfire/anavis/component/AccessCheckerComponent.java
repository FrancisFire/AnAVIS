package com.github.francisfire.anavis.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.models.Prenotation;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.PrenotationServices;
import com.github.francisfire.anavis.services.RequestServices;

@Component
public class AccessCheckerComponent {

	@Autowired
	private DonationServices donationServices;

	@Autowired
	private PrenotationServices prenotationServices;

	@Autowired
	private RequestServices requestServices;

	public boolean sameUserId(UserDetails principal, String userId) {
		return principal.getUsername().equals(userId);
	}

	public boolean isDonationOwnedByDonorId(UserDetails principal, String donationId) {
		ClosedPrenotation donation = donationServices.getDonationInstance(donationId);
		return isPrenotationInstanceOwnedByDonorId(principal, donation);
	}

	public boolean isPrenotationOwnedByOfficeId(UserDetails principal, String prenotationId) {
		ActivePrenotation prenotation = prenotationServices.getPrenotationInstance(prenotationId);
		return isPrenotationInstanceOwnedByOfficeId(principal, prenotation);
	}

	public boolean isPrenotationOwnedByDonorId(UserDetails principal, String prenotationId) {
		ActivePrenotation prenotation = prenotationServices.getPrenotationInstance(prenotationId);
		return isPrenotationInstanceOwnedByDonorId(principal, prenotation);
	}

	public boolean isRequestOwnedByDonorId(UserDetails principal, String requestId) {
		RequestPrenotation request = requestServices.getRequestInstance(requestId);
		return isPrenotationInstanceOwnedByDonorId(principal, request);
	}

	public boolean isRequestOwnedByOfficeId(UserDetails principal, String requestId) {
		RequestPrenotation request = requestServices.getRequestInstance(requestId);
		return isPrenotationInstanceOwnedByOfficeId(principal, request);
	}

	public boolean isPrenotationInstanceOwnedByOfficeId(UserDetails principal, Prenotation prenotation) {
		if (prenotation == null) {
			return false;
		}
		return principal.getUsername().equals(prenotation.getOfficeMail());
	}

	public boolean isPrenotationInstanceOwnedByDonorId(UserDetails principal, Prenotation prenotation) {
		if (prenotation == null) {
			return false;
		}
		return principal.getUsername().equals(prenotation.getDonorMail());
	}

}
