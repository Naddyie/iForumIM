<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>iForumIM - Announcements</title>
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
    </style>
</head>
<body class="bg-slate-50 text-slate-900">

    <div class="flex h-screen overflow-hidden">
        
        <c:choose>

            <%-- LECTURER SIDEBAR --%>
            <c:when test="${sessionScope.user.role == 'LECTURER'}">

                <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">

                    <div class="p-6 flex items-center space-x-2">
                        <div class="bg-emerald-600 p-1.5 rounded-lg">
                            <i class="fas fa-graduation-cap text-white text-lg"></i>
                        </div>
                        <span class="text-xl font-bold tracking-tight">
                            iForum<span class="text-emerald-600">IM</span>
                        </span>
                    </div>

                    <nav class="flex-1 px-4 space-y-1 mt-4">

                        <a href="lecturerDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-th-large w-5"></i>
                            <span>Overview</span>
                        </a>
                        <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-comments w-5"></i>
                            <span>Discussions</span>
                        </a>
                        <a href="announcements" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
                            <i class="fas fa-bullhorn w-5"></i>
                            <span>Post Announcement</span>
                        </a>
                        <a href="resources" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-folder-open w-5"></i>
                            <span>Upload Materials</span>
                        </a>
                        <!-- Link to Student Feedback -->
                        <a href="feedback" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-comment-dots w-5"></i>
                            <span>Manage Student Feedback</span>
                        </a>
                        <!-- Link to Profile Page -->
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-user-circle w-5"></i>
                            <span>My Profile</span>
                        </a>

                    </nav>

                    <%-- Lecturer Logout --%>
                    <div class="p-4 border-t border-slate-100">
                        <div class="bg-[#044e37] rounded-xl p-4 text-white shadow-lg">

                            <p class="text-[9px] font-bold text-emerald-300 mb-1 uppercase tracking-widest">
                                LECTURER ACCESS
                            </p>

                            <p class="font-bold truncate text-sm">
                                ${sessionScope.user.fullname}
                            </p>

                            <form action="logout" method="post">
                                <button type="submit"
                                        class="mt-3 w-full bg-[#033c2a] hover:bg-[#022b1e] py-2 rounded-lg text-xs font-bold transition">

                                    <i class="fas fa-sign-out-alt mr-2"></i>
                                    Logout
                                </button>
                            </form>

                        </div>
                    </div>

                </aside>

            </c:when>
            
            <%-- COORDINATOR SIDEBAR --%>
            <c:when test="${sessionScope.user.role == 'COORDINATOR' || sessionScope.user.role == 'ADMIN'}">
                <aside class="w-64 bg-slate-900 flex flex-col shrink-0 text-slate-300">
                    <div class="p-6 flex items-center space-x-2.5">
                        <div class="bg-[#059669] p-1.5 rounded-lg">
                            <i class="fas fa-graduation-cap text-white text-lg"></i>
                        </div>
                        <span class="text-xl font-bold tracking-tight text-white">iForum<span class="text-[#059669]">IM</span></span>
                    </div>

                    <nav class="flex-1 px-4 space-y-1 mt-6">
                        <p class="px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Management</p>
                        <a href="coordinatorDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition">
                            <i class="fas fa-chart-line w-5"></i>
                            <span>Overview</span>
                        </a>
                        <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-slate-800 text-white font-medium transition">
                            <i class="fas fa-bullhorn w-5"></i>
                            <span>Post Announcement</span>
                        </a>
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition">
                            <i class="fas fa-user-shield w-5"></i>
                            <span>Profile</span>
                        </a>
                    </nav>

                    <div class="p-4">
                        <form action="logout" method="get">
                            <button type="submit" class="w-full bg-slate-800 hover:bg-red-900/40 hover:text-red-400 py-3 rounded-xl text-xs font-bold transition flex items-center justify-center space-x-2">
                                <i class="fas fa-power-off"></i>
                                <span>Exit Admin Panel</span>
                            </button>
                        </form>
                    </div>
                </aside>
            </c:when>

            <%-- STUDENT SIDEBAR --%>
            <c:otherwise>

                <!-- KEEP YOUR CURRENT STUDENT SIDEBAR HERE -->
                <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
                    <div class="p-6 flex items-center space-x-2">
                        <div class="bg-emerald-600 p-1.5 rounded-lg">
                            <i class="fas fa-graduation-cap text-white text-lg"></i>
                        </div>
                        <span class="text-xl font-bold tracking-tight">iForum<span class="text-emerald-600">IM</span></span>
                    </div>

                    <nav class="flex-1 px-4 space-y-1 mt-4">
                        <a href="studentDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-th-large w-5"></i>
                            <span>Dashboard</span>
                        </a>
                        <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-comments w-5"></i>
                            <span>Discussions</span>
                        </a>
                        <a href="announcements" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
                            <i class="fas fa-bullhorn w-5"></i>
                            <span>Announcements</span>
                        </a>
                        <a href="resources" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-folder-open w-5"></i>
                            <span>Resources</span>
                        </a>
                        <a href="feedback" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-comment-dots w-5"></i>
                            <span>Feedback</span>
                        </a>
                        <!-- Link to Profile Page -->
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-user-circle w-5"></i>
                            <span>My Profile</span>
                        </a>
                    </nav>

                    <div class="p-4 border-t border-slate-100">
                        <div class="bg-slate-900 rounded-xl p-4 text-white">
                            <p class="text-xs font-bold text-slate-400 mb-1 uppercase tracking-wider">Logged in as</p>
                            <p class="font-bold truncate">${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Guest Student'}</p>
                            <form action="logout" method="post">
                                <button type="submit" class="mt-3 w-full bg-slate-800 hover:bg-slate-700 py-2 rounded-lg text-xs font-bold transition">
                                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                                </button>
                            </form>
                        </div>
                    </div>
                </aside>

            </c:otherwise>

        </c:choose>
        
        <main class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <h2 class="text-md font-bold text-slate-800">Campus Notification Portal</h2>
            </header>

            <div class="flex-1 overflow-y-auto p-8">
                <div class="max-w-5xl mx-auto">

                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
                        <form action="announcements" method="get" class="flex items-center bg-white border border-slate-200 rounded-2xl px-4 py-2 w-full md:w-96 shadow-sm focus-within:border-emerald-500 transition">
                            <i class="fas fa-search text-slate-400 mr-2.5"></i>
                            <input type="text" name="search" value="${param.search}" placeholder="Search statements, keywords..." class="w-full text-sm outline-none bg-transparent">
                        </form>

                        <c:if test="${sessionScope.user.role != 'STUDENT'}">
                            <a href="createAnnouncement.jsp" class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold px-5 py-3 rounded-2xl text-sm shadow-md shadow-emerald-100 transition-all flex items-center justify-center gap-2">
                                <i class="fas fa-plus"></i> New Announcement
                            </a>
                        </c:if>
                    </div>

                    <div class="space-y-4">
                        <c:forEach var="ann" items="${announcementsList}">
                            <div class="bg-white border border-slate-200 hover:border-slate-300 rounded-3xl p-6 shadow-sm hover:shadow-md transition flex flex-col justify-between relative overflow-hidden group">

                                <div class="absolute top-0 left-0 bottom-0 w-1.5 bg-emerald-600"></div>

                                <div>
                                    <div class="flex items-center justify-between gap-2 mb-3">
                                        <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 text-[10px] font-bold rounded-lg uppercase tracking-wide">
                                            ${ann.category}
                                        </span>
                                        <span class="text-xs text-slate-400 font-medium">
                                            <fmt:formatDate value="${ann.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                                        </span>
                                    </div>
                                    <h3 class="text-lg font-bold text-slate-900 group-hover:text-emerald-700 transition">
                                        <a href="announcements?action=view&id=${ann.announcement_id}">${ann.title}</a>
                                    </h3>
                                    <p class="text-sm text-slate-500 mt-2 line-clamp-2 leading-relaxed">${ann.content}</p>
                                </div>

                                <div class="mt-6 pt-4 border-t border-slate-100 flex items-center justify-between">
                                    <div class="text-xs text-slate-400">
                                        Posted by <span class="font-bold text-slate-700">${ann.creatorName}</span> 
                                        <span class="ml-1 text-[9px] bg-slate-100 text-slate-600 font-semibold px-1.5 py-0.5 rounded">${ann.creatorRole}</span>
                                    </div>

                                    <div class="flex items-center space-x-2">
                                        <c:if test="${not empty ann.filePath}">
                                            <span class="text-slate-300 text-xs mr-1"><i class="fas fa-paperclip"></i> Attachment</span>
                                        </c:if>
                                        <a href="announcements?action=view&id=${ann.announcement_id}" class="px-4 py-2 bg-slate-50 hover:bg-emerald-50 hover:text-emerald-700 text-slate-700 text-xs font-bold rounded-xl transition">
                                            View Details
                                        </a>
                                        <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'COORDINATOR' || sessionScope.user.id == ann.creatorId}">
                                            <a href="announcements?action=edit&id=${ann.announcement_id}" class="p-2 text-slate-400 hover:text-blue-600 transition" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="announcements?action=delete&id=${ann.announcement_id}" onclick="return confirm('Confirm archive/deletion?')" class="p-2 text-slate-400 hover:text-red-500 transition" title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty announcementsList}">
                            <div class="text-center py-16 bg-white border border-slate-200 rounded-3xl text-slate-400">
                                <i class="fas fa-bullhorn text-4xl opacity-20 mb-3"></i>
                                <p class="text-sm font-medium">No announcements found matching the current criteria context.</p>
                            </div>
                        </c:if>
                    </div>

                </div>
            </div>
        </main>
    </div>
</body>
</html>