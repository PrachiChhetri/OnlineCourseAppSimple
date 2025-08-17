<%@ page import="java.sql.*" %>
<%! public Connection getDBConnection() throws Exception { Class.forName("com.mysql.cj.jdbc.Driver"); return
    DriverManager.getConnection( "jdbc:mysql://localhost:3306/online_course_db" , "root" , "root123" ); } %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<% if (session.getAttribute("student_id")==null) { 
    response.sendRedirect("login.jsp"); 
    return;
}
int sid=(int) session.getAttribute("student_id"); 
Connection con = getDBConnection(); 
PreparedStatement ps = con.prepareStatement(
    "SELECT c.course_id, c.name, c.description " +
    "FROM enrollments e " +
    "JOIN courses c ON e.course_id = c.course_id " +
    "WHERE e.student_id = ?"
);
ps.setInt(1, sid); 
ResultSet rs=ps.executeQuery(); %>

<h2 style="text-align:center;">My Courses</h2>

<div class="course-container">
    <% boolean hasCourses=false; while (rs.next()) { hasCourses=true; %>
        <div class="course-card">
            <h3>
                <%= rs.getString("name") %>
            </h3>
            <p>
                <%= rs.getString("description") %>
            </p>

            <form method="post" action="unenroll.jsp" style="display:inline;">
                <input type="hidden" name="course_id" value="<%= rs.getInt("course_id") %>">
                <input type="submit" value="Unenroll" class="btn unenroll">
            </form>
        </div>
        <% } if (!hasCourses) { %>
            <p style="text-align:center; color:gray;">
                You have not enrolled in any courses yet.
            </p>
            <% 
} 
con.close(); 
%>