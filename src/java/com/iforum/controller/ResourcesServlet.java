package com.iforum.controller;

import com.iforum.dao.ResourcesDAO;
import com.iforum.dao.SubjectDAO;
import com.iforum.model.Resources;
import com.iforum.model.Subject;
import com.iforum.model.User;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/resources")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 500,
    maxRequestSize = 1024 * 1024 * 500
)
public class ResourcesServlet extends HttpServlet {
    private String UPLOAD_DIR = "uploads";
    private ResourcesDAO resourcesDAO = new ResourcesDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "upload".equals(action) && "LECTURER".equalsIgnoreCase(user.getRole())) {
            String title = request.getParameter("title");
            String subject = request.getParameter("subjectName"); // Ensure this matches your JSP input name
            Part filePart = request.getPart("file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);

            Resources newResource = new Resources();
            newResource.setTitle(title);
            newResource.setDescription("Learning Material");
            newResource.setSubjectName(subject);
            newResource.setFileName(fileName);
            newResource.setFilePath(UPLOAD_DIR + "/" + fileName);
            newResource.setFileType(filePart.getContentType());
            newResource.setUploadedBy(user.getFullname());

            try {
                resourcesDAO.addResource(newResource);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("resources");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ================= DOWNLOAD =================
        if ("download".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                List<Resources> list = resourcesDAO.getAllResources();
                for (Resources r : list) {
                    if (r.getResourceId() == id) {
                        File file = new File(getServletContext().getRealPath("") + File.separator + r.getFilePath());
                        if (!file.exists()) {
                            response.getWriter().println("File not found!");
                            return;
                        }
                        response.setContentType(r.getFileType());
                        response.setContentLength((int) file.length());
                        response.setHeader("Content-Disposition", "inline; filename=\"" + r.getFileName() + "\"");

                        try (FileInputStream in = new FileInputStream(file);
                             OutputStream out = response.getOutputStream()) {
                            byte[] buffer = new byte[4096];
                            int bytesRead;
                            while ((bytesRead = in.read(buffer)) != -1) {
                                out.write(buffer, 0, bytesRead);
                            }
                        }
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ================= DELETE =================
        else if ("delete".equals(action)) {
            try {
                resourcesDAO.deleteResource(Integer.parseInt(request.getParameter("id")));
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("resources");
            return;
        }

        // ================= DISPLAY LIST (GROUPED) =================
        try {
            List<Resources> list = resourcesDAO.getAllResources();
            List<Subject> subjects = subjectDAO.getAllSubjects();
            
            // Grouping by Subject Name for the accordion
            Map<String, List<Resources>> groupedResources = new LinkedHashMap<String, List<Resources>>();

            for (Resources r : list) {

                String subject = r.getSubjectName();

                if (!groupedResources.containsKey(subject)) {
                    groupedResources.put(subject, new ArrayList<Resources>());
                }

                groupedResources.get(subject).add(r);
            }
            
            request.setAttribute("groupedResources", groupedResources);
            request.setAttribute("subjectList", subjects);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("resources.jsp").forward(request, response);
    }
}