package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.github.francisfire.anavis.models.Donatore;
import com.github.francisfire.anavis.models.UfficioAVIS;
import com.github.francisfire.anavis.services.GestoreDonatori;

public class DonorsTest {

	private static GestoreDonatori donorServices;
	
	@BeforeAll
	public static void setUp() {
		donorServices = GestoreDonatori.getInstance();
	}
	
	@Test
	public void addDonor() {
		UfficioAVIS avisPineto = new UfficioAVIS("Pineto", new ArrayList<>());
		assertTrue(donorServices.addDonor(new Donatore("Gianni", avisPineto)));
		assertFalse(donorServices.getDonors().isEmpty());
//		assertNotNull(donorServices.getOfficeIdByDonor("Gianni"));	
	}
	
}
