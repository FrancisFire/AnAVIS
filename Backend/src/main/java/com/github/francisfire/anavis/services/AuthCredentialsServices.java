package com.github.francisfire.anavis.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.repository.AuthCredentialsRepository;

import lombok.NonNull;

@Service
public class AuthCredentialsServices {

	@Autowired
	private AuthCredentialsRepository repository;

	public List<AuthCredentials> getAuthCredentials() {
		return repository.findAll();
	}

	public boolean addDonorCredentials(@NonNull AuthCredentials authCredentials) {
		repository.insert(authCredentials);
		return true;
	}

	public boolean updateDonorCredentials(@NonNull AuthCredentials authCredentials) {
		repository.save(authCredentials);
		return false;
	}

	public boolean removeDonorCredentials(@NonNull String email) {
		repository.delete(getAuthCredentialsInstance(email));
		return false;
	}

	public AuthCredentials getAuthCredentialsInstance(@NonNull String email) {
		return repository.findById(email).orElse(null);
	}

}
