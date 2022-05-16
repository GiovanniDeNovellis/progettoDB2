package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.Service;
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

@WebServlet("/CreateService")
public class CreateService extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    private EmployeeService employeeService;

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

        /* Service creation */
        String type, name;
        int minutes = 0;
        int sms = 0;
        int giga = 0;
        float extraMinFee = 0;
        float extraSMSFee = 0;
        float extraGigaFee = 0;

        try {
            type = request.getParameter("type");
            name = request.getParameter("name");
            if(type == null || type.isEmpty()) {
                throw new Exception("Missing or empty Optional Product values.");

            }
            if(type.equals("MobilePhone")){
                minutes = Integer.parseInt(request.getParameter("minutes"));
                System.out.println(minutes);
                sms = Integer.parseInt(request.getParameter("SMS"));
                extraMinFee = Float.parseFloat(request.getParameter("extraMinFee"));
                extraSMSFee = Float.parseFloat(request.getParameter("extraSMSFee"));
            }
            if(type.equals("FixedInternet") || type.equals("MobileInternet")){
                giga = Integer.parseInt(request.getParameter("giga"));
                extraGigaFee = Float.parseFloat(request.getParameter("extraGigaFee"));   
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing service values.");
            return;
        }

        Service service = employeeService.createService(name, type, minutes, sms, extraMinFee, extraSMSFee, giga, extraGigaFee);

        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        if(service == null) {
            ctx.setVariable("errorServiceCreation", "Service creation failed.");
        }
        else{
            ctx.setVariable("successServiceCreation", "Service creation successful.");
        }
        response.sendRedirect(getServletContext().getContextPath()+"/HomeEmployee");
        //path = "/HomeEmployee.html";
        //templateEngine.process(path, ctx, response.getWriter());

    }

    @Override
    public void destroy(){

    }

}