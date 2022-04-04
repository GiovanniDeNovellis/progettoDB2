package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "order", schema = "new_schema")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private Date creationdate;

    private int valperiod;

    private int totalvalue;

    private Date startdate;

    private String status;

    private int fee;

    @ManyToOne
    @JoinColumn(name = "username")
    private User user;

    @ManyToOne
    @JoinColumn(name = "ID")
    private ServicePackage servicePackage;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Date creationdate) {
        this.creationdate = creationdate;
    }

    public int getValperiod() {
        return valperiod;
    }

    public void setValperiod(int valperiod) {
        this.valperiod = valperiod;
    }

    public int getTotalvalue() {
        return totalvalue;
    }

    public void setTotalvalue(int totalvalue) {
        this.totalvalue = totalvalue;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getFee() {
        return fee;
    }

    public void setFee(int fee) {
        this.fee = fee;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }
}
