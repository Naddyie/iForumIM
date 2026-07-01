package com.iforum.controller;

import com.iforum.dao.CoordinatorDAO;
import com.iforum.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/coordinatorDashboard")
public class CoordinatorDashboardServlet extends HttpServlet {

    private CoordinatorDAO coordinatorDAO = new CoordinatorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!"COORDINATOR".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("exportUsersCsv".equals(action)) {
            exportUsersCsv(response);
            return;
        }

        int totalUsers = coordinatorDAO.getTotalUsers();
        int totalDiscussions = coordinatorDAO.getTotalDiscussions();
        int totalReplies = coordinatorDAO.getTotalReplies();
        List<User> userList = coordinatorDAO.getAllUsers();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalDiscussions", totalDiscussions);
        request.setAttribute("totalReplies", totalReplies);
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("coordinatorDashboard.jsp").forward(request, response);
    }

    private void exportUsersCsv(HttpServletResponse response) throws IOException {
        List<User> userList = coordinatorDAO.getAllUsers();

        response.setContentType("text/csv");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"iforum_users.csv\"");

        PrintWriter writer = response.getWriter();

        writer.println("Full Name,Email,Phone,Role,Matric Number,Faculty,Program,Academic Session,Status");

        for (User user : userList) {
            writer.println(
                    escapeCsv(user.getFullname()) + "," +
                    escapeCsv(user.getEmail()) + "," +
                    escapeCsv(user.getPhone()) + "," +
                    escapeCsv(user.getRole()) + "," +
                    escapeCsv(user.getMatric_Number()) + "," +
                    escapeCsv(user.getFaculty()) + "," +
                    escapeCsv(user.getCourse()) + "," +
                    escapeCsv(user.getAcademicSession()) + "," +
                    escapeCsv(user.getStudentStatus())
            );
        }

        writer.flush();
    }

    private String escapeCsv(String value) {
        if (value == null) {
            return "";
        }

        String escaped = value.replace("\"", "\"\"");

        if (escaped.contains(",") || escaped.contains("\"") || escaped.contains("\n")) {
            return "\"" + escaped + "\"";
        }

        return escaped;
    }
}