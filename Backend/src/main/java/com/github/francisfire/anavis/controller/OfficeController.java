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

	@GetMapping("/{officeId}/timeTable")
	public Set<TimeSlot> getDonationsTimeTable(@PathVariable("officeId") String officeId) {
		return officeServices.getDonationsTimeTable(officeId);
	}
	
	@PutMapping("/{officeId}/addTimeSlot")
	public boolean addTimeSlot(@PathVariable("officeId") String officeId, @RequestBody TimeSlot timeSlot) {
		return officeServices.addTimeslotByOffice(timeSlot, officeId);
	}

}
