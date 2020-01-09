package com.github.francisfire.anavis.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.services.AuthCredentialsServices;
import com.github.francisfire.anavis.services.DonorServices;

@RestController
@RequestMapping("/api/auth")
public class AuthCredentialsController {

	@Autowired
	private AuthCredentialsServices authCredentialsServices;

	@Autowired
	private DonorServices donorServices;

	@GetMapping("/")
	public List<AuthCredentials> getAuthCredentials() {
		return authCredentialsServices.getAuthCredentials();
	}

	@PostMapping("/")
	public boolean addDonorCredentials(@RequestBody UserAndDonor userAndDonor) {
		donorServices.addDonor(userAndDonor.donor);
		return authCredentialsServices.addDonorCredentials(userAndDonor.authCredentials);
	}

	@PutMapping("/")
	public boolean updateDonorCredentials(@RequestBody AuthCredentials authCredentials) {
		return authCredentialsServices.updateDonorCredentials(authCredentials);
	}

	@DeleteMapping("/{email}")
	public boolean removeDonorCredentials(@PathVariable("email") String email) {
		donorServices.removeDonor(email);
		return authCredentialsServices.removeDonorCredentials(email);
	}

	static class UserAndDonor {
		private Donor donor;
		private AuthCredentials authCredentials;
	}

}
