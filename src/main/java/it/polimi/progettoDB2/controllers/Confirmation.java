package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Order;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/Confirmation/*")
public class Confirmation extends HttpServlet {

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
        if(!request.getRequestURI().replace("/progettoDB2_war_exploded/Confirmation", "").equals("")){
            int orderId = Integer.parseInt(request.getRequestURI().replace("/progettoDB2_war_exploded/Confirmation/", ""));
            request.getSession().setAttribute("orderId", orderId);
            Order order = customerService.getOrder(orderId);
            request.getSession().setAttribute("packageToBuy", order.getServicePackage());
            request.getSession().setAttribute("startDate", order.getStartdate());
            List<OptionalProduct> selectedOpProd = customerService.findBoughtOptional(orderId);
            String path = "/Confirmation.html";
            ServletContext servletContext = getServletContext();
            final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
            ctx.setVariable("selectedOpProd", selectedOpProd);
            ctx.setVariable("totalValue", order.getTotalvalue());
            ctx.setVariable("selectedServices", order.getServicePackage().getServices());
            templateEngine.process(path, ctx, response.getWriter());
        }
        else {
            int duration = Integer.parseInt(request.getParameter("duration"));
            int[] selectedOptIds = new int[0];
            try {
                selectedOptIds = Arrays.stream(request.getParameterValues("selectedProducts")).mapToInt(Integer::parseInt).toArray();
            } catch (NullPointerException ignored) {
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate;
            try {
                startDate = (Date) sdf.parse(request.getParameter("startDate"));
                request.getSession().setAttribute("packageStartDate", startDate);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            request.getSession().setAttribute("packageDuration", duration);
            request.getSession().setAttribute("selectedOpts", selectedOptIds);
            request.getSession().setAttribute("startDate", startDate);
            ServicePackage selectedPackage = (ServicePackage) request.getSession().getAttribute("packageToBuy");
            float selectedFee;
            if (duration == 12)
                selectedFee = selectedPackage.getMonthscost12();
            else if (duration == 24)
                selectedFee = selectedPackage.getMonthscost24();
            else
                selectedFee = selectedPackage.getMonthscost36();
            request.getSession().setAttribute("selectedFee", selectedFee);
            int totalValue = customerService.calculateTotalValue(duration, selectedFee, selectedPackage, Arrays.stream(selectedOptIds).boxed().collect(Collectors.toList()));
            String path = "/Confirmation.html";
            ServletContext servletContext = getServletContext();
            List<OptionalProduct> selectedOpProd = new ArrayList<>();
            for (int id : selectedOptIds) {
                selectedOpProd.add(customerService.getSingleOptionalProduct(id));
            }
            final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
            ctx.setVariable("selectedOpProd", selectedOpProd);
            ctx.setVariable("totalValue", totalValue);
            ctx.setVariable("selectedServices", selectedPackage.getServices());
            templateEngine.process(path, ctx, response.getWriter());
        }
    }
}
