package com.parking.servlets;

import com.parking.parkinglot.common.UserDto;
import com.parking.parkinglot.ejb.CarsBean;
import com.parking.parkinglot.ejb.UserBean;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import jakarta.annotation.security.DeclareRoles;

@DeclareRoles({"READ_USERS", "WRITE_USERS", "INVOICING"})
@ServletSecurity(value = @HttpConstraint(rolesAllowed = {"READ_USERS"}),
        httpMethodConstraints = {@HttpMethodConstraint(value="POST", rolesAllowed = {"WRITE_USERS", "INVOICING"})})

@WebServlet(name = "UsersServlet", value = "/Users")
public class UsersServlet extends HttpServlet {

private static final Logger LOG = Logger.getLogger(UsersServlet.class.getName());
    @Inject
    UserBean userBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOG.info("Requesting User data...");
        List<UserDto> users = userBean.findAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/pages/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
