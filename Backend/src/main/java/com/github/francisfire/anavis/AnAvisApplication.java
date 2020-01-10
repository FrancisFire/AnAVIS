package com.github.francisfire.anavis;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.github.francisfire.anavis.models.*;
import com.github.francisfire.anavis.models.Donor.DonorCategory;
import com.github.francisfire.anavis.services.*;

@SpringBootApplication
@EnableScheduling
public class AnAvisApplication implements CommandLineRunner {

	@Autowired
	private DonorServices donorServices;
	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private PrenotationServices prenotationServices;
	@Autowired
	private RequestServices requestServices;

	public static void main(String[] args) {
		SpringApplication.run(AnAvisApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		Office officeOne = new Office("osimo@office.com", "Osimo");
		Office officeTwo = new Office("fabriano@office.com", "Fabriano");
		Office officeThree = new Office("casetteverdini@office.com", "Casette Verdini");
		Office officeFour = new Office("tolentino@office.com","Tolentino");
		officeOne.addTimeSlot(new TimeSlot(new Date(260000), 5));
		officeOne.addTimeSlot(new TimeSlot(new Date(550000), 5));
		officeTwo.addTimeSlot(new TimeSlot(new Date(270000), 5));
		officeTwo.addTimeSlot(new TimeSlot(new Date(300000), 5));
		officeServices.addOffice(officeOne);
		officeServices.addOffice(officeTwo);
		officeServices.addOffice(officeThree);
		officeServices.addOffice(officeFour);

		Donor donorOne = new Donor("stelluti@donor.com", officeOne.getMail(), DonorCategory.MAN);
		Donor donorTwo = new Donor("coppola@donor.com", officeTwo.getMail(), DonorCategory.MAN);
		Donor donorThree = new Donor("clelio@donor.com", officeTwo.getMail(), DonorCategory.MAN);
		Donor donorFour = new Donor("zamponi@donor.com", officeThree.getMail(), DonorCategory.MAN);
		donorFour.setCanDonate(false);
		Donor donorFive = new Donor("sasso@donor.com", officeFour.getMail(), DonorCategory.MAN);
		donorFive.setCanDonate(false);

		donorServices.addDonor(donorOne);
		donorServices.addDonor(donorTwo);
		donorServices.addDonor(donorThree);
		donorServices.addDonor(donorFour);
		donorServices.addDonor(donorFive);

		RequestPrenotation requestOne = new RequestPrenotation("one", officeOne.getMail(), donorOne.getMail(),
				new Date(550000));
		RequestPrenotation requestTwo = new RequestPrenotation("two", officeTwo.getMail(), donorThree.getMail(),
				new Date(270000));
		requestServices.addRequest(requestOne);
		requestServices.addRequest(requestTwo);

		ActivePrenotation prenotationOne = new ActivePrenotation("ciccio", officeOne.getMail(), donorOne.getMail(),
				new Date(260000), true);
		ActivePrenotation prenotationTwo = new ActivePrenotation("ciccia", officeTwo.getMail(), donorThree.getMail(),
				new Date(300000), true);
		prenotationServices.addPrenotation(prenotationOne);
		prenotationServices.addPrenotation(prenotationTwo);
	}
}
