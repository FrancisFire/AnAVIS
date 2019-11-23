package com.github.francisfire.anavis.services;


import java.util.HashSet;
import java.util.Set;

import com.github.francisfire.anavis.models.Donor;

public class DonorServices {

	private static DonorServices instance;
	private Set<Donor> donors;

	private DonorServices() {
		donors = new HashSet<>();
	}

	public static DonorServices getInstance() {
		if (instance == null) {
			instance = new DonorServices();
		}

		return instance;
	}

	public boolean addDonor(Donor donor) {
		return donors.add(donor);
	}

	public Set<Donor> getDonors() {
		return new HashSet<>(this.donors);
	}

	/**
	 * 
	 * @param donor
	 */
	public String getOfficeIdByDonor(String donor) {
		Donor don = getDonorInstance(donor);
		return (don == null) ? "" : don.getOfficePoint().getName();
	}

	/**
	 * 
	 * @param donor
	 */
	public boolean checkDonationPossibility(String donor) {
		Donor don = getDonorInstance(donor);
		return (don == null) ? false : don.isCanDonate();
	}

	/**
	 * 
	 * @param donor
	 */
	private Donor getDonorInstance(String donor) {
		return donors.stream().filter(don -> don.getMail().equals(donor)).findFirst().orElse(null);
	}

}