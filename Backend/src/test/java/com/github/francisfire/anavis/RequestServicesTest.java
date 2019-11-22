package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
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
		Office officePineto = new Office("Pineto");
		Donor donorGianni = new Donor("gianni@gmail.com", officePineto);
		Request request = new Request("id1", officePineto, donorGianni, new Date());
		assertTrue(requestServices.addRichiesta(request));
		assertFalse(requestServices.getRichieste("Pineto").isEmpty());
		assertNotNull(requestServices.getRichiesta("id1"));
	}

}
