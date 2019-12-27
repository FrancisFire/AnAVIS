package com.github.francisfire.anavis.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.github.francisfire.anavis.models.ActivePrenotation;

@Repository
public interface PrenotationRepository extends MongoRepository<ActivePrenotation, String> {
}