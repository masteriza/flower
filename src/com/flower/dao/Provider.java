package com.flower.dao;

/**
 * Created by user on 14.08.2015.
 */
public class Provider {
    int providerId;
    String provider;
    Double longitude;
    Double latitude;

    public Provider(int anInt, String string) {

    }

    public Provider(int providerId, String provider, Double longitude, Double latitude) {
        this.providerId = providerId;
        this.provider = provider;
        this.longitude = longitude;
        this.latitude = latitude;
    }

    public int getProviderId() {
        return providerId;
    }

    public void setProviderId(int providerId) {
        this.providerId = providerId;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public Double getlongitude() {
        return longitude;
    }

    public void setlongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getlatitude() {
        return longitude;
    }

    public void setlatitude(Double latitude) {
        this.latitude = latitude;
    }
}
