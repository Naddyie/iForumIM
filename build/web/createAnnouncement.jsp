<%-- 
    Document   : createAnnouncement
    Created on : May 23, 2026, 3:28:56 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Create Announcement - iForumIM</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-800 p-8">
    <div class="max-w-2xl mx-auto bg-white border border-slate-200 rounded-[2.5rem] p-8 shadow-xl mt-8">
        <div class="mb-6 flex items-center justify-between">
            <div>
                <h1 class="text-2xl font-bold text-slate-900">Publish Campus Notice</h1>
                <p class="text-xs text-slate-400 mt-1">Broadcast official bulletins, lectures, updates, or documents.</p>
            </div>
            <a href="announcements" class="text-slate-400 hover:text-slate-600"><i class="fas fa-times text-xl"></i></a>
        </div>

        <form action="announcements?action=create" method="post" enctype="multipart/form-data" class="space-y-5">
            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Title</label>
                <input type="text" name="title" required class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 focus:bg-white transition" placeholder="e.g., Final Exam Schedule Release">
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Category Flag</label>
                <select name="category" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 focus:bg-white transition">
                    <option value="ACADEMIC">ACADEMIC</option>
                    <option value="EXAMINATION">EXAMINATION</option>
                    <option value="EVENTS">EVENTS</option>
                    <option value="GENERAL">GENERAL</option>
                </select>
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Content Message Body</label>
                <textarea name="content" required rows="6" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 focus:bg-white transition" placeholder="Provide complete bulletin message description instructions..."></textarea>
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Attachment (PDF, DOCX, Images)</label>
                <div class="border-2 border-dashed border-slate-200 hover:border-emerald-500 rounded-2xl p-6 text-center cursor-pointer relative bg-slate-50 transition">
                    <input type="file" name="attachment" class="absolute inset-0 opacity-0 cursor-pointer">
                    <i class="fas fa-cloud-upload-alt text-2xl text-slate-400 mb-2"></i>
                    <p class="text-xs text-slate-500">Click or drag a file to attach to this announcement</p>
                </div>
            </div>

            <div class="flex gap-4 pt-4">
                <a href="announcements" class="flex-1 py-4 bg-slate-100 text-slate-600 font-bold rounded-2xl text-center hover:bg-slate-200 transition">Cancel</a>
                <button type="submit" class="flex-1 py-4 bg-emerald-600 text-white font-bold rounded-2xl hover:bg-emerald-700 transition shadow-lg shadow-emerald-100">Publish Notice</button>
            </div>
        </form>
    </div>
</body>
</html>
