package com.parking.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Car {
    @Id
    private Long id;
    private String licensePlate;
    private String parkingSport;
    @ManyToOne public User user;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getParkingSport() {
        return parkingSport;
    }

    public void setParkingSport(String parkingSport) {
        this.parkingSport = parkingSport;
    }

}
