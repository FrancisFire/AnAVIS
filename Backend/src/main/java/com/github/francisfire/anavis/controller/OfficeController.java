package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.OfficeServices;

@RestController
@RequestMapping("api/office")
public class OfficeController {

	@Autowired
	private OfficeServices officeServices;

	@GetMapping("")
	public Set<Office> getOffices() {
		return officeServices.getOffices();
	}

	@GetMapping("/{officeMail}/timeTable")
	public Set<TimeSlot> getDonationsTimeTable(@PathVariable("officeMail") String officeMail) {
		return officeServices.getDonationsTimeTable(officeMail);
	}
	
	@PutMapping("/{officeMail}/addTimeSlot")
	public boolean addTimeSlot(@PathVariable("officeMail") String officeMail, @RequestBody TimeSlot timeSlot) {
		return officeServices.addTimeslotByOffice(timeSlot, officeMail);
	}

	@GetMapping("/{officeMail}") public Office getOfficeByMail(@PathVariable("officeMail") String officeMail) {
		return officeServices.getOfficeInstance(officeMail);
	}
}
