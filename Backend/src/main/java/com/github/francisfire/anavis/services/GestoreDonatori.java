package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.List;

import com.github.francisfire.anavis.models.Donatore;

public class GestoreDonatori {

	private static GestoreDonatori instance;
	private List<Donatore> donors;

	private GestoreDonatori() {
		donors = new ArrayList<>();
	}

	public static GestoreDonatori getInstance() {
		if (instance == null) {
			instance = new GestoreDonatori();
		}

		return instance;
	}

	public boolean addDonor(Donatore donor) {
		return donors.add(donor);
	}

	/**
	 * 
	 * @param donatore
	 */
	public boolean checkDonationPossibility(String donatore) {
		return getDonorInstance(donatore).canDonate();
	}

	public List<Donatore> getDonors() {
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
	private Donatore getDonorInstance(String donatore) {
		return donors.stream().filter(don -> don.getMail().equals(donatore)).findFirst().orElse(null);
	}

}