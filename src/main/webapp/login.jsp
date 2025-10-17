<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Quiz App</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: url("images/bg.jpg") no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px 50px;
            width: 380px;
            color: #fff;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            text-align: center;
        }

        .login-container img {
            width: 90px;
            margin-bottom: 15px;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 26px;
        }

        .login-container input {
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

        .login-container button {
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

        .login-container button:hover {
            background: #0056b3;
        }

        .login-container p {
            margin-top: 15px;
            font-size: 14px;
        }

        .login-container a {
            text-decoration: underline;
        }

        .login-container .forgot {
            text-align: right;
            margin-top: -5px;
            margin-bottom: 15px;
        }

        /* Updated Forgot Password Style */
        .login-container .forgot a {
            font-size: 14px;
            color: #001f4d; /* Dark Blue */
            font-weight: bold;
            text-decoration: none;
        }

        .login-container .forgot a:hover {
            text-decoration: underline;
            color: #0044cc;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <img src="images/loginlogo.jpg" alt="Quiz Logo">
        <h2>Welcome Back!</h2>

        <form action="login" method="post">
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>

            <div class="forgot">
                <a href="forgotPassword.jsp">Forgot Password?</a>
            </div>

            <button type="submit">Login</button>
        </form>

         <a href="register.jsp">Don’t have an account?</a>
    </div>

</body>
</html>