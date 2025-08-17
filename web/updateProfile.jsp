<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>
<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%! public Connection getDBConnection() throws Exception { 
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    return DriverManager.getConnection( "jdbc:mysql://localhost:3306/online_course_db" , "root" , "root123" ); } %>

<% if (session.getAttribute("student_id")==null) { 
    response.sendRedirect("login.jsp"); 
    return; }

request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String email = request.getParameter("email");

int sid = (int) session.getAttribute("student_id"); 

try {
    Connection con = getDBConnection();
    PreparedStatement ps;
ps = con.prepareStatement(
"UPDATE students SET name=?, email=? WHERE student_id=?"
);
ps.setString(1, name);
ps.setString(2, email);
ps.setInt(3, sid);

    int rows = ps.executeUpdate();
    con.close();
    if (rows > 0) {
        session.setAttribute("updateSuccess", "Profile updated successfully!");
    } else {
        session.setAttribute("updateError", "Failed to update profile.");
    } 
}catch (Exception e) {
    session.setAttribute("updateError", "Error: " + e.getMessage());
}

response.sendRedirect("profile.jsp");
%>

