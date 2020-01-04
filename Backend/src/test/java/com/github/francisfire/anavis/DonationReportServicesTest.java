package com.github.francisfire.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.util.Date;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.DonationReport;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.DonorCategory;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.DonationReportServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;

@SpringBootTest
public class DonationReportServicesTest {

	@Autowired
	private DonationReportServices donationReportServices;
	@Autowired
	private PrenotationServices prenotationServices;
	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private DonorServices donorServices;

	private String reportId = "";

	@BeforeEach
	public void initSingleTest() {

		Office officeOne = new Office("officeOne");
		officeServices.addOffice(officeOne);
		TimeSlot timeSlotOne = new TimeSlot(new Date(6000000), 5);
		officeServices.addTimeslotByOffice(timeSlotOne, "officeOne");

		Donor donor = new Donor("donor@gmail.com", "officeOne", DonorCategory.MAN);
		donorServices.addDonor(donor);

		ActivePrenotation prenotationOne = new ActivePrenotation("prenotationId", "officeOne", "donor@gmail.com",
				new Date(6000000), true);
		prenotationServices.addPrenotation(prenotationOne);

		Path path = Paths.get("/anavis/src/main/resources/donationReportOne.test");
		String name = "donationReportOne.test";
		String originalFileName = "donationReportOne.test";
		String contentType = "text/plain";
		byte[] content = null;
		try {
			content = Files.readAllBytes(path);
		} catch (final IOException e) {
		}
		MultipartFile mockFile = new MockMultipartFile(name, originalFileName, contentType, content);
		reportId = donationReportServices.addReport("prenotationId", mockFile);

	}

	@AfterEach
	public void closeSingleTest() {
		prenotationServices.removePrenotation("prenotationId");
		donorServices.removeDonor("donor@gmail.com");
		officeServices.removeOffice("officeOne");
		donationReportServices.removeReport(reportId);
	}

	@Test
	public void addReport() {
		assertThrows(NullPointerException.class, () -> donationReportServices.addReport(null, null));
		Path path = Paths.get("/anavis/src/main/resources/donationReportTwo.test");
		String name = "donationReportTwo.test";
		String originalFileName = "donationReportTwo.test";
		String contentType = "text/plain";
		byte[] content = null;
		try {
			content = Files.readAllBytes(path);
		} catch (final IOException e) {
		}
		MultipartFile mockFile = new MockMultipartFile(name, originalFileName, contentType, content);
		assertNotNull(donationReportServices.addReport("prenotationId", mockFile));
	}

	@Test
	public void getReportInstance() {
		DonationReport report = new DonationReport("donor@gmail.com", "officeOne", new Date(6000000));
		report.setReportId(this.reportId);
		assertEquals(report, donationReportServices.getReportInstance(this.reportId));
	}
}
