package com.iforum.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.iforum.dao.RegisterDAO;

@WebServlet("/checkMatric")
public class CheckMatricServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String matric = request.getParameter("matric_number");
        if (matric != null) {
            matric = matric.trim().toUpperCase();
        }
        System.out.println("Matric received: [" + matric + "]");
        
        RegisterDAO dao = new RegisterDAO();
        String verifiedName = dao.verifyMaritimeStudent(matric);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (verifiedName != null) {
            out.print("{\"status\":\"success\",\"fullname\":\"" + verifiedName + "\"}");
        } else {
            out.print("{\"status\":\"error\",\"message\":\"Matric not found\"}");
        }
    }
}