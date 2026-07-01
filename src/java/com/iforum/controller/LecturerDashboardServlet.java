package com.iforum.controller;

import com.iforum.dao.DiscussionGroupDAO;
import com.iforum.model.DiscussionGroup;
import com.iforum.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Handles Faculty Overview page request and loads database topics dynamically.
 */
@WebServlet("/lecturerDashboard")
public class LecturerDashboardServlet extends HttpServlet {
    private DiscussionGroupDAO groupDAO = new DiscussionGroupDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"LECTURER".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Fetch live discussion channels from the database
        List<DiscussionGroup> allGroups = groupDAO.getAllGroups(currentUser.getId());
        
        // 2. Filter or limit the list to 5 items to keep the dashboard viewport clean
        List<DiscussionGroup> previewGroups = allGroups;
        if (allGroups.size() > 5) {
            previewGroups = allGroups.subList(0, 5);
        }

        // 3. Bind to Request Scope
        request.setAttribute("pendingQuestions", previewGroups);

        // 4. Forward to the dynamic overview page
        request.getRequestDispatcher("lecturerDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}