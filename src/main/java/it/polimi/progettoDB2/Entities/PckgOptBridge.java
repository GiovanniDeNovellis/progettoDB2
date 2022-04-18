package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "package-opt-bridge", schema = "new_schema")
public class PckgOptBridge {

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

    public PckgOptBridge(Order order,ServicePackage servicePackage, OptionalProduct optionalProduct, Date actdate, Date deactdate) {
        this.servicePackage = servicePackage;
        this.optionalProduct = optionalProduct;
        this.actdate = actdate;
        this.deactdate = deactdate;
        this.orderid=order;
    }

    public PckgOptBridge() {

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

    @Override
    public String toString() {
        return "PckgOptBridge{" +
                "servicePackage=" + servicePackage.getID() +
                ", order=" + orderid.getId() +
                ", optionalProduct=" + optionalProduct.getId() +
                ", actdate=" + actdate +
                ", deactdate=" + deactdate +
                '}';
    }
}
