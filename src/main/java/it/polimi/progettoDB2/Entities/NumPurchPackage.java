package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package")
public class NumPurchPackage {
    @Id
    @OneToOne
    private ServicePackage servicePackage;

    private int numpurchases;

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public int getNumpurchases(){
        return numpurchases;
    }

    public void setNumpurchases(int numpurchases){
        this.numpurchases = numpurchases;
    }

}
