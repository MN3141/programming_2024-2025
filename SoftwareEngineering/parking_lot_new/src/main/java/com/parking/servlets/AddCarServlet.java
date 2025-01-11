package com.parking.servlets;

import com.parking.parkinglot.common.UserDto;
import com.parking.parkinglot.ejb.UserBean;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AddCar", value = "/AddCar")

//@Inject
//UsersBean userBean;
public class AddCarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        //List<UserDto> users=userBean.findAllUsers();
        //request.setAttribute("users",users);
        request.getRequestDispatcher("/WEB-INF/pages/addCars.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

    }
}