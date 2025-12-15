package com.example.demo;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "attendance",
       uniqueConstraints = @UniqueConstraint(columnNames = {"employee_id", "date"}))
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(name = "employee_id", nullable = false)
    private String employeeId;

    @Column(nullable = false)
    private LocalDate date;

    @Column(name = "sign_in_time")
    private LocalDateTime signInTime;

    @Column(name = "sign_out_time")
    private LocalDateTime signOutTime;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public Attendance() {}

    public Attendance(String employeeId, LocalDate date) {
        this.employeeId = employeeId;
        this.date = date;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public LocalDateTime getSignInTime() { return signInTime; }
    public void setSignInTime(LocalDateTime signInTime) { this.signInTime = signInTime; }

    public LocalDateTime getSignOutTime() { return signOutTime; }
    public void setSignOutTime(LocalDateTime signOutTime) { this.signOutTime = signOutTime; }
}
