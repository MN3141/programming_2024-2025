package com.parking.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.logging.Logger;

import com.parking.parkinglot.ejb.UserBean;

@WebServlet(name = "Login", value = "/Login")
public class LoginServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(UserBean.class.getName());
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

        LOG.info("Trying to log in...");
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

        LOG.info("Submitting login data..");
        request.setAttribute("message", "Username or password incorrect");
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
}