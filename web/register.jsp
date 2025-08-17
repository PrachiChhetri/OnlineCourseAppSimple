<%@ page import="java.sql.*" %>
<%! 
public Connection getDBConnection() throws Exception { 
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    return DriverManager.getConnection( "jdbc:mysql://localhost:3306/online_course_db" , "root" , "root123" ); } %>
<%@ include file="header.jsp" %>

<h2 style="text-align:center;">Register</h2>
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>

<form method="post" class="auth-form" onsubmit="return validateRegisterForm()">
    <label>Name:</label>
    <input type="text" id="name" name="name" required>

    <label>Email:</label>
    <input type="email" id="email" name="email" required>

    <label>Password:</label>
    <input type="password" id="password" name="password" required>

    <label>Confirm Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword"><br><br>

    <input type="submit" value="Register">
</form>


<% 
if ("post".equalsIgnoreCase(request.getMethod())) { 
    String name=request.getParameter("name"); 
    String email=request.getParameter("email"); 
    String pass=request.getParameter("password"); 
    try (Connection con = getDBConnection())  { 
        PreparedStatement ps = con.prepareStatement( 
            "INSERT INTO students(name, email, password) VALUES (?, ?, ?)" );
        ps.setString(1, name); 
        ps.setString(2, email); 
        ps.setString(3, pass); 
        ps.executeUpdate();
        out.println("Registered successfully. <a href='login.jsp'>Login here</a>");
        } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
%>

<%@ include file="footer.jsp" %>