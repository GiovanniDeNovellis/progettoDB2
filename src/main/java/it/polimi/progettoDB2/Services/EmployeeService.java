package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.ActivationSchedule;
import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Stateless
public class EmployeeService {

    @PersistenceContext
    private EntityManager em;

    /*This method creates a new service package based on the input data. It needs as an input a name, a list of floats to set
    * the fees, and a list of services and product Ids to associate to the package.*/
    public ServicePackage createServicePackage(String name, float cost12, float cost24, float cost36, List<Integer> servicesID, List<Integer> productsID) {
        ServicePackage servicePackage = new ServicePackage(name, cost12, cost24, cost36);
        List<Service> serviceList = new ArrayList<>();
        //Retrieving services
        for (Integer integer : servicesID) {
            Service service = em.find(Service.class, integer);
            serviceList.add(service);
            service.setServicePackage(servicePackage);
        }
        List<OptionalProduct> productList = new ArrayList<>();
        //Retrieving products
        for(Integer integer: productsID){
            OptionalProduct prod = em.find(OptionalProduct.class, integer);
            productList.add(prod);
        }
        servicePackage.setServices(serviceList);
        servicePackage.setAvailableProducts(productList);
        em.persist(servicePackage);
        return servicePackage;
    }
    /*This method creates a new optional product given a name and a fee.*/
    public OptionalProduct createOptionalProduct(String name, Float monthlyFee) {
        OptionalProduct optProduct = new OptionalProduct(name, monthlyFee);
        em.persist(optProduct);
        return optProduct;
    }

    /* This method creates a service given the configuration parameters.*/
    public Service createService (String name, String type, int minutes, int SMS, Float extraMinFee, Float extraSMSFee, int giga, Float extraGigaFee) {
        Service service = new Service(name, type, minutes, SMS, extraMinFee, extraSMSFee, giga, extraGigaFee);
        em.persist(service);
        return service;
    }

    public List<ActivationSchedule> findAllSchedules(){
        try{
            return em.createNamedQuery("activationSchedule.findAll", ActivationSchedule.class).getResultList();
        }
        catch (NoResultException e){
            return null;
        }
    }

}
