package it.polimi.progettoDB2.Entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "package-opt-bridge", schema = "new_schema")
public class PckgOptBridge {

    @Id
    @ManyToOne
    @JoinColumn(name = "package")
    private ServicePackage servicePackage;

    @Id
    @ManyToOne
    @JoinColumn(name = "order")
    private Order order;

    @Id
    @ManyToOne
    @JoinColumn(name = "optproduct")
    private OptionalProduct optionalProduct;

    private Date actdate;

    private Date deactdate;

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
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
}
