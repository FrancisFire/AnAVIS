package com.github.francisfire.anavis.component;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.models.AuthCredentials.Role;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Donor.DonorCategory;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;
import com.github.francisfire.anavis.services.RequestServices;

@SpringBootTest
public class AccessCheckerComponentTest {

	@Autowired
	private AccessCheckerComponent accessCheckerComponent;

	@Autowired
	private DonorServices donorServices;

	@Autowired
	private OfficeServices officeServices;

	@Autowired
	private RequestServices requestServices;

	@Autowired
	private PrenotationServices prenotationServices;

	@Autowired
	private DonationServices donationServices;

	@BeforeEach
	public void initSingleTest() {
		Donor donor = new Donor("test@donor.com", "test@office.com", DonorCategory.MAN);
		donor.setCanDonate(true);
		donorServices.addDonor(donor);
		Office office = new Office("test@office.com", "Test");
		officeServices.addOffice(office);
		officeServices.addTimeslotByOffice(new TimeSlot(new Date(1000000), 5), "test@office.com");
		RequestPrenotation request = new RequestPrenotation("1", "test@office.com", "test@donor.com",
				new Date(1000000));
		requestServices.addRequest(request);
		ActivePrenotation prenotation = new ActivePrenotation("1", "test@office.com", "test@donor.com",
				new Date(1000000), true);
		prenotationServices.addPrenotation(prenotation);
		donationServices.addDonation(prenotation, "report");
	}

	@AfterEach
	public void closeSingleTest() {
		requestServices.removeRequest("1");
		prenotationServices.removePrenotation("1");
		donationServices.removeDonation("1");
		officeServices.removeOffice("test@office.com");
		donorServices.removeDonor("test@donor.com");
	}

	@Test
	public void sameUserId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		assertTrue(accessCheckerComponent.sameUserId(authCredentialsOne, "test@donor.com"));
		assertFalse(accessCheckerComponent.sameUserId(authCredentialsOne, "test2@donor.com"));
	}

	@Test
	public void isDonationOwnedByDonorId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@donor.com", "sasso", Role.DONOR);
		assertTrue(accessCheckerComponent.isDonationOwnedByDonorId(authCredentialsOne, "1"));
		assertFalse(accessCheckerComponent.isDonationOwnedByDonorId(authCredentialsTwo, "1"));
	}

	@Test
	public void isPrenotationOwnedByOfficeId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@office.com", "sasso", Role.OFFICE);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@office.com", "sasso", Role.OFFICE);
		assertTrue(accessCheckerComponent.isPrenotationOwnedByOfficeId(authCredentialsOne, "1"));
		assertFalse(accessCheckerComponent.isPrenotationOwnedByOfficeId(authCredentialsTwo, "1"));
	}
	
	@Test
	public void isPrenotationOwnedByDonorId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@donor.com", "sasso", Role.DONOR);
		assertTrue(accessCheckerComponent.isPrenotationOwnedByDonorId(authCredentialsOne, "1"));
		assertFalse(accessCheckerComponent.isPrenotationOwnedByDonorId(authCredentialsTwo, "1"));
	}
	
	@Test
	public void isRequestOwnedByDonorId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@donor.com", "sasso", Role.DONOR);
		assertTrue(accessCheckerComponent.isRequestOwnedByDonorId(authCredentialsOne, "1"));
		assertFalse(accessCheckerComponent.isRequestOwnedByDonorId(authCredentialsTwo, "1"));
	}
	
	@Test
	public void isRequestOwnedByOfficeId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@office.com", "sasso", Role.OFFICE);
		AuthCredentials authCredentialsTwo = new AuthCredentials("test2@office.com", "sasso", Role.OFFICE);
		assertTrue(accessCheckerComponent.isRequestOwnedByOfficeId(authCredentialsOne, "1"));
		assertFalse(accessCheckerComponent.isRequestOwnedByOfficeId(authCredentialsTwo, "1"));
	}
	
	@Test
	public void isPrenotationInstanceOwnedByOfficeId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@office.com", "sasso", Role.OFFICE);
		assertFalse(accessCheckerComponent.isPrenotationInstanceOwnedByOfficeId(authCredentialsOne, prenotationServices.getPrenotationInstance("2")));
	}
	
	@Test
	public void isPrenotationInstanceOwnedByDonorId() {
		AuthCredentials authCredentialsOne = new AuthCredentials("test@donor.com", "sasso", Role.DONOR);
		assertFalse(accessCheckerComponent.isPrenotationInstanceOwnedByDonorId(authCredentialsOne, prenotationServices.getPrenotationInstance("2")));
	}
}
