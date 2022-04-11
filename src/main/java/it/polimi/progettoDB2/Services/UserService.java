package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class UserService {

    @PersistenceContext
    private EntityManager em;

    public List<ServicePackage> getServicePackages(){
        return em.createNamedQuery("ServicePackage.findAllPackages", ServicePackage.class)
                .getResultList();
    }

    public List<Order> getRejectedOrders(String username){
        return em.createNamedQuery("Order.findByStatusAndNickname", Order.class).setParameter(1, "Rejected").
                setParameter(2,username).getResultList();
    }

    public List<ServicePackage> getServicePackagesUser(String username){
        List<Order> activeOrders = em.createNamedQuery("Order.findByStatusAndNickname", Order.class).setParameter(1, "Valid").
                setParameter(2,username).getResultList();
        List<ServicePackage> packages = new ArrayList<>();
        for(Order order: activeOrders){
            packages.add(order.getServicePackage());
        }
        return packages;
    }

    public List<OptionalProduct> getOptionalProducts() {
        return em.createNamedQuery("OptionalProduct.findAllProducts", OptionalProduct.class).getResultList();
    }
}
