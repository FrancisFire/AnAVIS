package com.github.francisfire.anavis.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.github.francisfire.anavis.models.Office;

@Repository
public interface OfficeRepository extends MongoRepository<Office, String> {
}