package com.github.francisfire.anavis.component;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class AccessCheckerComponent {

	public boolean sameUserId(UserDetails principal, String userId) {
		return principal.getUsername().equals(userId);
	}
	
}
