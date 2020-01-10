package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.Date;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Donor.DonorCategory;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;

@SpringBootTest
public class DonationServicesTest {

	@Autowired
	private PrenotationServices prenotationServices;
	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private DonationServices donationServices;
	@Autowired
	private DonorServices donorServices;

	@BeforeEach
	public void initSingleTest() {

		Office officeOne = new Office("officeOne@office.com", "officeOne");
		officeServices.addOffice(officeOne);
		TimeSlot timeSlotOne = new TimeSlot(new Date(6000000), 5);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(8000000), 1);
		officeServices.addTimeslotByOffice(timeSlotOne, "officeOne@office.com");
		officeServices.addTimeslotByOffice(timeSlotTwo, "officeOne@office.com");

		Office officeTwo = new Office("officeTwo@office.com", "officeTwo");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotThree = new TimeSlot(new Date(2000000), 5);
		TimeSlot timeSlotFour = new TimeSlot(new Date(4000000), 1);
		officeServices.addTimeslotByOffice(timeSlotThree, "officeTwo@office.com");
		officeServices.addTimeslotByOffice(timeSlotFour, "officeTwo@office.com");

		Donor donor = new Donor("donor@gmail.com", "officeOne@office.com", DonorCategory.MAN);
		donorServices.addDonor(donor);

		ActivePrenotation prenotationOne = new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		prenotationServices.addPrenotation(prenotationOne);

		ActivePrenotation prenotationTwo = new ActivePrenotation("prenotationIdTwo", "officeOne@office.com", "donor@gmail.com",
				new Date(8000000), true);
		prenotationServices.addPrenotation(prenotationTwo);

		prenotationServices.closePrenotation("prenotationId", "reportId");
		prenotationServices.closePrenotation("prenotationIdTwo", "reportId");

	}

	@AfterEach
	public void closeSingleTest() {

		donationServices.removeDonation("prenotationId");
		donationServices.removeDonation("prenotationIdTwo");
		donorServices.removeDonor("donor@gmail.com");
		officeServices.removeOffice("officeOne@office.com");
		officeServices.removeOffice("officeTwo@office.com");
	}

	@Test
	public void getDonationInstance() {
		assertTrue(donationServices.getDonationInstance("prenotationId").equals(
				new ClosedPrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com", new Date(6000000), "reportId")));
		assertNull(donationServices.getDonationInstance("fakePrenotationId"));
	}

	@Test
	public void getDonationsByOffice() {
		ClosedPrenotation trueDonation = new ClosedPrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		ClosedPrenotation fakeDonation = new ClosedPrenotation("fakeDonationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		assertTrue(donationServices.getDonationsByOffice("officeOne@office.com").contains(trueDonation));
		assertFalse(donationServices.getDonationsByOffice("officeOne@office.com").contains(fakeDonation));
		assertTrue(donationServices.getDonationsByOffice("fakeOffice").isEmpty());
	}

	@Test
	public void getDonationsByDonor() {
		ClosedPrenotation trueDonation = new ClosedPrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		ClosedPrenotation fakeDonation = new ClosedPrenotation("fakeDonationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		assertTrue(donationServices.getDonationsByDonor("donor@gmail.com").contains(trueDonation));
		assertFalse(donationServices.getDonationsByDonor("donor@gmail.com").contains(fakeDonation));
		assertTrue(donationServices.getDonationsByDonor("fakeDonor@gmail.com").isEmpty());
	}

	@Test
	public void getDonations() {
		ClosedPrenotation trueDonation = new ClosedPrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		ClosedPrenotation fakeDonation = new ClosedPrenotation("fakeDonationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), "reportId");
		assertTrue(donationServices.getDonations().contains(trueDonation));
		assertFalse(donationServices.getDonations().contains(fakeDonation));
	}

	@Test
	public void addDonation() {
		assertThrows(NullPointerException.class, () -> donationServices.addDonation(null, null));
		ActivePrenotation prenotationThree = new ActivePrenotation("prenotationIdThree", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		assertTrue(donationServices.addDonation(prenotationThree, "reportId"));
		assertFalse(donationServices.addDonation(prenotationThree, "reportId"));
	}
}
