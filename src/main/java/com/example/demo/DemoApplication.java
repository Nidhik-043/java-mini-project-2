package com.example.demo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @Bean
    CommandLineRunner seedDatabase(StaffRepository staffRepository) {
        return args -> {
            if (staffRepository.findByEmployeeId("EMP001").isEmpty()) {
                Staff s = new Staff("John Doe", "EMP001", "Sales", null);
                staffRepository.save(s);
                System.out.println("Seeded database with sample staff: EMP001");
            }
        };
    }
}
