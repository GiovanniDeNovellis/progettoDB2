package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "avg-opt-for-package")
public class AvgOptForPackage {

    private int numOptTot;
    private int numsales;
    private int avgOptForSale;

    @Id
    @OneToOne(mappedBy = "id")
    private ServicePackage servicePackage;

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    @Column(name = "numopttot")
    public int getNumOptTot(){
        return numOptTot;
    }

    public void setNumOptTot(int numOptTot){
        this.numOptTot = numOptTot;
    }

    @Column(name = "numsales", nullable = false)
    public int getNumsales(){
        return numsales;
    }

    public void setNumsales(int numsales){
        this.numsales = numsales;
    }

    @Column(name = "avgoptforsale")
    public int getAvgOptForSale(){
        return avgOptForSale;
    }

    public void setAvgOptForSale(int avgOptForSale){
        this.avgOptForSale = avgOptForSale;
    }


}
