package com.iforum.controller;

import com.iforum.dao.DiscussionGroupDAO;
import com.iforum.model.DiscussionGroup;
import com.iforum.model.DiscussionMessage;
import com.iforum.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import java.io.File;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/discussions")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 100
)
public class DiscussionGroupServlet extends HttpServlet {
    private DiscussionGroupDAO groupDAO = new DiscussionGroupDAO();

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
        int userId = currentUser.getId();

        if ("room".equals(action)) {
            String groupIdParam = request.getParameter("groupId");
            if (groupIdParam != null) {
                int groupId = Integer.parseInt(groupIdParam);
                DiscussionGroup group = groupDAO.getGroupById(groupId, userId);
                
                // Security check: Only members, Lecturers, or Admins can enter
                boolean isAllowed = "LECTURER".equalsIgnoreCase(currentUser.getRole()) 
                        || "COORDINATOR".equalsIgnoreCase(currentUser.getRole()) 
                        || "ADMIN".equalsIgnoreCase(currentUser.getRole())
                        || group.isJoined();

                if (isAllowed) {
                    groupDAO.markMessagesAsRead(groupId, userId);

                    List<DiscussionMessage> messages = groupDAO.getMessagesByGroup(groupId);
                    request.setAttribute("group", group);
                    request.setAttribute("messageList", messages);
                    request.getRequestDispatcher("DiscussionRoom.jsp").forward(request, response);
                } else {
                    response.sendRedirect("discussions?error=notmember");
                }
                return;
            }
        }

        // Default: List all discussion groups
        List<DiscussionGroup> groups = groupDAO.getAllGroups(userId);
        request.setAttribute("groupList", groups);
        request.getRequestDispatcher("Discussions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int userId = currentUser.getId();

        if ("create".equals(action)) {
            // Only Lecturers and Coordinators can create groups
            /*if ("STUDENT".equalsIgnoreCase(currentUser.getRole())) {
                response.sendRedirect("discussions?error=unauthorized");
                return;
            */
            
            // Lecturers and Students to Create Group
            if (!(currentUser.getRole().equalsIgnoreCase("STUDENT") ||
                currentUser.getRole().equalsIgnoreCase("LECTURER"))) {

              response.sendRedirect("discussions?error=unauthorized");
              return;
            }

            DiscussionGroup group = new DiscussionGroup();
            group.setTitle(request.getParameter("title"));
            group.setCategory(request.getParameter("category"));
            group.setDescription(request.getParameter("description"));
            group.setCreatorId(userId);

            groupDAO.createGroup(group);
            response.sendRedirect("discussions?msg=created");
        } 
        
        else if ("join".equals(action)) {
            int groupId = Integer.parseInt(request.getParameter("groupId"));
            groupDAO.joinGroup(groupId, userId);
            response.sendRedirect("discussions?action=room&groupId=" + groupId);
        }
        
        else if ("sendMessage".equals(action)) {

            int groupId = Integer.parseInt(request.getParameter("groupId"));

            String text = request.getParameter("messageText");

            if (text != null) {
                text = text.trim();
            }

            String replyToMessageIdParam = request.getParameter("replyToMessageId");
            Integer replyToMessageId = null;

            if (replyToMessageIdParam != null && !replyToMessageIdParam.trim().isEmpty()) {
                replyToMessageId = Integer.parseInt(replyToMessageIdParam);
            }

            Part filePart = request.getPart("mediaFile");

            String fileName = null;
            String mediaType = null;

            // CHECK FILE
            if (filePart != null && filePart.getSize() > 0) {

                fileName = System.currentTimeMillis() + "_"
                        + filePart.getSubmittedFileName();

                String uploadPath =
                        getServletContext().getRealPath("/") + "uploads";

                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                filePart.write(uploadPath + File.separator + fileName);

                String contentType = filePart.getContentType();

                if (contentType.startsWith("image")) {
                    mediaType = "IMAGE";

                } else if (contentType.startsWith("video")) {
                    mediaType = "VIDEO";
                } else {
                    mediaType = "FILE";
                }
            }

            // SAVE MESSAGE
            if ((text != null && !text.trim().isEmpty())
                    || fileName != null) {

                groupDAO.postMessageWithMedia(
                        groupId,
                        userId,
                        text,
                        fileName,
                        mediaType,
                        replyToMessageId
                );
            }

            response.sendRedirect(
                    "discussions?action=room&groupId=" + groupId
            );
        }
    }
}