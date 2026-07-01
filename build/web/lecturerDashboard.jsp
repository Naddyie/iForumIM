<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Faculty Dashboard - iForum IM</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        
        /* Sidebar active and hover link states themed around emerald */
        .sidebar-link.active {
            background-color: #ecfdf5;
            color: #059669;
            border-right: 4px solid #059669;
        }
        
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: #f1f1f1; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 10px; }
        
        .interactive-card { transition: transform 0.2s ease, box-shadow 0.2s ease; }
        .interactive-card:hover { transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05); }
    </style>
</head>
<body class="bg-[#fcfcfd] text-slate-900">

    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
            <!-- Brand Logotype (Emerald Accent with Graduation Cap Logo) -->
            <div class="p-6 flex items-center space-x-2.5">
                <div class="bg-[#059669] p-1.5 rounded-lg">
                    <i class="fas fa-graduation-cap text-white text-lg"></i>
                </div>
                <span class="text-xl font-bold tracking-tight text-slate-800">iForum<span class="text-[#059669]">IM</span></span>
            </div>

            <!-- Navigation Links -->
            <nav class="flex-1 px-4 space-y-1 mt-4">
                <a href="lecturerDashboard" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
                    <i class="fas fa-th-large w-5"></i>
                    <span>Overview</span>
                </a>
                <a href="discussions" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                    <i class="fas fa-comments w-5"></i>
                    <span>Discussions</span>
                </a>
                <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
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

            <!-- User Info Sidebar Card -->
            <div class="p-4 border-t border-slate-100">
                <div class="bg-[#044e37] rounded-xl p-4 text-white shadow-lg">
                    <p class="text-[9px] font-bold text-emerald-300 mb-1 uppercase tracking-widest">LECTURER ACCESS</p>
                    <p class="font-bold truncate text-sm">
                        <c:out value="${sessionScope.user.fullname}" default="Lecturer" />
                    </p>
                    <form action="logout" method="post">
                        <button type="submit" class="mt-3 w-full bg-[#033c2a] hover:bg-[#022b1e] py-2 rounded-lg text-xs font-bold transition flex items-center justify-center gap-2">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </form>
                </div>
            </div>
        </aside>

        <!-- Main Content Area -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <!-- Header -->
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <h2 class="text-base font-bold text-slate-800">Faculty Dashboard</h2>
                <div class="flex items-center space-x-4">
                    <!-- User Initials Circle -->
                    <a href="user?action=profile" class="group flex items-center space-x-2">
                        <div class="h-8 w-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold text-xs border border-emerald-200 uppercase group-hover:bg-emerald-600 group-hover:text-white transition-colors">
                            ${sessionScope.user.initials != null ? sessionScope.user.initials : 'ST'}
                        </div>
                        <span class="text-sm font-medium text-slate-600 group-hover:text-emerald-600 hidden md:block"></span>
                    </a>
                </div>
            </header>

            <!-- Scrollable Content Area -->
            <div class="flex-1 overflow-y-auto p-8 custom-scrollbar">
                
                <!-- Welcome Banner -->
                <div class="mb-8">
                    <h1 class="text-2xl font-bold mb-1 text-slate-900">
                        Welcome back, <c:out value="${sessionScope.user.fullname}" default="Lecturer" />!
                    </h1>
                    <p class="text-slate-500 text-sm">Monitor your student engagement and discussion topics.</p>
                </div>

                <!-- Feed Content and Quick Tools Split Layout -->
                <div class="grid grid-cols-1 lg:grid-cols-5 gap-8">
                    
                    <!-- Left Section: Dynamic Pending Questions -->
                    <div class="lg:col-span-3 bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 flex flex-col">
                        <div class="flex justify-between items-center mb-6">
                            <h3 class="font-bold text-slate-800">Pending Questions</h3>
                            <a href="discussions" class="text-xs font-bold text-emerald-600 hover:underline">View All</a>
                        </div>
                        
                        <div class="space-y-4">
                            <c:choose>
                                <c:when test="${not empty pendingQuestions}">
                                    <c:forEach var="group" items="${pendingQuestions}">
                                        <!-- Dynamic Question Item linked directly to WhatsApp/Telegram chatroom -->
                                        <div onclick="window.location.href='discussions?action=room&groupId=${group.groupId}'" 
                                             class="p-4 bg-slate-50/80 hover:bg-emerald-50/30 border border-slate-100 hover:border-emerald-200 rounded-xl flex flex-col cursor-pointer transition">
                                            <p class="text-sm font-bold text-slate-800 hover:text-emerald-700 transition">
                                                <c:out value="${group.title}" />
                                            </p>
                                            <div class="flex items-center justify-between mt-2">
                                                <span class="px-2 py-0.5 bg-emerald-50 text-emerald-700 text-[9px] font-bold rounded uppercase tracking-wider">
                                                    <c:out value="${group.category}" />
                                                </span>
                                                <p class="text-[11px] text-slate-400">
                                                    Created by <span class="font-medium text-slate-600"><c:out value="${group.creatorName}" /></span>
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-12 text-slate-400">
                                        <i class="far fa-comments text-4xl mb-3 opacity-20 block"></i>
                                        <p class="text-sm">No discussions found. Use Quick Tools to create one.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Right Section: Quick Tools -->
                    <div class="lg:col-span-2 bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 flex flex-col">
                        <h3 class="font-bold text-slate-800 mb-6">Quick Tools</h3>
                        
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <!-- Tool 1: New Topic Link -->
                            <a href="discussions" class="flex flex-col items-center justify-center p-6 border-2 border-dashed border-slate-200/80 rounded-xl hover:border-emerald-500 hover:bg-emerald-50/30 transition-all text-center group cursor-pointer">
                                <div class="bg-slate-50 p-2.5 rounded-full group-hover:bg-emerald-50 text-slate-400 group-hover:text-emerald-600 transition mb-3">
                                    <i class="fas fa-plus text-sm"></i>
                                </div>
                                <span class="text-xs font-bold text-slate-500 group-hover:text-slate-700">New Topic</span>
                            </a>

                            <!-- Tool 2: Broadcast / Announcement Link -->
                            <a href="announcements" class="flex flex-col items-center justify-center p-6 border-2 border-dashed border-slate-200/80 rounded-xl hover:border-emerald-500 hover:bg-emerald-50/30 transition-all text-center group cursor-pointer">
                                <div class="bg-slate-50 p-2.5 rounded-full group-hover:bg-emerald-50 text-slate-400 group-hover:text-emerald-600 transition mb-3">
                                    <i class="fas fa-bullhorn text-sm"></i>
                                </div>
                                <span class="text-xs font-bold text-slate-500 group-hover:text-slate-700">Broadcast</span>
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

</body>
</html>