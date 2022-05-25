package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;


@Entity
@Table(name = "alert-history")
@NamedQuery(name = "AlertsHistory.getAllAlerts", query = "SELECT a FROM AlertHistory a")
public class AlertHistory {

    @Id
    private long id;
    @ManyToOne
    @JoinColumn(name = "username")
    private User user;

    private float amount;

    private Date datetimerejection;


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public float getAmount(){
        return amount;
    }

    public void setAmount(float amount){
        this.amount = amount;
    }

    public Date getDatetimerejection() {
        return datetimerejection;
    }

    public void setDatetimerejection(Date datetimerejection) {
        this.datetimerejection = datetimerejection;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
