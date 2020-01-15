package com.github.francisfire.anavis.controller;


import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.services.RequestServices;

@RestController
@RequestMapping("api/request")
public class RequestController {

	@Autowired
	private RequestServices requestServices;

	@PostMapping("")
	public boolean createRequest(@RequestBody RequestPrenotation request) {
		return requestServices.addRequest(request);
	}

	@GetMapping("/donor/{donorMail}")
	public Set<RequestPrenotation> getRequestsByDonor(@PathVariable("donorMail") String donorMail){
		return requestServices.getRequestsByDonor(donorMail);
	}
	@GetMapping("/office/{officeMail}")
	public Set<RequestPrenotation> getRequestsByOffice(@PathVariable("officeMail") String officeMail) {
		return requestServices.getRequestsByOffice(officeMail);
	}

	@GetMapping("/{requestId}")
	public RequestPrenotation getRequestById(@PathVariable("requestId") String requestId) {
		return requestServices.getRequestInstance(requestId);
	}

	@PutMapping("/{requestId}/approve")
	public boolean approveRequest(@PathVariable("requestId") String id) {
		return requestServices.approveRequest(id);
	}
	
	@PutMapping("/{requestId}/deny")
	public boolean denyRequest(@PathVariable("requestId") String id) {
		return requestServices.removeRequest(id);
	}

}
