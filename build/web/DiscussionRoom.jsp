<%-- 
    Document   : DiscussionRoom
    Created on : May 21, 2026, 6:35:39 PM
    Author     : User
--%>

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
    <title>Room: <c:out value="${group.title}"/> - iForum IM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
    </style>
</head>
<body class="bg-slate-100 text-slate-900 h-screen overflow-hidden flex flex-col">

    <!-- Active Chat Header -->
    <header class="h-16 bg-white border-b border-slate-200 px-6 flex items-center justify-between shadow-sm shrink-0">
        <div class="flex items-center space-x-4">
            <!-- Return Back to List -->
            <a href="discussions" class="p-2 text-slate-400 hover:text-slate-600 transition">
                <i class="fas fa-arrow-left text-lg"></i>
            </a>
            <div>
                <h2 class="text-base font-bold text-slate-800"><c:out value="${group.title}"/></h2>
                <p class="text-[10px] text-slate-400 uppercase tracking-widest"><c:out value="${group.category}"/></p>
            </div>
        </div>
        
        <div class="flex items-center space-x-3">
            <span class="px-3 py-1 text-xs font-semibold bg-emerald-50 text-emerald-700 rounded-lg">
                Active Member
            </span>
        </div>
    </header>

    <!-- Chat Messages Feed Section -->
    <div id="chatFeed" class="flex-1 overflow-y-auto p-6 space-y-4 custom-scrollbar bg-slate-50/50 flex flex-col">
        <c:forEach var="msg" items="${messageList}">
            
            <c:choose>
                <%-- IF CURRENT LOGGED IN USER IS SENDER (Align Right) --%>
                <c:when test="${sessionScope.user.id == msg.senderId}">
                    <div class="flex justify-end w-full">
                        <div class="max-w-[70%] bg-emerald-600 text-white rounded-3xl rounded-tr-sm px-5 py-3.5 shadow-sm">
                            
                            <c:if test="${not empty msg.replyToMessageId}">
                                <div class="mb-2 border-l-4 border-emerald-200 bg-emerald-700 rounded-lg px-3 py-2">
                                    <p class="text-xs font-bold text-emerald-100">
                                        Replying to <c:out value="${msg.replyToSenderName}" />
                                    </p>
                                    <p class="text-xs text-emerald-50">
                                        <c:choose>
                                            <c:when test="${not empty msg.replyToMessageText}">
                                                <c:out value="${msg.replyToMessageText}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${msg.replyToMediaType}" /> attachment
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty msg.media_path}">

                                <!-- IMAGE -->
                                <c:if test="${msg.media_type == 'IMAGE'}">
                                    <img src="uploads/${msg.media_path}"
                                         class="mt-3 rounded-xl max-w-xs shadow">
                                </c:if>

                                <!-- VIDEO -->
                                <c:if test="${msg.media_type == 'VIDEO'}">
                                    <video controls
                                           class="mt-3 rounded-xl max-w-xs shadow">
                                        <source src="uploads/${msg.media_path}">
                                    </video>
                                </c:if>

                            </c:if>
                            
                            <c:if test="${msg.media_type == 'FILE'}">

                                <a href="uploads/${msg.media_path}"
                                   target="_blank"
                                   class="mt-3 flex items-center gap-3 bg-slate-100 hover:bg-slate-200 transition rounded-xl px-4 py-3">

                                    <i class="fas fa-file-alt text-slate-600 text-xl"></i>

                                    <span class="text-sm font-medium text-slate-700">
                                        ${msg.media_path}
                                    </span>

                                </a>

                            </c:if>
                                
                            <p class="text-sm leading-relaxed">${msg.messageText}</p>
                                
                            <span class="block text-[9px] text-emerald-100 text-right mt-1.5 font-medium uppercase">
                                <fmt:formatDate value="${msg.sentAt}" pattern="hh:mm a" />
                            </span>
                            
                            <c:if test="${msg.readCount > 0}">
                                <span class="block text-[9px] text-emerald-100 text-right mt-1 font-medium">
                                    Seen by <c:out value="${msg.readByNames}" />
                                </span>
                            </c:if>
                            
                            <button type="button"
                                    class="reply-btn block text-[10px] text-emerald-100 text-right mt-1 hover:underline"
                                    data-message-id="${msg.messageId}"
                                    data-sender-name="You"
                                    data-message-text="<c:out value='${msg.messageText}'/>"
                                    data-media-type="<c:out value='${msg.media_type}'/>">
                                Reply
                            </button>
                            
                        </div>
                    </div>
                </c:when>
                
                <%-- ELSE IF SENDER IS SOMEONE ELSE (Align Left) --%>
                <c:otherwise>
                    <div class="flex justify-start w-full">
                        <div class="max-w-[70%] bg-white border border-slate-200 rounded-3xl rounded-tl-sm px-5 py-3.5 shadow-sm">
                            <!-- Sender name header label -->
                            <span class="block text-xs font-extrabold text-emerald-600 mb-1">
                                <c:out value="${msg.senderName}"/> 
                                <c:if test="${msg.senderRole == 'LECTURER'}">
                                    <span class="ml-1 text-[8px] bg-amber-100 text-amber-800 font-bold px-1.5 py-0.5 rounded">Lecturer</span>
                                </c:if>
                            </span>
                            
                            <c:if test="${not empty msg.replyToMessageId}">
                                <div class="mb-2 border-l-4 border-emerald-400 bg-slate-50 rounded-lg px-3 py-2">
                                    <p class="text-xs font-bold text-emerald-700">
                                        Replying to <c:out value="${msg.replyToSenderName}" />
                                    </p>
                                    <p class="text-xs text-slate-500">
                                        <c:choose>
                                            <c:when test="${not empty msg.replyToMessageText}">
                                                <c:out value="${msg.replyToMessageText}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${msg.replyToMediaType}" /> attachment
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty msg.media_path}">

                                <!-- IMAGE -->
                                <c:if test="${msg.media_type == 'IMAGE'}">
                                    <img src="uploads/${msg.media_path}"
                                         class="mt-3 rounded-xl max-w-xs shadow">
                                </c:if>

                                <!-- VIDEO -->
                                <c:if test="${msg.media_type == 'VIDEO'}">
                                    <video controls
                                           class="mt-3 rounded-xl max-w-xs shadow">
                                        <source src="uploads/${msg.media_path}">
                                    </video>
                                </c:if>

                            </c:if>
                                
                            <c:if test="${msg.media_type == 'FILE'}">

                                <a href="uploads/${msg.media_path}"
                                   target="_blank"
                                   class="mt-3 flex items-center gap-3 bg-slate-100 hover:bg-slate-200 transition rounded-xl px-4 py-3">

                                    <i class="fas fa-file-alt text-slate-600 text-xl"></i>

                                    <span class="text-sm font-medium text-slate-700">
                                        ${msg.media_path}
                                    </span>

                                </a>

                            </c:if>
                                
                            <p class="text-sm text-slate-700 leading-relaxed">${msg.messageText}</p>    
                            
                            <span class="block text-[9px] text-slate-400 text-right mt-1.5">
                                <fmt:formatDate value="${msg.sentAt}" pattern="hh:mm a" />
                            </span>
                            
                            <button type="button"
                                    class="reply-btn block text-[10px] text-slate-400 text-right mt-1 hover:underline"
                                    data-message-id="${msg.messageId}"
                                    data-sender-name="<c:out value='${msg.senderName}'/>"
                                    data-message-text="<c:out value='${msg.messageText}'/>"
                                    data-media-type="<c:out value='${msg.media_type}'/>">
                                Reply
                            </button>
                            
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </c:forEach>
        
        <c:if test="${empty messageList}">
            <div class="m-auto text-center py-10 text-slate-400 flex flex-col items-center">
                <i class="far fa-comments text-5xl mb-3 opacity-20"></i>
                <p class="font-medium text-sm">Welcome to <c:out value="${group.title}"/>!</p>
                <p class="text-xs">No messages yet. Say hello to start the discussion.</p>
            </div>
        </c:if>
    </div>

    <!-- Input Box Control bar at bottom -->
    <footer class="bg-white border-t border-slate-200 p-4 shrink-0">
        <form action="discussions" method="post" enctype="multipart/form-data" class="max-w-6xl mx-auto" id="msgForm">
            <input type="hidden" name="action" value="sendMessage">
            <input type="hidden" name="groupId" value="${group.groupId}">
            <input type="hidden" name="replyToMessageId" id="replyToMessageId">
            
            <div id="replyPreviewContainer"
                class="hidden mb-3 bg-emerald-50 border-l-4 border-emerald-500 rounded-xl px-4 py-3">
               <div class="flex items-start justify-between gap-3">
                   <div>
                       <p class="text-xs font-bold text-emerald-700">
                           Replying to <span id="replySenderName"></span>
                       </p>
                       <p id="replyMessageText" class="text-sm text-slate-600"></p>
                   </div>

                   <button type="button"
                           id="cancelReply"
                           class="text-slate-400 hover:text-slate-700">
                       <i class="fas fa-times"></i>
                   </button>
               </div>
           </div>

           <div class="flex gap-4">
                <input type="text" name="messageText" id="messageText" autocomplete="off"
                   placeholder="Type your message here..." 
                   class="flex-1 px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl outline-none focus:bg-white focus:border-emerald-500 transition text-sm">
            
                <div class="flex items-center">

                    <!-- Hidden file input -->
                    <input type="file"
                           name="mediaFile"
                           id="mediaFile"
                           accept="image/*,video/*,.pdf,.doc,.docx,.ppt,.pptx,.zip"
                           class="hidden">

                    <!-- Upload button -->
                    <label for="mediaFile"
                           class="cursor-pointer bg-slate-100 hover:bg-slate-200 w-14 h-14 rounded-2xl flex items-center justify-center transition">
                        <i class="fas fa-paperclip text-slate-600 text-lg"></i>
                    </label>
                </div>

                <!-- Media Preview -->
                <div id="mediaPreviewContainer"
                     class="hidden max-w-6xl mx-auto mb-3">

                    <div class="bg-slate-100 rounded-2xl p-3 inline-block relative">

                        <!-- Remove Preview Button -->
                        <button type="button"
                                id="removePreview"
                                class="absolute -top-2 -right-2 bg-red-500 text-white w-6 h-6 rounded-full text-xs">
                            ✕
                        </button>

                        <!-- Image Preview -->
                        <img id="imagePreview"
                             class="hidden max-h-48 rounded-xl">

                        <!-- Video Preview -->
                        <video id="videoPreview"
                               controls
                               class="hidden max-h-48 rounded-xl"></video>

                    </div>
                </div>

                <button type="submit" 
                        class="bg-emerald-600 hover:bg-emerald-700 text-white w-14 h-14 rounded-2xl shadow-lg shadow-emerald-100 transition flex items-center justify-center">
                    <i class="fas fa-paper-plane text-lg"></i>
                </button>
           </div>
            
        </form>
    </footer>

    <!-- Automatically scroll feed to bottom -->
    <script>
        window.onload = function() {
            const feed = document.getElementById("chatFeed");
            feed.scrollTop = feed.scrollHeight;
            document.getElementById("messageText").focus();
        };

        const replyToMessageId = document.getElementById("replyToMessageId");
        const replyPreviewContainer = document.getElementById("replyPreviewContainer");
        const replySenderName = document.getElementById("replySenderName");
        const replyMessageText = document.getElementById("replyMessageText");
        const cancelReply = document.getElementById("cancelReply");
        const messageTextInput = document.getElementById("messageText");

        document.querySelectorAll(".reply-btn").forEach(function(button) {
            button.addEventListener("click", function() {
                const messageId = this.dataset.messageId;
                const senderName = this.dataset.senderName;
                const messageText = this.dataset.messageText;
                const mediaType = this.dataset.mediaType;

                replyToMessageId.value = messageId;
                replySenderName.textContent = senderName;

                if (messageText && messageText.trim() !== "") {
                    replyMessageText.textContent = messageText;
                } else if (mediaType && mediaType.trim() !== "") {
                    replyMessageText.textContent = mediaType + " attachment";
                } else {
                    replyMessageText.textContent = "Message";
                }

                replyPreviewContainer.classList.remove("hidden");
                messageTextInput.focus();
            });
        });

        cancelReply.addEventListener("click", function() {
            replyToMessageId.value = "";
            replySenderName.textContent = "";
            replyMessageText.textContent = "";
            replyPreviewContainer.classList.add("hidden");
        });
    </script>

</body>
</html>