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
	private DonorCategory category;
	private int leftDonationsInYear;
	private Date firstDonationInYear;

	public Donor(String mail, String officeId, DonorCategory category) {
		this.mail = mail;
		this.officeId = officeId;
		this.canDonate = false;
		this.category = category;
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
		if (lastDonation.after(this.lastDonation)) {
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
}