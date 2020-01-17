package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.component.AccessCheckerComponent;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.services.DonorServices;

@RestController
@RequestMapping("api/donor")
public class DonorController {

	@Autowired
	private DonorServices donorServices;
	@SuppressWarnings("unused")
	@Autowired
	private AccessCheckerComponent accessCheckerComponent;

	@PreAuthorize("hasAuthority('OFFICE') or @accessCheckerComponent.sameDonorId(principal, #donorMail)")
	@GetMapping("/{donorMail}/canDonate")
	public boolean checkDonationPossibility(@PathVariable("donorMail") String donorMail) {
		return donorServices.checkDonationPossibility(donorMail);
	}

	@GetMapping("/office/{officeMail}/available")
	public Set<Donor> getAvailableDonorsByOfficeId(@PathVariable("officeMail") String officeMail) {
		return donorServices.getAvailableDonorsByOfficeId(officeMail);
	}
	
	@GetMapping("/{donorMail}") public Donor getDonorByMail(@PathVariable("donorMail") String donorMail) {
		return donorServices.getDonorInstance(donorMail);
	}

}
