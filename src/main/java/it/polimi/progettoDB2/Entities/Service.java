package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Service {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int serviceid;

    private String type;

    private int minutes;

    private int sms;

    private Float extraminfee;

    private Float extrasmsfee;

    private int giga;

    private Float extragigafee;

    private java.sql.Date activationdate;

    private java.sql.Date deactivationdate;

    public Service(String type, int minutes, int sms, Float extraminfee, Float extrasmsfee, int giga, Float extragigafee, java.sql.Date activationdate, java.sql.Date deactivationdate) {
        this.type = type;
        this.minutes = minutes;
        this.sms = sms;
        this.extraminfee = extraminfee;
        this.extrasmsfee = extrasmsfee;
        this.giga = giga;
        this.extragigafee = extragigafee;
        this.activationdate = activationdate;
        this.deactivationdate = deactivationdate;
    }


    @ManyToOne
    @JoinColumn(name = "service_package_id")
    private ServicePackage servicePackage;

    public Service() {

    }

    public int getServiceid() {
        return serviceid;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public int getSms() {
        return sms;
    }

    public void setSms(int sms) {
        this.sms = sms;
    }

    public float getExtraminfee() {
        return extraminfee;
    }

    public void setExtraminfee(float extraminfee) {
        this.extraminfee = extraminfee;
    }

    public float getExtrasmsfee() {
        return extrasmsfee;
    }

    public void setExtrasmsfee(float extrasmsfee) {
        this.extrasmsfee = extrasmsfee;
    }

    public int getGiga() {
        return giga;
    }

    public void setGiga(int giga) {
        this.giga = giga;
    }

    public float getExtragigafee() {
        return extragigafee;
    }

    public void setExtragigafee(float extragigafee) {
        this.extragigafee = extragigafee;
    }

    public Date getActivationdate() {
        return activationdate;
    }

    public void setActivationdate(java.sql.Date activationdate) {
        this.activationdate = activationdate;
    }

    public Date getDeactivationdate() {
        return deactivationdate;
    }

    public void setDeactivationdate(java.sql.Date deactivationdate) {
        this.deactivationdate = deactivationdate;
    }

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    @Override
    public String toString() {
        return "Service{" +
                "serviceid=" + serviceid +
                ", type='" + type + '\'' +
                ", minutes=" + minutes +
                ", sms=" + sms +
                ", extraminfee=" + extraminfee +
                ", extrasmsfee=" + extrasmsfee +
                ", giga=" + giga +
                ", extragigafee=" + extragigafee +
                ", activationdate=" + activationdate +
                ", deactivationdate=" + deactivationdate +
                '}';
    }
}
