package it.polimi.progettoDB2.controllers;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "/Logout")
public class Logout extends HttpServlet {

    private TemplateEngine templateEngine;

    public Logout(){
        super();
    }

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        this.templateEngine = new TemplateEngine();
        this.templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        ServletContext servletContext = getServletContext();
        final WebContext ctx =  new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("notifyMsg", "Successfully logged out.");

        String path = "/indexCustomer.html";
        templateEngine.process(path, ctx, response.getWriter());

    }

}
