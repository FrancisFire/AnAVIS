package com.github.francisfire.anavis.controller;

import java.util.Set;

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
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.AuthCredentialsServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;

@RestController
@RequestMapping("/api/auth")
public class AuthCredentialsController {

	@Autowired
	private AuthCredentialsServices authCredentialsServices;

	@Autowired
	private DonorServices donorServices;

	@Autowired
	private OfficeServices officeServices;

	@GetMapping("/")
	public Set<AuthCredentials> getAuthCredentials() {
		return authCredentialsServices.getAuthCredentials();
	}

	@PostMapping("/donor")
	public boolean addDonorCredentials(@RequestBody UserAndDonor userAndDonor) {
		donorServices.addDonor(userAndDonor.donor);
		return authCredentialsServices.addCredentials(userAndDonor.authCredentials);
	}

	@PostMapping("/office")
	public boolean addOfficeCredentials(@RequestBody UserAndOffice userAndOffice) {
		officeServices.addOffice(userAndOffice.office);
		return authCredentialsServices.addCredentials(userAndOffice.authCredentials);
	}

	@PutMapping("/")
	public boolean updateCredentials(@RequestBody AuthCredentials authCredentials) {
		return authCredentialsServices.updateCredentials(authCredentials);
	}

	@DeleteMapping("/{mail}")
	public boolean removeCredentials(@PathVariable("mail") String mail) {
		return authCredentialsServices.removeCredentials(mail);
	}

	static class UserAndDonor {
		private Donor donor;
		private AuthCredentials authCredentials;

		public UserAndDonor(Donor donor, AuthCredentials authCredentials) {
			this.donor = donor;
			this.authCredentials = authCredentials;
		}
	}

	static class UserAndOffice {
		private Office office;
		private AuthCredentials authCredentials;

		public UserAndOffice(Office office, AuthCredentials authCredentials) {
			this.office = office;
			this.authCredentials = authCredentials;
		}
	}
}
