package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.User;
import it.polimi.progettoDB2.Services.AuthService;
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


@WebServlet("/Register")
public class Register extends HttpServlet {
    private TemplateEngine templateEngine;

    @EJB
    private AuthService authService;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username, password, email;
        String[] typeCheckbox = request.getParameterValues("isEmployee");
        String type = "Customer";
        try {
            username = request.getParameter("username");
            password = request.getParameter("pwd");
            email = request.getParameter("email");
            if(typeCheckbox != null)
                type = "Employee";
            if (username == null || password == null || email == null || username.isEmpty() || password.isEmpty() || email.isEmpty()) {
                throw new Exception("Missing or empty registration value");
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
            return;
        }
        User user = authService.registerUser(username, password, email, type);
        String path;
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        if (user == null) {
            ctx.setVariable("notifyMsg", "Username or email already used");
        } else {
            ctx.setVariable("notifyMsg", "Registration completed! You can now login into the system.");
        }
        path = "/indexCustomer.html";
        templateEngine.process(path, ctx, response.getWriter());

    }
}
