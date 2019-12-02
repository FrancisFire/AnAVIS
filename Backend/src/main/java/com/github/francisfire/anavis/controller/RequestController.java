package com.github.francisfire.anavis.controller;


import java.util.Set;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.RequestServices;

@RestController
@RequestMapping("api/request")
public class RequestController {

	private static RequestServices requestServices = RequestServices.getInstance();

	@PostMapping("")
	public boolean createRequest(@RequestBody Request request) {
		return requestServices.addRequest(request);
	}

	@GetMapping("/office/{office}")
	public Set<Request> getRequestsByOffice(@PathVariable("office") String officeId) {
		return requestServices.getRequestsByOffice(officeId);
	}

	@GetMapping("/{requestId}")
	public Request getRequestById(@PathVariable("requestId") String requestId) {
		return requestServices.getRequestInstance(requestId);
	}

	@PutMapping("/{requestId}/approve")
	public boolean approveRequest(@PathVariable("requestId") String id) {
		return requestServices.approveRequest(id);
	}
	
	@PutMapping("/{requestId}/deny")
	public boolean denyRequest(@PathVariable("requestId") String id) {
		return requestServices.denyRequest(id);
	}

}
