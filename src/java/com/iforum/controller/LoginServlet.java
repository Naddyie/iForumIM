package com.iforum.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.iforum.dao.LoginDAO;
import com.iforum.model.User;

/**
 * Handles User Login and Session Creation with role-based redirection.
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        LoginDAO dao = new LoginDAO();
        User user = dao.authenticate(email, password);

        if (user != null) {
            // Create session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            
            String role = user.getRole().toUpperCase();
            
            // Redirect based on database role ENUM ('COORDINATOR', 'LECTURER', 'STUDENT')
            if ("COORDINATOR".equals(role) || "ADMIN".equals(role)) {
                response.sendRedirect("coordinatorDashboard");
            } else if ("LECTURER".equals(role)) {
                response.sendRedirect("lecturerDashboard");
            } else if ("STUDENT".equals(role)) {
                response.sendRedirect("studentDashboard");
            } else {
                // Fallback for unexpected roles
                response.sendRedirect("login.jsp?error=invalidRole");
            }
        } else {
            // Failed login - redirect back with error message
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}