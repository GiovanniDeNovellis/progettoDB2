package it.polimi.progettoDB2.controllers;

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
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/PurchController")
public class PurchController extends HttpServlet {
    @EJB
    private CustomerService customerService;
    private TemplateEngine templateEngine;

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
        String status = request.getParameter("submit");
        if(request.getSession().getAttribute("orderId")!=null){
            int orderID = (int) request.getSession().getAttribute("orderId");
            request.getSession().removeAttribute("packageToBuy");
            request.getSession().removeAttribute("startDate");
            request.getSession().removeAttribute("orderId");
            if(status.equals("Valid")){
                customerService.validateOrder(orderID);
            }
            else{
                customerService.failAgainOrder(orderID);
            }
            String path = getServletContext().getContextPath() + "/HomeCustomer";
            response.sendRedirect(path);
        }
        else {
            Date startDate = (Date) request.getSession().getAttribute("startDate");
            int duration = (int) request.getSession().getAttribute("packageDuration");
            float fee = (float) request.getSession().getAttribute("selectedFee");
            ServicePackage servicePackage = (ServicePackage) request.getSession().getAttribute("packageToBuy");
            User user = (User) request.getSession().getAttribute("user");
            int[] optIds = (int[]) request.getSession().getAttribute("selectedOpts");
            List<Integer> optionals = Arrays.stream(optIds).boxed().collect(Collectors.toList());
            customerService.addOrder(new Date(), duration, startDate, fee, servicePackage.getID(), user.getUsername(), optionals, status);
            request.getSession().removeAttribute("startDate");
            request.getSession().removeAttribute("packageDuration");
            request.getSession().removeAttribute("selectedFee");
            request.getSession().removeAttribute("packageToBuy");
            request.getSession().removeAttribute("selectedOpts");
            String path = getServletContext().getContextPath() + "/HomeCustomer";
            response.sendRedirect(path);
        }
    }
}
