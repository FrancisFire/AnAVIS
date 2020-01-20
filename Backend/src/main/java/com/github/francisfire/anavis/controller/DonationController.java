package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.component.AccessCheckerComponent;
import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.models.DonationReport;
import com.github.francisfire.anavis.services.DonationReportServices;
import com.github.francisfire.anavis.services.DonationServices;

@RestController
@RequestMapping("api/donation")
public class DonationController {

	@Autowired
	private DonationServices donationServices;
	
	@Autowired
	private DonationReportServices closedPrenotationReportServices;
	
	@SuppressWarnings("unused")
	@Autowired
	private AccessCheckerComponent accessCheckerComponent;

	@PreAuthorize("@accessCheckerComponent.sameUserId(principal, #donorMail)")
	@GetMapping("/donor/{donorMail}")
	public Set<ClosedPrenotation> getDonationsByDonor(@PathVariable("donorMail") String donorMail) {
		return donationServices.getDonationsByDonor(donorMail);
	}
	
	@PreAuthorize("@accessCheckerComponent.isDonationOwnedByDonorId(principal, #donationId)")
	@GetMapping("/report/{donationId}")
	public DonationReport getDonationReport(@PathVariable("donationId") String donationId) {
		String reportId = donationServices.getDonationInstance(donationId).getReportId();
		return closedPrenotationReportServices.getReportInstance(reportId);
	}
}
