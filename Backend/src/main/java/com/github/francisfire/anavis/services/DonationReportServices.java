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

	public String addReport(@NonNull String prenotationId, @NonNull MultipartFile reportFile) {
		ActivePrenotation prenotation = prenotationServices.getPrenotationInstance(prenotationId);
		DonationReport report = new DonationReport(prenotation.getDonorId(), prenotation.getOfficeId(),
				prenotation.getHour());
		try {
			report.setReportFile(new Binary(BsonBinarySubType.BINARY, reportFile.getBytes()));
			report = repository.insert(report);
		} catch (IOException e) {
			return null;
		}
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
		if (repository.findAll().contains(this.getReportInstance(reportId))) {
			repository.delete(getReportInstance(reportId));
			return true;
		} else {
			return false;
		}
	}

	public DonationReport getReportInstance(@NonNull String reportId) {
		return repository.findById(reportId).orElse(null);
	}

}
