package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
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
        return em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, "Rejected").
                setParameter(2,username).getResultList();
    }

    public List<ServicePackage> getServicePackagesUser(String username){
        List<Order> activeOrders = em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, "Valid").
                setParameter(2,username).getResultList();
        List<ServicePackage> packages = new ArrayList<>();
        for(Order order: activeOrders){
            packages.add(order.getServicePackage());
        }
        return packages;
    }


    public Order addOrder(Date creationDate, int valPeriod, int totalValue, Date starDate, int fee, int packageID, String username, List<Integer> optProductIDs) {
        String status = "Created";
        User user = em.find(User.class, username);
        ServicePackage servicePackage;
        servicePackage = em.find(ServicePackage.class, packageID);
        Order order = new Order(creationDate, valPeriod, totalValue, starDate, status, user, servicePackage, fee);
        em.persist(order);

        /* Create the tuples of package-opt-bridge related to the order */

        Calendar c = Calendar.getInstance();
        c.setTime(creationDate);
        c.add(Calendar.MONTH, valPeriod);
        Date pckgBridgeDeactDate = (Date) c.getTime();

        for(Integer integer : optProductIDs) {
            PckgOptBridge pckgOptBridge = new PckgOptBridge();
            pckgOptBridge.setServicePackage(servicePackage);
            pckgOptBridge.setOptionalProduct(em.find(OptionalProduct.class, integer));
            pckgOptBridge.setOrder(order);
            pckgOptBridge.setActdate(creationDate);
            pckgOptBridge.setDeactdate(pckgBridgeDeactDate);
            em.persist(pckgOptBridge);
        }

        return order;
    }

    /* To modify */
    public Order validateOrder(int orderID) {
        String status = "Valid";
        Order order;
        order = em.find(Order.class, orderID);
        order.setStatus(status);
        em.persist(order);
        return order;
    }

    /* To modify */
    public Order failOrder(int orderID){
        String status = "Failed";
        Order order;
        order = em.find(Order.class, orderID);
        order.setStatus(status);
        em.persist(order);
        return order;
    }

    public List<OptionalProduct> getOptionalProducts() {
        try {
            return em.createNamedQuery("OptionalProduct.findAllProducts", OptionalProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

}
