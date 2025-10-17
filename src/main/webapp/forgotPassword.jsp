<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Quiz App</title>

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

        .reset-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px 50px;
            width: 380px;
            color: #fff;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            text-align: center;
        }

        .reset-container h2 {
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 26px;
        }

        .reset-container input {
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

        .reset-container button {
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
            margin-top: 15px;
        }

        .reset-container button:hover {
            background: #0056b3;
        }

        .reset-container p {
            margin-top: 15px;
            font-size: 14px;
        }

        .reset-container a {
            color: #fff;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <h2>Reset Password</h2>
        <form action="resetPassword" method="post">
            <input type="email" name="email" placeholder="Enter your registered email" required>
            <input type="password" name="newPassword" placeholder="Enter new password" required>
            <button type="submit">Reset Password</button>
        </form>
        <p>Remembered your password? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>