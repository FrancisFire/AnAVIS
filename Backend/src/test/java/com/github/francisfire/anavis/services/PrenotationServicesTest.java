package com.github.francisfire.anavis.services;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;
import java.util.Set;

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
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;

@SpringBootTest
public class PrenotationServicesTest {

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

		RequestPrenotation request = new RequestPrenotation("requestId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000));
		prenotationServices.addPrenotation(request);

		ActivePrenotation prenotationOne = new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		prenotationServices.addPrenotation(prenotationOne);

		ActivePrenotation prenotationTwo = new ActivePrenotation("prenotationIdTwo", "officeOne@office.com", "donor@gmail.com",
				new Date(8000000), true);
		prenotationServices.addPrenotation(prenotationTwo);

	}

	@AfterEach
	public void closeSingleTest() {

		prenotationServices.removePrenotation("requestId");
		prenotationServices.removePrenotation("prenotationId");
		prenotationServices.removePrenotation("prenotationIdTwo");
		donorServices.removeDonor("donor@gmail.com");
		officeServices.removeOffice("officeOne@office.com");
		officeServices.removeOffice("officeTwo@office.com");
	}

	@Test
	public void getPrenotations() {
		Set<ActivePrenotation> set = prenotationServices.getPrenotations();
		assertTrue(set
				.contains(new ActivePrenotation("requestId", "officeOne@office.com", "donor@gmail.com", new Date(6000000), true)));
		assertTrue(set.contains(
				new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com", new Date(6000000), true)));
		assertFalse(set
				.contains(new ActivePrenotation("falseId", "officeOne@office.com", "donor@gmail.com", new Date(8000000), true)));

	}

	@Test
	public void addPrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.addPrenotation((RequestPrenotation) null));
		assertTrue(officeServices.isDateAvailableByOffice(new Date(6000000), "officeOne@office.com"));

		ActivePrenotation prenotationOne = new ActivePrenotation("prenotationIdOne", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		assertTrue(prenotationServices.addPrenotation(prenotationOne));
		ActivePrenotation prenotationTwo = new ActivePrenotation("prenotationIdTwo", "officeOne@office.com", "donor@gmail.com",
				new Date(8000000), true);
		assertFalse(officeServices.isDateAvailableByOffice(new Date(8000000), "officeOne@office.com"));
		assertFalse(prenotationServices.addPrenotation(prenotationTwo));

		assertFalse(prenotationServices.addPrenotation(
				new RequestPrenotation("requestId", "officeOne@office.com", "donor@gmail.com", new Date(6000000))));

	}

	@Test
	public void removePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.removePrenotation(null));

		assertTrue(prenotationServices.removePrenotation("prenotationIdTwo"));
		assertTrue(officeServices.isDateAvailableByOffice(new Date(8000000), "officeOne@office.com"));
		assertFalse(prenotationServices.removePrenotation("prenotationIdFake"));
		assertFalse(prenotationServices.removePrenotation("prenotationIdTwo"));
	}

	@Test
	public void updatePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.updatePrenotation(null));

		ActivePrenotation updatedPrenotation = new ActivePrenotation("prenotationIdTwo", "officeTwo@office.com", "donor@gmail.com",
				new Date(4000000), false);
		ActivePrenotation fakeUpdatedPrenotation = new ActivePrenotation("fakeUpdatedPrenotationId", "officeTwo@office.com",
				"donor@gmail.com", new Date(), false);

		assertFalse(officeServices.getOfficeInstance("officeOne@office.com").isDateAvailable(new Date(8000000)));
		assertTrue(officeServices.getOfficeInstance("officeTwo@office.com").isDateAvailable(new Date(4000000)));

		assertTrue(prenotationServices.updatePrenotation(updatedPrenotation));
		assertTrue(officeServices.getOfficeInstance("officeOne@office.com").isDateAvailable(new Date(8000000)));
		assertFalse(officeServices.getOfficeInstance("officeTwo@office.com").isDateAvailable(new Date(4000000)));
		assertFalse(prenotationServices.updatePrenotation(fakeUpdatedPrenotation));

	}

	@Test
	public void getPrenotationsByOffice() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByOffice(null));

		ActivePrenotation truePrenotation = new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		ActivePrenotation fakePrenotation = new ActivePrenotation("fakePrenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);

		assertTrue(prenotationServices.getPrenotationsByOffice("officeOne@office.com").contains(truePrenotation));
		assertFalse(prenotationServices.getPrenotationsByOffice("officeOne@office.com").contains(fakePrenotation));
		assertTrue(prenotationServices.getPrenotationsByOffice("fakeOffice").isEmpty());
	}

	@Test
	public void getPrenotationsByDonor() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByDonor(null));

		ActivePrenotation truePrenotation = new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		ActivePrenotation fakePrenotation = new ActivePrenotation("fakePrenotationId", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), true);
		assertTrue(prenotationServices.getPrenotationsByDonor("donor@gmail.com").contains(truePrenotation));
		assertFalse(prenotationServices.getPrenotationsByDonor("donor@gmail.com").contains(fakePrenotation));
		assertTrue(prenotationServices.getPrenotationsByDonor("fakeDonor@gmail.com").isEmpty());

	}

	@Test
	public void acceptPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.acceptPrenotationChange(null));

		ActivePrenotation prenotation = new ActivePrenotation("notConfirmedPrenotation", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), false);
		prenotationServices.addPrenotation(prenotation);

		assertTrue(prenotationServices.acceptPrenotationChange("notConfirmedPrenotation"));
		assertTrue(prenotationServices.getPrenotationInstance("notConfirmedPrenotation").isConfirmed());
		assertFalse(prenotationServices.acceptPrenotationChange("notConfirmedPrenotation"));
		assertFalse(prenotationServices.acceptPrenotationChange("notExistingPrenotation"));

	}

	@Test
	public void denyPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.denyPrenotationChange(null));

		ActivePrenotation prenotation = new ActivePrenotation("confirmedPrenotation", "officeOne@office.com", "donor@gmail.com",
				new Date(6000000), false);
		prenotationServices.addPrenotation(prenotation);

		assertTrue(prenotationServices.denyPrenotationChange("confirmedPrenotation"));
		assertFalse(prenotationServices.acceptPrenotationChange("confirmedPrenotation"));
		assertFalse(prenotationServices.acceptPrenotationChange("notExistingPrenotation"));
	}

	@Test
	public void closePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.closePrenotation(null, null));

		assertTrue(prenotationServices.closePrenotation("prenotationId", "reportId"));
		assertFalse(prenotationServices.closePrenotation("prenotationId", "reportId"));
		assertTrue(donationServices.getDonationsByDonor("donor@gmail.com").contains(
				new ClosedPrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com", new Date(6000000), "reportId")));
		assertFalse(prenotationServices.getPrenotationsByDonor("close@gmail.com").contains(
				new ActivePrenotation("prenotationId", "officeOne@office.com", "donor@gmail.com", new Date(6000000), true)));
		assertFalse(donorServices.checkDonationPossibility("donor@gmail.com"));
	}
}
