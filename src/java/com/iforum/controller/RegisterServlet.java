package com.iforum.controller;

import java.io.IOException;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.iforum.dao.RegisterDAO;
import com.iforum.model.User;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RegisterDAO dao = new RegisterDAO();
        User user = new User();

        String role = request.getParameter("role");

        user.setRole(role);
        user.setFullname(request.getParameter("fullname"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        String rawPassword = request.getParameter("password");
        String hashedPassword = hashPassword(rawPassword);
        user.setPassword(hashedPassword);

        if ("student".equalsIgnoreCase(role)) {
            String matricNumber = request.getParameter("matric_number");

            String verifiedFullName = dao.verifyMaritimeStudent(matricNumber);

            if (verifiedFullName == null) {
                request.setAttribute("error", "Only active Maritime Informatics students can create an account.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            user.setMatric_Number(matricNumber);
            user.setFullname(verifiedFullName);

        } else {
            user.setFullname(request.getParameter("fullname"));
            user.setFaculty(request.getParameter("faculty"));
        }

        if (dao.registerUser(user)) {
            response.sendRedirect("login.jsp?msg=success");
        } else {
            response.sendRedirect("register.jsp?msg=error");
        }
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));

            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}