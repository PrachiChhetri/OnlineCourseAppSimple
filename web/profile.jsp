<%@ page import="java.sql.*" %>
<%! public Connection getDBConnection() throws Exception { Class.forName("com.mysql.cj.jdbc.Driver"); return
    DriverManager.getConnection( "jdbc:mysql://localhost:3306/online_course_db" , "root" , "root123" ); } %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<% 
if (session.getAttribute("student_id")==null) { 
    response.sendRedirect("login.jsp");
    return;
 } 
    int sid=(int) session.getAttribute("student_id"); 
    Connection con=getDBConnection(); 
    PreparedStatement ps=con.prepareStatement(
        "SELECT * FROM students WHERE student_id=?"); 
    ps.setInt(1, sid); 
    ResultSet rs=ps.executeQuery(); 
    if (rs.next()) { 
%>
<div class="profile-container">
    <h2>My Profile</h2>
    
    <% String successMsg=(String) session.getAttribute("updateSuccess"); 
    String errorMsg=(String) session.getAttribute("updateError");

    if (successMsg != null) {
    %>
        <div class="alert success"><%= successMsg %></div>
    <%
        session.removeAttribute("updateSuccess");
    }

    if (errorMsg != null) {
    %>
        <div class="alert error"><%= errorMsg %></div>
    <%
        session.removeAttribute("updateError");
    }
    %>
    <div class="profile-info">
        <p><span class="profile-label">Name:</span>
            <%= rs.getString("name") %>
        </p>
        <p><span class="profile-label">Email:</span>
            <%= rs.getString("email") %>
        </p>
    </div>
    <div class="profile-actions">
        <a href="editProfile.jsp">Edit Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>
    <% } 
con.close(); 
%>

<%@ include file="footer.jsp" %>