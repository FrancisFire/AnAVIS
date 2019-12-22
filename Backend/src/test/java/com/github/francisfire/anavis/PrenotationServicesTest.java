package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Date;
import java.util.Set;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;

public class PrenotationServicesTest {

	private static PrenotationServices prenotationServices;
	private static OfficeServices officeServices;
	private static DonationServices donationServices;

	@BeforeAll
	public static void setUp() {
		prenotationServices = PrenotationServices.getInstance();
		officeServices = OfficeServices.getInstance();
		donationServices = DonationServices.getInstance();
	}

	@Test
	public void getPrenotations() {

		Office office = new Office("Pineto");
		officeServices.addOffice(office);

		TimeSlot timeSlot = new TimeSlot(new Date(8000000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		RequestPrenotation request = new RequestPrenotation("id4", "Pineto", "gianni@gmail.com", new Date(8000000));
		prenotationServices.addPrenotation(request);

		Set<ActivePrenotation> set = prenotationServices.getPrenotations();
		assertTrue(set.contains(new ActivePrenotation("id4", "Pineto", "gianni@gmail.com", new Date(8000000), true)));
		assertFalse(set.contains(new ActivePrenotation("id10", "Pineto", "gianni@gmail.com", new Date(8000000), true)));

	}

	@Test
	public void addPrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.addPrenotation((RequestPrenotation) null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(6000000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		RequestPrenotation request = new RequestPrenotation("id5", "Pineto", "gianni@gmail.com", new Date(6000000));
		assertTrue(officeServices.isDateAvailableByOffice(new Date(6000000), "Pineto"));
		assertTrue(prenotationServices.addPrenotation(request));
		assertFalse(officeServices.isDateAvailableByOffice(new Date(6000000), "Pineto"));
		assertFalse(prenotationServices.addPrenotation(request));

		TimeSlot timeSlotTwo = new TimeSlot(new Date(7000000), 1);
		officeServices.addTimeslotByOffice(timeSlotTwo, "Pineto");

		ActivePrenotation prenotation = new ActivePrenotation("id10", "Pineto", "gianni@gmail.com", new Date(7000000), true);
		assertTrue(officeServices.isDateAvailableByOffice(new Date(7000000), "Pineto"));
		assertTrue(prenotationServices.addPrenotation(prenotation));
		assertFalse(officeServices.isDateAvailableByOffice(new Date(7000000), "Pineto"));
		assertFalse(prenotationServices.addPrenotation(prenotation));

	}

	@Test
	public void removePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.removePrenotation(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(9100000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		ActivePrenotation prenotation = new ActivePrenotation("id21", "Pineto", "gianni@gmail.com", new Date(9100000), true);
		prenotationServices.addPrenotation(prenotation);
		assertFalse(officeServices.isDateAvailableByOffice(new Date(9100000), "Pineto"));
		assertTrue(prenotationServices.removePrenotation("id21"));
		assertTrue(officeServices.isDateAvailableByOffice(new Date(9100000), "Pineto"));
		assertFalse(prenotationServices.removePrenotation("id21"));
		assertFalse(prenotationServices.removePrenotation("id2"));
	}

	@Test
	public void updatePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.updatePrenotation(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(3000000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		Office officeTwo = new Office("Roma");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(2000000), 1);
		officeServices.addTimeslotByOffice(timeSlotTwo, "Roma");

		ActivePrenotation prenotation = new ActivePrenotation("id1", "Pineto", "gianni@gmail.com", new Date(3000000), true);
		ActivePrenotation updatedPrenotation = new ActivePrenotation("id1", "Roma", "gianni@gmail.com",
				new Date(2000000), false);
		ActivePrenotation wrongPrenotation = new ActivePrenotation("id2", "Roma", "gianni@gmail.com", new Date(), false);
		prenotationServices.addPrenotation(prenotation);
		assertFalse(officeServices.getOfficeInstance("Pineto").isDateAvailable(new Date(3000000)));
		assertTrue(officeServices.getOfficeInstance("Roma").isDateAvailable(new Date(2000000)));
		assertFalse(prenotationServices.updatePrenotation(prenotation));
		assertTrue(prenotationServices.updatePrenotation(updatedPrenotation));
		assertTrue(officeServices.getOfficeInstance("Pineto").isDateAvailable(new Date(3000000)));
		assertFalse(officeServices.getOfficeInstance("Roma").isDateAvailable(new Date(2000000)));
		assertFalse(prenotationServices.updatePrenotation(wrongPrenotation));

	}

	@Test
	public void getPrenotationsByOffice() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByOffice(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(3000000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		Office officeTwo = new Office("Roma");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(2000000), 1);
		officeServices.addTimeslotByOffice(timeSlotTwo, "Roma");

		ActivePrenotation prenotationOne = new ActivePrenotation("id11", "Pineto", "gianni@gmail.com",
				new Date(3000000), true);
		prenotationServices.addPrenotation(prenotationOne);
		ActivePrenotation prenotationTwo = new ActivePrenotation("id12", "Roma", "gianni@gmail.com", new Date(2000000), true);
		prenotationServices.addPrenotation(prenotationTwo);

		assertTrue(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationOne));
		assertFalse(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationTwo));
	}

	@Test
	public void getPrenotationsByDonor() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByDonor(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(4000000), 3);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		ActivePrenotation prenotationOne = new ActivePrenotation("id13", "Pineto", "panino@gmail.com",
				new Date(4000000), true);
		prenotationServices.addPrenotation(prenotationOne);
		ActivePrenotation prenotationTwo = new ActivePrenotation("id14", "Pineto", "panino@gmail.com",
				new Date(4000000), true);
		prenotationServices.addPrenotation(prenotationTwo);
		ActivePrenotation prenotationThree = new ActivePrenotation("id15", "Pineto", "salame@gmail.com",
				new Date(4000000), true);
		prenotationServices.addPrenotation(prenotationThree);

		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationOne));
		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationTwo));
		assertFalse(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationThree));

	}

	@Test
	public void acceptPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.acceptPrenotationChange(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(9200000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		ActivePrenotation prenotationOne = new ActivePrenotation("id16", "Pineto", "panino@gmail.com",
				new Date(9200000), true);
		prenotationServices.addPrenotation(prenotationOne);
		assertFalse(prenotationServices.acceptPrenotationChange("id16"));
		assertFalse(prenotationServices.acceptPrenotationChange("id54"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.acceptPrenotationChange("id16"));
		assertTrue(prenotationServices.getPrenotationInstance("id16").isConfirmed());
	}

	@Test
	public void denyPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.denyPrenotationChange(null));

		Office office = new Office("Pineto");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(9300000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Pineto");

		ActivePrenotation prenotationOne = new ActivePrenotation("id17", "Pineto", "panino@gmail.com",
				new Date(9300000), true);
		prenotationServices.addPrenotation(prenotationOne);
		assertTrue(prenotationServices.getPrenotationInstance("id17").isConfirmed());
		assertFalse(prenotationServices.denyPrenotationChange("id17"));
		assertFalse(prenotationServices.denyPrenotationChange("id28"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.denyPrenotationChange("id17"));
	}

	@Test
	public void closePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.closePrenotation(null, null));

		Office office = new Office("Close");
		String id = "sas";
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(420), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Close");
		ClosedPrenotation prenotationClosed = new ClosedPrenotation("idclose", "Close", "close@gmail.com",
				new Date(420), id);
		ActivePrenotation prenotationActive = new ActivePrenotation("idclose", "Close", "close@gmail.com",
				new Date(420), true);
		prenotationServices.addPrenotation(prenotationActive);
		
		assertTrue(prenotationServices.closePrenotation("idclose", id));
		assertFalse(prenotationServices.closePrenotation("idclose", id));
		assertTrue(donationServices.getDonationsByDonor("close@gmail.com").contains(prenotationClosed));
		assertFalse(prenotationServices.getPrenotationsByDonor("close@gmail.com").contains(prenotationActive));
	}
}
