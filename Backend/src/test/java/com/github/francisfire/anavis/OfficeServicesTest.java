package com.github.francisfire.anavis;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.github.francisfire.anavis.services.OfficeServices;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class OfficeServicesTest {
	
	private static OfficeServices officeServices;
	
	@BeforeAll
	public static void setUp() {
		officeServices = OfficeServices.getInstance();
	}
	
	@Test
	public static void addOffice() {
	}

}
