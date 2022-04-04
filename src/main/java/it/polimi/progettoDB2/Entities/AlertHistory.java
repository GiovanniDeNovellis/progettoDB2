package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "alert-history")
public class AlertHistory {

    private float amount;
    private Date daterejection;
    private Time timerejection;

    @Id
    @ManyToOne
    @JoinColumn(name = "username")
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "amount")
    public float getAmount(){
        return amount;
    }

    public void setAmount(float amount){
        this.amount = amount;
    }

    @Column(name = "daterejection")
    public Date getDaterejection(){
        return daterejection;
    }

    public void setDaterejection(Date daterejection){
        this.daterejection = daterejection;
    }

    @Column(name = "timerejection")
    public Time getTimerejection(){
        return timerejection;
    }

    public void setTimerejection(Time timerejection){
        this.timerejection = timerejection;
    }


}
