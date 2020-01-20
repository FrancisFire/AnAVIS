package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.Donor;
import com.github.francisfire.anavis.models.RequestPrenotation;
import com.github.francisfire.anavis.repository.PrenotationRepository;

import lombok.NonNull;

@Service
public class PrenotationServices {

	@Autowired
	private OfficeServices officeServices;
	@Autowired
	private DonationServices donationServices;
	@Autowired
	private DonorServices donorServices;
	@Autowired
	private PrenotationRepository repository;

	/**
	 * Adds a prenotation to the prenotation collection from the request that has
	 * been passed as an input to the method. Decreases the time slot of the office.
	 * 
	 * @throws NullPointerException if request is null
	 * @param request the request from where data has been taken to create the
	 *                prenotation
	 * @return true if the donor associated with the request can donate and the
	 *         prenotation wasn't already present in the collection and timeslot was
	 *         available and has been correctly decreased, false otherwise
	 */
	public boolean addPrenotation(RequestPrenotation request) {
		Objects.requireNonNull(request);
		if (donorServices.checkDonationPossibility(request.getDonorMail())
				&& officeServices.decreaseTimeslotByOffice(request.getHour(), request.getOfficeMail())) {
			ActivePrenotation prenotation = new ActivePrenotation(request.getId(), request.getOfficeMail(),
					request.getDonorMail(), request.getHour(), true);
			if (repository.existsById(prenotation.getId())) {
				return false;
			} else {
				repository.insert(prenotation);
				return true;
			}
		}
		return false;
	}

	/**
	 * Returns a view of the collection of prenotations, modifying this view won't
	 * have effects on the original collection, however modifying the objects in it
	 * will have effects on the objects contained in the original collection.
	 * 
	 * @return a view of the prenotation collection
	 */
	public Set<ActivePrenotation> getPrenotations() {
		return new HashSet<>(repository.findAll());
	}

	/**
	 * Adds a prenotation to the prenotation collection and decreases by one the
	 * cardinality of the office timeslot at the date of prenotation
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to add
	 * @return true if the donor associated with the prenotation can donate and the
	 *         collection didn't contain the added prenotation and a timeslot was
	 *         present
	 */
	public boolean addPrenotation(@NonNull ActivePrenotation prenotation) {
		Date date = prenotation.getHour();
		String officeId = prenotation.getOfficeMail();
		if (donorServices.checkDonationPossibility(prenotation.getDonorMail())
				&& officeServices.decreaseTimeslotByOffice(date, officeId)) {
			if (repository.existsById(prenotation.getId())) {
				return false;
			} else {
				repository.insert(prenotation);
				return true;
			}
		} else {
			return false;
		}
	}

