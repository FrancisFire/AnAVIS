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
	private String officeMail;
	private boolean canDonate;
	private Date lastDonation;
	private DonorCategory category;
	private String name;
	private String surname;
	private Date birthday;
	private String birthPlace;
	private int leftDonationsInYear;
	private Date firstDonationInYear;

	public Donor(String mail, String officeMail, DonorCategory category) {
		this.mail = mail;
		this.officeMail = officeMail;
		this.category = category;
		this.canDonate = true;
		resetLeftDonationsInYear();
	}
	
	public Donor(String mail, String officeMail, DonorCategory category, String name, String surname, Date birthday, String birthPlace) {
		this.mail = mail;
		this.officeMail = officeMail;
		this.category = category;
		this.canDonate = true;
		this.name = name;
		this.surname = surname;
		this.birthday = birthday;
		this.birthPlace = birthPlace;
		resetLeftDonationsInYear();
	}

	public void resetLeftDonationsInYear() {
		if (leftDonationsInYear == 0) {
			switch (category) {
			case MAN:
			case NONFERTILEWOMAN:
				this.leftDonationsInYear = 4;
				break;
			case FERTILEWOMAN:
				this.leftDonationsInYear = 2;
				break;
			}
		}
	}

	public void setLastDonation(Date lastDonation) {
		if (this.lastDonation == null || lastDonation.after(this.lastDonation)) {
			this.lastDonation = lastDonation;
			switch (category) {
			case MAN:
			case NONFERTILEWOMAN:
				if (leftDonationsInYear == 4) {
					firstDonationInYear = lastDonation;
				}
				break;
			case FERTILEWOMAN:
				if (leftDonationsInYear == 2) {
					firstDonationInYear = lastDonation;
				}
				break;
			}
			leftDonationsInYear--;
		}
	}

	public enum DonorCategory {
		MAN, FERTILEWOMAN, NONFERTILEWOMAN
	}
}