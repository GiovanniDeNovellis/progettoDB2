package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Stateless
public class CustomerService {

    @PersistenceContext
    private EntityManager em;

    public List<ServicePackage> getServicePackages(){
        return em.createNamedQuery("ServicePackage.findAllPackages", ServicePackage.class)
                .getResultList();
    }

    public List<Order> getSuspendedOrders(String username){
        return em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, "Suspended").
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

    public List<OptionalProduct> getAvailableProducts(int packageID){
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        return (List<OptionalProduct>) servicePackage.getAvailableProducts();
    }

    public Order addOrder(Date creationDate, int valPeriod, Date startDate, int fee, int packageID, String username, List<Integer> optProductIDs) {
        String status = "Created";
        User user = em.find(User.class, username);
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        int totalValue = calculateTotalValue(valPeriod, fee, servicePackage, optProductIDs);
        Order order = new Order(creationDate, valPeriod, totalValue, startDate, status, user, servicePackage, fee);
        em.persist(order);
        createOrderSchedule(order, optProductIDs, startDate, valPeriod, servicePackage);
        return order;
    }

    public int calculateTotalValue(int valPeriod, int fee, ServicePackage servicePackage, List<Integer> optProductIDs){
        int totalValue = valPeriod*fee;
        for(Integer id: optProductIDs){
            OptionalProduct opt = em.find(OptionalProduct.class, id);
            totalValue+= opt.getMonthlyFee()*valPeriod;
        }
        return totalValue;
    }

    private void createOrderSchedule(Order order, List<Integer> optProductIDs, Date startDate, int valPeriod, ServicePackage servicePackage){
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.add(Calendar.MONTH, valPeriod);
        Date pckgBridgeDeactDate = c.getTime();
        for(Integer integer : optProductIDs) {
            OptionalProduct prod = em.find(OptionalProduct.class, integer);
            ActivationSchedule activationSchedule = new ActivationSchedule(order, servicePackage, prod, startDate, pckgBridgeDeactDate, "Created");
            em.persist(activationSchedule);
        }
    }

    public Order validateOrder(int orderID) {
        String status = "Valid";
        Order order;
        order = em.find(Order.class, orderID);
        checkInsolventAndRemove(orderID, order.getUser().getUsername());
        order.setStatus(status);
        validateOrderSchedule(orderID);
        return order;
    }

    private void validateOrderSchedule(int orderID){
        List <ActivationSchedule> orderSchedule = em.createNamedQuery("activationSchedule.findByOrderID", ActivationSchedule.class).setParameter(1, orderID).getResultList();
        for(ActivationSchedule p: orderSchedule){
            p.setStatus("Valid");
            em.persist(p);
        }
    }

    private void checkInsolventAndRemove(int orderID, String username){
        List<Order> suspendedOrders = getSuspendedOrders(username);
        if(suspendedOrders.size()==1 && suspendedOrders.get(0).getUser().getUsername().equals(username)){
            suspendedOrders.get(0).getUser().setInsolvent(false);
        }
    }

    /* To modify */
    public Order suspendOrder(int orderID){
        String status = "Suspended";
        Order order;
        order = em.find(Order.class, orderID);
        order.setStatus(status);
        User user = em.find(User.class, order.getUser().getUsername());
        user.setInsolvent(true);
        user.setNumRejections(user.getNumRejections()+1);
        checkAlert(user, order.getTotalvalue());
        return order;
    }

    private void checkAlert(User user, int amount){
        Date date = new Date(System.currentTimeMillis());
        if(user.getNumRejections()==3){
            Alert alert = new Alert(user, user.getEmail(), amount, date);
            em.persist(alert);
        }
        else if(user.getNumRejections()>3){
            Alert alert = em.find(Alert.class, user.getUsername());
            alert.setAmount(amount);
            alert.setDatetimelastrejection(date);
        }
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
