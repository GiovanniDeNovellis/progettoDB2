package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package")
public class NumPurchPackage {

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

    @Column(name = "numpurchases")
    public int getNumpurchases(){
        return numpurchases;
    }

    public void setNumpurchases(int numpurchases){
        this.numpurchases = numpurchases;
    }

}
