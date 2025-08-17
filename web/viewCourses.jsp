<%@ page import="java.sql.*" %>
<%! 
    public Connection getDBConnection() throws Exception { 
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/online_course_db", "root", "root123"
        ); 
    } 
%>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<%
if (session.getAttribute("student_id") == null) { 
    response.sendRedirect("login.jsp"); 
    return;
} 

Connection con = getDBConnection(); 

if ("post".equalsIgnoreCase(request.getMethod())) { 
    int sid = (int) session.getAttribute("student_id"); 
    int cid = Integer.parseInt(request.getParameter("course_id"));

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO enrollments(student_id, course_id) VALUES (?, ?)"
    );
    ps.setInt(1, sid); 
    ps.setInt(2, cid); 
    ps.executeUpdate(); 

    out.println("<p style='color:green;'>Enrolled successfully!</p>");
}

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM courses");
%>

<h2>Available Courses</h2>

<% while (rs.next()) { %>
<div class="course-card">
    <b><%= rs.getString("name") %></b><br>
    <p><%= rs.getString("description") %></p>
    <form method="post" class="course-actions">
        <input type="hidden" name="course_id" value="<%= rs.getInt("course_id") %>">
        <input type="submit" value="Enroll" class="enroll-btn">
    </form>
</div>
<% } 
con.close(); %>

<%@ include file="footer.jsp" %>