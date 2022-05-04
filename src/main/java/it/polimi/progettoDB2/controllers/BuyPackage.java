package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.ServicePackage;
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

@WebServlet("/BuyPackage")
public class BuyPackage extends HttpServlet {

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
        List<ServicePackage> allPackages = customerService.getServicePackages();
        String path = "/BuyPackage.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("allpackages", allPackages);
        ctx.setVariable("selecting", true);
        ctx.setVariable("selected", false);
        templateEngine.process(path, ctx, response.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int servicePackageID = Integer.parseInt(request.getParameter("packageid"));
        ServicePackage servicePackage = customerService.getSingleServicePackage(servicePackageID);
        String path = "/BuyPackage.html";
        request.getSession().setAttribute("packageToBuy", servicePackage);
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("selecting", false);
        ctx.setVariable("selected", true);
        ctx.setVariable("selectedPackage", servicePackage);
        templateEngine.process(path, ctx, response.getWriter());
    }
}
