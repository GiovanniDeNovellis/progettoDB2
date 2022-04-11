package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package-val-period")
public class NumPurchPackageValPeriod {

    @Id
    @OneToOne
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


}
