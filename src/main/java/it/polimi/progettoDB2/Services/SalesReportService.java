package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.AvgOptForPackage;
import it.polimi.progettoDB2.Entities.NumPurchPackage;
import it.polimi.progettoDB2.Entities.NumPurchPackageValPeriod;
import it.polimi.progettoDB2.Entities.SalesOfPackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

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

    public AvgOptForPackage getAvgOptForPakage(int packageID){
        try{
            return em.createNamedQuery("AvgOptForPackage.findByPackageID", AvgOptForPackage.class).setParameter(1, packageID).getSingleResult();
        }
        catch (NoResultException e){
            return null;
        }
    }
}
