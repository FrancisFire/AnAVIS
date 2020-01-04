package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
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

	@BeforeEach
	public void initSingleTest() {
		Office officeOne = new Office("officeOne");
		officeServices.addOffice(officeOne);
		TimeSlot timeSlotOne = new TimeSlot(new Date(6000000), 5);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(8000000), 1);
		officeServices.addTimeslotByOffice(timeSlotOne, "officeOne");
		officeServices.addTimeslotByOffice(timeSlotTwo, "officeOne");
		
		Office officeTwo = new Office("officeTwo");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotThree = new TimeSlot(new Date(2000000), 1);
		officeServices.addTimeslotByOffice(timeSlotThree, "officeTwo");
	}

	@AfterEach
	public void closeSingleTest() {
		officeServices.removeOffice("officeOne");
		officeServices.removeOffice("officeTwo");
	}
	
	@Test
	public void getDonationTimeTable() {
		assertThrows(NullPointerException.class, () -> officeServices.getDonationsTimeTable(null));

		assertTrue(officeServices.getDonationsTimeTable("officeOne").contains(new TimeSlot(new Date(6000000), 3)));
		assertFalse(officeServices.getDonationsTimeTable("officeOne").contains(new TimeSlot(new Date(7000000), 1)));
	}

	@Test
	public void getOffices() {
		assertTrue(officeServices.getOffices().contains(new Office("officeOne")));
		assertFalse(officeServices.getOffices().contains(new Office("officeErr")));
	}

	@Test
	public void addOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addOffice(null));

		assertTrue(officeServices.addOffice(new Office("officeThree")));
		assertTrue(officeServices.getOffices().contains(new Office("officeThree")));
		assertFalse(officeServices.addOffice(new Office("officeOne")));
	}

	@Test
	public void addTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addTimeslotByOffice(null, null));
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		assertTrue(officeServices.addTimeslotByOffice(new TimeSlot(today, 5), "officeOne"));
		assertFalse(officeServices.addTimeslotByOffice(new TimeSlot(today, 10), "officeOne"));
		assertThrows(NullPointerException.class,
				() -> officeServices.addTimeslotByOffice(new TimeSlot(new Date(), 6), "officeError"));
	}

	@Test
	public void increaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(null, null));
		assertTrue(officeServices.increaseTimeslotByOffice(new Date(2000000), "officeTwo"));
		assertEquals(2, officeServices.getDonationsTimeTable("officeTwo").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(new Date(2000000), "officeError"));
	}

	@Test
	public void decreaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(null, null));
		assertTrue(officeServices.decreaseTimeslotByOffice(new Date(2000000), "officeTwo"));
		assertEquals(0, officeServices.getDonationsTimeTable("officeTwo").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(new Date(2000000), "officeError"));
	}
}
