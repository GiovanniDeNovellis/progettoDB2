package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package-val-period")
public class NumPurchPackageValPeriod {

    private int valperiod;
    private int numpurchases;

    @Id
    @OneToOne(mappedBy = "packageid")
    private ServicePackage servicePackage;
    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    @Column(name = "valperiod", nullable = false)
    public int getValPeriod(){
        return valperiod;
    }

    public void setValPeriod(int valperiod){
        this.valperiod = valperiod;
    }

    @Column(name = "numpurchases")
    public int getNumpurchases(){
        return numpurchases;
    }

    public void setNumpurchases(int numpurchases){
        this.numpurchases = numpurchases;
    }


}
