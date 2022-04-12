package it.polimi.progettoDB2;
import it.polimi.progettoDB2.Entities.OptionalProduct;
import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;
import it.polimi.progettoDB2.Services.SalesReportService;
import it.polimi.progettoDB2.Services.UserService;

import java.io.*;
import java.sql.DriverManager;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    private static final long serialVersionUID = 1L;

    @EJB
    private UserService userService;

    @EJB
    private SalesReportService salesReportService;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("Debugging getRejectedOrders:");
        List<Order> orders = userService.getRejectedOrders("carlo");
        for(Order o: orders) {
            System.out.println(o);
        }

        System.out.println("Debugging getOptionalProducts:");
        List<OptionalProduct> optionalProducts = userService.getOptionalProducts();
        for(OptionalProduct op: optionalProducts)
            System.out.println(op);

        System.out.println("Debugging getServicePackagesUser:");
        List<ServicePackage> servicePackageList = userService.getServicePackagesUser("carlo");
        for(ServicePackage s: servicePackageList) {
            System.out.println(s);
        }



        System.out.println("Debugging getNumPurchPackages:");

        System.out.println(salesReportService.getNumPurchPackages(1));
        System.out.println(salesReportService.getNumPurchPackages(2));
        System.out.println(salesReportService.getNumPurchPackages(3));


        System.out.println("Debugging getNumPurchPackageValPeriod:");

        System.out.println(salesReportService.getNumPurchPackageValPeriod(1,12));
        System.out.println(salesReportService.getNumPurchPackageValPeriod(1,24));
        System.out.println(salesReportService.getNumPurchPackageValPeriod(1,50));
        System.out.println(salesReportService.getNumPurchPackageValPeriod(5,12));


        System.out.println("Debugging getTotalSalesValue:");
        System.out.println(salesReportService.getTotalSalesValuePackage(1));
        System.out.println(salesReportService.getTotalSalesValuePackage(2));
        System.out.println(salesReportService.getTotalSalesValuePackage(3));

        System.out.println("Debugging getAvgOptForPackage:");

        System.out.println(salesReportService.getAvgOptForPakage(1));
        System.out.println(salesReportService.getAvgOptForPakage(2));
        System.out.println(salesReportService.getAvgOptForPakage(3));
        /*
        final String DB_URL = "jdbc:mysql://localhost:3306/new_schema"; //Replace with your own configuration
        final String USER = "root"; //Replace with your own configuration
        final String PASS = ""; //Replace with your own configuration
        String result = "Connection worked";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (Exception e) {
            result = "Connection failed"; e.printStackTrace();
        }
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println(result);
        out.close();
        */
    }
    public void destroy() {
    }
}