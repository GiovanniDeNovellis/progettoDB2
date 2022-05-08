package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.OptionalProduct;
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

@WebServlet("/CreateOptionalProduct")
public class CreateOptionalProduct extends HttpServlet {

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
        float monthlyFee;

        try {
            name = request.getParameter("name");
            monthlyFee = Float.parseFloat(request.getParameter("monthlyFee"));

            if(name == null || name.isEmpty()){
                throw new Exception("Missing or empty Optional Product values.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing optional product value");
            return;
        }

        OptionalProduct optionalProduct = employeeService.createOptionalProduct(name, monthlyFee);

        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        if(optionalProduct == null) {
            ctx.setVariable("errorMsg", "Optional Product creation failed.");
        }
        else{
            ctx.setVariable("notifyMsg", "Optional Product creation successful.");
        }

        path = "/indexEmployee.html";
        templateEngine.process(path, ctx, response.getWriter());

    }

    @Override
    public void destroy(){

    }

}
