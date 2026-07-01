package com.iforum.controller;

import com.iforum.dao.*;
import com.iforum.model.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    // =========================
    // LOAD PAGE
    // =========================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");

            return;
        }

        // LECTURER VIEW
        if ("LECTURER".equalsIgnoreCase(user.getRole())) {

            FeedbackDAO feedbackDAO = new FeedbackDAO();

            List<Feedback> feedbackList = feedbackDAO.getAllFeedback();

            request.setAttribute("feedbackList", feedbackList);

        }

        // STUDENT VIEW
        else {

            DiscussionGroupDAO discussionDAO = new DiscussionGroupDAO();

            List<DiscussionGroup> groups =
                    discussionDAO.getAllGroups(user.getId());

            request.setAttribute("discussionGroups", groups);
        }

        request.getRequestDispatcher("feedback.jsp")
                .forward(request, response);
    }

    // =========================
    // SAVE FEEDBACK
    // =========================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");

        String comment = request.getParameter("comment");

        int rating = Integer.parseInt(request.getParameter("rating"));

        Feedback feedback = new Feedback();

        feedback.setDiscussionTitle(title);

        feedback.setComment(comment);

        feedback.setRating(rating);

        FeedbackDAO feedbackDAO = new FeedbackDAO();

        try {

            feedbackDAO.insertFeedback(feedback);

            response.sendRedirect("FeedbackServlet?status=success");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("FeedbackServlet?status=error");
        }
    }
}