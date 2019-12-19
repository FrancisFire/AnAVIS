package com.github.francisfire.anavis.models;

import java.util.Date;

public class ActivePrenotation extends Prenotation {
	private boolean confirmed;

	public ActivePrenotation(String id, String officeId, String donorId, Date hour) {
		super(id, officeId, donorId, hour);
		confirmed = true;
	}

	public boolean isConfirmed() {
		return confirmed;
	}

	public void setConfirmed(boolean confirmed) {
		this.confirmed = confirmed;
	}
}
