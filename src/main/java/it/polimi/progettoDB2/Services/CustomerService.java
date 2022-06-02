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

    /* This method will retrieve the list of all the service packages available in the database.*/
    public List<ServicePackage> getServicePackages(){
        return em.createNamedQuery("ServicePackage.findAllPackages", ServicePackage.class)
                .getResultList();
    }

    /* This method will retrieve the service packages corresponding to the given ID, if present in the database.*/
    public ServicePackage getSingleServicePackage(int packageID){
        return em.find(ServicePackage.class, packageID);
    }

    /* This method will retrieve the list of orders done by the given user in the given status.*/
    public List<Order> getOrdersByStatusAndNickname(String username, String status){
        return em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, status).
                setParameter(2,username).getResultList();
    }

    /*
    public List<ServicePackage> getServicePackagesUser(String username){
        List<Order> activeOrders = em.createNamedQuery("Order.findByStatusAndUsername", Order.class).setParameter(1, "Valid").
                setParameter(2,username).getResultList();
        List<ServicePackage> packages = new ArrayList<>();
        for(Order order: activeOrders){
            packages.add(order.getServicePackage());
        }
        return packages;
    }
    */

    /* This method will retrieve the optional product corresponding to the inserted ID.*/
    public OptionalProduct getSingleOptionalProduct(int productId){
        return em.find(OptionalProduct.class, productId);
    }

    public List<OptionalProduct> getAvailableProducts(int packageID){
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        return (List<OptionalProduct>) servicePackage.getAvailableProducts();
    }

    /* This method will create an order with the given data and status and add the corresponding
        activation schedule lines.*/
    public Order addOrder(Date creationDate, int valPeriod, Date startDate, float fee, long packageID, String username, List<Integer> optProductIDs, String status) {
        User user = em.find(User.class, username);
        ServicePackage servicePackage = em.find(ServicePackage.class, packageID);
        //Calculating the total value of the order
        int totalValue = calculateTotalValue(valPeriod, fee, servicePackage, optProductIDs);
        Order order = new Order(creationDate, valPeriod, totalValue, startDate, status, user, servicePackage, fee);
        em.persist(order);
        //Creating the order schedule lines
        createOrderSchedule(order, optProductIDs, startDate, valPeriod, servicePackage, status);
        //If the payment for the order failed, i have to update the rejection and check for the alerts
        if(status.equals("Suspended")){
            user.setInsolvent(true);
            user.setNumRejections(user.getNumRejections()+1);
            checkAlert(user, order.getTotalvalue());
        }
        return order;
    }

    /* This method calculates the total value of the order given the fee of the package and the selected products*/
    public int calculateTotalValue(int valPeriod, float fee, ServicePackage servicePackage, List<Integer> optProductIDs){
        int totalValue = (int) (valPeriod*fee);
        for(Integer id: optProductIDs){
            OptionalProduct opt = em.find(OptionalProduct.class, id);
            totalValue+= opt.getMonthlyFee()*valPeriod;
        }
        return totalValue;
    }

    /* This method creates the rows for the activation schedule and stores them into the database.*/
    private void
    createOrderSchedule(Order order, List<Integer> optProductIDs, Date startDate, int valPeriod, ServicePackage servicePackage, String status){
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.add(Calendar.MONTH, valPeriod);
        Date pckgBridgeDeactDate = c.getTime();
        //At least 1 schedule for the services if i have no optional products
        if(optProductIDs.isEmpty()) {
            ActivationSchedule activationSchedule = new ActivationSchedule(order, servicePackage, startDate, pckgBridgeDeactDate, status);
            em.persist(activationSchedule);
        }
        //1 schedule for each optional product
        for(Integer integer : optProductIDs) {
            OptionalProduct prod = em.find(OptionalProduct.class, integer);
            ActivationSchedule activationSchedule = new ActivationSchedule(order, servicePackage, prod, startDate, pckgBridgeDeactDate, status);
            em.persist(activationSchedule);
        }
    }

    /* This method will retrieve all the service packages available in the database.*/
    public Order validateOrder(int orderID) {
        String status = "Valid";
        Order order;
        order = em.find(Order.class, orderID);
        //If the user is insolvent, need to check if now he is not anymore
        checkInsolventAndRemove(orderID, order.getUser().getUsername());
        order.setStatus(status);
        //Change order schedule status
        validateOrderSchedule(orderID);
        return order;
    }

    // This method changes the status of the schedule rows relative to a given order ID to Valid
    private void validateOrderSchedule(int orderID){
        List <ActivationSchedule> orderSchedule = em.createNamedQuery("activationSchedule.findByOrderID", ActivationSchedule.class).setParameter(1, orderID).getResultList();
        for(ActivationSchedule p: orderSchedule){
            p.setStatus("Valid");
            em.persist(p);
        }
    }

    //This method checks if for a given user there aren't suspended orders anymore and eventually remove his insolvent tag
    private void checkInsolventAndRemove(int orderID, String username){
        List<Order> suspendedOrders = getOrdersByStatusAndNickname(username, "Suspended");
        if(suspendedOrders.size()==1 && suspendedOrders.get(0).getUser().getUsername().equals(username)){
            suspendedOrders.get(0).getUser().setInsolvent(false);
        }
    }

    /*This method is used, when there is a new failed buying attempt for the same order,
    * to increase the number of rejections for the user and eventually generate an alert.*/

    public void failAgainOrder(int orderID){
        Order order = em.find(Order.class, orderID);
        User user = em.find(User.class, order.getUser().getUsername());
        user.setNumRejections(user.getNumRejections()+1);
        //Check if I have to create a new alert
        checkAlert(user, order.getTotalvalue());
    }

    /* This method is used to check if I have to create or update an alert when an user fails a payment.*/
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

    /* This method retrieves the list of all the available optional products.*/
    public List<OptionalProduct> getOptionalProducts() {
        try {
            return em.createNamedQuery("OptionalProduct.findAllProducts", OptionalProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /*This method retrieves an order given its ID.*/
    public Order getOrder(int orderID){
        return em.find(Order.class, orderID);
    }

    /* This method retrieves the list of optional products bought in a certain order.*/
    public List<OptionalProduct> findBoughtOptional(int orderId){
        try {
            return em.createNamedQuery("activationSchedule.findOptByOrderID", OptionalProduct.class).setParameter(1,orderId).
                    getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /*This method retrieves the activation schedules of the given order list.*/
    public List<ActivationSchedule> findSchedulesByOrderIDs(List<Order> orders) {
        List<ActivationSchedule> activationSchedules = new ArrayList<>();
        for (Order o : orders) {
            activationSchedules.addAll(em.createNamedQuery("activationSchedule.findByOrderID", ActivationSchedule.class).setParameter(1, o.getId()).getResultList());
        }

        return activationSchedules;
    }

    /*This method retrieves the activation schedules associated to the given orders.*/
    public List<Service> findUnassignedServices(){
        return em.createNamedQuery("service.findUnassigned", Service.class).getResultList();
    }
}
