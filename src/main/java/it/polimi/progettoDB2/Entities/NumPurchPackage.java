package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package")
@NamedQuery(name = "NumPurchPackage.findByPackageID", query = "SELECT p FROM NumPurchPackage p WHERE p.servicePackage.ID = ?1")
@NamedQuery(name = "NumPurchPackage.getAllNumPurchPackages", query = "SELECT p FROM NumPurchPackage p")
public class NumPurchPackage {
    @Id
    private long id;
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "packageid")
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

    @Override
    public String toString() {
        return "NumPurchPackage{" +
                "servicePackage=" + servicePackage.getID() +
                ", servicepackageName= " + servicePackage.getName() +
                ", numpurchases=" + numpurchases +
                '}';
    }
}

