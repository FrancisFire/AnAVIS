package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.DonorServices;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class DonorServicesTest {

	private static DonorServices donorServices;
	
	@BeforeAll
	public static void setUp() {
		donorServices = DonorServices.getInstance();
	}
	
	@Test
	public void addDonor() {
		Office avisPineto = new Office("Pineto");
		assertTrue(donorServices.addDonor(new Donor("Gianni", avisPineto)));
		assertFalse(donorServices.getDonors().isEmpty());
	}
	
	@Test
	public void getOfficeIdByDonor() {
		Office avisPosillipo = new Office("Posillipo");
		donorServices.addDonor(new Donor("Lillo", avisPosillipo));
		assertEquals("Posillipo", donorServices.getOfficeIdByDonor("Lillo"));
		assertNotEquals("Posillipa", donorServices.getOfficeIdByDonor("Lillo"));
		assertEquals("", donorServices.getOfficeIdByDonor("Lilla"));
	}
	
	@Test
	public void checkDonationPossibility() {
		Office avisSasso = new Office("Sasso");
		Donor donaone = new Donor("Greg", avisSasso);
		donorServices.addDonor(donaone);
		donaone.setCanDonate(true);
		Donor donatwo = new Donor("Mimmo", avisSasso);
		donorServices.addDonor(donatwo);
		donatwo.setCanDonate(false);
		assertTrue(donorServices.checkDonationPossibility("Greg"));
		assertFalse(donorServices.checkDonationPossibility("Mimmo"));
		assertFalse(donorServices.checkDonationPossibility("Gregg"));
	}
	
}
