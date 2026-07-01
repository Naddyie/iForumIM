package com.iforum.controller;

import com.iforum.dao.DiscussionGroupDAO;
import com.iforum.dao.AnnouncementDAO;
import com.iforum.model.DiscussionGroup;
import com.iforum.model.Announcement;
import com.iforum.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Controller to fetch student metrics, live discussions, and latest announcements.
 * URL Mapping: /studentDashboard
 */
@WebServlet("/studentDashboard")
public class StudentDashboardServlet extends HttpServlet {
    private DiscussionGroupDAO groupDAO = new DiscussionGroupDAO();
    private AnnouncementDAO announcementDAO = new AnnouncementDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"STUDENT".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Fetch live discussions (channels)
        List<DiscussionGroup> allGroups = groupDAO.getAllGroups(currentUser.getId());
        List<DiscussionGroup> recentTopics = allGroups;
        if (allGroups.size() > 4) {
            recentTopics = allGroups.subList(0, 4);
        }

        // 2. Fetch latest campus announcements
        List<Announcement> allAnnouncements = announcementDAO.getAllAnnouncements(null);
        List<Announcement> latestAnnouncements = allAnnouncements;
        if (allAnnouncements.size() > 3) {
            latestAnnouncements = allAnnouncements.subList(0, 3);
        }

        // 3. Set Attributes for studentDashboard.jsp
        request.setAttribute("recentTopics", recentTopics);
        request.setAttribute("announcements", latestAnnouncements);

        // 4. Forward to the dashboard view JSP
        request.getRequestDispatcher("studentDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}