package com.github.francisfire.anavis.services;

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
		Office officeOne = new Office("officeOne@office.com", "officeOne");
		officeServices.addOffice(officeOne);
		TimeSlot timeSlotOne = new TimeSlot(new Date(6000000), 5);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(8000000), 1);
		officeServices.addTimeslotByOffice(timeSlotOne, "officeOne@office.com");
		officeServices.addTimeslotByOffice(timeSlotTwo, "officeOne@office.com");
		
		Office officeTwo = new Office("officeTwo@office.com", "officeTwo");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotThree = new TimeSlot(new Date(2000000), 1);
		officeServices.addTimeslotByOffice(timeSlotThree, "officeTwo@office.com");
	}

	@AfterEach
	public void closeSingleTest() {
		officeServices.removeOffice("officeOne@office.com");
		officeServices.removeOffice("officeTwo@office.com");
	}
	
	@Test
	public void getDonationTimeTable() {
		assertThrows(NullPointerException.class, () -> officeServices.getDonationsTimeTable(null));

		assertTrue(officeServices.getDonationsTimeTable("officeOne@office.com").contains(new TimeSlot(new Date(6000000), 3)));
		assertFalse(officeServices.getDonationsTimeTable("officeOne@office.com").contains(new TimeSlot(new Date(7000000), 1)));
	}

	@Test
	public void getOffices() {
		assertTrue(officeServices.getOffices().contains(new Office("officeOne@office.com", "officeOne")));
		assertFalse(officeServices.getOffices().contains(new Office("officeErr@office.com", "officeErr")));
	}

	@Test
	public void addOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addOffice(null));

		assertTrue(officeServices.addOffice(new Office("officeThree@office.com", "officeThree")));
		assertTrue(officeServices.getOffices().contains(new Office("officeThree@office.com", "officeThree")));
		assertFalse(officeServices.addOffice(new Office("officeOne@office.com", "officeOne")));
	}

	@Test
	public void addTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.addTimeslotByOffice(null, null));
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		assertTrue(officeServices.addTimeslotByOffice(new TimeSlot(today, 5), "officeOne@office.com"));
		assertFalse(officeServices.addTimeslotByOffice(new TimeSlot(today, 10), "officeOne@office.com"));
		assertThrows(NullPointerException.class,
				() -> officeServices.addTimeslotByOffice(new TimeSlot(new Date(), 6), "officeError@office.com"));
	}

	@Test
	public void increaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(null, null));
		assertTrue(officeServices.increaseTimeslotByOffice(new Date(2000000), "officeTwo@office.com"));
		assertEquals(2, officeServices.getDonationsTimeTable("officeTwo@office.com").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.increaseTimeslotByOffice(new Date(2000000), "officeError@office.com"));
	}

	@Test
	public void decreaseTimeslotByOffice() {
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(null, null));
		assertTrue(officeServices.decreaseTimeslotByOffice(new Date(2000000), "officeTwo@office.com"));
		assertEquals(0, officeServices.getDonationsTimeTable("officeTwo@office.com").iterator().next().getDonorSlots());
		assertThrows(NullPointerException.class, () -> officeServices.decreaseTimeslotByOffice(new Date(2000000), "officeError@office.com"));
	}
}
