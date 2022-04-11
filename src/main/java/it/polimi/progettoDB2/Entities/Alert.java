package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "alert")
public class Alert {
    @Id
    @OneToOne
    private User user;

    private String email;

    private float amount;

    private Date datelastrejection;

    private Time timelastrejection;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public float getAmount(){
        return amount;
    }

    public void setAmount(float amount){
        this.amount = amount;
    }

    public Date getDatelastrejection(){
        return datelastrejection;
    }

    public void setDatelastrejection(Date daterejection){
        this.datelastrejection = daterejection;
    }

    public Time getTimelastrejection(){
        return timelastrejection;
    }

    public void setTimelastrejection(Time timelastrejection){
        this.timelastrejection = timelastrejection;
    }

}
