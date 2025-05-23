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

@ServletSecurity(value = @HttpConstraint(rolesAllowed =
{"WRITE_CARS"}))

@WebServlet(name = "AddCar", value = "/AddCar")

public class AddCarServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(AddCarServlet.class.getName());

    @Inject
    UserBean userBean;

    @Inject
    CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

        LOG.info("Requesting to add a car...");

        List<UserDto> users=userBean.findAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/pages/addCars.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        LOG.info("Submitting car...");
        String licensePlate = request.getParameter("license_plate");
        String parkingSpot = request.getParameter("parking_spot");
        Long userId = Long.parseLong(request.getParameter("owner_id"));

        carsBean.createCar(licensePlate, parkingSpot, userId);

        response.sendRedirect(request.getContextPath() + "/Cars");
    }
}