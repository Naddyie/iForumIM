package com.iforum.controller;

import com.iforum.dao.AnnouncementDAO;
import com.iforum.model.Announcement;
import com.iforum.model.User;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/announcements")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 15,       // 15MB max file size
    maxRequestSize = 1024 * 1024 * 30     // 30MB combined max multipart payload
)
public class AnnouncementServlet extends HttpServlet {
    
    private AnnouncementDAO announcementDAO = new AnnouncementDAO();
    private static final String UPLOAD_DIR = "uploads";

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
        if (action == null) action = "list";

        switch (action) {
            case "view":
                showViewPage(request, response);
                break;
            case "edit":
                showEditForm(request, response, currentUser);
                break;
            case "delete":
                processDelete(request, response, currentUser);
                break;
            case "list":
            default:
                renderAnnouncementsList(request, response);
                break;
        }
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
        
        if ("create".equals(action)) {
            if ("STUDENT".equalsIgnoreCase(currentUser.getRole())) {
                response.sendRedirect("announcements?error=unauthorized");
                return;
            }
            processCreate(request, response, currentUser);
        } else if ("update".equals(action)) {
            if ("STUDENT".equalsIgnoreCase(currentUser.getRole())) {
                response.sendRedirect("announcements?error=unauthorized");
                return;
            }
            processUpdate(request, response, currentUser);
        }
    }

    private void renderAnnouncementsList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("search");
        List<Announcement> announcements = announcementDAO.getAllAnnouncements(query);
        request.setAttribute("announcementsList", announcements);
        request.getRequestDispatcher("announcements.jsp").forward(request, response);
    }

    private void showViewPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Announcement announcement = announcementDAO.getAnnouncementById(id);
        if (announcement != null) {
            request.setAttribute("announcement", announcement);
            request.getRequestDispatcher("viewAnnouncement.jsp").forward(request, response);
        } else {
            response.sendRedirect("announcements?error=notfound");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        if ("STUDENT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("announcements?error=unauthorized");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Announcement announcement = announcementDAO.getAnnouncementById(id);
        
        // Safety guard: only allow editing if admin or owner
        if (announcement != null && ("ADMIN".equalsIgnoreCase(user.getRole()) || "COORDINATOR".equalsIgnoreCase(user.getRole()) || announcement.getCreatorId() == user.getId())) {
            request.setAttribute("announcement", announcement);
            request.getRequestDispatcher("editAnnouncement.jsp").forward(request, response);
        } else {
            response.sendRedirect("announcements?error=unauthorized");
        }
    }

    private void processCreate(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        Announcement a = new Announcement();
        a.setTitle(request.getParameter("title"));
        a.setContent(request.getParameter("content"));
        a.setCategory(request.getParameter("category"));
        a.setCreatorId(user.getId());

        String relativePath = handleFileUpload(request.getPart("attachment"));
        a.setFilePath(relativePath);

        announcementDAO.createAnnouncement(a);
        response.sendRedirect("announcements?success=created");
    }

    private void processUpdate(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Announcement existing = announcementDAO.getAnnouncementById(id);

        if (existing == null || (!"ADMIN".equalsIgnoreCase(user.getRole()) && !"COORDINATOR".equalsIgnoreCase(user.getRole()) && existing.getCreatorId() != user.getId())) {
            response.sendRedirect("announcements?error=unauthorized");
            return;
        }

        existing.setTitle(request.getParameter("title"));
        existing.setContent(request.getParameter("content"));
        existing.setCategory(request.getParameter("category"));

        Part filePart = request.getPart("attachment");
        if (filePart != null && filePart.getSize() > 0) {
            String relativePath = handleFileUpload(filePart);
            existing.setFilePath(relativePath);
        }

        announcementDAO.updateAnnouncement(existing);
        response.sendRedirect("announcements?success=updated");
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = announcementDAO.deleteAnnouncement(id, user.getId(), user.getRole());
        if (success) {
            response.sendRedirect("announcements?success=deleted");
        } else {
            response.sendRedirect("announcements?error=failedtodelete");
        }
    }

    private String handleFileUpload(Part part) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        
        String applicationPath = getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        
        File uploadFolder = new File(uploadFilePath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String originalFileName = part.getSubmittedFileName();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String randomizedFileName = UUID.randomUUID().toString() + fileExtension;
        
        part.write(uploadFilePath + File.separator + randomizedFileName);
        return UPLOAD_DIR + "/" + randomizedFileName;
    }
}