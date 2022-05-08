package it.polimi.progettoDB2.controllers;

import it.polimi.progettoDB2.Entities.*;
import it.polimi.progettoDB2.Services.EmployeeService;
import it.polimi.progettoDB2.Services.SalesReportService;
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

@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {

    private TemplateEngine templateEngine;

    @EJB
    SalesReportService salesReportService;
    EmployeeService employeeService;

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

        if(request.getSession().getAttribute("Employee")!=null) {
            List<Alert> alerts = salesReportService.getAlerts();
            List<InsolventUsers> insolventUsers = salesReportService.getInsolventUsers();
            List<SuspendedOrders> suspendedOrders = salesReportService.getSuspendedOrders();
            List<SalesOfPackage> salesOfPackages = salesReportService.getSalesOfPackages();
            List<SalesOptionalProduct> salesOptionalProducts = salesReportService.getSalesOptionalProduct();
            List<NumPurchPackage> numPurchPackages = salesReportService.getAllNumPurchPackages();
            List<NumPurchPackageValPeriod> numPurchPackageValPeriods = salesReportService.getAllNumPurchPackagesValPeriod();
            List<BestOptProduct> bestOptProduct = salesReportService.getBestSeller();
            List<AvgOptForPackage> avgOptForPackages = salesReportService.getAllAvgOptForPackage();

            ctx.setVariable("allAlerts", alerts);
            ctx.setVariable("allInsolventUsers", insolventUsers);
            ctx.setVariable("allSuspendedOrders", suspendedOrders);
            ctx.setVariable("allSalesOfPackages", salesOfPackages);
            ctx.setVariable("allSalesOptionalProducts", salesOptionalProducts);
            ctx.setVariable("allNumPurchPackages", numPurchPackages);
            ctx.setVariable("allNumPurchPackageValPeriod", numPurchPackageValPeriods);
            ctx.setVariable("bestOptProduct", bestOptProduct);
            ctx.setVariable("avgOptForPackages", avgOptForPackages);

        }

        String path = "/SalesReport.html";
        templateEngine.process(path, ctx, response.getWriter());

    }

}
