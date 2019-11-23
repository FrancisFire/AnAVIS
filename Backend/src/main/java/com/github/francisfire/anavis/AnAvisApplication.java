package com.github.francisfire.anavis;

import java.util.Date;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.RequestServices;

@SpringBootApplication
public class AnAvisApplication {

	public static void main(String[] args) {
		initData();
		SpringApplication.run(AnAvisApplication.class, args);
	}

	private static void initData() {
		Office officeOne = new Office("Osimo");
		Donor donorOne = new Donor("stelluti@mail.com", officeOne);
		donorOne.setCanDonate(true);
		Office officeTwo = new Office("Fabriano");
		Donor donorTwo = new Donor("coppola@mail.com", officeTwo);
		DonorServices.getInstance().addDonor(donorOne);
		DonorServices.getInstance().addDonor(donorTwo);
		OfficeServices.getInstance().addOffice(officeOne);
		OfficeServices.getInstance().addOffice(officeTwo);
		Request requestOne = new Request("one", officeOne, donorOne, new Date());
		Request requestTwo = new Request("two", officeTwo, donorTwo, new Date());
		RequestServices.getInstance().addRequest(requestOne);
		RequestServices.getInstance().addRequest(requestTwo);
	}
}
