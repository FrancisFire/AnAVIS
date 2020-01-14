package com.github.francisfire.anavis.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.repository.AuthCredentialsRepository;

@Service
public class DatabaseUserDetailsService implements UserDetailsService {

	@Autowired
	AuthCredentialsRepository authCredentialsRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		return authCredentialsRepository.findById(username).orElse(null);
	}

}
