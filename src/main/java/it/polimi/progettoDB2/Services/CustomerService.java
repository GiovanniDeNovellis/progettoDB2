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

    public ServicePackage getSingleServicePackage(int packageID){
        return em.find(ServicePackage.class, packageID);
    }

    public List<Order> getOrdersByStatusAndNickname(String username, String status){
        return em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, status).
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

    public OptionalProduct getSingleOptionalProduct(int productId){
        return em.find(OptionalProduct.class, productId);
    }

    public List<OptionalProduct> getAvailableProducts(int packageID){
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        return (List<OptionalProduct>) servicePackage.getAvailableProducts();
    }

    public Order addOrder(Date creationDate, int valPeriod, Date startDate, float fee, long packageID, String username, List<Integer> optProductIDs, String status) {
        User user = em.find(User.class, username);
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        int totalValue = calculateTotalValue(valPeriod, fee, servicePackage, optProductIDs);
        Order order = new Order(creationDate, valPeriod, totalValue, startDate, status, user, servicePackage, fee);
        em.persist(order);
        createOrderSchedule(order, optProductIDs, startDate, valPeriod, servicePackage, status);
        if(status.equals("Suspended")){
            user.setInsolvent(true);
            user.setNumRejections(user.getNumRejections()+1);
            checkAlert(user, order.getTotalvalue());
        }
        return order;
    }

    public int calculateTotalValue(int valPeriod, float fee, ServicePackage servicePackage, List<Integer> optProductIDs){
        int totalValue = (int) (valPeriod*fee);
        for(Integer id: optProductIDs){
            OptionalProduct opt = em.find(OptionalProduct.class, id);
            totalValue+= opt.getMonthlyFee()*valPeriod;
        }
        return totalValue;
    }

    private void createOrderSchedule(Order order, List<Integer> optProductIDs, Date startDate, int valPeriod, ServicePackage servicePackage, String status){
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.add(Calendar.MONTH, valPeriod);
        Date pckgBridgeDeactDate = c.getTime();
        if(optProductIDs.isEmpty()) {
            ActivationSchedule activationSchedule = new ActivationSchedule(order, servicePackage, startDate, pckgBridgeDeactDate, status);
            em.persist(activationSchedule);
        }
        for(Integer integer : optProductIDs) {
            OptionalProduct prod = em.find(OptionalProduct.class, integer);
            ActivationSchedule activationSchedule = new ActivationSchedule(order, servicePackage, prod, startDate, pckgBridgeDeactDate, status);
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
        List<Order> suspendedOrders = getOrdersByStatusAndNickname(username, "Suspended");
        if(suspendedOrders.size()==1 && suspendedOrders.get(0).getUser().getUsername().equals(username)){
            suspendedOrders.get(0).getUser().setInsolvent(false);
        }
    }

    public void failAgainOrder(int orderID){
        Order order = em.find(Order.class, orderID);
        User user = em.find(User.class, order.getUser().getUsername());
        user.setNumRejections(user.getNumRejections()+1);
        checkAlert(user, order.getTotalvalue());
    }

    private void checkAlert(User user, int amount){
        Date date = new Date(System.currentTimeMillis());
        System.out.println(date);
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

    public Order getOrder(int orderID){
        return em.find(Order.class, orderID);
    }

    public List<OptionalProduct> findBoughtOptional(int orderId){
        try {
            return em.createNamedQuery("activationSchedule.findOptByOrderID", OptionalProduct.class).setParameter(1,orderId).
                    getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<ActivationSchedule> findSchedulesByOrderIDs(List<Order> orders) {
        List<ActivationSchedule> activationSchedules = new ArrayList<>();
        for (Order o : orders) {
            activationSchedules.addAll(em.createNamedQuery("activationSchedule.findByOrderID", ActivationSchedule.class).setParameter(1, o.getId()).getResultList());
        }

        return activationSchedules;
    }

    public List<Service> findUnassignedServices(){
        return em.createNamedQuery("service.findUnassigned", Service.class).getResultList();
    }
}
