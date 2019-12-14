package com.github.francisfire.anavis;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.Prenotation;
import com.github.francisfire.anavis.models.Request;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;
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
		Donor donorOne = new Donor("stelluti@mail.com", officeOne.getName());
		donorOne.setCanDonate(true);
		Office officeTwo = new Office("Fabriano");
		Set<Date> datesTwo = new HashSet<>();
		datesTwo.add(new Date(270000));
		datesTwo.add(new Date(300000));
		officeTwo.setDonationTimeTables(datesTwo);
		Donor donorTwo = new Donor("coppola@mail.com", officeTwo.getName());
		Donor donorThree = new Donor("clelio@mail.com", officeTwo.getName());
		donorThree.setCanDonate(true);
		Office officeThree = new Office("Casette Verdini");
		Donor donorFour = new Donor("zamponi@mail.com", officeThree.getName());
		Office officeFour = new Office("Tolentino");
		Donor donorFive = new Donor("sasso@mail.com", officeFour.getName());

		DonorServices.getInstance().addDonor(donorOne);
		DonorServices.getInstance().addDonor(donorTwo);
		DonorServices.getInstance().addDonor(donorThree);
		DonorServices.getInstance().addDonor(donorFour);
		DonorServices.getInstance().addDonor(donorFive);
		OfficeServices.getInstance().addOffice(officeOne);
		OfficeServices.getInstance().addOffice(officeTwo);
		OfficeServices.getInstance().addOffice(officeThree);
		OfficeServices.getInstance().addOffice(officeFour);
		Request requestOne = new Request("one", officeOne.getName(), donorOne.getMail(), new Date());
		Request requestTwo = new Request("two", officeTwo.getName(), donorTwo.getMail(), new Date());
		RequestServices.getInstance().addRequest(requestOne);
		RequestServices.getInstance().addRequest(requestTwo);
		Prenotation prenotationOne = new Prenotation("ciccio", officeThree.getName(), donorFour.getMail(),
				new Date(1575200000));
		Prenotation prenotationTwo = new Prenotation("ciccia", officeFour.getName(), donorFive.getMail(),
				new Date(1575800000));
		PrenotationServices.getInstance().addPrenotation(prenotationOne);
		PrenotationServices.getInstance().addPrenotation(prenotationTwo);
	}
}
