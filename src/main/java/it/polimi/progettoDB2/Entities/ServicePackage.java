package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "service-package", schema = "new_schema")
public class ServicePackage {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int ID;

    private String name;

    @OneToMany(mappedBy = "servicePackage")
    private Collection<Order> orders;

    @OneToMany(mappedBy = "service_package_id")
    private Collection<Service> services;

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

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
