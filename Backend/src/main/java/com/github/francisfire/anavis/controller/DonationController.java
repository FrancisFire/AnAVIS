package com.github.francisfire.anavis.controller;

import java.io.File;
import java.util.Set;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.services.DonationServices;

@RestController
@RequestMapping("api/donation")
public class DonationController {

	private static DonationServices donationServices = DonationServices.getInstance();

	@GetMapping("/donor/{donorId}")
	public Set<ClosedPrenotation> getPrenotationsByDonor(@PathVariable("donorId") String donorId) {
		return donationServices.getDonationsByDonor(donorId);
	}
	
	@GetMapping("/report/{donationId}")
	public File getDonationReport(@PathVariable("donationId") String donationId) {
		String reportId = donationServices.getPrenotationInstance(donationId).getReportId();
		// TODO get file
		return null;
	}
}
