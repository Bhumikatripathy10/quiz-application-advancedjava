<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f8f8; text-align: center; padding: 50px; }
        .container { background-color: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); display: inline-block; }
        h2 { color: #d9534f; }
        a { display: inline-block; margin-top: 20px; text-decoration: none; color: #337ab7; }
    </style>
</head>
<body>
    <div class="container">
        <h2>${message}</h2>
        <a href="roleLanding.jsp">Go Back</a>
    </div>
</body>
</html>
