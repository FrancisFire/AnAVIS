package com.github.francisfire.anavis.services;

import java.io.IOException;
import java.util.Objects;
import java.util.Optional;

import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.francisfire.anavis.models.ActivePrenotation;
import com.github.francisfire.anavis.models.ClosedPrenotation;
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

	public DonationReport getReportInstance(String reportId) {
		Objects.requireNonNull(reportId);
		Optional<DonationReport> opt = repository.findById(reportId);
		return opt.orElse(null);
	}

	public boolean removeReport(String reportId) {
		if (repository.findAll().contains(this.getReportInstance(reportId))) {
			repository.delete(getReportInstance(Objects.requireNonNull(reportId)));
			return true;
		} else {
			return false;
		}
	}

}
