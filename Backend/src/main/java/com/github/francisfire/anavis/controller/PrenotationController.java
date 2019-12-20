package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.services.PrenotationServices;

@RestController
@RequestMapping("api/prenotation")
public class PrenotationController {

	private static PrenotationServices prenotationServices = PrenotationServices.getInstance();

	@PostMapping("")
	public boolean createPrenotation(@RequestBody ActivePrenotation prenotation) {
		return prenotationServices.addPrenotation(prenotation);
	}

	@GetMapping("/office/{officeId}")
	public Set<ActivePrenotation> getPrenotationsByOffice(@PathVariable("officeId") String officeId) {
		return prenotationServices.getPrenotationsByOffice(officeId);
	}

	@GetMapping("/donor/{donorId}")
	public Set<ActivePrenotation> getPrenotationsByDonor(@PathVariable("donorId") String donorId) {
		return prenotationServices.getPrenotationsByDonor(donorId);
	}

	@PutMapping("")
	public boolean updatePrenotation(
			@RequestBody ActivePrenotation prenotation) {
		return prenotationServices.updatePrenotation(prenotation);
	}

	@DeleteMapping("/{prenotationId}")
	public boolean removePrenotation(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.removePrenotation(prenotationId);
	}

	@PutMapping("/{prenotationId}/acceptChange")
	public boolean acceptPrenotationChange(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.acceptPrenotationChange(prenotationId);
	}

	@PutMapping("/{prenotationId}/denyChange")
	public boolean denyPrenotationChange(@PathVariable("prenotationId") String prenotationId) {
		return prenotationServices.denyPrenotationChange(prenotationId);
	}
	
	@PutMapping("/{prenotationId}/close")
	public boolean closePrenotation(@PathVariable("prenotationId") String prenotationId, @RequestBody String reportId) {
		// TODO file handling
		return prenotationServices.closePrenotation(prenotationId, reportId);
	}
}
