package com.parking.servlets;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import com.parking.parkinglot.common.CarDto;
import com.parking.parkinglot.common.UserDto;
import com.parking.parkinglot.ejb.CarsBean;
import com.parking.parkinglot.ejb.UserBean;

@ServletSecurity(value = @HttpConstraint(rolesAllowed =
{"WRITE_CARS"}))

@WebServlet(name = "EditCar", value = "/EditCar")
public class EditCarServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(AddCarServlet.class.getName());

    @Inject
    UserBean userBean;

    @Inject
    CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

        LOG.info("Requesting to edit cars list");
        List<UserDto> users = userBean.findAllUsers();

        Long carID=Long.parseLong(request.getParameter("id"));
        CarDto carDto=carsBean.findById(carID);

        request.setAttribute("car", carDto);
        request.getRequestDispatcher("/WEB-INF/pages/editCar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {

            LOG.info("Saving edited car...");
            String licensePlate=request.getParameter("license_plate");
            String parkingSpot=request.getParameter("parking_spot");
            Long userId=Long.parseLong(request.getParameter("owner_id"));
            Long carId=Long.parseLong(request.getParameter("car_id"));

            carsBean.updateCar(carId, licensePlate, parkingSpot,userId);

            response.sendRedirect(request.getContextPath()+"/Cars");
    }

}