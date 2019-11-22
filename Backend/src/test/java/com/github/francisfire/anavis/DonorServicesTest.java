package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
	
}
