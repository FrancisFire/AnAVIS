package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;

public class DonationServices {
	private static DonationServices instance;
	private Set<ClosedPrenotation> donations;

	private DonationServices() {
		this.donations = new HashSet<>();
	}

	/**
	 * Creates an instance of the class the first time it is used and returns the
	 * class instance
	 * 
	 * @return the class instance
	 */
	public static DonationServices getInstance() {
		if (instance == null) {
			instance = new DonationServices();
		}

		return instance;
	}

	/**
	 * Gets the ClosedPrenotation instance associated to the id that has been passed
	 * in input to the method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param donationId id of the request
	 * @return the ClosedPrenotation object if present in the collection, null
	 *         otherwise
	 */
	public ClosedPrenotation getPrenotationInstance(String donationId) {
		Objects.requireNonNull(donationId);
		return donations.stream().filter(donation -> donation.getId().equals(donationId)).findFirst().orElse(null);
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
		return donations.stream().filter(donation -> donation.getOfficeId().equalsIgnoreCase(officeId))
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
		return donations.stream().filter(donation -> donation.getDonorId().equalsIgnoreCase(donorId))
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
		return new HashSet<>(donations);
	}

	/**
	 * Adds a donation to the donation collection using the informations from a prenotation
	 * 
	 * @throws NullPointerException if donation is null
	 * @param donation the donation to add
	 * @return true if the collection didn't contain the added donation
	 */
	public boolean addDonation(ActivePrenotation prenotation, String reportId) {
		Objects.requireNonNull(prenotation);
		Objects.requireNonNull(reportId);
		ClosedPrenotation donation = new ClosedPrenotation(prenotation.getId(), prenotation.getOfficeId(), prenotation.getDonorId(), prenotation.getHour(), reportId);
		return donations.add(donation);
	}
}
