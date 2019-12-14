package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.services.DonorServices;

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
		assertThrows(NullPointerException.class, () -> donorServices.addDonor(null));

		Office avisPineto = new Office("Pineto");
		assertTrue(donorServices.addDonor(new Donor("Gianni", avisPineto.getName())));
		assertFalse(donorServices.getDonors().isEmpty());
	}

	@Test
	public void getOfficeIdByDonor() {
		assertThrows(NullPointerException.class, () -> donorServices.getOfficeIdByDonor(null));

		Office avisPosillipo = new Office("Posillipo");
		donorServices.addDonor(new Donor("Lillo", avisPosillipo.getName()));
		assertEquals("Posillipo", donorServices.getOfficeIdByDonor("Lillo"));
		assertNotEquals("Posillipa", donorServices.getOfficeIdByDonor("Lillo"));
		assertNull(donorServices.getOfficeIdByDonor("Lilla"));
	}

	@Test
	public void checkDonationPossibility() {
		assertThrows(NullPointerException.class, () -> donorServices.checkDonationPossibility(null));

		Office avisSasso = new Office("Sasso");
		Donor donaone = new Donor("Greg", avisSasso.getName());
		donorServices.addDonor(donaone);
		donaone.setCanDonate(true);
		Donor donatwo = new Donor("Mimmo", avisSasso.getName());
		donorServices.addDonor(donatwo);
		donatwo.setCanDonate(false);
		assertTrue(donorServices.checkDonationPossibility("Greg"));
		assertFalse(donorServices.checkDonationPossibility("Mimmo"));
		assertFalse(donorServices.checkDonationPossibility("Gregg"));
	}

	@Test
	public void getDonorsByOfficeId() {
		assertThrows(NullPointerException.class, () -> donorServices.getDonorsByOfficeId(null));

		Office officeOne = new Office("Camerino");
		Donor donorOne = new Donor("Pepe", officeOne.getName());
		Office officeTwo = new Office("Muccia");
		donorServices.addDonor(donorOne);
		Donor donorTwo = new Donor("Spina", officeTwo.getName());
		donorServices.addDonor(donorTwo);

		assertTrue(donorServices.getDonorsByOfficeId(officeOne.getName()).contains(donorOne));
		assertFalse(donorServices.getDonorsByOfficeId(officeOne.getName()).contains(donorTwo));
	}

	@Test
	public void getAvailableDonorsByOfficeId() {
		assertThrows(NullPointerException.class, () -> donorServices.getAvailableDonorsByOfficeId(null));

		Office officeOne = new Office("Camerino");
		Donor donorOne = new Donor("Sara", officeOne.getName());
		Office officeTwo = new Office("Muccia");
		donorServices.addDonor(donorOne);
		Donor donorTwo = new Donor("Giorgio", officeTwo.getName());
		donorServices.addDonor(donorTwo);
		Donor donorThree = new Donor("Presa", officeOne.getName());
		donorThree.setCanDonate(true);
		donorServices.addDonor(donorThree);

		assertFalse(donorServices.getAvailableDonorsByOfficeId(officeOne.getName()).contains(donorOne));
		assertFalse(donorServices.getAvailableDonorsByOfficeId(officeOne.getName()).contains(donorTwo));
		assertTrue(donorServices.getAvailableDonorsByOfficeId(officeOne.getName()).contains(donorThree));
	}

}
