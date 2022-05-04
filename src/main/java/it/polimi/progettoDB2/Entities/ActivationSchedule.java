package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "activation-schedule", schema = "new_schema")
@NamedQuery(name = "activationSchedule.findByOrderID", query = "SELECT o FROM ActivationSchedule o WHERE o.orderid.id = ?1")
@NamedQuery(name = "activationSchedule.findOptByOrderID", query = "SELECT o.optionalProduct FROM ActivationSchedule o  " +
        "WHERE o.orderid.id = ?1")
public class ActivationSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long bridge_id;

    @ManyToOne
    @JoinColumn(name = "package")
    private ServicePackage servicePackage;


    @ManyToOne
    @JoinColumn(name = "orderid")
    private Order orderid;


    @ManyToOne
    @JoinColumn(name = "optproduct")
    private OptionalProduct optionalProduct;

    private Date actdate;

    private Date deactdate;

    private String status;

    public ActivationSchedule(Order order, ServicePackage servicePackage, OptionalProduct optionalProduct, Date actdate, Date deactdate, String status) {
        this.servicePackage = servicePackage;
        this.optionalProduct = optionalProduct;
        this.actdate = actdate;
        this.deactdate = deactdate;
        this.orderid=order;
        this.status=status;
    }

    public ActivationSchedule(Order order, ServicePackage servicePackage, Date actdate, Date deactdate, String status) {
        this.servicePackage = servicePackage;
        this.actdate = actdate;
        this.deactdate = deactdate;
        this.orderid=order;
        this.status=status;
    }

    public ActivationSchedule() {

    }

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public Order getOrder() {
        return orderid;
    }

    public void setOrder(Order order) {
        this.orderid = order;
    }

    public OptionalProduct getOptionalProduct() {
        return optionalProduct;
    }

    public void setOptionalProduct(OptionalProduct optionalProduct) {
        this.optionalProduct = optionalProduct;
    }

    public Date getActdate() {
        return actdate;
    }

    public void setActdate(Date actdate) {
        this.actdate = actdate;
    }

    public Date getDeactdate() {
        return deactdate;
    }

    public void setDeactdate(Date deactdate) {
        this.deactdate = deactdate;
    }

    public long getBridge_id() {
        return bridge_id;
    }

    public void setBridge_id(int bridge_id) {
        this.bridge_id = bridge_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "PckgOptBridge{" +
                "servicePackage=" + servicePackage.getID() +
                ", order=" + orderid.getId() +
                ", optionalProduct=" + optionalProduct +
                ", actdate=" + actdate +
                ", deactdate=" + deactdate +
                ", status= " + status +
                '}';
    }
}
