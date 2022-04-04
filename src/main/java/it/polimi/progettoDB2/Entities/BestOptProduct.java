package it.polimi.progettoDB2.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "best-opt-product")
public class BestOptProduct {

    private int productid;

    @Id
    @Column(name = "productid", nullable = false)
    public int getProductid(){
        return productid;
    }

    public void setProductid(int productid){
        this.productid = productid;
    }

}
