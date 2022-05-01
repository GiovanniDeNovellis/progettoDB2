package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.ServicePackage;
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
import java.util.List;

@WebServlet("/CreateServicePackage")
public class CreateServicePackage extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    private EmployeeService employeeService;

    @Override
    public void init(){
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        TemplateEngine templateEngine = new TemplateEngine();
        templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

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
            if (name == null || name.isEmpty() || cost12 == 0 || cost24 == 0 || cost36 == 0 || servicesID.length == 0 || productsID.length == 0) {
                throw new Exception("Missing or empty service package values.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
            return;
        }

        List<Integer> servicesIDList = null;
        List<Integer> productsIDList = null;
        for (String s : servicesID) {
            servicesIDList.add(Integer.valueOf(s));
        }
        for (String s : productsID) {
            productsIDList.add(Integer.valueOf(s));
        }

        ServicePackage servicePackage = employeeService.createServicePackage(name, cost12, cost24, cost36, servicesIDList, productsIDList);

        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        if(servicePackage == null) {
            ctx.setVariable("notifyMsg", "Service package creation successful.");
        }
        else{
            ctx.setVariable("notifyMsg", "Service package creation failed.");
        }

        path = "/indexEmployee.html";
        templateEngine.process(path, ctx, response.getWriter());

    }

    @Override
    public void destroy(){

    }

}
