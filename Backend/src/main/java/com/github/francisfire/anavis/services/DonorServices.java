package com.github.francisfire.anavis.services;

import java.util.HashSet;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.repository.DonorRepository;

@Service
public class DonorServices {

	/*
	 * private Set<Donor> donors;
	 * 
	 * public DonorServices() { this.donors = new HashSet<>(); }
	 */

	@Autowired
	private DonorRepository repository;

	/**
	 * Adds a donor to the donor collection
	 * 
	 * @throws NullPointerException if donor is null
	 * @param donor the donor to add
	 * @return true if the collection didn't contain the added donor
	 */
	public boolean addDonor(Donor donor) {
		repository.save(Objects.requireNonNull(donor));
		return true;
		// return donors.add(Objects.requireNonNull(donor));
	}

	/**
	 * Returns a view of the collection of donors, modifying this view won't have
	 * effects on the original collection, however modifying the objects in it will
	 * have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the donor collection
	 */
	public Set<Donor> getDonors() {
		return new HashSet<>(repository.findAll());
		// return new HashSet<>(this.donors);
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
		return (donor == null) ? null : donor.getOfficeId();
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
	 * Returns a collection of donors whose officePoint is the one associated to the
	 * id given to the method
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of donors associated to the office
	 */
	public Set<Donor> getDonorsByOfficeId(String officeId) {
		Objects.requireNonNull(officeId);
		return repository.findAll().stream().filter(donor -> donor.getOfficeId().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
		/*
		 * return donors.stream().filter(donor ->
		 * donor.getOfficeId().equalsIgnoreCase(officeId)) .collect(Collectors.toSet());
		 */
	}

	/**
	 * Returns a collection of donors whose officePoint is the one associated to the
	 * id given to the method and that can donate
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of donors associated to the office and that can donate
	 */
	public Set<Donor> getAvailableDonorsByOfficeId(String officeId) {
		Objects.requireNonNull(officeId);
		return repository.findAll().stream()
				.filter(donor -> donor.getOfficeId().equalsIgnoreCase(officeId) && donor.isCanDonate())
				.collect(Collectors.toSet());
		/*
		 * return donors.stream().filter(donor ->
		 * donor.getOfficeId().equalsIgnoreCase(officeId) && donor.isCanDonate())
		 * .collect(Collectors.toSet());
		 */
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
	public Donor getDonorInstance(String donorId) {
		Objects.requireNonNull(donorId);
		Optional<Donor> opt = repository.findById(donorId);
		return opt.isPresent() ? opt.get() : null;
		// return donors.stream().filter(donor ->
		// donor.getMail().equals(donorId)).findFirst().orElse(null);
	}

}