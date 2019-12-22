package com.github.francisfire.anavis.models;

import java.util.Date;

public class ActivePrenotation extends Prenotation {
	private boolean confirmed;

	public ActivePrenotation() {}
	public ActivePrenotation(String id, String officeId, String donorId, Date hour, boolean conf) {
		super(id, officeId, donorId, hour);
		confirmed = conf;
	}

	public boolean isConfirmed() {
		return confirmed;
	}

	public void setConfirmed(boolean confirmed) {
		this.confirmed = confirmed;
	}
}
