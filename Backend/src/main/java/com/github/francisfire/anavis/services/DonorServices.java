package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import com.github.francisfire.anavis.models.Donor;

public class DonorServices {

	private static DonorServices instance;
	private Set<Donor> donors;

	private DonorServices() {
		this.donors = new HashSet<>();
	}

	/**
	 * Creates an instance of the class the first time it is used and returns the
	 * class instance
	 * 
	 * @return the class instance
	 */
	public static DonorServices getInstance() {
		if (instance == null) {
			instance = new DonorServices();
		}

		return instance;
	}

	/**
	 * Adds a donor to the donor collection
	 * 
	 * @throws NullPointerException if donor is null
	 * @param donor the donor to add
	 * @return true if the collection didn't contain the added donor
	 */
	public boolean addDonor(Donor donor) {
		return donors.add(Objects.requireNonNull(donor));
	}

	/**
	 * Returns a view of the collection of donors, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the donor collection
	 */
	public Set<Donor> getDonors() {
		return new HashSet<>(this.donors);
	}

	/**
	 * Returns the id of the office associated with the donor whose id has been
	 * passed as an input of the function. Returns null if the donor is not present
	 * in the collection.
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId the id of the donor
	 * @return the id of the office associated to the donor, null if the donor
	 *         hasn't been found
	 */
	public String getOfficeIdByDonor(String donorId) {
		Donor donor = getDonorInstance(Objects.requireNonNull(donorId));
		return (donor == null) ? null : donor.getOfficePoint().getName();
	}

	/**
	 * Checks if the donor whose id has been passed as an input to the function can
	 * donate or not.
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId the id of the donor
	 * @return true if the donor can donate, false otherwise
	 */
	public boolean checkDonationPossibility(String donorId) {
		Donor donor = getDonorInstance(Objects.requireNonNull(donorId));
		return (donor == null) ? false : donor.isCanDonate();
	}

	/**
	 * Finds the instance of Donor class which has the same id as the one who has
	 * been passed as input to the function. If the instance hasn't been found it
	 * returns null
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId id of the donor to find
	 * @return the Donor object associated to the id, null if it hasn't been found
	 */
	private Donor getDonorInstance(String donorId) {
		Objects.requireNonNull(donorId);
		return donors.stream().filter(donor -> donor.getMail().equals(donorId)).findFirst().orElse(null);
	}

}