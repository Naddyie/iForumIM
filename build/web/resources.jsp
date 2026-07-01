<%-- 
    Document   : resources
    Created on : May 24, 2026, 10:31:31 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resources - iForum IM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .sidebar-link.active {
            background-color: #ecfdf5;
            color: #059669;
            border-right: 4px solid #059669;
        }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
    </style>
</head>
<body class="bg-[#fcfcfd] text-slate-900">
    <div class="flex h-screen overflow-hidden">
        
        <!-- Sidebar Navigation -->
        <c:choose>
            <c:when test="${sessionScope.user.role == 'LECTURER'}">
                <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
                    <div class="p-6 flex items-center space-x-2">
                        <div class="bg-emerald-600 p-1.5 rounded-lg"><i class="fas fa-graduation-cap text-white text-lg"></i></div>
                        <span class="text-xl font-bold tracking-tight">iForum<span class="text-emerald-600">IM</span></span>
                    </div>
                    <nav class="flex-1 px-4 space-y-1 mt-4">
                        <a href="lecturerDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-th-large w-5"></i><span>Overview</span></a>
                        <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-comments w-5"></i><span>Discussions</span></a>
                        <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-bullhorn w-5"></i><span>Post Announcement</span></a>
                        <a href="resources" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group"><i class="fas fa-folder-open w-5"></i><span>Upload Materials</span></a>
                        <a href="feedback" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-comment-dots w-5"></i><span>Manage Student Feedback</span></a>
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-user-circle w-5"></i><span>My Profile</span></a>
                    </nav>
                    <div class="p-4 border-t border-slate-100">
                        <div class="bg-[#044e37] rounded-xl p-4 text-white shadow-lg">
                            <p class="text-[9px] font-bold text-emerald-300 mb-1 uppercase tracking-widest">LECTURER ACCESS</p>
                            <p class="font-bold truncate text-sm">${sessionScope.user.fullname}</p>
                            <form action="logout" method="post">
                                <button type="submit" class="mt-3 w-full bg-[#033c2a] hover:bg-[#022b1e] py-2 rounded-lg text-xs font-bold transition"><i class="fas fa-sign-out-alt mr-2"></i>Logout</button>
                            </form>
                        </div>
                    </div>
                </aside>
            </c:when>
            <c:otherwise>
                <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
                    <div class="p-6 flex items-center space-x-2">
                        <div class="bg-emerald-600 p-1.5 rounded-lg"><i class="fas fa-graduation-cap text-white text-lg"></i></div>
                        <span class="text-xl font-bold tracking-tight">iForum<span class="text-emerald-600">IM</span></span>
                    </div>
                    <nav class="flex-1 px-4 space-y-1 mt-4">
                        <a href="studentDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-th-large w-5"></i><span>Dashboard</span></a>
                        <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-comments w-5"></i><span>Discussions</span></a>
                        <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-bullhorn w-5"></i><span>Announcements</span></a>
                        <a href="resources" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group"><i class="fas fa-folder-open w-5"></i><span>Resources</span></a>
                        <a href="feedback" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-comment-dots w-5"></i><span>Feedback</span></a>
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition"><i class="fas fa-user-circle w-5"></i><span>My Profile</span></a>
                    </nav>
                    <div class="p-4 border-t border-slate-100">
                        <div class="bg-slate-900 rounded-xl p-4 text-white">
                            <p class="text-xs font-bold text-slate-400 mb-1 uppercase tracking-wider">Logged in as</p>
                            <p class="font-bold truncate">${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Guest Student'}</p>
                            <form action="logout" method="post">
                                <button type="submit" class="mt-3 w-full bg-slate-800 hover:bg-slate-700 py-2 rounded-lg text-xs font-bold transition"><i class="fas fa-sign-out-alt mr-2"></i>Logout</button>
                            </form>
                        </div>
                    </div>
                </aside>
            </c:otherwise>
        </c:choose>

        <!-- Main Content -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8">
                <h2 class="text-base font-bold">Learning Materials</h2>
            </header>

            <div class="flex-1 overflow-y-auto p-8 custom-scrollbar">
                <c:if test="${sessionScope.user.role == 'LECTURER'}">
                    <div class="bg-white p-6 rounded-xl border border-slate-200 mb-8 shadow-sm">
                        <h3 class="font-bold mb-4 text-emerald-700"><i class="fas fa-upload mr-2"></i> Upload New Resource</h3>
                        <form action="resources?action=upload" method="post" enctype="multipart/form-data" class="grid md:grid-cols-3 gap-4">
                            <input type="text" name="title" placeholder="Title" class="border p-2 rounded" required>
                            <select name="subjectName" class="border p-2 rounded" required>
                                <c:forEach var="s" items="${subjectList}"><option value="${s.subjectName}">${s.subjectName}</option></c:forEach>
                            </select>
                            <input type="file" name="file" class="p-1" required>
                            <button class="bg-emerald-600 text-white py-2 rounded font-bold col-span-3">Upload</button>
                        </form>
                    </div>
                </c:if>

                <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                    <!-- Accordion Section -->
                    <div class="space-y-4">
                        <c:forEach var="entry" items="${groupedResources}">
                            <div class="bg-white rounded-lg border shadow-sm">
                                <button onclick="this.nextElementSibling.classList.toggle('hidden')" class="w-full p-4 text-left font-bold bg-slate-100 flex justify-between items-center rounded-t-lg">
                                    <span><i class="fas fa-folder text-emerald-600 mr-2"></i> ${entry.key}</span>
                                    <i class="fas fa-chevron-down text-xs"></i>
                                </button>
                                <div class="hidden">
                                    <c:forEach var="r" items="${entry.value}">
                                        <div class="flex items-center justify-between p-4 border-t hover:bg-slate-50">
                                            <div class="flex items-center gap-3">
                                                <c:choose>
                                                    <c:when test="${r.fileType == 'application/pdf'}">
                                                        <i class="fas fa-file-pdf text-red-500"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-file-alt text-blue-500"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="font-medium text-sm">${r.title}</span>
                                            </div>
                                            <div class="flex gap-4">
                                                <a href="resources?action=download&id=${r.resourceId}" class="text-xs text-emerald-600 font-bold hover:underline">Download</a>
                                                <c:if test="${sessionScope.user.role == 'LECTURER'}">
                                                    <a href="resources?action=delete&id=${r.resourceId}" class="text-xs text-red-600 font-bold hover:underline">Delete</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>