package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.ActivationSchedule;
import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Entities.ServicePackage;
import it.polimi.progettoDB2.Entities.User;
import it.polimi.progettoDB2.Services.CustomerService;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/HomeCustomer")
public class HomeCustomer extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        this.templateEngine = new TemplateEngine();
        this.templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        List<ServicePackage> allPackages = customerService.getServicePackages();
        if(request.getSession().getAttribute("user")!=null){
            User user = (User) request.getSession().getAttribute("user");
            List<Order> validOrders = customerService.getOrdersByStatusAndNickname(user.getUsername(), "Valid");
            List<Order> suspendedOrders = customerService.getOrdersByStatusAndNickname(user.getUsername(), "Suspended");
            List<ActivationSchedule> activationSchedules = customerService.findSchedulesByOrderIDs(validOrders);
            ctx.setVariable("validorders", validOrders);
            ctx.setVariable("suspendedorders", suspendedOrders);
            ctx.setVariable("schedules", activationSchedules);
        }
        String path = "/HomeCustomer.html";
        ctx.setVariable("allpackages", allPackages);
        templateEngine.process(path, ctx, response.getWriter());
    }
}
