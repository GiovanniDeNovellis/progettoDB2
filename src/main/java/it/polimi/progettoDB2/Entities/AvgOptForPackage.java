package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "avg-opt-for-package")
@NamedQuery(name = "AvgOptForPackage.findByPackageID", query = "SELECT p FROM AvgOptForPackage p WHERE p.servicePackage.ID = ?1")
@NamedQuery(name = "AvgOptForPackage.getAllAvgOptForPackages", query = "SELECT p FROM AvgOptForPackage p")
public class AvgOptForPackage {
    @Id
    private long id;

    @OneToOne
    @JoinColumn(name = "servicePackage")
    private ServicePackage servicePackage;

    private int numOptTot;

    private int numsales;

    private float avgOptForSale;


    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public int getNumOptTot(){
        return numOptTot;
    }

    public void setNumOptTot(int numOptTot){
        this.numOptTot = numOptTot;
    }

    public int getNumsales(){
        return numsales;
    }

    public void setNumsales(int numsales){
        this.numsales = numsales;
    }

    public float getAvgOptForSale(){
        return avgOptForSale;
    }

    public void setAvgOptForSale(float avgOptForSale){
        this.avgOptForSale = avgOptForSale;
    }

    @Override
    public String toString() {
        return "AvgOptForPackage{" +
                "servicePackage=" + servicePackage.getID() +
                ", numOptTot=" + numOptTot +
                ", numsales=" + numsales +
                ", avgOptForSale=" + avgOptForSale +
                '}';
    }
}
