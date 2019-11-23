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
@RequestMapping("office")
public class OfficeController {

	private static OfficeServices officeServices = OfficeServices.getInstance();

	@GetMapping("")
	public Set<Office> getOffices() {
		return officeServices.getOffices();
	}

	@GetMapping("/{office}/timeTable")
	public Set<Date> getDonationsTimeTable(@PathVariable("office") String office) {
		return officeServices.getDonationsTimeTable(office);
	}

}
