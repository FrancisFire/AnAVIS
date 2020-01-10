package com.github.francisfire.anavis.models;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Setter;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
@Document(collection = "activeprenotation")
public class ActivePrenotation extends Prenotation {

	private boolean confirmed;

	public ActivePrenotation(String id, String officeMail, String donorMail, Date hour, boolean confirmed) {
		super(id, officeMail, donorMail, hour);
		this.confirmed = confirmed;
	}

}
