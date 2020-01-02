package com.github.francisfire.anavis;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.github.francisfire.anavis.models.*;
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
		Office officeOne = new Office("Osimo");
		Office officeTwo = new Office("Fabriano");
		Office officeThree = new Office("Casette Verdini");
		Office officeFour = new Office("Tolentino");
		officeOne.addTimeSlot(new TimeSlot(new Date(260000), 5));
		officeOne.addTimeSlot(new TimeSlot(new Date(550000), 5));
		officeTwo.addTimeSlot(new TimeSlot(new Date(270000), 5));
		officeTwo.addTimeSlot(new TimeSlot(new Date(300000), 5));
		officeServices.addOffice(officeOne);
		officeServices.addOffice(officeTwo);
		officeServices.addOffice(officeThree);
		officeServices.addOffice(officeFour);

		Donor donorOne = new Donor("stelluti@mail.com", officeOne.getId(), DonorCategory.MAN);
		Donor donorTwo = new Donor("coppola@mail.com", officeTwo.getId(), DonorCategory.MAN);
		Donor donorThree = new Donor("clelio@mail.com", officeTwo.getId(), DonorCategory.MAN);
		Donor donorFour = new Donor("zamponi@mail.com", officeThree.getId(), DonorCategory.MAN);
		donorFour.setCanDonate(false);
		Donor donorFive = new Donor("sasso@mail.com", officeFour.getId(), DonorCategory.MAN);
		donorFive.setCanDonate(false);

		donorServices.addDonor(donorOne);
		donorServices.addDonor(donorTwo);
		donorServices.addDonor(donorThree);
		donorServices.addDonor(donorFour);
		donorServices.addDonor(donorFive);

		RequestPrenotation requestOne = new RequestPrenotation("one", officeOne.getId(), donorOne.getMail(),
				new Date(550000));
		RequestPrenotation requestTwo = new RequestPrenotation("two", officeTwo.getId(), donorThree.getMail(),
				new Date(270000));
		requestServices.addRequest(requestOne);
		requestServices.addRequest(requestTwo);

		ActivePrenotation prenotationOne = new ActivePrenotation("ciccio", officeOne.getId(), donorOne.getMail(),
				new Date(260000), true);
		ActivePrenotation prenotationTwo = new ActivePrenotation("ciccia", officeTwo.getId(), donorThree.getMail(),
				new Date(300000), true);
		prenotationServices.addPrenotation(prenotationOne);
		prenotationServices.addPrenotation(prenotationTwo);
	}
}
