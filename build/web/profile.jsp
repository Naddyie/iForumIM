<%-- 
    Document   : profile
    Created on : Apr 21, 2026, 4:09:00 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - iForum IM</title>
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
                        <a href="user?action=profile" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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
                        <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition">
                            <i class="fas fa-bullhorn w-5"></i>
                            <span>Post Announcement</span>
                        </a>
                        <a href="user?action=profile" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-slate-800 text-white font-medium transition">
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
                        <a href="user?action=profile" class="sidebar-link active flex items-center space-x-3 px-4 py-3 rounded-lg font-medium transition group">
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
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <h2 class="text-lg font-bold text-slate-800">Account Settings</h2>
                
            </header>

            <div class="flex-1 overflow-y-auto p-8 custom-scrollbar">
                <div class="max-w-4xl mx-auto">
                    
                    <c:if test="${param.msg == 'success'}">
                        <div class="mb-6 p-4 bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-2xl flex items-center">
                            <i class="fas fa-check-circle mr-3"></i> Profile updated successfully!
                        </div>
                    </c:if>

                    <div class="bg-white rounded-[2.5rem] shadow-sm border border-slate-200 overflow-hidden mb-8">
                        <!-- Profile Banner -->
                        
                        <c:if test="${not empty param.status}">
                            <div class="mb-6 p-4 rounded-xl text-sm font-medium 
                                <c:choose>
                                    <c:when test='${param.status == "success" || param.status == "password_updated"}'>bg-emerald-50 text-emerald-700 border border-emerald-200</c:when>
                                    <c:otherwise>bg-red-50 text-red-700 border border-red-200</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test='${param.status == "success"}'>Profile updated successfully.</c:when>
                                    <c:when test='${param.status == "password_updated"}'>Password changed successfully.</c:when>
                                    <c:when test='${param.status == "mismatch"}'>Passwords do not match.</c:when>
                                    <c:otherwise>An error occurred. Please try again.</c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                        
                        <div class="bg-emerald-600 h-32 relative">
                            <div class="absolute -bottom-12 left-10">
                                <div class="w-24 h-24 rounded-3xl bg-white p-1 shadow-lg">
                                    <div class="w-full h-full rounded-2xl bg-emerald-100 flex items-center justify-center text-3xl font-bold text-emerald-700 uppercase">
                                        <c:out value="${not empty sessionScope.user.initials ? sessionScope.user.initials : '?'}" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pt-16 p-10">
                            <h3 class="text-xl font-bold text-slate-800 mb-6">Personal Information</h3>
                            <form action="user" method="POST" class="space-y-6">
                                <input type="hidden" name="action" value="updateProfile">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="md:col-span-2">
                                        <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Full Name</label>
                                        <!-- Note: using 'fullname' to match your Model getter getFullname() -->
                                        <input type="text" name="fullname" value="<c:out value='${sessionScope.user.fullname}'/>" 
                                               class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                                    </div>
                                    
                                    <div>
                                        <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Email Address</label>
                                        <input type="email" value="<c:out value='${sessionScope.user.email}'/>" disabled 
                                               class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl text-slate-400 cursor-not-allowed">
                                        <p class="text-[10px] text-slate-400 mt-1 ml-1">Email cannot be changed.</p>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Phone Number</label>
                                        <input type="text" name="phone" value="<c:out value='${sessionScope.user.phone}'/>" 
                                               class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                                    </div>

                                    <c:choose>
                                        <c:when test="${sessionScope.user.role == 'STUDENT'}">
                                            <div>
                                                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Matric Number</label>
                                                <!-- Fixed property access to match getMatric_Number() -->
                                                <input type="text" value="<c:out value='${sessionScope.user.matric_Number}'/>" disabled 
                                                       class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl text-slate-400">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">
                                                    Academic Session
                                                </label>
                                                <input type="text"
                                                       value="${sessionScope.user.academicSession}" disabled
                                                       class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl text-slate-500">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">
                                                    Status
                                                </label>
                                                <input type="text"
                                                       value="${sessionScope.user.studentStatus}" disabled
                                                       class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl text-slate-500">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Program</label>
                                                <input type="text" value="Bachelor of Computer Science with Maritime Informatics" disabled 
                                                       class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl text-slate-400">
                                            </div>
                                        </c:when>
                                        <c:when test="${sessionScope.user.role == 'LECTURER'}">
                                            <div class="md:col-span-2">
                                                <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Faculty</label>
                                                <input type="text" name="faculty" value="<c:out value='${sessionScope.user.faculty}'/>" 
                                                       class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>

                                <div class="pt-6 border-t border-slate-100 flex justify-end">
                                    <button type="submit" class="bg-emerald-600 text-white px-8 py-4 rounded-2xl font-bold shadow-lg shadow-emerald-100 hover:bg-emerald-700 transition transform hover:-translate-y-1">
                                        Update Profile
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Security Section -->
                    <div class="bg-white rounded-[2.5rem] shadow-sm border border-slate-200 p-10">
                        <h3 class="text-xl font-bold text-slate-800 mb-6">Security</h3>
                        <form action="user" method="POST" class="space-y-6">
                            <input type="hidden" name="action" value="changePassword">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">New Password</label>
                                    <input type="password" name="newPassword" placeholder="••••••••"
                                           class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition" required>
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Confirm Password</label>
                                    <input type="password" name="confirmPassword" placeholder="••••••••"
                                           class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition" required>
                                </div>
                            </div>
                            <div class="pt-4 flex justify-end">
                                <button type="submit" class="text-emerald-600 font-bold hover:text-emerald-700 transition">
                                    Change Password <i class="fas fa-arrow-right ml-2 text-xs"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </main>
    </div>
</body>
</html>