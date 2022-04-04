package entities;

import javax.persistence.*;

@Entity
@Table(name = "num-purch-package-val-period")
public class NumPurchPackageValPeriod {

    private int packageid;
    private int valperiod;
    private int numpurchases;

    @Id
    @Column(name = "packageid", nullable = false)
    public int getPackageid(){
        return packageid;
    }

    public void setPackageid(int packageid){
        this.packageid = packageid;
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
