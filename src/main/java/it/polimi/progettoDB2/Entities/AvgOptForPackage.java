package it.polimi.progettoDB2.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "avg-opt-for-package")
public class AvgOptForPackage {

    private int id;
    private int numOptTot;
    private int numsales;
    private int avgOptForSale;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id){
        this.id = id;
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
