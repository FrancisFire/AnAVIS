package com.github.francisfire.anavis;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.OfficeServices;

@SpringBootTest
public class OfficeServicesTest {

	@Autowired
	private OfficeServices officeServices;

	@Test
	public void getDonationTimeTable() {
		assertThrows(NullPointerException.class, () -> officeServices.getDonationsTimeTable(null));

		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		TimeSlot ts = new TimeSlot(today, 5);
		Office of = new Office("Roma Sud");
		Set<TimeSlot> dates = new HashSet<>();
		dates.add(ts);
		of.setDonationTimeTable(dates);
		officeServices.addOffice(of);
		assertTrue(officeServices.getDonationsTimeTable("Roma Sud").contains(ts));
		assertFalse(officeServices.getDonationsTimeTable("Roma Nord").contains(ts));
	}

	@Test
	public void getOffices() {
		assertTrue(officeServices.addOffice(new Office("Uno")));
		assertTrue(officeServices.getOffices().contains(new Office("Uno")));
		assertFalse(officeServices.getOffices().contains(new Office("Due")));
	}

	@Test
	public void addOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addOffice(null));

		assertTrue(officeServices.addOffice(new Office("Camerino")));
		assertFalse(officeServices.addOffice(new Office("Camerino")));
	}

	@Test
	public void addTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addTimeslotByOffice(null, null));
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		officeServices.addOffice(new Office("Test"));
		assertTrue(officeServices.addTimeslotByOffice(new TimeSlot(today, 5), "Test"));
		assertFalse(officeServices.addTimeslotByOffice(new TimeSlot(today, 10), "Test"));
		assertThrows(NullPointerException.class,
				() -> officeServices.addTimeslotByOffice(new TimeSlot(new Date(), 6), "TestErr"));
	}

	@Test
	public void increaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(null, null));
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		officeServices.addOffice(new Office("TestDue"));
		officeServices.addTimeslotByOffice(new TimeSlot(today, 6), "TestDue");
		assertTrue(officeServices.increaseTimeslotByOffice(today, "TestDue"));
		assertEquals(7, officeServices.getDonationsTimeTable("TestDue").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(today, "TestErr"));
	}

	@Test
	public void decreaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(null, null));
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		officeServices.addOffice(new Office("TestTre"));
		officeServices.addOffice(new Office("TestQuattro"));
		officeServices.addTimeslotByOffice(new TimeSlot(today, 6), "TestTre");
		officeServices.addTimeslotByOffice(new TimeSlot(today, 1), "TestQuattro");
		assertTrue(officeServices.decreaseTimeslotByOffice(today, "TestTre"));
		assertTrue(officeServices.decreaseTimeslotByOffice(today, "TestQuattro"));
		assertFalse(officeServices.decreaseTimeslotByOffice(today, "TestQuattro"));
		assertEquals(5, officeServices.getDonationsTimeTable("TestTre").iterator().next().getDonorSlots());
		assertEquals(0, officeServices.getDonationsTimeTable("TestQuattro").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(today, "TestErr"));
	}
}
