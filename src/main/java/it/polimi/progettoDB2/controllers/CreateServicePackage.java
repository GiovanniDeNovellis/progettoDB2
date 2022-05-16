package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;
import it.polimi.progettoDB2.Services.CustomerService;
import it.polimi.progettoDB2.Services.EmployeeService;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CreateServicePackage")
public class CreateServicePackage extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    private EmployeeService employeeService;

    @EJB
    private CustomerService customerService;

    @Override
    public void init(){
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        this.templateEngine = new TemplateEngine();
        this.templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());

        String name;
        float cost12;
        float cost24;
        float cost36;
        String[] servicesID;
        String[] productsID;

        try {
            name = request.getParameter("name");
            cost12 = Float.parseFloat(request.getParameter("cost12"));
            cost24 = Float.parseFloat(request.getParameter("cost24"));
            cost36 = Float.parseFloat(request.getParameter("cost36"));
            servicesID = request.getParameterValues("servicesID");
            productsID = request.getParameterValues("productsID");

            if (servicesID == null) {
                ctx.setVariable("errorMsgServPckgCreation", "Must select at least one Service when creating a Service Package!");
                path = "/HomeEmployee.html";
                List<Service> unassignedServices = customerService.findUnassignedServices();
                List<OptionalProduct> optionalProducts = customerService.getOptionalProducts();
                ctx.setVariable("unassignedServices", unassignedServices);
                ctx.setVariable("optionalProducts", optionalProducts);
                templateEngine.process(path, ctx, response.getWriter());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error parsing package creation values");
            return;
        }

        List<Integer> servicesIDList = new ArrayList<>();
        List<Integer> productsIDList = new ArrayList<>();
        for (String s : servicesID) servicesIDList.add(Integer.valueOf(s));
        if(productsID!=null)
            for (String s : productsID) productsIDList.add(Integer.valueOf(s));

        ServicePackage servicePackage = employeeService.createServicePackage(name, cost12, cost24, cost36, servicesIDList, productsIDList);

        if(servicePackage == null) {
            ctx.setVariable("errorMsgServPckgCreation", "Service package creation failed.");
        }
        else {
            ctx.setVariable("successMsgServPckgCreation", "Service package creation successful.");
        }
        response.sendRedirect(getServletContext().getContextPath()+"/HomeEmployee");

        //List<Service> unassignedServices = customerService.findUnassignedServices();
        //List<OptionalProduct> optionalProducts = customerService.getOptionalProducts();
        //ctx.setVariable("unassignedServices", unassignedServices);
        //ctx.setVariable("optionalProducts", optionalProducts);
        //path = "/HomeEmployee.html";
        //templateEngine.process(path, ctx, response.getWriter());

    }

    @Override
    public void destroy(){

    }

}
