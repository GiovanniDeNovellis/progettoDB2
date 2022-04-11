package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "optional-product")
@NamedQuery(name = "OptionalProduct.findAllProducts", query = "SELECT o FROM OptionalProduct o")
public class OptionalProduct {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private float monthlyFee;

    public int getId() {
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public Float getMonthlyFee(){
        return monthlyFee;
    }

    public void setMonthlyFee(float monthlyFee){
        this.monthlyFee = monthlyFee;
    }

    @Override
    public String toString() {
        return "OptionalProduct{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", monthlyFee=" + monthlyFee +
                '}';
    }
}
