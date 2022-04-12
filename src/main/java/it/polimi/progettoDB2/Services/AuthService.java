package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class AuthService {

    @PersistenceContext
    private EntityManager em;

    public User registerUser(String username, String password, String email, String type){
        List<User> usr;
        usr = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, username).setParameter(2, password).getResultList();
        if(!usr.isEmpty())
            return null;
        User user = new User(username, email, password, type);
        em.persist(user);
        return user;
    }

    public User authenticateUser(String username, String password){
        List<User> usr;
        usr = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, username).setParameter(2, password).getResultList();
        if(usr.isEmpty())
            return null;
        else if(usr.size()==1)
            return usr.get(0);
        else
            System.out.println("ERROR");
        return null;
    }
}
