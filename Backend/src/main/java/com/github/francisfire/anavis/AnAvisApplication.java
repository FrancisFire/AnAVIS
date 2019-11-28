package com.github.francisfire.anavis;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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
		Set<Date> datesOne = new HashSet<>();
		datesOne.add(new Date(260000));
		datesOne.add(new Date(280000));
		officeOne.setDonationTimeTables(datesOne);
		Donor donorOne = new Donor("stelluti@mail.com", officeOne);
		donorOne.setCanDonate(true);
		Office officeTwo = new Office("Fabriano");
		Set<Date> datesTwo = new HashSet<>();
		datesTwo.add(new Date(270000));
		datesTwo.add(new Date(300000));
		officeTwo.setDonationTimeTables(datesTwo);
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
