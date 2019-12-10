package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;
import java.util.Set;

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

	@Test
	public void getPrenotations() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id4", officePineto, donorGianni, new Date());
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
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByOffice(null));

		Office officePineto = new Office("Pineto");
		Office officeRoma = new Office("Roma");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Prenotation prenotationOne = new Prenotation("id11", officePineto, donorGianni, new Date());
		prenotationServices.addPrenotation(prenotationOne);
		Prenotation prenotationTwo = new Prenotation("id12", officeRoma, donorGianni, new Date());
		prenotationServices.addPrenotation(prenotationTwo);

		assertTrue(prenotationServices.getPrenotationsByOffice(officePineto.getName()).contains(prenotationOne));
		assertFalse(prenotationServices.getPrenotationsByOffice(officePineto.getName()).contains(prenotationTwo));
	}

	@Test
	public void getPrenotationsByDonor() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByDonor(null));
		Office officePineto = new Office("Pineto");
		Donor donorOne = new Donor("panino@gmail.com", officePineto);
		Donor donorTwo = new Donor("salame@gmail.com", officePineto);

		Prenotation prenotationOne = new Prenotation("id13", officePineto, donorOne, new Date());
		prenotationServices.addPrenotation(prenotationOne);
		Prenotation prenotationTwo = new Prenotation("id14", officePineto, donorOne, new Date());
		prenotationServices.addPrenotation(prenotationTwo);
		Prenotation prenotationThree = new Prenotation("id15", officePineto, donorTwo, new Date());
		prenotationServices.addPrenotation(prenotationThree);

		assertTrue(prenotationServices.getPrenotationsByDonor(donorOne.getMail()).contains(prenotationOne));
		assertTrue(prenotationServices.getPrenotationsByDonor(donorOne.getMail()).contains(prenotationTwo));
		assertFalse(prenotationServices.getPrenotationsByDonor(donorOne.getMail()).contains(prenotationThree));

	}

	@Test
	public void acceptPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.acceptPrenotationChange(null));

		Office officePineto = new Office("Pineto");
		Donor donorOne = new Donor("panino@gmail.com", officePineto);

		Prenotation prenotationOne = new Prenotation("id16", officePineto, donorOne, new Date());
		prenotationServices.addPrenotation(prenotationOne);
		assertFalse(prenotationServices.acceptPrenotationChange("id16"));
		assertFalse(prenotationServices.acceptPrenotationChange("id54"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.acceptPrenotationChange("id16"));
		assertTrue(prenotationServices.getPrenotationInstance("id16").isConfirmed());
	}

	@Test
	public void denyPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.denyPrenotationChange(null));

		Office officePineto = new Office("Pineto");
		Donor donorOne = new Donor("panino@gmail.com", officePineto);

		Prenotation prenotationOne = new Prenotation("id17", officePineto, donorOne, new Date());
		prenotationServices.addPrenotation(prenotationOne);
		assertTrue(prenotationServices.getPrenotationInstance("id17").isConfirmed());
		assertFalse(prenotationServices.denyPrenotationChange("id17"));
		assertFalse(prenotationServices.denyPrenotationChange("id28"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.denyPrenotationChange("id17"));
	}
}
