package entities;

import javax.persistence.*;

@Entity
@Table(name = "optional-product")
public class OptionalProduct {

    private int id;
    private String name;
    private float monthlyFee;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    @Column(name = "name", nullable = false)
    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    @Column(name = "monthlyfee", nullable = false)
    public Float getMonthlyFee(){
        return monthlyFee;
    }

    public void setMonthlyFee(float monthlyFee){
        this.monthlyFee = monthlyFee;
    }

}