	/**
	 * Removes the prenotation assigned to the prenotationId from the prenotation
	 * collection and increases by one the cardinality of the timeslot of the office
	 * at the date of prenotation
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId the id of the prenotation to remove
	 * @return true if the collections contained the prenotation and the timeslot
	 *         was succesfully increased
	 */
	public boolean removePrenotation(@NonNull String prenotationId) {
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null) {
			return false;
		}
		Date date = prenotation.getHour();
		String officeId = prenotation.getOfficeMail();
		repository.delete(getPrenotationInstance(prenotationId));
		return officeServices.increaseTimeslotByOffice(date, officeId);

	}

	/**
	 * Updates the prenotation passed in input to the method in the prenotation
	 * collection, increases by one the cardinality of the timeslot of the office
	 * from the old prenotation and decreases the one associated to the new
	 * prenotation
	 * 
	 * 
	 * @throws NullPointerException if prenotation is null
	 * @param prenotation the prenotation to update
	 * @return true if the donor associated with the new prenotation can donate and
	 *         the prenotation was present and updates succesfully and timeslots
	 *         have been modified successfully, false otherwise
	 */
	public boolean updatePrenotation(@NonNull ActivePrenotation prenotation) {
		ActivePrenotation oldPrenotation = getPrenotationInstance(prenotation.getId());
		if (oldPrenotation == null) {
			return false;
		}
		Date oldDate = oldPrenotation.getHour();
		String oldOffice = oldPrenotation.getOfficeMail();

		Date newDate = prenotation.getHour();
		String newOffice = prenotation.getOfficeMail();
		if (donorServices.checkDonationPossibility(prenotation.getDonorMail())
				&& officeServices.decreaseTimeslotByOffice(newDate, newOffice)
				&& officeServices.increaseTimeslotByOffice(oldDate, oldOffice)) {
			repository.save(prenotation);
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Returns a collection of prenotations related to an office passed in input
	 * 
	 * @throws NullPointerException if officeId is null
	 * @param officeId id of the office
	 * @return collection of prenotations related to the office passed in input
	 */
	public Set<ActivePrenotation> getPrenotationsByOffice(@NonNull String officeId) {
		return repository.findAll().stream().filter(prenotation -> prenotation.getOfficeMail().equalsIgnoreCase(officeId))
				.collect(Collectors.toSet());
	}

	/**
	 * Returns a collection of prenotations related to a donor passed in input
	 * 
	 * @throws NullPointerException if donorId is null
	 * @param donorId id of the donor
	 * @return a collection of prenotations related to the donor passed in input
	 */
	public Set<ActivePrenotation> getPrenotationsByDonor(@NonNull String donorId) {
		return repository.findAll().stream().filter(prenotation -> prenotation.getDonorMail().equalsIgnoreCase(donorId))
				.collect(Collectors.toSet());
	}

	/**
	 * Accepts the changes made to the prenotation associated to the id given to the
	 * method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the prenotation
	 * @return false if prenotation was present and not already confirmed, true
	 *         otherwise
	 */
	public boolean acceptPrenotationChange(@NonNull String prenotationId) {
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null || prenotation.isConfirmed()) {
			return false;
		}
		prenotation.setConfirmed(true);
		repository.save(prenotation);
		return true;
	}

	/**
	 * Denies the changes made to the prenotation associated to the id given to the
	 * method and deletes such prenotation
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the prenotation
	 * @return true if prenotation was present and succesfully removed, false
	 *         otherwise
	 */
	public boolean denyPrenotationChange(@NonNull String prenotationId) {
		ActivePrenotation prenotation = getPrenotationInstance(prenotationId);
		if (prenotation == null || prenotation.isConfirmed()) {
			return false;
		}
		return this.removePrenotation(prenotationId);
	}

	/**
	 * Closes the currently active prenotation associated to the id that has been
	 * passed in input to the method
	 * 
	 * 
	 * @param prenotationId id of the prenotation that needs to be closed
	 * @param reportId      id of the report associated to the prenotation
	 * @return true if prenotation was present and succesfully closed, false
	 *         otherwise
	 */
	public boolean closePrenotation(@NonNull String prenotationId, String reportId) {
		if(reportId == null) {
			return false;
		}
		ActivePrenotation prenotation = this.getPrenotationInstance(prenotationId);
		if(prenotation == null) {
			return false;
		}
		if (prenotation.isConfirmed() 
				&& this.removePrenotation(prenotationId) && donationServices.addDonation(prenotation, reportId)) {
			String donorId = prenotation.getDonorMail();
			Date date = prenotation.getHour();
			Donor donor = donorServices.getDonorInstance(donorId);
			donor.setCanDonate(false);
			donor.setLastDonation(date);
			donorServices.updateDonor(donor);
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Gets the ActivePrenotation instance associated to the id that has been passed
	 * in input to the method
	 * 
	 * @throws NullPointerException if prenotationId is null
	 * @param prenotationId id of the request
	 * @return the Prenotation object if present in the collection, null otherwise
	 */
	public ActivePrenotation getPrenotationInstance(@NonNull String prenotationId) {
		return repository.findById(prenotationId).orElse(null);
	}

}