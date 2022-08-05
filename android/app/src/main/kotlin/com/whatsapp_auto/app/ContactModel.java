package com.whatsapp_auto.app;

public class ContactModel {
    String displayName;
    String mobileNumber;
    String avatar;

    public ContactModel(String displayName, String mobileNumber, String avatar) {
        this.displayName = displayName;
        this.mobileNumber = mobileNumber;
        this.avatar = avatar;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }


}
