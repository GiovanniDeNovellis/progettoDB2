package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "best-opt-product")
@NamedQuery(name = "BestOptProduct.findAllBestOptProduct", query = "SELECT b FROM BestOptProduct b")
public class BestOptProduct {

    @Id
    @OneToOne
    @JoinColumn(name = "productid")
    private OptionalProduct optionalProduct;

    public OptionalProduct getOptionalProduct() {
        return optionalProduct;
    }

    public void setOptionalProduct(OptionalProduct optionalProduct) {
        this.optionalProduct = optionalProduct;
    }
}
