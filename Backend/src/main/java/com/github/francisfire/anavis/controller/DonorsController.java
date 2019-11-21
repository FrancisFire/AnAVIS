package com.github.francisfire.anavis.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("donors")
public class DonorsController {

	@GetMapping("/canDonate/{mail}")
	public String checkDonationPossibility(@PathVariable("mail") String mail) {
		return "sas" + mail;
	}
	
}
