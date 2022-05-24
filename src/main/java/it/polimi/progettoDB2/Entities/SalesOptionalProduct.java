package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "sales-optional-product", schema = "new_schema")
@NamedQuery(name = "SalesOptionalProduct.getAllSalesOptionalProducts", query = "SELECT s FROM SalesOptionalProduct s")
@NamedQuery(name = "SalesOptionalProduct.findByProductId", query = "SELECT s FROM SalesOptionalProduct s WHERE s.optionalProduct.id=?1")
public class SalesOptionalProduct {

    @Id
    private long id;

    @OneToOne
    @JoinColumn(name = "optproductid")
    private OptionalProduct optionalProduct;

    private float totalsalesvalue;

    public OptionalProduct getOptionalProduct() {
        return optionalProduct;
    }

    public void setOptionalProduct(OptionalProduct optionalProduct) {
        this.optionalProduct = optionalProduct;
    }

    public float getTotalsalesvalue() {
        return totalsalesvalue;
    }

    public void setTotalsalesvalue(float totalsalesvalue) {
        this.totalsalesvalue = totalsalesvalue;
    }
}
