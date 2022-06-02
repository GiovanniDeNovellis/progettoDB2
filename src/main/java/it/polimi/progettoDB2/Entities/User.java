package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "user", schema = "new_schema")
@NamedQuery(name = "User.checkCredentials", query = "SELECT u FROM User u WHERE u.username = ?1 AND u.password = ?2 AND u.type = ?3")
@NamedQuery(name = "User.checkExisting", query = "SELECT u FROM User u WHERE u.username = ?1 OR u.email = ?2")
public class User {

    @Id
    private String username;

    private String email;

    private String password;

    private String type;

    private boolean isInsolvent;

    private int numRejections;



    public User(String username, String email, String password, String type) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.type = type;
        this.isInsolvent = false;
        this.numRejections=0;
    }

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private Collection<Order> orders;

    public User() {

    }

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

    public void addOrder(Order order){
        getOrders().add(order);
    }

    public int getNumRejections() {
        return numRejections;
    }

    public void setNumRejections(int numRejections) {
        this.numRejections = numRejections;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", type='" + type + '\'' +
                ", isInsolvent=" + isInsolvent +
                '}';
    }
}
