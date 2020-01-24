package com.github.francisfire.anavis.services;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.models.AuthCredentials.Role;
import com.github.francisfire.anavis.services.AuthCredentialsServices;

@SpringBootTest
public class AuthCredentialsServicesTest {

	@Autowired
	private AuthCredentialsServices authCredentialsServices;

	@BeforeEach
	public void initSingleTest() {

		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		authCredentialsServices.addCredentials(authCredentialsOne);

	}

	@AfterEach
	public void closeSingleTest() {
		authCredentialsServices.removeCredentials("test@donor.com");
		authCredentialsServices.removeCredentials("test2@donor.com");
	}

	@Test
	public void loginWithCredentials() {
		assertThrows(NullPointerException.class, () -> authCredentialsServices.loginWithCredentials(null));

		AuthCredentials nonExistentCredentials = new AuthCredentials("nope@donor.com", "nope", Role.DONOR);
		AuthCredentials wrongPasswordCredentials = new AuthCredentials("test@donor.com", "sassi", Role.DONOR);
		AuthCredentials correctCredentials = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);

		assertNull(authCredentialsServices.loginWithCredentials(nonExistentCredentials));
		assertNull(authCredentialsServices.loginWithCredentials(wrongPasswordCredentials));
		assertEquals(authCredentialsServices.loginWithCredentials(correctCredentials), Role.DONOR);
	}

	@Test
	public void getAuthCredentials() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@donor.com", "sasso", Role.DONOR);

		assertTrue(authCredentialsServices.getAuthCredentials().contains(authCredentialsOne));
		assertFalse(authCredentialsServices.getAuthCredentials().contains(authCredentialsTwo));

		authCredentialsServices.addCredentials(authCredentialsTwo);
		assertTrue(authCredentialsServices.getAuthCredentials().contains(authCredentialsTwo));

		authCredentialsServices.removeCredentials("test2@donor.com");
		assertFalse(authCredentialsServices.getAuthCredentials().contains(authCredentialsTwo));
	}

	@Test
	public void addCredentials() {
		assertThrows(NullPointerException.class, () -> authCredentialsServices.addCredentials(null));

		AuthCredentials authCredentialsOne = new AuthCredentials("test2@donor.com", "sasso", Role.DONOR);

		assertTrue(authCredentialsServices.addCredentials(authCredentialsOne));
		assertFalse(authCredentialsServices.addCredentials(authCredentialsOne));
	}
	
	@Test
	public void updateCredentials() {
		assertThrows(NullPointerException.class, () -> authCredentialsServices.updateCredentials(null));
		
		AuthCredentials modifiedCredentials = new AuthCredentials("test@donor.com", "prasso", Role.DONOR);
		AuthCredentials nonExistentCredentials = new AuthCredentials("test2@donor.com", "prasso", Role.DONOR);
		
		assertTrue(authCredentialsServices.updateCredentials(modifiedCredentials));
		assertFalse(authCredentialsServices.updateCredentials(nonExistentCredentials));
	}
	
	@Test
	public void removeCredentials() {
		assertThrows(NullPointerException.class, () -> authCredentialsServices.removeCredentials(null));
		
		assertTrue(authCredentialsServices.removeCredentials("test@donor.com"));
		assertFalse(authCredentialsServices.removeCredentials("test@donor.com"));
	}
	
	@Test
	public void getAuthCredentialsInstance() {
		assertThrows(NullPointerException.class, () -> authCredentialsServices.getAuthCredentialsInstance(null));
		
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		
		assertEquals(authCredentialsServices.getAuthCredentialsInstance("test@donor.com"), authCredentialsOne);
		assertNull(authCredentialsServices.getAuthCredentialsInstance("test2@donor.com"));
	}
	
	@Test
	public void loadByUserName() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		
		assertEquals(authCredentialsServices.loadUserByUsername("test@donor.com"), authCredentialsOne);
		assertNull(authCredentialsServices.loadUserByUsername("test2@donor.com"));
	}

}
