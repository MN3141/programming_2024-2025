package com.parking.parkinglot.ejb;

import com.parking.entities.User;
import com.parking.entities.UserGroup;
import com.parking.parkinglot.common.UserDto;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class UserBean {

    @Inject
    PasswordBean passwordBean;

    private static final Logger LOG = Logger.getLogger(UserBean.class.getName());

    @PersistenceContext
    EntityManager entityManager;

    // Method to convert User entity to UserDto
    public List<UserDto> copyUsersToDto(List<User> users) {
        List<UserDto> userDtos = new ArrayList<>();
        for (User user : users) {
            userDtos.add(new UserDto(user.getId(), user.getUsername(), user.getEmail(), user.getPassword()));
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

    public void createUser(String username, String email, String password,
                           Collection<String> groups) {
        LOG.info("createUser");
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(passwordBean.convertToSha256(password));
        entityManager.persist(newUser);
        assignGroupsToUser(username, groups);
    }

    private void assignGroupsToUser(String username, Collection<String>
            groups) {
        LOG.info("assignGroupsToUser");
        for (String group : groups) {
            UserGroup userGroup = new UserGroup();
            userGroup.setUsername(username);
            userGroup.setUserGroup(group);
            entityManager.persist(userGroup);
        }
    }

    public Collection<String> findUsernamesByUserIds(Collection<Long> userIds){
        List<String> usernames =
                entityManager.createQuery("SELECT u.username FROM User u WHERE u.id IN :userIds", String.class)
                        .setParameter("userIds", userIds)
                        .getResultList();
        return usernames;
    }

    public UserDto findById(Long userId) {
        LOG.info("findById");
        User user = entityManager.find(User.class, userId);
        return new UserDto(user.getId(), user.getUsername(), user.getEmail(), user.getPassword());
    }

    public void updateUser(Long userId, String username, String email, String password){
        LOG.info("updateUser");
        User user = entityManager.find(User.class, userId);
        user.setUsername(username);
        user.setEmail(email);
        if(password == null)
        {
            user.setPassword(user.getPassword());
        }
        else{
        user.setPassword(password);
        }
    }
}
