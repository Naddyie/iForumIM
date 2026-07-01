<%-- 
    Document   : editAnnouncement
    Created on : May 23, 2026, 3:38:32 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("user") == null || "STUDENT".equalsIgnoreCase(((com.iforum.model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect("announcements?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Announcement - iForumIM</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-800 p-8">
    <div class="max-w-2xl mx-auto bg-white border border-slate-200 rounded-[2.5rem] p-8 shadow-xl mt-8">
        <h1 class="text-2xl font-bold text-slate-900 mb-2">Modify Announcement</h1>
        <p class="text-xs text-slate-400 mb-6">Updating announcement record ID: ${announcement.announcement_id}</p>

        <form action="announcements?action=update&id=${announcement.announcement_id}" method="post" enctype="multipart/form-data" class="space-y-5">
            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Title</label>
                <input type="text" name="title" value="<c:out value='${announcement.title}'/>" required class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition">
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Category</label>
                <select name="category" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition">
                    <option value="ACADEMIC" ${announcement.category == 'ACADEMIC' ? 'selected' : ''}>ACADEMIC</option>
                    <option value="EXAMINATION" ${announcement.category == 'EXAMINATION' ? 'selected' : ''}>EXAMINATION</option>
                    <option value="EVENTS" ${announcement.category == 'EVENTS' ? 'selected' : ''}>EVENTS</option>
                    <option value="GENERAL" ${announcement.category == 'GENERAL' ? 'selected' : ''}>GENERAL</option>
                </select>
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Content</label>
                <textarea name="content" required rows="6" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition"><c:out value="${announcement.content}"/></textarea>
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Replace Attachment (Optional)</label>
                <div class="border-2 border-dashed border-slate-200 hover:border-emerald-500 rounded-2xl p-6 text-center cursor-pointer relative bg-slate-50 transition">
                    <input type="file" name="attachment" class="absolute inset-0 opacity-0 cursor-pointer">
                    <i class="fas fa-upload text-xl text-slate-400 mb-2"></i>
                    <p class="text-xs text-slate-500">Choose a new file to overwrite the current attachment</p>
                </div>
                <c:if test="${not empty announcement.filePath}">
                    <p class="text-xs text-emerald-600 font-medium mt-2"><i class="fas fa-paperclip"></i> Existing file: ${announcement.filePath}</p>
                </c:if>
            </div>

            <div class="flex gap-4 pt-4">
                <a href="announcements" class="flex-1 py-4 bg-slate-100 text-slate-600 font-bold rounded-2xl text-center hover:bg-slate-200 transition">Cancel</a>
                <button type="submit" class="flex-1 py-4 bg-emerald-600 text-white font-bold rounded-2xl hover:bg-emerald-700 transition">Save Changes</button>
            </div>
        </form>
    </div>
</body>
</html>
