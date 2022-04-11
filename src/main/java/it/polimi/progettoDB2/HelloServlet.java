package it.polimi.progettoDB2;
import it.polimi.progettoDB2.Entities.Order;
import it.polimi.progettoDB2.Entities.Service;
import it.polimi.progettoDB2.Entities.ServicePackage;
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

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Order> servicePackageList = userService.getRejectedOrders("carlo");
        for(Order s: servicePackageList) {
            System.out.println(s);
        }
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