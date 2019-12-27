package com.github.francisfire.anavis;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.github.francisfire.anavis.models.*;
import com.github.francisfire.anavis.services.*;

@SpringBootApplication
public class AnAvisApplication implements CommandLineRunner {

	@Autowired
	private static DonationReportServices donationReportServices;
	@Autowired
	private DonationServices donationServices;
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

		Donor donorOne = new Donor("stelluti@mail.com", officeOne.getId());
		donorOne.setCanDonate(true);
		Donor donorTwo = new Donor("coppola@mail.com", officeTwo.getId());
		Donor donorThree = new Donor("clelio@mail.com", officeTwo.getId());
		donorThree.setCanDonate(true);
		Donor donorFour = new Donor("zamponi@mail.com", officeThree.getId());
		Donor donorFive = new Donor("sasso@mail.com", officeFour.getId());

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

	private static void initData() {

		/*
		 * Office officeOne = new Office("Osimo"); Office officeTwo = new
		 * Office("Fabriano"); Office officeThree = new Office("Casette Verdini");
		 * Office officeFour = new Office("Tolentino");
		 * 
		 * OfficeServices.getInstance().addOffice(officeOne);
		 * OfficeServices.getInstance().addOffice(officeTwo);
		 * OfficeServices.getInstance().addOffice(officeThree);
		 * OfficeServices.getInstance().addOffice(officeFour);
		 * 
		 * Set<TimeSlot> datesOne = new HashSet<>(); datesOne.add(new TimeSlot(new
		 * Date(260000), 5)); datesOne.add(new TimeSlot(new Date(550000), 5));
		 * officeOne.setDonationTimeTables(datesOne); Set<TimeSlot> datesTwo = new
		 * HashSet<>(); datesTwo.add(new TimeSlot(new Date(270000), 5));
		 * datesTwo.add(new TimeSlot(new Date(300000), 5));
		 * officeTwo.setDonationTimeTables(datesTwo); Set<TimeSlot> datesThree = new
		 * HashSet<>(); datesTwo.add(new TimeSlot(new Date(270000), 5));
		 * datesTwo.add(new TimeSlot(new Date(300000), 5));
		 * officeThree.setDonationTimeTables(datesThree); Set<TimeSlot> datesFour = new
		 * HashSet<>(); datesTwo.add(new TimeSlot(new Date(270000), 5));
		 * datesTwo.add(new TimeSlot(new Date(300000), 5));
		 * officeFour.setDonationTimeTables(datesFour);
		 * 
		 * Donor donorOne = new Donor("stelluti@mail.com", officeOne.getId());
		 * donorOne.setCanDonate(true); Donor donorTwo = new Donor("coppola@mail.com",
		 * officeTwo.getId()); Donor donorThree = new Donor("clelio@mail.com",
		 * officeTwo.getId()); donorThree.setCanDonate(true); Donor donorFour = new
		 * Donor("zamponi@mail.com", officeThree.getId()); Donor donorFive = new
		 * Donor("sasso@mail.com", officeFour.getId());
		 * 
		 * DonorServices.getInstance().addDonor(donorOne);
		 * DonorServices.getInstance().addDonor(donorTwo);
		 * DonorServices.getInstance().addDonor(donorThree);
		 * DonorServices.getInstance().addDonor(donorFour);
		 * DonorServices.getInstance().addDonor(donorFive);
		 * 
		 * RequestPrenotation requestOne = new RequestPrenotation("one",
		 * officeOne.getId(), donorOne.getMail(), new Date(550000)); RequestPrenotation
		 * requestTwo = new RequestPrenotation("two", officeTwo.getId(),
		 * donorTwo.getMail(), new Date(270000));
		 * RequestServices.getInstance().addRequest(requestOne);
		 * RequestServices.getInstance().addRequest(requestTwo);
		 * 
		 * ActivePrenotation prenotationOne = new ActivePrenotation("ciccio",
		 * officeOne.getId(), donorFour.getMail(), new Date(260000), true);
		 * ActivePrenotation prenotationTwo = new ActivePrenotation("ciccia",
		 * officeTwo.getId(), donorFive.getMail(), new Date(300000), true);
		 * PrenotationServices.getInstance().addPrenotation(prenotationOne);
		 * PrenotationServices.getInstance().addPrenotation(prenotationTwo);
		 */
	}
}
