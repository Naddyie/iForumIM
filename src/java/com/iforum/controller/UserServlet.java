package com.iforum.controller;

import com.iforum.dao.UserDAO;
import com.iforum.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("profile".equals(action)) {
            User freshUser = userDAO.getUserById(currentUser.getId());

            if (freshUser != null) {
                session.setAttribute("user", freshUser);
            }

            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        String role = currentUser.getRole();

        if ("STUDENT".equalsIgnoreCase(role)) {
            response.sendRedirect("studentDashboard.jsp");
        } else if ("LECTURER".equalsIgnoreCase(role)) {
            response.sendRedirect("lecturerDashboard.jsp");
        } else if ("COORDINATOR".equalsIgnoreCase(role)) {
            response.sendRedirect("coordinatorDashboard.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("updateProfile".equals(action)) {
            currentUser.setFullname(request.getParameter("fullname"));
            currentUser.setPhone(request.getParameter("phone"));

            if (userDAO.updateUser(currentUser)) {
                User freshUser = userDAO.getUserById(currentUser.getId());

                if (freshUser != null) {
                    session.setAttribute("user", freshUser);
                }

                response.sendRedirect("user?action=profile&status=success");
            } else {
                response.sendRedirect("user?action=profile&status=error");
            }

        } else if ("changePassword".equals(action)) {
            String newPass = request.getParameter("newPassword");
            String confirmPass = request.getParameter("confirmPassword");

            if (newPass.equals(confirmPass)) {
                if (userDAO.changePassword(currentUser.getId(), newPass)) {
                    response.sendRedirect("user?action=profile&status=password_updated");
                } else {
                    response.sendRedirect("user?action=profile&status=error");
                }
            } else {
                response.sendRedirect("user?action=profile&status=error");
            }
        }
    }
}