package com.github.francisfire.anavis.component;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class AccessCheckerComponent {

	public boolean sameDonorId(UserDetails principal, String donorId) {
		return principal.getUsername().equals(donorId);
	}
	
}
