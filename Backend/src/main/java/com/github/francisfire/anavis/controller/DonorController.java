package com.github.francisfire.anavis.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.services.DonorServices;

@RestController
@RequestMapping("api/donor")
public class DonorController {

	private static DonorServices donorServices = DonorServices.getInstance();

	@GetMapping("/{donorId}/canDonate")
	public boolean checkDonationPossibility(@PathVariable("donorId") String donorId) {
		return donorServices.checkDonationPossibility(donorId);
	}

}
