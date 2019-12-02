package com.github.francisfire.anavis.controller;

import java.util.Date;
import java.util.Set;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.OfficeServices;

@RestController
@RequestMapping("api/office")
public class OfficeController {

	private static OfficeServices officeServices = OfficeServices.getInstance();

	@GetMapping("")
	public Set<Office> getOffices() {
		return officeServices.getOffices();
	}

	@GetMapping("/{officeId}/timeTable")
	public Set<Date> getDonationsTimeTable(@PathVariable("officeId") String officeId) {
		return officeServices.getDonationsTimeTable(officeId);
	}

}
