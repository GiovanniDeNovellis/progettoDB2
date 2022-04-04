package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "user", schema = "new_schema")
public class User {

    @Id
    private String username;

    private String email;

    private String password;

    private String type;

    private boolean isInsolvent;

    @OneToMany(mappedBy = "user")
    private Collection<Order> orders;

    public Collection<Order> getOrders() {
        return orders;
    }

    public void setOrders(Collection<Order> orders) {
        this.orders = orders;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isInsolvent() {
        return isInsolvent;
    }

    public void setInsolvent(boolean insolvent) {
        isInsolvent = insolvent;
    }
}
