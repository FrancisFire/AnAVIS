package com.github.francisfire.anavis.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.component.AccessCheckerComponent;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.services.RequestServices;

@RestController
@RequestMapping("api/request")
public class RequestController {

	@Autowired
	private RequestServices requestServices;

	@SuppressWarnings("unused")
	@Autowired
	private AccessCheckerComponent accessCheckerComponent;

	@PreAuthorize("hasAuthority('DONOR')")
	@PostMapping("")
	public boolean createRequest(@RequestBody RequestPrenotation request) {
		return requestServices.addRequest(request);
	}

	@PreAuthorize("@accessCheckerComponent.sameUserId(principal, #donorMail)")
	@GetMapping("/donor/{donorMail}")
	public Set<RequestPrenotation> getRequestsByDonor(@PathVariable("donorMail") String donorMail) {
		return requestServices.getRequestsByDonor(donorMail);

	}

	@PreAuthorize("@accessCheckerComponent.sameUserId(principal, #officeMail)")
	@GetMapping("/office/{officeMail}")
	public Set<RequestPrenotation> getRequestsByOffice(@PathVariable("officeMail") String officeMail) {
		return requestServices.getRequestsByOffice(officeMail);
	}

	@PreAuthorize("@accessCheckerComponent.isRequestOwnedByDonorId(principal, #requestId) or @accessCheckerComponent.isRequestOwnedByOfficeId(principal, #requestId)")
	@GetMapping("/{requestId}")
	public RequestPrenotation getRequestById(@PathVariable("requestId") String requestId) {
		return requestServices.getRequestInstance(requestId);
	}

	@PreAuthorize("@accessCheckerComponent.isRequestOwnedByOfficeId(principal, #requestId)")
	@PutMapping("/{requestId}/approve")
	public boolean approveRequest(@PathVariable("requestId") String requestId) {
		return requestServices.approveRequest(requestId);
	}

	@PreAuthorize("@accessCheckerComponent.isRequestOwnedByOfficeId(principal, #requestId)")
	@PutMapping("/{requestId}/deny")
	public boolean denyRequest(@PathVariable("requestId") String requestId) {
		return requestServices.removeRequest(requestId);
	}

}
