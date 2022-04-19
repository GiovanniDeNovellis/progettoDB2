package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Stateless
public class EmployeeService {

    @PersistenceContext
    private EntityManager em;

    public ServicePackage createServicePackage(String name, float cost12, float cost24, float cost36, List<Integer> servicesID, List<Integer> productsID) {
        ServicePackage servicePackage = new ServicePackage(name, cost12, cost24, cost36);
        List<Service> serviceList = new ArrayList<>();
        for (Integer integer : servicesID) {
            Service service = em.find(Service.class, integer);
            serviceList.add(service);
            service.setServicePackage(servicePackage);
        }
        List<OptionalProduct> productList = new ArrayList<>();
        for(Integer integer: productsID){
            OptionalProduct prod = em.find(OptionalProduct.class, integer);
            productList.add(prod);
        }
        servicePackage.setServices(serviceList);
        servicePackage.setAvailableProducts(productList);
        em.persist(servicePackage);
        return servicePackage;
    }

    public OptionalProduct createOptionalProduct(String name, Float monthlyFee) {
        OptionalProduct optProduct = new OptionalProduct(name, monthlyFee);
        em.persist(optProduct);
        return optProduct;
    }

    public Service createService (String type, int minutes, int SMS, Float extraMinFee, Float extraSMSFee, int giga, Float extraGigaFee) {
        Service service = new Service(type, minutes, SMS, extraMinFee, extraSMSFee, giga, extraGigaFee);
        em.persist(service);
        return service;
    }

}
