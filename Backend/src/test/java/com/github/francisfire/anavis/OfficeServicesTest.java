package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.OfficeServices;

public class OfficeServicesTest {

	private static OfficeServices officeServices;

	@BeforeAll
	public static void setUp() {
		officeServices = OfficeServices.getInstance();
	}

	@Test
	public void getDonationTimeTable() {
		assertThrows(NullPointerException.class, () -> officeServices.getDonationsTimeTable(null));

		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
		Date today = calendar.getTime();
		TimeSlot ts = new TimeSlot(today, 5);
		Office of = new Office("Roma Sud");
		Set<TimeSlot> dates = new HashSet<>();
		dates.add(ts);
		of.setDonationTimeTables(dates);
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
}
