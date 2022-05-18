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

    public NumPurchPackage getNumPurchPackages(int packageID){
        try {
            return em.createNamedQuery("NumPurchPackage.findByPackageID", NumPurchPackage.class).
                    setParameter(1, packageID).getSingleResult();
        }
        catch (NoResultException e) {
            return null;
        }
    }

    public NumPurchPackageValPeriod getNumPurchPackageValPeriod(int packageID, int valperiod){
        try{
            return em.createNamedQuery("NumPurchPackageValPeriod.findByPackageIdValPeriod", NumPurchPackageValPeriod.class).setParameter(1, packageID)
                    .setParameter(2, valperiod).getSingleResult();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public SalesOfPackage getTotalSalesValuePackage(int packageID){
        try {
            return em.createNamedQuery("SalesOfPackage.findByPackageID", SalesOfPackage.class).setParameter(1, packageID).getSingleResult();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public AvgOptForPackage getAvgOptForPackage(int packageID){
        try{
            return em.createNamedQuery("AvgOptForPackage.findByPackageID", AvgOptForPackage.class).setParameter(1, packageID).getSingleResult();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<InsolventUsers> getInsolventUsers() {
        try {
            return em.createNamedQuery("InsolventUsers.findAllInsolventUsers", InsolventUsers.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<SuspendedOrders> getSuspendedOrders(){
        try {
            return em.createNamedQuery("SuspendedOrders.findAllSuspendedOrders", SuspendedOrders.class).getResultList();
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

    public List<Alert> getAlertsUser(String username){
        try {
            return em.createNamedQuery("Alerts.getAllAlertsByUser", Alert.class).setParameter(1, username).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<BestOptProduct> getBestSeller(){
        try {
            return em.createNamedQuery("BestOptProduct.findAllBestOptProduct", BestOptProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

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

    public List<SalesOfPackage> getSalesOfPackages(){
        try {
            return em.createNamedQuery("SalesOfPackage.findAllSalesOfPackages", SalesOfPackage.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<SalesOptionalProduct> getSalesOptionalProduct(){
        try{
            return em.createNamedQuery("SalesOptionalProduct.getAllSalesOptionalProducts", SalesOptionalProduct.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<NumPurchPackage> getAllNumPurchPackages(){
        try {
            return em.createNamedQuery("NumPurchPackage.getAllNumPurchPackages", NumPurchPackage.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<NumPurchPackageValPeriod> getAllNumPurchPackagesValPeriod(){
        try {
            return em.createNamedQuery("NumPurchPackage.getAllNumPurchPackageValPeriod", NumPurchPackageValPeriod.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

    public List<AvgOptForPackage> getAllAvgOptForPackage(){
        try {
            return em.createNamedQuery("AvgOptForPackage.getAllAvgOptForPackages", AvgOptForPackage.class).getResultList();
        } catch (NoResultException e){
            return null;
        }
    }
}
