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
	 * @param donatore
	 */
	public String getOfficeIdByDonor(String donatore) {
		return getDonorInstance(donatore).getOfficeId();
	}

	/**
	 * 
	 * @param donatore
	 */
	public boolean checkDonationPossibility(String donatore) {
		return getDonorInstance(donatore).canDonate();
	}

	/**
	 * 
	 * @param donatore
	 */
	private Donor getDonorInstance(String donatore) {
		return donors.stream().filter(don -> don.getMail().equals(donatore)).findFirst().orElse(null);
	}

}