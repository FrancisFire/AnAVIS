package com.github.francisfire.anavis.models;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Document(collection = "donor")
public class Donor {

	@EqualsAndHashCode.Include
	@Id
	private String mail;
	private String officeId;
	private boolean canDonate;
	private Date lastDonation;
	
	public Donor(String mail, String officeId) {
		this.mail = mail;
		this.officeId = officeId;
		this.canDonate = false;
	}

}