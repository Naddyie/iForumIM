<%-- 
    Document   : viewAnnouncement
    Created on : May 23, 2026, 3:38:52 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${announcement.title} - iForumIM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-slate-50 text-slate-800 p-8">
    <div class="max-w-4xl mx-auto bg-white border border-slate-200 rounded-[2.5rem] p-8 shadow-md">
        
        <div class="mb-6">
            <a href="announcements" class="text-sm font-bold text-emerald-600 hover:text-emerald-700 inline-flex items-center gap-3 mb-4">
                <i class="fas fa-arrow-left"></i> Back to Announcements
            </a>
            <div class="flex items-center gap-2 mb-2">
                <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 text-xs font-bold rounded-lg uppercase">${announcement.category}</span>
                <span class="text-xs text-slate-400"><fmt:formatDate value="${announcement.createdAt}" pattern="dd MMMM yyyy, hh:mm a" /></span>
            </div>
            <h1 class="text-3xl font-bold text-slate-900">${announcement.title}</h1>
            <p class="text-xs text-slate-400 mt-2">Published by <span class="font-semibold text-slate-700">${announcement.creatorName}</span> (${announcement.creatorRole})</p>
        </div>

        <div class="prose max-w-none text-slate-600 text-sm leading-relaxed border-t border-slate-100 pt-6">
            ${fn:replace(announcement.content, java.lang.System.lineSeparator(), '<br/>')}
        </div>

        <c:if test="${not empty announcement.filePath}">
            <div class="mt-8 pt-6 border-t border-slate-100">
                <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-3">Attached File Media</h4>
                
                <c:set var="pathLower" value="${fn:toLowerCase(announcement.filePath)}" />
                
                <c:choose>
                    <c:when test="${fn:endsWith(pathLower, '.jpg') || fn:endsWith(pathLower, '.jpeg') || fn:endsWith(pathLower, '.png') || fn:endsWith(pathLower, '.gif')}">
                        <div class="rounded-2xl overflow-hidden border border-slate-200 max-w-lg shadow-sm bg-slate-50 p-2">
                            <img src="${announcement.filePath}" alt="Attachment preview image" class="rounded-xl w-full object-contain max-h-96">
                            <div class="p-2 text-center">
                                <a href="${announcement.filePath}" download class="text-xs text-emerald-600 font-bold hover:underline"><i class="fas fa-download mr-1"></i> Download Original Image</a>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="flex items-center justify-between p-4 bg-slate-50 border border-slate-200 rounded-2xl max-w-md">
                            <div class="flex items-center space-x-3 truncate">
                                <div class="p-3 bg-white text-emerald-600 rounded-xl border border-slate-200 shadow-sm">
                                    <i class="fas fa-file-alt text-lg"></i>
                                </div>
                                <div class="truncate">
                                    <p class="text-xs font-bold text-slate-700 truncate">${fn:substringAfter(announcement.filePath, "/")}</p>
                                    <p class="text-[10px] text-slate-400">Official Context File Document</p>
                                </div>
                            </div>
                            <a href="${announcement.filePath}" download class="ml-4 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold px-4 py-2.5 rounded-xl transition shadow-md shadow-emerald-50 shrink-0">
                                <i class="fas fa-download"></i> Download
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

    </div>
</body>
</html>
