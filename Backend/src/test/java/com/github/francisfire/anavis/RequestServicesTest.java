package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.services.RequestServices;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class RequestServicesTest {

	private static RequestServices requestServices;

	@BeforeAll
	public static void setUp() {
		requestServices = RequestServices.getInstance();
	}

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

		RequestPrenotation request = new RequestPrenotation("id1", "Pineto", "gianni@gmail.com", new Date());
		requestServices.addRequest(request);
		assertTrue(requestServices.approveRequest("id1"));
		assertFalse(requestServices.approveRequest("id1"));
		assertFalse(requestServices.approveRequest("id2"));
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
