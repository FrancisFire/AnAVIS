package com.github.francisfire.anavis.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.github.francisfire.anavis.models.RequestPrenotation;

@Repository
public interface RequestRepository extends MongoRepository<RequestPrenotation, String> {
}