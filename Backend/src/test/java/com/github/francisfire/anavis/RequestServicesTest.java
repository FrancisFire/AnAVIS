package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.RequestServices;

@SpringBootTest
public class RequestServicesTest {

	@Autowired
	private RequestServices requestServices;
	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private DonorServices donorServices;

	@Test
	public void addRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.addRequest(null));

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		assertTrue(requestServices.addRequest(request));
		assertFalse(requestServices.addRequest(request));
		assertFalse(requestServices.getRequestsByOffice("Pineto").isEmpty());
	}

	@Test
	public void removeRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.removeRequest(null));

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.removeRequest("id1"));
		assertFalse(requestServices.removeRequest("id1"));
		assertFalse(requestServices.removeRequest("id2"));
	}

	@Test
	public void approveRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.approveRequest(null));
		Donor donor = new Donor("gianni@gmail.com", "Bari");
		donorServices.addDonor(donor);
		Office office = new Office("Bari");
		officeServices.addOffice(office);
		TimeSlot timeSlot = new TimeSlot(new Date(10000000), 1);
		officeServices.addTimeslotByOffice(timeSlot, "Bari");

		RequestPrenotation request1 = new RequestPrenotation("id23", "Bari", "gianni@gmail.com", new Date(10000000));
		requestServices.addRequest(request1);
		RequestPrenotation request2 = new RequestPrenotation("id1", "Bari", "gianni@gmail.com", new Date(10000000));
		requestServices.addRequest(request2);
		assertTrue(requestServices.approveRequest("id23"));
		assertFalse(requestServices.approveRequest("id1"));
		assertFalse(requestServices.approveRequest("id23"));
	}

	@Test
	public void denyRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.denyRequest(null));

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.denyRequest("id1"));
		assertFalse(requestServices.denyRequest("id1"));
		assertFalse(requestServices.denyRequest("id2"));
	}

	@Test
	public void getRequestsByOffice() {
		assertThrows(NullPointerException.class, () -> requestServices.getRequestsByOffice(null));

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.getRequestsByOffice("Pineto").contains(request));
		assertTrue(requestServices.getRequestsByOffice("Sasso").isEmpty());
	}

	@Test
	public void getRequestInstance() {
		assertThrows(NullPointerException.class, () -> requestServices.getRequestInstance(null));

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		requestServices.addRequest(request);
		assertEquals(request, requestServices.getRequestInstance("id1"));
		assertNull(requestServices.getRequestInstance("id2"));
		requestServices.removeRequest("id1");
		assertNull(requestServices.getRequestInstance("id1"));
	}
}
