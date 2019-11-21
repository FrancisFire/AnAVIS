package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.francisfire.anavis.models.UfficioAVIS;

public class GestoreUffici {

	private static GestoreUffici instance;
	private List<UfficioAVIS> uffici;

	private GestoreUffici() {
		this.uffici = new ArrayList<>();
	}
	
	public static GestoreUffici getInstance() {
		if(instance == null) {
			
		}
		
		return instance;
	}

	public List<UfficioAVIS> getUffici() {
		return this.uffici;
	}

	/**
	 * 
	 * @param ufficio
	 */
	public Date[] ottieniOrariDonazioni(String ufficio) {
		// TODO - implement GestoreUffici.ottieniOrariDonazioni
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param ufficio
	 */
	public UfficioAVIS getIstanzaUfficio(String ufficio) {
		// TODO - implement GestoreUffici.getIstanzaUfficio
		throw new UnsupportedOperationException();
	}

}