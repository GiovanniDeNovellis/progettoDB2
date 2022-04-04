package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "alert")
public class Alert {

    private String email;
    private float amount;
    private Date datelastrejection;
    private Time timelastrejection;

    @Id
    @OneToOne(mappedBy = "userid")
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "email")
    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    @Column(name = "amount")
    public float getAmount(){
        return amount;
    }

    public void setAmount(float amount){
        this.amount = amount;
    }

    @Column(name = "datelastrejection")
    public Date getDatelastrejection(){
        return datelastrejection;
    }

    public void setDatelastrejection(Date daterejection){
        this.datelastrejection = daterejection;
    }

    @Column(name = "timelastrejection")
    public Time getTimelastrejection(){
        return timelastrejection;
    }

    public void setTimelastrejection(Time timelastrejection){
        this.timelastrejection = timelastrejection;
    }

}
