package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;
import com.github.francisfire.anavis.repository.DonationRepository;

@Service
public class DonationServices {

	// private Set<ClosedPrenotation> donations;
	@Autowired
	private DonationRepository repository;

	/*
	 * private DonationServices() { this.donations = new HashSet<>(); }
	 */

	/**
	 * Gets the ClosedPrenotation instance associated to the id that has been passed
	 * in input to the method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param donationId id of the request
	 * @return the ClosedPrenotation object if present in the collection, null
	 *         otherwise
	 */
	public ClosedPrenotation getDonationInstance(String donationId) {
		Objects.requireNonNull(donationId);
		Optional<ClosedPrenotation> opt = repository.findById(donationId);
		return opt.orElse(null);
	}

	/**
	 * Returns a collection of donations related to an office passed in input
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of donations related to the office passed in input
	 */
	public Set<ClosedPrenotation> getDonationsByOffice(String officeId) {
		Objects.requireNonNull(officeId);
		return repository.findAll().stream().filter(donation -> donation.getOfficeId().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a collection of donations related to a donor passed in input
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId id of the donor
	 * @return a collection of donations related to the donor passed in input
	 */
	public Set<ClosedPrenotation> getDonationsByDonor(String donorId) {
		Objects.requireNonNull(donorId);
		return repository.findAll().stream().filter(donation -> donation.getDonorId().equalsIgnoreCase(donorId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a view of the collection of donations, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the donation collection
	 */
	public Set<ClosedPrenotation> getDonations() {
		return new HashSet<>(repository.findAll());
	}

	/**
	 * Adds a donation to the donation collection using the informations from a
	 * prenotation
	 * 
	 * @throws NullPointerException if donation is null
	 * @param donation the donation to add
	 * @return true if the collection didn't contain the added donation
	 */
	public boolean addDonation(ActivePrenotation prenotation, String reportId) {
		Objects.requireNonNull(prenotation);
		Objects.requireNonNull(reportId);
		ClosedPrenotation donation = new ClosedPrenotation(prenotation.getId(), prenotation.getOfficeId(),
				prenotation.getDonorId(), prenotation.getHour(), reportId);
		repository.save(donation);
		return true;
		// return donations.add(donation);
	}
}
