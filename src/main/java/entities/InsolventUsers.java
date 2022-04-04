package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "insolvent-users")
public class InsolventUsers {

    private String id;

    @Id
    @Column(name = "idinsolventuser", nullable = false)
    public String getId(){
        return id;
    }

    public void setId(String id){
        this.id = id;
    }

}
