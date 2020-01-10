package com.github.francisfire.anavis.models;

import java.util.Set;

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
@Document(collection = "authcredentials")
public class AuthCredentials {
	
	@EqualsAndHashCode.Include
	@Id
	private String mail;
	private String password;
	private Set<Role> roles;

	public enum Role{
		DONOR, OFFICE, ADMIN;
	}
	
}
