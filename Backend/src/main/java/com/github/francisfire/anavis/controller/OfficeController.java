package com.github.francisfire.anavis.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.francisfire.anavis.services.OfficeServices;

@RestController
@RequestMapping("office")
public class OfficeController {
	
	private static OfficeServices officeServices = OfficeServices.getInstance();

}
