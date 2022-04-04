package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "sales-package", schema = "new_schema")
public class SalesOfPackage {

    @Id
    @ManyToOne
    @JoinColumn(name = "id")
    private ServicePackage servicePackage;

    private float totalwithopt;

    private float totalwithoutopt;

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public float getTotalwithopt() {
        return totalwithopt;
    }

    public void setTotalwithopt(float totalwithopt) {
        this.totalwithopt = totalwithopt;
    }

    public float getTotalwithoutopt() {
        return totalwithoutopt;
    }

    public void setTotalwithoutopt(float totalwithoutopt) {
        this.totalwithoutopt = totalwithoutopt;
    }
}
