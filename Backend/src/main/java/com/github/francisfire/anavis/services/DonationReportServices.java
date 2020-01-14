package com.github.francisfire.anavis.services;

import java.io.IOException;

import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.DonationReport;
import com.github.francisfire.anavis.repository.DonationReportRepository;

import lombok.NonNull;

@Service
public class DonationReportServices {

	@Autowired
	private PrenotationServices prenotationServices;
	@Autowired
	private DonationReportRepository repository;

	/**
	 * Creates and adds a report to the report collection using the informations from a
	 * prenotation and a reportFile
	 * 
	 * @throws NullPointerException if prenotationId or reportFile is null
	 * @param prenotationId the id of the prenotation
	 * @param reportFile the file associated to the report
	 * @return the id of the created report, null if file upload failed
	 */
	public String addReport(@NonNull String prenotationId, @NonNull MultipartFile reportFile) {
		ActivePrenotation prenotation = prenotationServices.getPrenotationInstance(prenotationId);
		DonationReport report = new DonationReport(prenotation.getDonorMail(), prenotation.getOfficeMail(),
				prenotation.getHour());
		try {
			report.setReportFile(reportFile.getBytes());
		} catch (IOException e) {
			return null;
		}
		report = repository.insert(report);
		return report.getReportId();
	}

	/**
	 * Removes the report assigned to the reportId
	 * 
	 * @throws NullPointerException if reportId is null
	 * @param reportId the id of the report to remove
	 * @return true if the collections contained the report
	 */
	public boolean removeReport(@NonNull String reportId) {
		if (repository.existsById(reportId)) {
			repository.delete(getReportInstance(reportId));
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Gets the DonationReport instance associated to the reportId that has been
	 * passed in input to the method
	 * 
	 * @throws NullPointerException if id is null
	 * @param reportId id of the report
	 * @return the DonationReport object if present in the collection, null
	 *         otherwise
	 */
	public DonationReport getReportInstance(@NonNull String reportId) {
		return repository.findById(reportId).orElse(null);
	}

}
