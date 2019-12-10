package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Date;
import java.util.Set;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.Prenotation;
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

	@AfterAll
	public static void cleanUp() {
		prenotationServices.resetPrenotationServices();
	}

	@Test
	public void getPrenotations() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id4", officePineto, donorGianni, new Date());
		assertTrue(prenotationServices.getPrenotations().isEmpty());
		prenotationServices.addPrenotation(request);

		Set<Prenotation> set = prenotationServices.getPrenotations();
		assertTrue(set.contains(new Prenotation("id4", officePineto, donorGianni, new Date())));
		assertFalse(set.contains(new Prenotation("id10", officePineto, donorGianni, new Date())));

	}

	@Test
	public void addPrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.addPrenotation((Request) null));

		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id5", officePineto, donorGianni, new Date());
		assertTrue(prenotationServices.addPrenotation(request));
		assertFalse(prenotationServices.addPrenotation(request));
		Prenotation prenotation = new Prenotation("id10", officePineto, donorGianni, new Date());
		assertTrue(prenotationServices.addPrenotation(prenotation));
		assertFalse(prenotationServices.addPrenotation(prenotation));

	}

	@Test
	public void removePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.removePrenotation(null));

		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Prenotation prenotation = new Prenotation("id1", officePineto, donorGianni, new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id2"));
	}

	@Test
	public void updatePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.updatePrenotation(null));

		Office officePineto = new Office("Pineto");
		Office officeRoma = new Office("Roma");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Prenotation prenotation = new Prenotation("id1", officePineto, donorGianni, new Date());
		Prenotation updatedPrenotation = new Prenotation("id1", officeRoma, donorGianni, new Date());
		Prenotation wrongPrenotation = new Prenotation("id2", officeRoma, donorGianni, new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.updatePrenotation(prenotation));
		assertTrue(prenotationServices.updatePrenotation(updatedPrenotation));
		assertFalse(prenotationServices.updatePrenotation(wrongPrenotation));

	}

	@Test
	public void getPrenotationsByOffice() {
	}

	@Test
	public void getPrenotationsByDonor() {
	}

	@Test
	public void acceptPrenotationChange() {
	}

	@Test
	public void denyPrenotationChange() {
	}

	@Test
	public void getPrenotationInstance() {
	}
}
