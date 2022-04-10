package it.polimi.progettoDB2.Services;

import it.polimi.progettoDB2.Entities.ServicePackage;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserService {

    @PersistenceContext
    private EntityManager em;

    public List<ServicePackage> getServicePackages(){
        System.out.println("kek");
        List<ServicePackage> servicePackages = em.createNamedQuery("ServicePackage.getAllPackages", ServicePackage.class)
                .getResultList();
        for(ServicePackage s : servicePackages) {
            System.out.println("kek");
            System.out.println(s);
        }
        return servicePackages;
    }
}
