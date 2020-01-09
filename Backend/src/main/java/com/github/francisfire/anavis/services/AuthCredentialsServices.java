package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.repository.AuthCredentialsRepository;

import lombok.NonNull;

@Service
public class AuthCredentialsServices {

	@Autowired
	private AuthCredentialsRepository repository;

	/**
	 * Returns a view of the collection of authcredentials, modifying this view
	 * won't have effects on the original collection, however modifying the objects
	 * in it will have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the authcredentials collection
	 */
	public Set<AuthCredentials> getAuthCredentials() {
		return new HashSet<AuthCredentials>(repository.findAll());
	}

	/**
	 * Adds credentials to the credentials collection
	 * 
	 * @throws NullPointerException if credentials is null
	 * @param authCredentials the credentials to add
	 * @return true if the collection didn't contain the added credentials
	 */
	public boolean addDonorCredentials(@NonNull AuthCredentials authCredentials) {
		if (repository.existsById(authCredentials.getEmail())) {
			return false;
		} else {
			repository.insert(authCredentials);
			return true;
		}
	}

	/**
	 * Updates the credentials passed in input to the method in the credentials
	 * collection
	 * 
	 * 
	 * @throws NullPointerException if credentials are null
	 * @param credentials the credentials to update
	 * @return true if the credentials were present and updated succesfully, false
	 *         otherwise
	 */
	public boolean updateDonorCredentials(@NonNull AuthCredentials authCredentials) {
		AuthCredentials oldAuthCredentials = getAuthCredentialsInstance(authCredentials.getEmail());
		if (oldAuthCredentials == null) {
			return false;
		}
		repository.save(authCredentials);
		return false;
	}

	/**
	 * Removes the credentials assigned to the email from the credentials collection
	 * 
	 * @throws NullPointerException if email is null
	 * @param email the email of the credentials to remove
	 * @return true if the collections contained the credentials
	 */
	public boolean removeDonorCredentials(@NonNull String email) {
		AuthCredentials oldAuthCredentials = getAuthCredentialsInstance(email);
		if (oldAuthCredentials == null) {
			return false;
		}
		repository.delete(getAuthCredentialsInstance(email));
		return false;
	}

	/**
	 * Gets the AuthCredentials instance associated to the email that has been
	 * passed in input to the method
	 * 
	 * @throws NullPointerException if email is null
	 * @param email id of the credentials
	 * @return the AuthCredentials object if present in the collection, null
	 *         otherwise
	 */
	public AuthCredentials getAuthCredentialsInstance(@NonNull String email) {
		return repository.findById(email).orElse(null);
	}

}
