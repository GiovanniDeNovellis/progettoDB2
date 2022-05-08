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
        TemplateEngine templateEngine = new TemplateEngine();
        templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        /* Service creation */
        String type;
        int minutes;
        int sms;
        int giga;
        float extraMinFee;
        float extraSMSFee;
        float extraGigaFee;

        try {

            type = request.getParameter("type");
            minutes = Integer.parseInt(request.getParameter("minutes"));
            sms = Integer.parseInt(request.getParameter("sms"));
            giga = Integer.parseInt(request.getParameter("giga"));
            extraMinFee = Float.parseFloat(request.getParameter("extraMinFee"));
            extraSMSFee = Float.parseFloat(request.getParameter("extraSMSFee"));
            extraGigaFee = Float.parseFloat(request.getParameter("extraGigaFee"));

            if(type == null || type.isEmpty()) {
                throw new Exception("Missing or empty Optional Product values.");

            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing service values.");
            return;
        }

        Service service = employeeService.createService(type, minutes, sms, extraMinFee, extraSMSFee, giga, extraGigaFee);

        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        if(service == null) {
            ctx.setVariable("errorMsg", "Service creation failed.");
        }
        else{
            ctx.setVariable("notifyMsg", "Service creation successful.");
        }

        path = "/indexEmployee.html";
        templateEngine.process(path, ctx, response.getWriter());

    }

    @Override
    public void destroy(){

    }

}