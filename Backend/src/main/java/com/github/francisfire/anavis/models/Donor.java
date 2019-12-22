package com.github.francisfire.anavis.models;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class Donor {

	@EqualsAndHashCode.Include
	private String mail;
	private String officeId;
	private boolean canDonate;
	
	public Donor(String mail, String officeId) {
		this.mail = mail;
		this.officeId = officeId;
		this.canDonate = false;
	}

}