package com.parking.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Car {
    @Id
    private Long id;
    private String licensePlate;
    private String parkingSpot;
    @ManyToOne public User owner;

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

    public String getParkingSpot() {
        return parkingSpot;
    }

    public void setParkingSport(String parkingSpot) {
        this.parkingSpot = parkingSpot;
    }
    public User getOwner() {
        return owner;
    }

}
