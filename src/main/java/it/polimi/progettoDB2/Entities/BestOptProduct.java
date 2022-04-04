package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "best-opt-product")
public class BestOptProduct {

    @Id
    @OneToOne(mappedBy = "productid")
    private OptionalProduct optionalProduct;

    public OptionalProduct getOptionalProduct() {
        return optionalProduct;
    }

    public void setOptionalProduct(OptionalProduct optionalProduct) {
        this.optionalProduct = optionalProduct;
    }
}
