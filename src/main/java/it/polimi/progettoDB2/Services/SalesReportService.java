package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class SalesReportService {

    @PersistenceContext
    private EntityManager em;

    /* This method retrieves the materialized view with the list of the insolvent users.*/
    public List<InsolventUsers> getInsolventUsers() {
        try {
            return em.createNamedQuery("InsolventUsers.findAllInsolventUsers", InsolventUsers.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the list of suspended orders. */
    public List<SuspendedOrders> getSuspendedOrders(){
        try {
            return em.createNamedQuery("SuspendedOrders.findAllSuspendedOrders", SuspendedOrders.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the list of all the alerts created.*/
    public List<AlertHistory> getAlertHistory(){
        try {
            return em.createNamedQuery("AlertsHistory.getAllAlerts", AlertHistory.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<Alert> getAlerts(){
        try {
            return em.createNamedQuery("Alerts.getAllAlerts", Alert.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the optional product with the greatest value of sales.*/
    public List<BestOptProduct> getBestSeller(){
        try {
            return em.createNamedQuery("BestOptProduct.findAllBestOptProduct", BestOptProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the data of the optional product with the greates value of sales. */
    public SalesOptionalProduct getBestSellerData(){
        BestOptProduct  best = getBestSeller().get(0);
        try {
            return em.createNamedQuery("SalesOptionalProduct.findByProductId", SalesOptionalProduct.class).
                    setParameter(1,best.getOptionalProduct().getId()).getSingleResult();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the list of sales details of the service packages. */
    public List<SalesOfPackage> getSalesOfPackages(){
        try {
            return em.createNamedQuery("SalesOfPackage.findAllSalesOfPackages", SalesOfPackage.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the list of the sales of each optional product.*/
    public List<SalesOptionalProduct> getSalesOptionalProduct(){
        try{
            return em.createNamedQuery("SalesOptionalProduct.getAllSalesOptionalProducts", SalesOptionalProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the list of purchases for each package.*/
    public List<NumPurchPackage> getAllNumPurchPackages(){
        try {
            return em.createNamedQuery("NumPurchPackage.getAllNumPurchPackages", NumPurchPackage.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }
    /* This method retrieves the materialized view with the list of purchases for each package with a given validity period.*/
    public List<NumPurchPackageValPeriod> getAllNumPurchPackagesValPeriod(){
        try {
            return em.createNamedQuery("NumPurchPackage.getAllNumPurchPackageValPeriod", NumPurchPackageValPeriod.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    /* This method retrieves the materialized view with the average number of optional products sold with each package.*/
    public List<AvgOptForPackage> getAllAvgOptForPackage(){
        try {
            return em.createNamedQuery("AvgOptForPackage.getAllAvgOptForPackages", AvgOptForPackage.class).getResultList();
        } catch (NoResultException e){
            return null;
        }
    }
}
