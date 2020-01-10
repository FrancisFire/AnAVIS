package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.repository.DonorRepository;

import lombok.NonNull;

@Service
public class DonorServices {

	@Autowired
	private DonorRepository repository;

	/**
	 * Adds a donor to the donor collection
	 * 
	 * @throws NullPointerException if donor is null
	 * @param donor the donor to add
	 * @return true if the collection didn't contain the added donor
	 */
	public boolean addDonor(@NonNull Donor donor) {
		if (repository.existsById(donor.getMail())) {
			return false;
		} else {
			repository.save(donor);
			return true;
		}
	}
	
	/**
	 * Updates the donor passed in input to the method in the donor
	 * collection
	 * 
	 * @throws NullPointerException if donor is null
	 * @param donor the donor to update
	 * @return true if the donor was present and updated succesfully
	 */
	public boolean updateDonor(@NonNull Donor donor) {
		Donor oldDonor = getDonorInstance(donor.getMail());
		if(oldDonor == null) {
			return false;
		}
		repository.save(donor);
		return true;
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
	public String getOfficeIdByDonor(@NonNull String donorId) {
		Donor donor = getDonorInstance(donorId);
		return (donor == null) ? null : donor.getOfficeMail();
	}

	/**
	 * Checks if the donor whose id has been passed as an input to the function can
	 * donate or not.
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId the id of the donor
	 * @return true if the donor can donate, false otherwise
	 */
	public boolean checkDonationPossibility(@NonNull String donorId) {
		Donor donor = getDonorInstance(donorId);
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
	public Set<Donor> getDonorsByOfficeId(@NonNull String officeId) {
		return repository.findAll().stream().filter(donor -> donor.getOfficeMail().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a collection of donors whose officePoint is the one associated to the
	 * id given to the method and that can donate
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of donors associated to the office and that can donate
	 */
	public Set<Donor> getAvailableDonorsByOfficeId(@NonNull String officeId) {
		return repository.findAll().stream()
				.filter(donor -> donor.getOfficeMail().equalsIgnoreCase(officeId) && donor.isCanDonate())
				.collect(Collectors.toSet());
	}

	/**
	 * Removes the donor assigned to the donorId 
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId the id of the donor to remove
	 * @return true if the collections contained the donor
	 */
	public boolean removeDonor(@NonNull String donorId) {
		if (repository.existsById(donorId)) {
			repository.delete(getDonorInstance(donorId));
			return true;
		} else {
			return false;
		}
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
	public Donor getDonorInstance(@NonNull String donorId) {
		return repository.findById(donorId).orElse(null);
	}

	@Scheduled(cron = "0 0 * * * ?")
	public void updateDonorsAvailability() {
		Date currentDate = new Date();
		for (Donor donor : repository.findAll()) {
			if (donor.getFirstDonationInYear() != null) {
				long differenceFirstYearDonation = currentDate.getTime() - donor.getFirstDonationInYear().getTime();
				if (differenceFirstYearDonation >= 365 * 24 * 60 * 60 * 1000) {
					donor.resetLeftDonationsInYear();
				}
			}
			if (donor.getLastDonation() != null) {
				long differenceLastDonation = currentDate.getTime() - donor.getLastDonation().getTime();
				if (differenceLastDonation >= 90 * 24 * 60 * 60 * 1000 && donor.getLeftDonationsInYear() > 0) {
					donor.setCanDonate(true);
				}
			}
			repository.save(donor);
		}
	}
}