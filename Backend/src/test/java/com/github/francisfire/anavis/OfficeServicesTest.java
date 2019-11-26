package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.OfficeServices;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class OfficeServicesTest {
	
	private static OfficeServices officeServices;
	
	@BeforeAll
	public static void setUp() {
		officeServices = OfficeServices.getInstance();
	}
	
	@Test
	public void getDonationTimeTable() {
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"),Locale.ITALY);
		Date today = calendar.getTime();
		Office of = new Office("Roma Sud");
		Set<Date> dates = new HashSet<>();
		dates.add(today);
		of.setDonationTimeTables(dates);
		officeServices.addOffice(of);
		assertTrue(officeServices.getDonationsTimeTable("Roma Sud").contains(today));
		assertFalse(officeServices.getDonationsTimeTable("Roma Nord").contains(today));
	}
	
	@Test
	public void getOffices() {
		assertTrue(officeServices.addOffice(new Office("Uno")));
		assertTrue(officeServices.getOffices().contains(new Office("Uno")));
		assertFalse(officeServices.getOffices().contains(new Office("Due")));
	}

	@Test
	public void addOffice() {
		assertTrue(officeServices.addOffice(new Office("Camerino")));
		assertFalse(officeServices.addOffice(new Office("Camerino")));
	}
}
