<%-- 
    Document   : register
    Created on : Apr 21, 2026, 5:14:06 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - iForum IM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; }
        .role-card.active {
            border-color: #10b981;
            background-color: #f0fdf4;
            transform: scale(1.02);
        }
        .step-hidden { display: none; }
        .glass-panel {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
        }
        .loader {
            border: 2px solid #f3f3f3;
            border-top: 2px solid #10b981;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 8px;
            vertical-align: middle;
        }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    </style>
</head>
<body class="bg-slate-50 min-h-screen py-12 px-6 flex flex-col items-center justify-center">
    
    <!-- Background Decoration -->
    <div class="absolute top-0 left-0 w-full h-full -z-10 overflow-hidden">
        <div class="absolute top-[-10%] right-[-10%] w-[40%] h-[40%] bg-emerald-100 rounded-full blur-[120px] opacity-60"></div>
        <div class="absolute bottom-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-100 rounded-full blur-[120px] opacity-60"></div>
    </div>

    <div class="max-w-2xl w-full mx-auto">
        <!-- Brand -->
        <div class="flex flex-col items-center mb-10">
            <a href="index.jsp" class="inline-flex items-center space-x-2">
                <div class="bg-emerald-600 p-2 rounded-xl shadow-lg">
                    <i class="fas fa-graduation-cap text-white text-xl"></i>
                </div>
                <span class="text-2xl font-bold text-slate-800">iForum<span class="text-emerald-600">IM</span></span>
            </a>
        </div>

        <div class="glass-panel rounded-[2.5rem] shadow-2xl overflow-hidden border border-white/50 p-8 md:p-12">
            <!-- Form Header -->
            <div class="mb-10 text-center">
                <div class="flex items-center justify-center space-x-2 mb-3">
                    <span id="step-badge" class="px-3 py-1 bg-emerald-100 text-emerald-700 rounded-full text-[10px] font-bold uppercase tracking-widest">Step 1 of 2</span>
                </div>
                <h3 id="form-title" class="text-3xl font-extrabold text-slate-900">Select your account type</h3>
                <p id="form-subtitle" class="text-slate-500 text-sm mt-2">Choose the role that best describes your position.</p>
            </div>

            <form id="regForm" action="registerServlet" method="POST">
                <!-- Step 1: Role Selection -->
                <div id="step1" class="space-y-4">
                    <input type="hidden" name="role" id="roleInput">
                    <div class="grid grid-cols-1 gap-4">
                        <div onclick="setRole('student', event)" class="role-card group p-6 border-2 border-slate-100 rounded-2xl cursor-pointer hover:border-emerald-200 transition-all flex items-center space-x-5">
                            <div class="w-14 h-14 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-2xl group-hover:scale-110 transition">
                                <i class="fas fa-user-graduate"></i>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-bold text-slate-800 text-lg">Student</h4>
                                <p class="text-xs text-slate-500">View courses and join discussions.</p>
                            </div>
                            <div class="radio-icon opacity-0 transition"><i class="fas fa-check-circle text-emerald-500 text-2xl"></i></div>
                        </div>

                        <div onclick="setRole('lecturer', event)" class="role-card group p-6 border-2 border-slate-100 rounded-2xl cursor-pointer hover:border-emerald-200 transition-all flex items-center space-x-5">
                            <div class="w-14 h-14 rounded-2xl bg-amber-50 text-amber-600 flex items-center justify-center text-2xl group-hover:scale-110 transition">
                                <i class="fas fa-chalkboard-teacher"></i>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-bold text-slate-800 text-lg">Lecturer</h4>
                                <p class="text-xs text-slate-500">Publish content and guide students.</p>
                            </div>
                            <div class="radio-icon opacity-0 transition"><i class="fas fa-check-circle text-emerald-500 text-2xl"></i></div>
                        </div>
                    </div>
                    <button type="button" id="nextBtn" disabled onclick="goStep(2)" 
                        class="w-full mt-8 bg-slate-200 text-slate-500 font-bold py-5 rounded-2xl cursor-not-allowed transition-all">
                        Continue to Details
                    </button>
                </div>

                <!-- Step 2: Personal Details -->
                <div id="step2" class="step-hidden space-y-6">
                    <!-- Verification Section (Only for Student) -->
                    <div class="role-specific student-only hidden col-span-2 p-5 bg-emerald-50/50 border border-emerald-100 rounded-3xl mb-4">
                        <label class="block text-xs font-bold text-emerald-700 uppercase tracking-widest mb-2 ml-1">Matric Verification</label>
                        <div class="flex space-x-2">
                            <input type="text" id="matric_check" name="matric_number" placeholder="Enter Matric No (e.g. S12345)" 
                                   class="flex-1 px-5 py-4 bg-white border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition uppercase">
                            <button type="button" onclick="verifyStudent()" id="verifyBtn"
                                    class="bg-slate-800 text-white px-6 py-4 rounded-2xl font-bold hover:bg-slate-700 transition flex items-center">
                                <span id="btnText">Verify</span>
                            </button>
                        </div>
                        <p id="verifyMsg" class="text-[10px] mt-2 font-semibold ml-1 text-slate-400">verification required for students</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="col-span-2">
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Full Name</label>
                            <input type="text" name="fullname" id="fullname" placeholder="Insert your Full Name" readonly
                                   class="w-full px-5 py-4 bg-slate-100 border border-slate-200 rounded-2xl outline-none text-slate-500">
                        </div>
                        
                        <div>
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">University Email</label>
                            <input type="email" name="email" required placeholder="user@university.com" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Phone Number</label>
                            <input type="tel" name="phone" placeholder="012-3456789" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                        </div>

                        <!-- Lecturer specific field -->
                        <div class="role-specific lecturer-only hidden col-span-2">
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Faculty/Department</label>
                            <input type="text" name="faculty" placeholder="ex: Faculty of Computing" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                        </div>

                        <div class="col-span-2">
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Create Password</label>
                            <input type="password" name="password" required placeholder="Enter your password" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl focus:border-emerald-500 outline-none transition">
                        </div>
                        
                        <div class="col-span-2">
                            <label class="block text-xs font-bold text-slate-400 uppercase tracking-widest mb-2 ml-1">Confirm Password</label>
                            <input type="password" id="confirmPassword" required placeholder="Re-enter password" class="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-2xl">
                        </div>
                    </div>

                    <div class="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-4 pt-4">
                        <button type="button" onclick="goStep(1)" class="w-full sm:flex-1 py-5 bg-slate-100 text-slate-600 font-bold rounded-2xl hover:bg-slate-200 transition">Back</button>
                        <button type="submit" id="submitBtn" class="w-full sm:flex-[2] py-5 bg-emerald-600 text-white font-bold rounded-2xl shadow-xl shadow-emerald-200 hover:bg-emerald-700 transition">Create Account</button>
                    </div>
                </div>
            </form>

            <div class="mt-10 pt-8 border-t border-slate-100 text-center">
                <p class="text-sm text-slate-500">Already have an account? <a href="login.jsp" class="text-emerald-600 font-bold hover:underline">Log In</a></p>
            </div>
        </div>
    </div>

    <script>
        let selectedRole = null;
        let isVerified = false;

        function setRole(role, e) {
            selectedRole = role;
            document.getElementById('roleInput').value = role;
            
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('active');
                card.querySelector('.radio-icon').classList.add('opacity-0');
            });
            
            const activeCard = e.currentTarget;
            activeCard.classList.add('active');
            activeCard.querySelector('.radio-icon').classList.remove('opacity-0');

            const btn = document.getElementById('nextBtn');
            btn.disabled = false;
            btn.className = "w-full mt-8 bg-emerald-600 text-white font-bold py-5 rounded-2xl shadow-xl shadow-emerald-200 hover:bg-emerald-700 transition-all hover:scale-[1.01] active:scale-[0.99]";
        }

        async function verifyStudent() {
            const matric = document.getElementById('matric_check').value.toUpperCase().trim();
            //const matric = document.getElementById('matric_check').value;
            const msg = document.getElementById('verifyMsg');
            const btnText = document.getElementById('btnText');
            const nameInput = document.getElementById('fullname');

            if(!matric) {
                msg.innerText = "Please enter your matric number.";
                msg.className = "text-[10px] mt-2 font-semibold ml-1 text-red-500";
                return;
            }

            btnText.innerHTML = '<span class="loader"></span>Checking...';
            
            try {
                // Adjust this URL to match your Servlet mapping
                const matric = document.getElementById('matric_check').value;
                const response = await fetch('/iForumIM/checkMatric?matric_number=' + matric);
                const data = await response.json();

                if(data.status === 'success') {
                    msg.innerText = "Verified: " + (data.course || "Record Found");
                    msg.className = "text-[10px] mt-2 font-semibold ml-1 text-emerald-600";
                    nameInput.value = data.fullname;
                    nameInput.classList.remove('bg-slate-100');
                    nameInput.classList.add('bg-emerald-50', 'text-emerald-900', 'font-bold');
                    isVerified = true;
                    document.getElementById('submitBtn').disabled = false;
                    document.getElementById('submitBtn').classList.remove('opacity-50', 'cursor-not-allowed');
                    document.getElementById('matric_check').readOnly = true;
                    document.getElementById('verifyBtn').classList.add('hidden');
                } else {
                    msg.innerText = data.message || "Matric number not found.";
                    msg.className = "text-[10px] mt-2 font-semibold ml-1 text-red-500";
                    isVerified = false;
                }
            } catch (e) {
                console.error(e);
                msg.innerText = "Connection error: " + e;
                msg.className = "text-[10px] mt-2 font-semibold ml-1 text-red-500";
            } finally {
                btnText.innerText = "Verify";
            }
        }

        function goStep(step) {
            const step1 = document.getElementById('step1');
            const step2 = document.getElementById('step2');
            const badge = document.getElementById('step-badge');
            const title = document.getElementById('form-title');
            const sub = document.getElementById('form-subtitle');
            const nameInput = document.getElementById('fullname');
            const submitBtn = document.getElementById('submitBtn');

            document.querySelectorAll('.role-specific').forEach(el => el.classList.add('hidden'));
            
            if(selectedRole === 'student') {
                document.querySelector('.student-only').classList.remove('hidden');
                nameInput.readOnly = true;
                if(!isVerified) {
                    submitBtn.disabled = true;
                    submitBtn.classList.add('opacity-50', 'cursor-not-allowed');
                }
            } else {
                document.querySelector('.lecturer-only').classList.remove('hidden');
                nameInput.readOnly = false;
                nameInput.classList.remove('bg-emerald-50', 'text-emerald-900');
                submitBtn.disabled = false;
                submitBtn.classList.remove('opacity-50', 'cursor-not-allowed');
            }

            if(step === 2) {
                step1.classList.add('step-hidden');
                step2.classList.remove('step-hidden');
                badge.innerText = "Step 2 of 2";
                title.innerText = "Personal Details";
                sub.innerText = "Please provide your academic information.";
            } else {
                step2.classList.add('step-hidden');
                step1.classList.remove('step-hidden');
                badge.innerText = "Step 1 of 2";
                title.innerText = "Select your account type";
                sub.innerText = "Choose the role that best describes your position.";
            }
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
        
        document.getElementById('regForm').addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]').value;
            const confirm = document.getElementById('confirmPassword').value;

            if (password !== confirm) {
                e.preventDefault();
                alert("Passwords do not match!");
            }
        });
    </script>
</body>
</html>
