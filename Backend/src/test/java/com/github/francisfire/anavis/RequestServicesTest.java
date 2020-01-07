package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Donor.DonorCategory;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;
import com.github.francisfire.anavis.services.RequestServices;

@SpringBootTest
public class RequestServicesTest {

	@Autowired
	private RequestServices requestServices;
	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private DonorServices donorServices;
	@Autowired
	private PrenotationServices prenotationServices;

	@BeforeEach
	public void initSingleTest() {

		Office officeOne = new Office("officeOne");
		officeServices.addOffice(officeOne);
		TimeSlot timeSlotOne = new TimeSlot(new Date(6000000), 5);
		TimeSlot timeSlotTwo = new TimeSlot(new Date(8000000), 1);
		officeServices.addTimeslotByOffice(timeSlotOne, "officeOne");
		officeServices.addTimeslotByOffice(timeSlotTwo, "officeOne");

		Office officeTwo = new Office("officeTwo");
		officeServices.addOffice(officeTwo);
		TimeSlot timeSlotThree = new TimeSlot(new Date(2000000), 5);
		TimeSlot timeSlotFour = new TimeSlot(new Date(4000000), 1);
		officeServices.addTimeslotByOffice(timeSlotThree, "officeTwo");
		officeServices.addTimeslotByOffice(timeSlotFour, "officeTwo");

		Donor donor = new Donor("donor@gmail.com", "officeOne", DonorCategory.MAN);
		donorServices.addDonor(donor);

		RequestPrenotation request = new RequestPrenotation("requestId", "officeOne", "donor@gmail.com",
				new Date(6000000));
		requestServices.addRequest(request);
	}

	@AfterEach
	public void closeSingleTest() {
		prenotationServices.removePrenotation("requestId");
		donorServices.removeDonor("donor@gmail.com");
		officeServices.removeOffice("officeOne");
		officeServices.removeOffice("officeTwo");
		requestServices.removeRequest("requestId");

	}

	@Test
	public void addRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.addRequest(null));

		RequestPrenotation request = new RequestPrenotation("newRequestId", "officeTwo", "donor@gmail.com",
				new Date(4000000));
		assertTrue(requestServices.addRequest(request));
		assertFalse(requestServices.addRequest(request));
		assertFalse(requestServices.getRequestsByOffice("officeTwo").isEmpty());
	}

	@Test
	public void removeRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.removeRequest(null));
		assertTrue(requestServices.removeRequest("requestId"));
		assertFalse(requestServices.removeRequest("requestId"));
		assertFalse(requestServices.removeRequest("fakeRequestId"));
	}

	@Test
	public void approveRequest() {
		assertThrows(NullPointerException.class, () -> requestServices.approveRequest(null));

		assertTrue(requestServices.approveRequest("requestId"));

		RequestPrenotation newRequestOne = new RequestPrenotation("newRequestOne", "officeTwo", "donor@gmail.com",
				new Date(4000000));
		requestServices.addRequest(newRequestOne);
		RequestPrenotation newRequestTwo = new RequestPrenotation("newRequestTwo", "officeTwo", "donor@gmail.com",
				new Date(4000000));
		requestServices.addRequest(newRequestTwo);
		assertTrue(requestServices.approveRequest("newRequestOne"));
		assertFalse(requestServices.approveRequest("newRequestTwo"));
		assertFalse(requestServices.approveRequest("newRequestOne"));
	}

	@Test
	public void getRequestsByOffice() {
		assertThrows(NullPointerException.class, () -> requestServices.getRequestsByOffice(null));

		assertTrue(requestServices.getRequestsByOffice("officeOne")
				.contains(new RequestPrenotation("requestId", "officeOne", "donor@gmail.com", new Date(6000000))));
		assertTrue(requestServices.getRequestsByOffice("officeThree").isEmpty());
	}

	@Test
	public void getRequestInstance() {
		assertThrows(NullPointerException.class, () -> requestServices.getRequestInstance(null));

		RequestPrenotation request = new RequestPrenotation("requestId", "officeOne", "donor@gmail.com",
				new Date(6000000));
		assertEquals(request, requestServices.getRequestInstance("requestId"));
		assertNull(requestServices.getRequestInstance("secondRequestId"));
		requestServices.removeRequest("requestId");
		assertNull(requestServices.getRequestInstance("requestId"));
	}
}
