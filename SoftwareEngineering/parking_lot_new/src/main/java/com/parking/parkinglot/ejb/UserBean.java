package com.parking.parkinglot.ejb;

import com.parking.entities.User;
import com.parking.parkinglot.common.UserDto;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class UserBean {

    private static final Logger LOG = Logger.getLogger(UserBean.class.getName());

    @PersistenceContext
    EntityManager entityManager;

    // Method to convert User entity to UserDto
    public List<UserDto> copyUsersToDto(List<User> users) {
        List<UserDto> userDtos = new ArrayList<>();
        for (User user : users) {
            userDtos.add(new UserDto(user.getId(), user.getUsername(), user.getEmail()));
        }
        return userDtos;
    }

    // Method to fetch all users from the database
    public List<UserDto> findAllUsers() {
        LOG.info("findAllUsers");
        try {
            TypedQuery<User> typedQuery =
                    entityManager.createQuery("SELECT u FROM User u", User.class);
            List<User> users = typedQuery.getResultList();
            return copyUsersToDto(users);
        } catch (Exception e) {
            throw new EJBException("Error fetching users", e);
        }
    }

}
