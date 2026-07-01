<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Prevent browser caching of this secure page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Session validation: If the user is not logged in, redirect them immediately to the login page
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
    <title>Student Dashboard - iForum IM</title>
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
        .custom-scrollbar::-webkit-scrollbar-track { background: #f1f1f1; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 10px; }
        .dashboard-card { transition: transform 0.2s ease, box-shadow 0.2s ease; }
        .dashboard-card:hover { transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body class="bg-slate-50 text-slate-900">

    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
            <div class="p-6 flex items-center space-x-2">
                <div class="bg-emerald-600 p-1.5 rounded-lg">
                    <i class="fas fa-graduation-cap text-white text-lg"></i>
                </div>
                <span class="text-xl font-bold tracking-tight">iForum<span class="text-emerald-600">IM</span></span>
            </div>

            <nav class="flex-1 px-4 space-y-1 mt-4">
                <a href="studentDashboard" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
                    <i class="fas fa-th-large w-5"></i>
                    <span>Dashboard</span>
                </a>
                <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                    <i class="fas fa-comments w-5"></i>
                    <span>Discussions</span>
                </a>
                <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
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
                <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                    <i class="fas fa-user-circle w-5"></i>
                    <span>My Profile</span>
                </a>
            </nav>

            <div class="p-4 border-t border-slate-100">
                <div class="bg-slate-900 rounded-xl p-4 text-white">
                    <p class="text-xs font-bold text-slate-400 mb-1 uppercase tracking-wider">Logged in as</p>
                    <p class="font-bold truncate">
                        <c:out value="${not empty sessionScope.user.fullname ? sessionScope.user.fullname : 'Guest Student'}" />
                    </p>
                    <form action="logout" method="post">
                        <button type="submit" class="mt-3 w-full bg-slate-800 hover:bg-slate-700 py-2 rounded-lg text-xs font-bold transition">
                            <i class="fas fa-sign-out-alt mr-2"></i>Logout
                        </button>
                    </form>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <h2 class="text-lg font-bold text-slate-800">Student Dashboard</h2>
                <div class="flex items-center space-x-4">
                    
                    <a href="user?action=profile" class="group flex items-center space-x-2">
                        <div class="h-8 w-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold text-xs border border-emerald-200 uppercase group-hover:bg-emerald-600 group-hover:text-white transition-colors">
                            ${sessionScope.user.initials != null ? sessionScope.user.initials : 'ST'}
                        </div>
                        <span class="text-sm font-medium text-slate-600 group-hover:text-emerald-600 hidden md:block"></span>
                    </a>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-8 custom-scrollbar">
                <!-- Welcome Banner -->
                <div class="bg-gradient-to-r from-emerald-600 to-teal-500 rounded-2xl p-8 mb-8 text-white shadow-md">
                    <h1 class="text-2xl font-bold mb-2">
                        Welcome back, <c:out value="${not empty sessionScope.user.fullname ? sessionScope.user.fullname : 'Student'}" />! 👋
                    </h1>
                    <p class="text-emerald-50 opacity-90">Stay updated with your latest forum activities and course resources.</p>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Recent Discussions Table -->
                    <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden flex flex-col">
                        <div class="px-6 py-4 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                            <h3 class="font-bold text-slate-800">Recent Group Discussions</h3>
                            <a href="discussions" class="text-xs font-bold text-emerald-600 hover:underline">View All</a>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <tbody class="divide-y divide-slate-50">
                                    <c:choose>
                                        <c:when test="${not empty recentTopics}">
                                            <c:forEach items="${recentTopics}" var="topic">
                                                <!-- Action link to enter discussion channel or join room -->
                                                <tr onclick="window.location.href='discussions?action=room&groupId=${topic.groupId}'" class="hover:bg-slate-50 transition cursor-pointer">
                                                    <td class="px-6 py-4">
                                                        <p class="font-bold text-sm text-slate-800">${topic.title}</p>
                                                        <p class="text-[11px] text-slate-400">In ${topic.category} &bull; Created by ${topic.creatorName}</p>
                                                    </td>
                                                    <td class="px-6 py-4 text-right">
                                                        <span class="text-xs font-semibold text-slate-500"><i class="far fa-user mr-1"></i> ${topic.memberCount} joined</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="2" class="px-6 py-12 text-center text-slate-400">
                                                    <i class="fas fa-comments text-4xl mb-3 block opacity-20"></i>
                                                    No recent topics found.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Latest Announcements -->
                    <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                            <h3 class="font-bold text-slate-800">Latest Announcements</h3>
                            <a href="announcements" class="text-xs font-bold text-emerald-600 hover:underline">View All</a>
                        </div>
                        <div class="p-6 space-y-4">
                            <c:choose>
                                <c:when test="${not empty announcements}">
                                    <c:forEach items="${announcements}" var="ann">
                                        <!-- Action link to redirect student to view announcement page -->
                                        <div onclick="window.location.href='announcements?action=view&id=${ann.announcement_id}'" class="flex items-start space-x-4 p-3 rounded-xl hover:bg-slate-50 cursor-pointer transition">
                                            <div class="bg-emerald-100 text-emerald-600 p-2 rounded-lg shrink-0">
                                                <i class="fas fa-bullhorn text-sm"></i>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <h4 class="text-sm font-bold text-slate-800 truncate">${ann.title}</h4>
                                                <p class="text-xs text-slate-500 line-clamp-2 mt-1">${ann.content}</p>
                                                <span class="text-[10px] text-slate-400 mt-2 block font-medium uppercase tracking-tighter">
                                                    <fmt:formatDate value="${ann.createdAt}" pattern="dd MMM yyyy" />
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-8 text-slate-400">
                                        No announcements at this time.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>