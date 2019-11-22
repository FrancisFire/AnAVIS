package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;

import com.github.francisfire.anavis.models.Donor;

public class DonorServices {

	private static DonorServices instance;
	private List<Donor> donors;

	private DonorServices() {
		donors = new ArrayList<>();
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

	public List<Donor> getDonors() {
		return this.donors;
	}

	/**
	 * 
	 * @param donor
	 */
	public String getOfficeIdByDonor(String donor) {
		return getDonorInstance(donor).getOfficeId();
	}

	/**
	 * 
	 * @param donor
	 */
	public boolean checkDonationPossibility(String donor) {
		return getDonorInstance(donor).canDonate();
	}

	/**
	 * 
	 * @param donor
	 */
	private Donor getDonorInstance(String donor) {
		return donors.stream().filter(don -> don.getMail().equals(donor)).findFirst().orElse(null);
	}

}