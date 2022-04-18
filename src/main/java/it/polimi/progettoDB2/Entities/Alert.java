package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "alert")
@NamedQuery(name = "Alerts.getAllAlerts", query = "SELECT a FROM Alert a")
@NamedQuery(name = "Alerts.getAllAlertsByUser", query = "SELECT a FROM Alert a WHERE a.user.username = ?1")
public class Alert {
    @Id
    @OneToOne
    @JoinColumn(name = "username")
    private User username;

    private String email;

    private float amount;

    private Date datetimelastrejection;

    public Alert(User user, String email, float amount, Date datetimelastrejection) {
        this.username = user;
        this.email = email;
        this.amount = amount;
        this.datetimelastrejection = datetimelastrejection;
    }

    public Alert() {

    }

    public User getUser() {
        return username;
    }

    public void setUser(User user) {
        this.username = user;
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

    public Date getDatetimelastrejection() {
        return datetimelastrejection;
    }

    public void setDatetimelastrejection(Date datetimelastrejection) {
        this.datetimelastrejection = datetimelastrejection;
    }

    @Override
    public String toString() {
        return "Alert{" +
                "user=" + username +
                ", email='" + email + '\'' +
                ", amount=" + amount +
                ", datetimelastrejection=" + datetimelastrejection +
                '}';
    }
}
