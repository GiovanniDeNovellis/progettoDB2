package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.*;
import it.polimi.progettoDB2.Services.CustomerService;
import it.polimi.progettoDB2.Services.EmployeeService;
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
import java.util.Objects;

@WebServlet("/HomeEmployee")
public class HomeEmployee extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    private CustomerService customerService;

    @EJB
    private EmployeeService employeeService;

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
        String path;
        User user = (User) request.getSession().getAttribute("user");
        if(user!=null && Objects.equals(user.getType(), "Employee")) {
            List<Service> unassignedServices = customerService.findUnassignedServices();
            List<OptionalProduct> optionalProducts = customerService.getOptionalProducts();
            path = "/HomeEmployee.html";
            ctx.setVariable("unassignedServices", unassignedServices);
            ctx.setVariable("optionalProducts", optionalProducts);
        }
        else {
            path = "/indexEmployee.html";
            ctx.setVariable("errorMsg", "Please login before accessing the employee application.");
        }
            templateEngine.process(path, ctx, response.getWriter());
    }
}