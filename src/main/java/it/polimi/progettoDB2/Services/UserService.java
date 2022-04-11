package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserService {

    @PersistenceContext
    private EntityManager em;

    public List<ServicePackage> getServicePackages(){
        return em.createNamedQuery("ServicePackage.getAllPackages", ServicePackage.class)
                .getResultList();
    }

    public List<Order> getRejectedOrders(String username){
        return em.createNamedQuery("Order.findByStatusAndNickname", Order.class).setParameter(1, "Rejected").
                setParameter(2,username).getResultList();
    }
}
