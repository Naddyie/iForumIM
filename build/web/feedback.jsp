<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>Feedback - iForum IM</title>
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
        <!-- Sidebar (Same as your dashboard) -->
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
                        <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-bullhorn w-5"></i>
                            <span>Post Announcement</span>
                        </a>
                        <a href="resources" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-500 hover:bg-slate-50 transition">
                            <i class="fas fa-folder-open w-5"></i>
                            <span>Upload Materials</span>
                        </a>
                        <!-- Link to Student Feedback -->
                        <a href="feedback" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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
                        <a href="feedback" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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

        <!-- Main Content -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 bg-white border-b border-slate-200 flex items-center px-8">
                <h2 class="text-lg font-bold text-slate-800">Feedback System</h2>
            </header>

            <div class="flex-1 overflow-y-auto p-8">
                <div class="max-w-3xl mx-auto">
                    
                    <c:choose>
                        <%-- LECTURER VIEW: See Anonymous Feedback --%>
                        <c:when test="${sessionScope.user.role == 'LECTURER'}">
                            <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                                <div class="p-6 border-b border-slate-100">
                                    <h3 class="font-bold text-lg text-slate-800">Student Feedback Overview</h3>
                                    <p class="text-sm text-slate-500">All submissions are anonymous.</p>
                                </div>
                                <table class="w-full text-left">
                                    <thead class="bg-slate-50">
                                        <tr>
                                            <th class="px-6 py-3 text-xs font-bold text-slate-500 uppercase">Discussion Group</th>
                                            <th class="px-6 py-3 text-xs font-bold text-slate-500 uppercase">Comment</th>
                                            <th class="px-6 py-3 text-xs font-bold text-slate-500 uppercase">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100">
                                        <c:forEach var="f" items="${feedbackList}">
                                            <tr>
                                                <td class="px-6 py-4 font-medium text-slate-800">${f.discussionTitle}</td>
                                                <td class="px-6 py-4 text-slate-600 text-sm">${f.comment}</td>
                                                <td class="px-6 py-4 text-slate-400 text-xs">${f.submittedAt}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>

                        <%-- STUDENT VIEW: Send Anonymous Feedback --%>
                        <c:otherwise>
                            <div class="bg-white rounded-2xl border border-slate-200 shadow-sm p-8">
                                <h1 class="text-xl font-bold mb-2">Provide Feedback</h1>
                                <p class="text-slate-500 mb-6">Your feedback is completely anonymous and will help improve our forum.</p>
                                <%-- Inside the <c:otherwise> block of your feedback.jsp --%>
                                <form action="FeedbackServlet" method="POST" class="space-y-4">
                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-1">Select Discussion Topic</label>
                                        <%-- Replace your old input text field with this select menu --%>
                                        <select name="title" required class="w-full border border-slate-300 p-3 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                                            <option value="" disabled selected>Choose a discussion...</option>
                                            <c:forEach items="${discussionGroups}" var="group">
                                                <option value="${group.title}">${group.title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-1">Rating (1-5)</label>
                                        <input type="number" name="rating" min="1" max="5" required class="w-full border border-slate-300 p-3 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-1">Your Comment</label>
                                        <textarea name="comment" required class="w-full border border-slate-300 p-3 rounded-xl h-32 focus:ring-2 focus:ring-emerald-500 outline-none"></textarea>
                                    </div>

                                    <button type="submit" class="w-full bg-emerald-600 text-white py-3 rounded-xl font-bold hover:bg-emerald-700 transition">
                                        Submit Anonymously
                                    </button>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </main>
    </div>
</body>
</html>