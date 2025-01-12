package com.parking.servlets;

import com.parking.parkinglot.common.UserDto;
import com.parking.parkinglot.ejb.UserBean;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@ServletSecurity(value = @HttpConstraint(rolesAllowed = {"WRITE_USERS"}))
@WebServlet(name = "EditUser", value = "/EditUser")
public class EditUserServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(EditUserServlet.class.getName());
    @Inject
    UserBean userBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        List<UserDto> users=userBean.findAllUsers();
        request.setAttribute("users", users);

        Long userId=Long.parseLong(request.getParameter("id"));
        UserDto user=userBean.findById(userId);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/pages/editUser.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Long userId = Long.parseLong(request.getParameter("id"));

        userBean.updateUser(userId, username, email, password);
        response.sendRedirect(request.getContextPath() + "/Users");

    }
}