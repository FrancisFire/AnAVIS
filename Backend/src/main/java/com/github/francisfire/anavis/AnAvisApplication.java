package com.github.francisfire.anavis;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.multipart.MultipartFile;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.AuthCredentials;
import com.github.francisfire.anavis.models.AuthCredentials.Role;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.Donor.DonorCategory;
import com.github.francisfire.anavis.models.Office;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.models.TimeSlot;
import com.github.francisfire.anavis.services.AuthCredentialsServices;
import com.github.francisfire.anavis.services.DonationReportServices;
import com.github.francisfire.anavis.services.DonationServices;
import com.github.francisfire.anavis.services.DonorServices;
import com.github.francisfire.anavis.services.OfficeServices;
import com.github.francisfire.anavis.services.PrenotationServices;
import com.github.francisfire.anavis.services.RequestServices;

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
	@Autowired
	private DonationServices donationServices;
	@Autowired
	private DonationReportServices donationReportServices;
	@Autowired
	private AuthCredentialsServices authCredentialsServices;

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
		
		Set<Role> roles = new HashSet<>();
		roles.add(Role.DONOR);
		AuthCredentials userOne = new AuthCredentials("stelluti@donor.com", "sasso", roles);
		authCredentialsServices.addCredentials(userOne);
	}
}
