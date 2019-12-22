package com.github.francisfire.anavis.models;

import java.util.Date;

import lombok.Setter;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
public class ActivePrenotation extends Prenotation {

	private boolean confirmed;

	public ActivePrenotation(String id, String officeId, String donorId, Date hour, boolean confirmed) {
		super(id, officeId, donorId, hour);
		this.confirmed = confirmed;
	}

}
