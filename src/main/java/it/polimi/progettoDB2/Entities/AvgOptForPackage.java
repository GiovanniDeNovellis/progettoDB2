package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "avg-opt-for-package")
public class AvgOptForPackage {
    @Id
    @OneToOne(mappedBy = "id")
    private ServicePackage servicePackage;

    private int numOptTot;

    private int numsales;

    private int avgOptForSale;


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

    public int getAvgOptForSale(){
        return avgOptForSale;
    }

    public void setAvgOptForSale(int avgOptForSale){
        this.avgOptForSale = avgOptForSale;
    }


}
