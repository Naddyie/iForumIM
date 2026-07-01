<%-- 
    Document   : Discussions
    Created on : Jan 17, 2026, 9:58:57 AM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

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
    <title>Discussions Channels - iForum IM</title>
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
        <!-- Sidebar -->
        
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
                        <a href="discussions" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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
                        <a href="discussions" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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

        <!-- Main Workspace -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <!--<header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <h2 class="text-lg font-bold text-slate-800">Discussion Channels</h2>
                <div class="h-8 w-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold text-xs">
                    ${sessionScope.user.initials}
                </div>
            </header>-->
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">

                <c:choose>

                    <c:when test="${sessionScope.user.role == 'LECTURER'}">
                        <h2 class="text-lg font-bold text-slate-800">
                            Faculty Discussions
                        </h2>
                    </c:when>

                    <c:otherwise>
                        <h2 class="text-lg font-bold text-slate-800">
                            Community Discussions
                        </h2>
                    </c:otherwise>

                </c:choose>

                <a href="user?action=profile" class="group flex items-center space-x-2">
                    <div class="h-8 w-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold text-xs border border-emerald-200 uppercase group-hover:bg-emerald-600 group-hover:text-white transition-colors">
                        ${sessionScope.user.initials != null ? sessionScope.user.initials : 'ST'}
                    </div>
                    <span class="text-sm font-medium text-slate-600 group-hover:text-emerald-600 hidden md:block"></span>
                </a>

            </header>

            <div class="flex-1 overflow-y-auto p-8 custom-scrollbar">
                <div class="max-w-6xl mx-auto">
                    
                    <div class="flex justify-between items-center mb-8">
                        <div>
                            <h1 class="text-2xl font-bold text-slate-900">Academic Chat Channels</h1>
                            <p class="text-sm text-slate-500 mt-1">Browse and join specialized channels or group conversations.</p>
                        </div>
                        
                        <!-- CREATE BUTTON FOR STUDENT AND LECTURER -->
                        <c:if test="${sessionScope.user.role == 'STUDENT' || sessionScope.user.role == 'LECTURER'}">
                            <button onclick="document.getElementById('createModal').classList.remove('hidden')" 
                                    class="bg-emerald-600 hover:bg-emerald-700 text-white px-5 py-3 rounded-xl text-sm font-bold shadow-md shadow-emerald-100 transition-all flex items-center gap-2">
                                <i class="fas fa-plus"></i> New Channel
                            </button>
                        </c:if>
                    </div>

                    <%-- Groups List Grid --%>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="group" items="${groupList}">
                            <div class="bg-white rounded-2xl border border-slate-200 p-6 flex flex-col justify-between shadow-sm transition hover:shadow-md">
                                <div>
                                    <div class="flex justify-between items-start mb-4">
                                        <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 text-[10px] font-bold rounded-lg uppercase tracking-wide">
                                            <c:out value="${group.category}"/>
                                        </span>
                                        <span class="text-xs text-slate-400 font-medium">
                                            <i class="fas fa-users mr-1"></i> <c:out value="${group.memberCount}"/> members
                                        </span>
                                    </div>
                                    <h3 class="text-lg font-bold text-slate-800 line-clamp-1"><c:out value="${group.title}"/></h3>
                                    <p class="text-xs text-slate-500 mt-2 line-clamp-2 min-h-[2.5rem]"><c:out value="${group.description}"/></p>
                                </div>

                                <div class="mt-6 pt-4 border-t border-slate-100 flex items-center justify-between">
                                    <span class="text-[10px] text-slate-400">By <c:out value="${group.creatorName}"/></span>
                                    
                                    <c:choose>
                                        <c:when test="${group.joined || sessionScope.user.role != 'STUDENT'}">
                                            <a href="discussions?action=room&groupId=${group.groupId}" 
                                               class="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-xl transition">
                                                Enter Chat
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="discussions" method="post">
                                                <input type="hidden" name="action" value="join">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <button type="submit" class="px-4 py-2 bg-slate-100 hover:bg-emerald-50 hover:text-emerald-700 text-slate-700 text-xs font-bold rounded-xl transition">
                                                    Join Channel
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </main>
    </div>

    <!-- Create Channel Modal (Hidden by Default) -->
    <div id="createModal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 flex items-center justify-center hidden p-4">
        <div class="bg-white rounded-[2.5rem] max-w-lg w-full p-8 shadow-2xl border border-slate-100">
            <h3 class="text-2xl font-bold text-slate-900 mb-2">Create New Channel</h3>
            <p class="text-sm text-slate-500 mb-6">Create a focused WhatsApp/Telegram-style discussion space.</p>
            
            <form action="discussions" method="post" class="space-y-5">
                <input type="hidden" name="action" value="create">
                
                <div>
                    <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Channel Title</label>
                    <input type="text" name="title" required placeholder="e.g. Maritime Operations Study Room" 
                           class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition">
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Category</label>
                    <select name="category" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition">
                        <option value="ACADEMIC">ACADEMIC</option>
                        <option value="STUDY GROUP">STUDY GROUP</option>
                        <option value="GENERAL">GENERAL</option>
                    </select>
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Description</label>
                    <textarea name="description" rows="3" placeholder="Briefly describe what this channel is for..." 
                              class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:border-emerald-500 transition"></textarea>
                </div>

                <div class="flex gap-4 pt-4">
                    <button type="button" onclick="document.getElementById('createModal').classList.add('hidden')" 
                            class="flex-1 py-4 bg-slate-100 text-slate-600 font-bold rounded-2xl hover:bg-slate-200 transition">
                        Cancel
                    </button>
                    <button type="submit" class="flex-1 py-4 bg-emerald-600 text-white font-bold rounded-2xl hover:bg-emerald-700 transition shadow-lg shadow-emerald-100">
                        Create Channel
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>