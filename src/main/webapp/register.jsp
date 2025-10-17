<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Quiz App</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: url("images/bg.jpg") no-repeat center center fixed; /* 🖼️ your background image */
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px 50px;
            width: 400px;
            color: #fff;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            text-align: center;
        }

        .register-container img {
            width: 90px;
            margin-bottom: 15px;
        }

        .register-container h2 {
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 26px;
        }

        .register-container input, select {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            outline: none;
            background: rgba(255, 255, 255, 0.85);
            font-size: 14px;
            color: #333;
        }

        .register-container button {
            width: 100%;
            padding: 12px;
            background: #007bff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .register-container button:hover {
            background: #0056b3;
        }

        .register-container p {
            margin-top: 15px;
            font-size: 14px;
        }

        .register-container a {
            color: #fff;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <!-- 🖼️ Add your logo image here -->
        <img src="images/loginlogo.jpg" alt="Quiz Logo">

        <h2>Create Your Account</h2>

        <form action="register" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>

            <select name="role" required>
    <option value="" disabled selected>Select Role</option>
    <option value="student">Student</option>
    <option value="teacher">Teacher</option>
    <option value="admin">Admin</option>
</select>
            

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jpg">Login here</a></p>
    </div>

</body>
</html>