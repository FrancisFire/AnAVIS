package com.github.francisfire.anavis.models;

import java.util.Date;

public class ClosedPrenotation extends Prenotation {
	private String reportId;

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String id) {
		this.reportId = id;
	}

	public ClosedPrenotation(String id, String officeId, String donorId, Date hour, String reportId) {
		super(id, officeId, donorId, hour);
		this.reportId = reportId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((reportId == null) ? 0 : reportId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		ClosedPrenotation other = (ClosedPrenotation) obj;
		if (reportId == null) {
			if (other.reportId != null)
				return false;
		} else if (!reportId.equals(other.reportId))
			return false;
		return true;
	}
}
