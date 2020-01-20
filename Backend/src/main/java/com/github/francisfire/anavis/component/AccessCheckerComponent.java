package com.github.francisfire.anavis.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.services.DonationServices;

@Component
public class AccessCheckerComponent {

	@Autowired
	private DonationServices donationServices;

	public boolean sameUserId(UserDetails principal, String userId) {
		return principal.getUsername().equals(userId);
	}

	public boolean isDonationOwnedById(UserDetails principal, String donationId) {
		ClosedPrenotation prenotation = donationServices.getDonationInstance(donationId);
		if (prenotation == null) {
			return false;
		}
		return principal.getUsername().equals(prenotation.getDonorMail());
	}

}
