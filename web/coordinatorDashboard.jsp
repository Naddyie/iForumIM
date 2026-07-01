<%-- 
    Document   : coordinatorDashboard
    Created on : May 12, 2026, 11:27:28 AM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coordinator Dashboard - iForum IM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .sidebar-link.active {
            background-color: #f8fafc;
            color: #0f172a;
            border-left: 4px solid #0f172a;
        }
        .admin-stat { border-left: 4px solid #10b981; }
    </style>
</head>
<body class="bg-slate-50 text-slate-900">

    <div class="flex h-screen overflow-hidden">
        <!-- Admin Sidebar (Darker Slate Theme) -->
        <aside class="w-64 bg-slate-900 flex flex-col shrink-0 text-slate-300">
            <div class="p-6 flex items-center space-x-2.5">
                <div class="bg-[#059669] p-1.5 rounded-lg">
                    <i class="fas fa-graduation-cap text-white text-lg"></i>
                </div>
                <span class="text-xl font-bold tracking-tight text-white">iForum<span class="text-[#059669]">IM</span></span>
            </div>

            <nav class="flex-1 px-4 space-y-1 mt-6">
                <p class="px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Management</p>
                <a href="coordinatorDashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-slate-800 text-white font-medium transition">
                    <i class="fas fa-chart-line w-5"></i>
                    <span>Overview</span>
                </a>
                <a href="announcements" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition">
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

        <!-- Main Content -->
        <main class="flex-1 flex flex-col overflow-hidden">
            <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 shrink-0">
                <div class="flex items-center space-x-2">
                    <span class="bg-slate-100 text-slate-600 px-2 py-1 rounded text-[10px] font-bold uppercase">Coordinator Console</span>
                    <i class="fas fa-chevron-right text-[10px] text-slate-300"></i>
                    <h2 class="text-sm font-bold text-slate-800">System Overview</h2>
                </div>
                <div class="flex items-center space-x-6">
                    <a href="user?action=profile" class="group flex items-center space-x-2">
                        <div class="h-8 w-8 bg-slate-900 text-white rounded-lg flex items-center justify-center text-xs">
                            ${sessionScope.user.initials != null ? sessionScope.user.initials : 'ST'}
                        </div>
                        <span class="text-sm font-medium text-slate-600 group-hover:text-emerald-600 hidden md:block"></span>
                    </a>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-8">
                <!-- System Health -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
                    <div class="bg-white p-5 rounded-xl border border-slate-200 admin-stat">
                        <h3 class="text-xs font-bold text-slate-400 uppercase mb-1">Total Users</h3>
                        <p class="text-2xl font-black text-slate-800">${totalUsers}</p>
                    </div>
                    <div class="bg-white p-5 rounded-xl border border-slate-200 admin-stat">
                        <h3 class="text-xs font-bold text-slate-400 uppercase mb-1">Total Discussions</h3>
                        <p class="text-2xl font-black text-slate-800">${totalDiscussions}</p>
                    </div>
                    <div class="bg-white p-5 rounded-xl border border-slate-200 admin-stat">
                        <h3 class="text-xs font-bold text-slate-400 uppercase mb-1">Replies</h3>
                        <p class="text-2xl font-black text-slate-800">${totalReplies}</p>
                    </div>
                </div>

                <!-- Main Admin Table -->
                <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                    <div class="p-6 border-b border-slate-100 flex justify-between items-center">
                        <h3 class="font-bold text-slate-800">List of the Users</h3>
                        <div class="flex space-x-2">
                            <a href="coordinatorDashboard?action=exportUsersCsv"
                               class="px-3 py-1.5 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg text-xs font-bold transition">
                                Export CSV
                            </a>
                        </div>
                    </div>
                    <table class="w-full text-left text-sm">
                        <thead class="bg-slate-50 text-slate-400 uppercase text-[10px] font-bold">
                            <tr>
                                <th class="px-6 py-4">User</th>
                                <th class="px-6 py-4">Matric/ID</th>
                                <th class="px-6 py-4">Role</th>
                                <th class="px-6 py-4">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            <c:forEach var="user" items="${userList}">
                                <tr>
                                    <td class="px-6 py-4 font-medium">
                                        <c:out value="${user.fullname}" />
                                    </td>

                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${user.role == 'STUDENT'}">
                                                <c:out value="${user.matric_Number}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${user.email}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${user.role == 'STUDENT'}">
                                                <span class="px-2 py-1 bg-blue-50 text-blue-600 rounded text-[10px] font-bold">
                                                    STUDENT
                                                </span>
                                            </c:when>
                                            <c:when test="${user.role == 'LECTURER'}">
                                                <span class="px-2 py-1 bg-amber-50 text-amber-600 rounded text-[10px] font-bold">
                                                    LECTURER
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 py-1 bg-slate-100 text-slate-600 rounded text-[10px] font-bold">
                                                    <c:out value="${user.role}" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${user.role == 'STUDENT'}">
                                                <span class="flex items-center text-emerald-600">
                                                    <i class="fas fa-check-circle mr-1"></i>
                                                    <c:out value="${user.studentStatus}" />
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="flex items-center text-slate-500">
                                                    <i class="fas fa-user-shield mr-1"></i>
                                                    Staff Account
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty userList}">
                                <tr>
                                    <td colspan="5" class="px-6 py-8 text-center text-slate-400">
                                        No users found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
