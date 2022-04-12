package it.polimi.progettoDB2.Entities;

import javax.persistence.*;

@Entity
@Table(name = "insolvent-users")
public class InsolventUsers {

    @Id
    @OneToOne
    @JoinColumn(name = "idinsolventuser")
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
