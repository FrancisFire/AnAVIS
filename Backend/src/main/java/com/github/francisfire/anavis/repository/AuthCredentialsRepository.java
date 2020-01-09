package com.github.francisfire.anavis.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.github.francisfire.anavis.models.AuthCredentials;

public interface AuthCredentialsRepository extends MongoRepository<AuthCredentials, String> {
}
