package com.github.francisfire.anavis.models;

import java.util.Date;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.springframework.data.annotation.Id;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
abstract class Prenotation {

	@EqualsAndHashCode.Include
	@Id
	private String id;
	private String officeMail;
	private String donorMail;
	private Date hour;

	public Prenotation(String id, String officeMail, String donorMail, Date hour) {
		this.id = id;
		this.officeMail = officeMail;
		this.donorMail = donorMail;
		this.hour = hour;
	}

}
