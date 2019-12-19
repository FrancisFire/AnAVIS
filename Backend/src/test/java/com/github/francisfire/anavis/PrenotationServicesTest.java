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

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.RequestPrenotation;
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
		RequestPrenotation request = new RequestPrenotation("id4", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(request);

		Set<ActivePrenotation> set = prenotationServices.getPrenotations();
		assertTrue(set.contains(new ActivePrenotation("id4", "Pineto", "gianni@gmail.com", new Date())));
		assertFalse(set.contains(new ActivePrenotation("id10", "Pineto", "gianni@gmail.com", new Date())));

	}

	@Test
	public void addPrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.addPrenotation((RequestPrenotation) null));

		RequestPrenotation request = new RequestPrenotation("id5", "Pineto", "gianni@gmail.com", new Date());
		assertTrue(prenotationServices.addPrenotation(request));
		assertFalse(prenotationServices.addPrenotation(request));
		ActivePrenotation prenotation = new ActivePrenotation("id10", "Pineto", "gianni@gmail.com", new Date());
		assertTrue(prenotationServices.addPrenotation(prenotation));
		assertFalse(prenotationServices.addPrenotation(prenotation));

	}

	@Test
	public void removePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.removePrenotation(null));

		ActivePrenotation prenotation = new ActivePrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id1"));
		assertFalse(prenotationServices.removePrenotation("id2"));
	}

	@Test
	public void updatePrenotation() {
		assertThrows(NullPointerException.class, () -> prenotationServices.updatePrenotation(null));

		ActivePrenotation prenotation = new ActivePrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		ActivePrenotation updatedPrenotation = new ActivePrenotation("id1", "Roma", "gianni@gmail.com", new Date());
		ActivePrenotation wrongPrenotation = new ActivePrenotation("id2", "Roma", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotation);
		assertTrue(prenotationServices.updatePrenotation(prenotation));
		assertTrue(prenotationServices.updatePrenotation(updatedPrenotation));
		assertFalse(prenotationServices.updatePrenotation(wrongPrenotation));

	}

	@Test
	public void getPrenotationsByOffice() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByOffice(null));

		ActivePrenotation prenotationOne = new ActivePrenotation("id11", "Pineto", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		ActivePrenotation prenotationTwo = new ActivePrenotation("id12", "Roma", "gianni@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationTwo);

		assertTrue(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationOne));
		assertFalse(prenotationServices.getPrenotationsByOffice("Pineto").contains(prenotationTwo));
	}

	@Test
	public void getPrenotationsByDonor() {
		assertThrows(NullPointerException.class, () -> prenotationServices.getPrenotationsByDonor(null));

		ActivePrenotation prenotationOne = new ActivePrenotation("id13", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		ActivePrenotation prenotationTwo = new ActivePrenotation("id14", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationTwo);
		ActivePrenotation prenotationThree = new ActivePrenotation("id15", "Pineto", "salame@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationThree);

		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationOne));
		assertTrue(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationTwo));
		assertFalse(prenotationServices.getPrenotationsByDonor("panino@gmail.com").contains(prenotationThree));

	}

	@Test
	public void acceptPrenotationChange() {
		assertThrows(NullPointerException.class, () -> prenotationServices.acceptPrenotationChange(null));

		ActivePrenotation prenotationOne = new ActivePrenotation("id16", "panino@gmail.com", "Pineto", new Date());
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

		ActivePrenotation prenotationOne = new ActivePrenotation("id17", "Pineto", "panino@gmail.com", new Date());
		prenotationServices.addPrenotation(prenotationOne);
		assertTrue(prenotationServices.getPrenotationInstance("id17").isConfirmed());
		assertFalse(prenotationServices.denyPrenotationChange("id17"));
		assertFalse(prenotationServices.denyPrenotationChange("id28"));
		prenotationOne.setConfirmed(false);
		assertTrue(prenotationServices.denyPrenotationChange("id17"));
	}
}
