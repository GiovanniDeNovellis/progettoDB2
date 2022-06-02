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

    /* This method will first check for an already existing user with the nickname and email inserted.
      If an user is found, it won't register the new user otherwise it will create the user object and add it to the database.*/
    public User registerUser(String username, String password, String email, String type){
        List<User> usr;
        usr = em.createNamedQuery("User.checkExisting", User.class).setParameter(1, username).setParameter(2, email).getResultList();
        if(!usr.isEmpty())
            return null;
        User user = new User(username, email, password, type);
        em.persist(user);
        return user;
    }

    /* This method wil check for an existing user with the username, password and type inserted. If found, it will return
    * the user data, otherwise will return null.*/
    public User authenticateUser(String username, String password, String type){
        List<User> usr;
        usr = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, username)
                .setParameter(2, password).setParameter(3, type).getResultList();
        if(usr.isEmpty())
            return null;
        else if(usr.size()==1)
            return usr.get(0);
        else
            System.err.println("INVALID DATABASE STATE");
        return null;
    }
}
