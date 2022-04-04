package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "alert-history")
public class AlertHistory {

    private String username;
    private float amount;
    private Date daterejection;
    private Time timerejection;

    @Id
    @Column(name = "username", nullable = false)
    public String getUsername(){
        return username;
    }

    public void setUsername(String username){
        this.username = username;
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
