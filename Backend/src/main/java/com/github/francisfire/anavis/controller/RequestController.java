package com.github.francisfire.anavis.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.RequestServices;

@RestController
@RequestMapping("request")
public class RequestController {
	
	private static RequestServices requestServices = RequestServices.getInstance();

	@PostMapping("/")
	public boolean addRequest(@RequestBody Request request) {
		return requestServices.addRequest(request);
	}
	
	@GetMapping("/{office}")
	public List<Request> getRequests(@RequestParam String office) {
		return requestServices.getRequests(office);
	}
	
}
