<%-- 
    Document   : index
    Created on : Apr 21, 2026, 5:15:33 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iForum IM - Academic Collaboration Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Inter', sans-serif;
            scroll-behavior: smooth;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .hero-gradient {
            background: radial-gradient(circle at 50% 50%, rgba(16, 185, 129, 0.05) 0%, rgba(255, 255, 255, 0) 50%);
        }
    </style>
</head>
<body class="bg-slate-50 text-slate-900">

    <!-- Navigation -->
    <nav class="fixed w-full z-50 glass-effect py-4 shadow-sm">
        <div class="max-w-7xl mx-auto px-6 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <div class="bg-emerald-600 p-2 rounded-lg">
                    <i class="fas fa-graduation-cap text-white text-xl"></i>
                </div>
                <span class="text-2xl font-bold tracking-tight text-slate-800">iForum<span class="text-emerald-600">IM</span></span>
            </div>
            <div class="flex space-x-4">
                <a href="login.jsp" class="text-slate-700 font-semibold px-4 py-2 hover:bg-slate-100 rounded-lg transition inline-block">Log In</a>
                <a href="register.jsp" class="bg-emerald-600 text-white font-semibold px-6 py-2 rounded-lg hover:bg-emerald-700 shadow-lg shadow-emerald-200 transition inline-block">Join Now</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section (Centered & No Image) -->
    <section class="relative min-h-screen flex items-center pt-20 overflow-hidden hero-gradient">
        <!-- Background Orbs -->
        <div class="absolute top-1/4 left-1/4 w-96 h-96 bg-emerald-100 rounded-full blur-[120px] opacity-40 -z-10"></div>
        <div class="absolute bottom-1/4 right-1/4 w-96 h-96 bg-blue-100 rounded-full blur-[120px] opacity-40 -z-10"></div>

        <div class="max-w-4xl mx-auto px-6 text-center">
            <div class="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-emerald-50 border border-emerald-100 mb-8">
           
            </div>

            <h1 class="text-5xl lg:text-7xl font-extrabold text-slate-900 leading-[1.1] mb-8">
                Collaborate, Learn, <br>
                <span class="text-emerald-600">Share Ideas</span>
            </h1>
            
            <p class="text-xl text-slate-600 mb-12 max-w-2xl mx-auto leading-relaxed">
                The central hub for iForum students, lecturers, and coordinators.
Access resources, engage in discussions, and stay updated.
            </p>

            
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-white border-t border-slate-100 py-12">
        <div class="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center">
            <div class="flex items-center space-x-2 mb-4 md:mb-0">
                <div class="bg-slate-200 p-1.5 rounded-lg">
                    <i class="fas fa-graduation-cap text-slate-600"></i>
                </div>
                <span class="text-lg font-bold text-slate-800 tracking-tight">iForum<span class="text-emerald-600">IM</span></span>
            </div>
            <p class="text-slate-400 text-sm font-medium">© 2025 iForum IM Portal. All rights reserved.</p>
            <div class="flex space-x-6 mt-4 md:mt-0">
                <a href="#" class="text-slate-400 hover:text-emerald-600 transition"><i class="fab fa-twitter"></i></a>
                <a href="#" class="text-slate-400 hover:text-emerald-600 transition"><i class="fab fa-linkedin"></i></a>
                <a href="#" class="text-slate-400 hover:text-emerald-600 transition"><i class="fab fa-github"></i></a>
            </div>
        </div>
    </footer>

</body>
</html>
