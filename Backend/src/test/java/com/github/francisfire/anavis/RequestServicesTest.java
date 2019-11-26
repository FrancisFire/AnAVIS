package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.RequestServices;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class RequestServicesTest {
	
	private static RequestServices requestServices;
	
	@BeforeAll
	public static void setUp() {
		requestServices = RequestServices.getInstance();
	}
	
	@AfterEach
	public void clearCollection() {
		requestServices.getRequests().clear();
	}
	
	@Test
	public void addRequest() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		assertTrue(requestServices.addRequest(request));
		assertFalse(requestServices.addRequest(request));
		assertFalse(requestServices.getRequestsByOffice("Pineto").isEmpty());
		assertFalse(requestServices.addRequest(null));
	}
	
	@Test
	public void removeRequest() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.removeRequest("id1"));
		assertFalse(requestServices.removeRequest("id1"));
		assertFalse(requestServices.removeRequest("id2"));
		assertFalse(requestServices.removeRequest(null));
	}

	@Test
	public void approveRequest() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.approveRequest("id1"));
		assertFalse(requestServices.approveRequest("id1"));
		assertFalse(requestServices.approveRequest("id2"));
		assertFalse(requestServices.approveRequest(null));
	}
	
	@Test
	public void denyRequest() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.denyRequest("id1"));
		assertFalse(requestServices.denyRequest("id1"));
		assertFalse(requestServices.denyRequest("id2"));
		assertFalse(requestServices.denyRequest(null));
	}
	
	@Test
	public void getRequestsByOffice() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.getRequestsByOffice("Pineto").contains(request));
		assertTrue(requestServices.getRequestsByOffice("Sasso").isEmpty());
	}
	
	@Test
	public void getRequestInstance() {
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		requestServices.addRequest(request);
		assertEquals(request, requestServices.getRequestInstance("id1"));
		assertNull(requestServices.getRequestInstance("id2"));
		requestServices.removeRequest("id1");
		assertNull(requestServices.getRequestInstance("id1"));
	}
}
