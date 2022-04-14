package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.sql.Date;
import java.util.ArrayList;

@Stateless
public class EmployeeService {

    @PersistenceContext
    private EntityManager em;

    public ServicePackage createServicePackage(String name, ArrayList<Integer> servicesID) {
        ServicePackage servicePackage = new ServicePackage(name);
        for (Integer integer : servicesID) {
            servicePackage.getServices().add(em.find(Service.class, integer));
        }
        em.persist(servicePackage);
        return servicePackage;
    }

    public OptionalProduct createOptionalProduct(String name, Float monthlyFee) {
        OptionalProduct optProduct = new OptionalProduct(name, monthlyFee);
        em.persist(optProduct);
        return optProduct;
    }

    public Service createService (String type, int minutes, int SMS, Float extraMinFee, Float extraSMSFee, int giga, Float extraGigaFee, Date activationDate, Date deactivationDate) {
        Service service = new Service(type, minutes, SMS, extraMinFee, extraSMSFee, giga, extraGigaFee, activationDate, deactivationDate);
        em.persist(service);
        return service;
    }

}
