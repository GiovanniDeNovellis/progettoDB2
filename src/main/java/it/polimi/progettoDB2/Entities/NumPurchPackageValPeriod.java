package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package-val-period")
@NamedQuery(name = "NumPurchPackageValPeriod.findByPackageIdValPeriod", query = "SELECT p FROM NumPurchPackageValPeriod p WHERE " +
        "p.servicePackage.ID = ?1 AND p.valperiod = ?2")
public class NumPurchPackageValPeriod {

    @Id
    @ManyToOne
    @JoinColumn(name = "packageid")
    private ServicePackage servicePackage;

    private int valperiod;

    private int numpurchases;

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public int getValPeriod(){
        return valperiod;
    }

    public void setValPeriod(int valperiod){
        this.valperiod = valperiod;
    }

    public int getNumpurchases(){
        return numpurchases;
    }

    public void setNumpurchases(int numpurchases){
        this.numpurchases = numpurchases;
    }

    @Override
    public String toString() {
        return "NumPurchPackageValPeriod{" +
                "servicePackage=" + servicePackage.getID() +
                ", valperiod=" + valperiod +
                ", numpurchases=" + numpurchases +
                '}';
    }
}
