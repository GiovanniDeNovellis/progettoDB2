package it.polimi.progettoDB2;
import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Services.AuthService;
import it.polimi.progettoDB2.Services.EmployeeService;
import it.polimi.progettoDB2.Services.SalesReportService;
import it.polimi.progettoDB2.Services.CustomerService;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerService customerService;

    @EJB
    private SalesReportService salesReportService;

    @EJB
    private AuthService authService;

    @EJB
    private EmployeeService employeeService;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        customerService.validateOrder(29);
        /*
        Date date = new Date();
        List<Integer> list = new ArrayList<>();
        list.add(2);
        list.add(3);
        Order order = customerService.addOrder(date, 12,  date, 15,59,  "peppe", list);

        //System.out.println(customerService.getAvailableProducts(60));
        /*
        userService.validateOrder(24);
        List<ServicePackage> list = userService.getServicePackages();
        for(ServicePackage s: list) {
            System.out.println(s);
            System.out.println(s.getServices());
        }
        List<Integer> serviceList = new ArrayList<>();
        serviceList.add(2);
        serviceList.add(4);
        serviceList.add(6);
        serviceList.add(8);
        List<Integer> products = new ArrayList<>();
        products.add(1);
        products.add(4);
        employeeService.createServicePackage("packagewithdiffproducts", 20,30,40, serviceList, products);


        /*
        employeeService.createOptionalProduct("skyCalcio", (float) 20);
        employeeService.createOptionalProduct("filmService", (float) 40);
        employeeService.createOptionalProduct("foodDelivery", (float) 5);
        employeeService.createService("FixedPhone",1,1,(float)1,(float) 1,1,(float) 1);
        employeeService.createService("FixedPhone",1,1,(float)1,(float) 1,1,(float) 1);
        employeeService.createService("MobilePhone",200,50, (float) 0.2,(float) 1,0, (float) 0);
        employeeService.createService("MobilePhone",100,20,(float)0.1,(float) 1,0,(float) 0);
        employeeService.createService("FixedInternetA",1,1,(float)1,(float) 1,50,(float) 1);
        employeeService.createService("FixedInternetB",1,1,(float)1,(float) 1,100,(float) 2);
        employeeService.createService("MobileInternetA",1,1,(float)1,(float) 1,20,(float) 3);
        employeeService.createService("MobileInternetB",1,1,(float)1,(float) 1,80,(float) 4);
        List<OptionalProduct> opts = userService.getOptionalProducts();
        for(OptionalProduct op: opts)
            System.out.println(op);
        userService.validateOrder(26);
        Date date = new Date();
        List<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(4);
        Order order = userService.addOrder(date, 12, 50, date, 5, 2, "leo", list);
        authService.registerUser("peppe", "123", "peppe@gmail.com", "User");
        System.out.println("Debugging login");
        System.out.println(authService.authenticateUser("carlo", "123456"));
        System.out.println(authService.authenticateUser("lool", "loool"));

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

        System.out.println(salesReportService.getAvgOptForPackage(1));
        System.out.println(salesReportService.getAvgOptForPackage(2));
        System.out.println(salesReportService.getAvgOptForPackage(3));
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