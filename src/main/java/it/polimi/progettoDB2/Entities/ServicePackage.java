package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "service-package", schema = "new_schema")
@NamedQuery(name = "ServicePackage.findAllPackages", query = "SELECT s FROM ServicePackage s ")
@NamedQuery(name = "ServicePackage.checkServicePackage", query = "SELECT s FROM ServicePackage s WHERE s.ID = ?1")
public class ServicePackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long ID;

    private String name;

    private float monthscost12;

    private float monthscost24;

    private float monthscost36;
    @OneToMany(mappedBy = "servicePackage", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private Collection<Order> orders;

    @OneToMany(mappedBy = "servicePackage", fetch = FetchType.EAGER)
    private Collection<Service> services;

    public ServicePackage(String name, float monthscost12, float monthscost24, float monthscost36) {
        this.name = name;
        this.monthscost12 = monthscost12;
        this.monthscost24 = monthscost24;
        this.monthscost36 = monthscost36;
    }

    public ServicePackage() {

    }
    public Collection<Service> getServices() {
        return services;
    }

    public void setServices(Collection<Service> services) {
        this.services = services;
    }

    public Collection<Order> getOrders() {
        return orders;
    }

    public void setOrders(Collection<Order> orders) {
        this.orders = orders;
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void addOrder(Order order){
        getOrders().add(order);
    }

    public float getMonthscost12() {
        return monthscost12;
    }

    public void setMonthscost12(float monthscost12) {
        this.monthscost12 = monthscost12;
    }

    public float getMonthscost24() {
        return monthscost24;
    }

    public void setMonthscost24(float monthscost24) {
        this.monthscost24 = monthscost24;
    }

    public float getMonthscost36() {
        return monthscost36;
    }

    public void setMonthscost36(float monthscost36) {
        this.monthscost36 = monthscost36;
    }

    @Override
    public String toString() {
        return "ServicePackage{" +
                "ID=" + ID +
                ", name='" + name + '\'' +
                ", monthscost12=" + monthscost12 +
                ", monthscost24=" + monthscost24 +
                ", monthscost36=" + monthscost36 +
                ", orders=" + orders +
                ", services=" + services +
                '}';
    }
}
