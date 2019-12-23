package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

	@GetMapping("/donor/{donorId}")
	public Set<ClosedPrenotation> getDonationsByDonor(@PathVariable("donorId") String donorId) {
		return donationServices.getDonationsByDonor(donorId);
	}
	
	@GetMapping("/report/{donationId}")
	public DonationReport getDonationReport(@PathVariable("donationId") String donationId) {
		String reportId = donationServices.getPrenotationInstance(donationId).getReportId();
		return closedPrenotationReportServices.getReport(reportId);
	}
}
