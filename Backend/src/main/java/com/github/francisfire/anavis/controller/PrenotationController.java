package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.github.francisfire.anavis.component.AccessCheckerComponent;
import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.services.DonationReportServices;
import com.github.francisfire.anavis.services.PrenotationServices;

@RestController
@RequestMapping("api/prenotation")
public class PrenotationController {

	@Autowired
	private PrenotationServices prenotationServices;

	@Autowired
	private DonationReportServices donationReportServices;

	@SuppressWarnings("unused")
	@Autowired
	private AccessCheckerComponent accessCheckerComponent;

	@PreAuthorize("hasAnyAuthority('OFFICE')")
	@PostMapping("")
	public boolean createPrenotation(@RequestBody ActivePrenotation prenotation) {
		prenotation.setId(prenotation.getDonorMail() + "-" + prenotation.getOfficeMail() + "-"
				+ prenotation.getHour().toString());
		return prenotationServices.addPrenotation(prenotation);
	}

	@PreAuthorize("@accessCheckerComponent.sameUserId(principal, #officeMail)")
	@GetMapping("/office/{officeMail}")
	public Set<ActivePrenotation> getPrenotationsByOffice(@PathVariable("officeMail") String officeMail) {
		return prenotationServices.getPrenotationsByOffice(officeMail);
	}

	@PreAuthorize("@accessCheckerComponent.sameUserId(principal, #donorMail)")
	@GetMapping("/donor/{donorMail}")
	public Set<ActivePrenotation> getPrenotationsByDonor(@PathVariable("donorMail") String donorMail) {
		return prenotationServices.getPrenotationsByDonor(donorMail);
	}

	@PreAuthorize("@accessCheckerComponent.isPrenotationInstanceOwnedByOfficeId(principal, #prenotation)")
	@PutMapping("")
	public boolean updatePrenotation(@RequestBody ActivePrenotation prenotation) {
		return prenotationServices.updatePrenotation(prenotation);
	}

	@PreAuthorize("@accessCheckerComponent.isPrenotationOwnedByDonorId(principal, #prenotationId) or @accessCheckerComponent.isPrenotationOwnedByOfficeId(principal, #prenotationId)")
	@DeleteMapping("/{prenotationId}")
	public boolean removePrenotation(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.removePrenotation(prenotationId);
	}

	@PreAuthorize("@accessCheckerComponent.isPrenotationOwnedByDonorId(principal, #prenotationId)")
	@PutMapping("/{prenotationId}/acceptChange")
	public boolean acceptPrenotationChange(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.acceptPrenotationChange(prenotationId);
	}

	@PreAuthorize("@accessCheckerComponent.isPrenotationOwnedByDonorId(principal, #prenotationId)")
	@PutMapping("/{prenotationId}/denyChange")
	public boolean denyPrenotationChange(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.denyPrenotationChange(prenotationId);
	}

	@PreAuthorize("@accessCheckerComponent.isPrenotationOwnedByOfficeId(principal, #prenotationId)")
	@PutMapping("/{prenotationId}/close")
	public boolean closePrenotation(@PathVariable("prenotationId") String prenotationId,
			@RequestParam("file") MultipartFile reportFile) {
		String reportId = donationReportServices.addReport(prenotationId, reportFile);
		return prenotationServices.closePrenotation(prenotationId, reportId);
	}
}
