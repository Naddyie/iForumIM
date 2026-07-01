<%-- 
    Document   : login
    Created on : Jun 18, 2025, 9:56:39 PM
    Author     : Nadiah Binti Abdul Latif
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - iForumIM</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                background: radial-gradient(circle at top left, #f0fdf4, #ffffff, #f0fdf4);
                font-family: 'Inter', sans-serif;
            }
            .login-card {
                backdrop-filter: blur(10px);
                background-color: rgba(255, 255, 255, 0.9);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
                            0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            .input-group:focus-within label,
            .input-group:focus-within i {
                color: #059669;
            }
        </style>
    </head>

    <body class="min-h-screen flex items-center justify-center p-4">

    <div class="w-full max-w-md">

        <!-- Logo + Header -->
        <div class="text-center mb-8">
            <div class="flex items-center justify-center space-x-2 mb-4">

                <!-- ✅ YOUR ORIGINAL LOGO -->
                <div class="bg-emerald-600 p-2 rounded-xl shadow-lg">
                    <i class="fas fa-graduation-cap text-white text-xl"></i>
                </div>

                <span class="text-2xl font-bold text-slate-800">
                    iForum<span class="text-emerald-600">IM</span>
                </span>
            </div>

            <h2 class="text-2xl font-bold text-gray-700">Welcome Back</h2>
            <p class="text-gray-500 mt-2">Access your academic collaboration portal</p>
        </div>

        <!-- Login Card -->
        <div class="login-card rounded-3xl p-8 border border-gray-100">

            <form action="loginServlet" method="POST" class="space-y-5">

                <!-- Email -->
                <div class="input-group">
                    <label class="block text-sm font-medium text-gray-600 mb-2">Email Address</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                            <i class="fa-solid fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" name="email" required
                            class="w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
                            placeholder="user@university.com">
                    </div>
                </div>

                <!-- Password -->
                <div class="input-group">
                    <div class="flex justify-between mb-2">
                        <label class="block text-sm font-medium text-gray-600">Password</label>
                    </div>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                            <i class="fa-solid fa-lock text-gray-400"></i>
                        </div>
                        <input type="password" name="password" required
                            class="w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
                            placeholder="••••••••">
                    </div>
                </div>

                <!-- Button -->
                <button type="submit"
                    class="w-full py-3.5 rounded-xl font-bold text-white bg-emerald-600 hover:bg-emerald-700 transition-all">
                    Sign In
                </button>
            </form>

            <!-- Register -->
            <div class="mt-8 text-center border-t pt-6">
                <p class="text-sm text-gray-600">
                    Don’t have an account?
                    <a href="register.jsp" class="font-bold text-emerald-600 hover:underline">
                        Create Account
                    </a>
                </p>
            </div>
        </div>

        <!-- Footer -->
        <div class="mt-8 text-center">
            <a href="index.jsp"
               class="inline-flex items-center text-sm text-gray-500 hover:text-emerald-600">
                <i class="fa-solid fa-arrow-left mr-2"></i>
                Back to Homepage
            </a>
        </div>

    </div>

    </body>
</html>