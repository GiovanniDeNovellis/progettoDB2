package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "service", schema="new_schema")
@NamedQuery(name = "service.findUnassigned", query = "SELECT s FROM Service s WHERE s.servicePackage IS NULL")
public class Service {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long serviceid;

    private String name;

    private String type;

    private int minutes;

    private int sms;

    private Float extraminfee;

    private Float extrasmsfee;

    private int giga;

    private Float extragigafee;

    @ManyToOne
    @JoinColumn(name = "service_package_id")
    private ServicePackage servicePackage;

    public Service(String name, String type, int minutes, int sms, Float extraminfee, Float extrasmsfee, int giga, Float extragigafee) {
        this.name = name;
        this.type = type;
        this.minutes = minutes;
        this.sms = sms;
        this.extraminfee = extraminfee;
        this.extrasmsfee = extrasmsfee;
        this.giga = giga;
        this.extragigafee = extragigafee;
    }

    public Service() {

    }

    public long getServiceid() {
        return serviceid;
    }

    public void setServiceid(long serviceid) {
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
    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setExtraminfee(Float extraminfee) {
        this.extraminfee = extraminfee;
    }

    public void setExtrasmsfee(Float extrasmsfee) {
        this.extrasmsfee = extrasmsfee;
    }

    public void setExtragigafee(Float extragigafee) {
        this.extragigafee = extragigafee;
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
                '}';
    }
}
