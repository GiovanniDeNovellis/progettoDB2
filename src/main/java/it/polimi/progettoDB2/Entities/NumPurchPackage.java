package it.polimi.progettoDB2.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "num-purch-package")
public class NumPurchPackage {

    private int packageid;
    private int numpurchases;

    @Id
    @Column(name = "packageid", nullable = false)
    public int getPackageid(){
        return packageid;
    }

    public void setPackageid(int packageid){
        this.packageid = packageid;
    }

    @Column(name = "numpurchases")
    public int getNumpurchases(){
        return numpurchases;
    }

    public void setNumpurchases(int numpurchases){
        this.numpurchases = numpurchases;
    }

}
