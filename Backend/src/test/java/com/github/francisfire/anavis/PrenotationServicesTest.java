package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.PrenotationServices;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class PrenotationServicesTest {
	
	private static PrenotationServices prenotationServices;
	
	@BeforeAll
	public static void setUp() {
		prenotationServices = PrenotationServices.getInstance();
	}
	
	@Test
	public void addPrenotation() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		assertTrue(prenotationServices.addPrenotazione(request));
	}

}
