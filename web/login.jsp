<%@ page import="java.sql.*" %>
<%! public Connection getDBConnection() throws Exception { Class.forName("com.mysql.cj.jdbc.Driver"); return
    DriverManager.getConnection( "jdbc:mysql://localhost:3306/online_course_db" , "root" , "root123" ); } %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<h2 style="text-align:center;">Login</h2>
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>
<form method="post" class="auth-form" onsubmit="return validateLoginForm()">
    <label>Email:</label>
    <input type="email" id="loginEmail" name="email" required>
    
    <label>Password:</label>
    <input type="password" id="loginPassword" name="password" required>
    
    <input type="submit" value="Login">
</form>

<% 
if ("post".equalsIgnoreCase(request.getMethod())) { 
    String email=request.getParameter("email");
    String pass=request.getParameter("password"); 
    try (Connection con=getDBConnection()) {
        PreparedStatement ps=con.prepareStatement( 
            "SELECT * FROM students WHERE email=? AND password=?" );
        ps.setString(1, email); 
        ps.setString(2, pass); 
        ResultSet rs=ps.executeQuery(); 
        if (rs.next()) {
            session.setAttribute("student_id", rs.getInt("student_id")); 
            session.setAttribute("name", rs.getString("name")); 
            response.sendRedirect("viewCourses.jsp"); 
        } else { out.println("Invalidcredentials."); 
    } } 
    catch (Exception e) 
    { 
        out.println("Error: " + e.getMessage());
    }
}
%>

<%@ include file="footer.jsp" %>