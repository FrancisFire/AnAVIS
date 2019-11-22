package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.francisfire.anavis.models.Office;

public class OfficeServices {

	private static OfficeServices instance;
	private List<Office> uffici;

	private OfficeServices() {
		this.uffici = new ArrayList<>();
	}
	
	/**
	 * 
	 * 
	 * @return instance
	 */
	public static OfficeServices getInstance() {
		if(instance == null) {
			
		}
		
		return instance;
	}

	/**
	 * 
	 * @param ufficio
	 */
	public Office getIstanzaUfficio(String ufficio) {
		return uffici.stream().filter(uff -> uff.getName().equals(ufficio)).findFirst().orElse(null);
	}

	/**
	 * 
	 * @return uffici
	 */
	public List<Office> getUffici() {
		return this.uffici;
	}

	/**
	 * 
	 * @param ufficio
	 */
	public Date[] ottieniOrariDonazioni(String ufficio) {
		return getIstanzaUfficio(ufficio).getDonationHours();
	}

}