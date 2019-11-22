package com.github.francisfire.anavis.controller;

import java.util.List;

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
@RequestMapping("request")
public class RequestController {

	private static RequestServices requestServices = RequestServices.getInstance();

	@PostMapping("")
	public boolean createRequest(@RequestBody Request request) {
		return requestServices.addRequest(request);
	}

	@GetMapping("/office/{office}")
	public List<Request> getRequestsByOffice(@PathVariable("office") String office) {
		return requestServices.getRequests(office);
	}

	@GetMapping("/{id}")
	public Request getRequestById(@PathVariable("id") String id) {
		return requestServices.getRequest(id);
	}

	@PutMapping("/{id}/approve")
	public boolean approveRequest(@PathVariable("id") String id) {
		return requestServices.approveRequest(id);
	}
	
	@PutMapping("/{id}/deny")
	public boolean denyRequest(@PathVariable("id") String id) {
		return requestServices.denyRequest(id);
	}

}
