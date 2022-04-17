package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
@Entity
@Table(name = "suspended-orders", schema = "new_schema")
@NamedQuery(name = "SuspendedOrders.findAllSuspendedOrders", query = "SELECT s FROM SuspendedOrders s")
public class SuspendedOrders {

    @Id
    @OneToOne
    @JoinColumn(name = "idsuspendedorders")
    private Order order;

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}
