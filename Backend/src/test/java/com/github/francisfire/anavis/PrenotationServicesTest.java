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
		Request request = new Request("id4", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(request);

		Set<Prenotation> set = prenotationServices.getPrenotations();
		assertTrue(set.contains(new Prenotation("id4", "Pineto", "gianni@gmail.com", new Date())));
		assertFalse(set.contains(new Prenotation("id10", "Pineto", "gianni@gmail.com", new Date())));

	}

	@Test
	public void addPrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.addPrenotation((Request) null));

		Request request = new Request("id5", "Pineto", "gianni@gmail.com", new Date());
		assertTrue(prenotationServices.addPrenotation(request));
		assertFalse(prenotationServices.addPrenotation(request));
		Prenotation prenotation = new Prenotation("id10", "Pineto", "gianni@gmail.com", new Date());
		assertTrue(prenotationServices.addPrenotation(prenotation));
		assertFalse(prenotationServices.addPrenotation(prenotation));

	}

	@Test
	public void removePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.removePrenotation(null));

		Prenotation prenotation = new Prenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id2"));
	}

	@Test
	public void updatePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.updatePrenotation(null));

		Prenotation prenotation = new Prenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		Prenotation updatedPrenotation = new Prenotation("id1", "Roma", "gianni@gmail.com", new Date());
		Prenotation wrongPrenotation = new Prenotation("id2", "Roma", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.updatePrenotation(prenotation));
		assertTrue(prenotationServices.updatePrenotation(updatedPrenotation));
		assertFalse(prenotationServices.updatePrenotation(wrongPrenotation));

	}

	@Test
	public void getPrenotationsByOffice() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByOffice(null));

		Prenotation prenotationOne = new Prenotation("id11", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		Prenotation prenotationTwo = new Prenotation("id12", "Roma", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationTwo);

		assertTrue(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationOne));
		assertFalse(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationTwo));
	}

	@Test
	public void getPrenotationsByDonor() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByDonor(null));

		Prenotation prenotationOne = new Prenotation("id13", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		Prenotation prenotationTwo = new Prenotation("id14", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationTwo);
		Prenotation prenotationThree = new Prenotation("id15", "Pineto", "salame@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationThree);

		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationOne));
		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationTwo));
		assertFalse(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationThree));

	}

	@Test
	public void acceptPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.acceptPrenotationChange(null));

		Prenotation prenotationOne = new Prenotation("id16", "panino@gmail.com", "Pineto", new Date());
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

		Prenotation prenotationOne = new Prenotation("id17", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		assertTrue(prenotationServices.getPrenotationInstance("id17").isConfirmed());
		assertFalse(prenotationServices.denyPrenotationChange("id17"));
		assertFalse(prenotationServices.denyPrenotationChange("id28"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.denyPrenotationChange("id17"));
	}
}
