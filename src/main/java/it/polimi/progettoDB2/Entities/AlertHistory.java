package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "alert-history")
public class AlertHistory {

    @Id
    private long id;
    @ManyToOne
    @JoinColumn(name = "username")
    private User user;

    private float amount;

    private Date daterejection;

    private Time timerejection;

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

    public Date getDaterejection(){
        return daterejection;
    }

    public void setDaterejection(Date daterejection){
        this.daterejection = daterejection;
    }

    public Time getTimerejection(){
        return timerejection;
    }

    public void setTimerejection(Time timerejection){
        this.timerejection = timerejection;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
