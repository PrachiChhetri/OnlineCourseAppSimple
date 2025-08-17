<%@ page import="java.sql.*" %>
    <%! public Connection getDBConnection() throws Exception { 
        Class.forName("com.mysql.cj.jdbc.Driver"); return
        DriverManager.getConnection("jdbc:mysql://localhost:3306/online_course_db", "root" , "root123" ); 
    } %>
    <%@ page session="true" %>

    <%
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int courseId=Integer.parseInt(request.getParameter("course_id")); 
    int studentId=(int) session.getAttribute("student_id");

    Connection con = null;
    PreparedStatement ps = null;
    boolean success = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_course_db", "root", "root123");

        ps = con.prepareStatement("DELETE FROM enrollments WHERE course_id = ? AND student_id = ?");
        ps.setInt(1, courseId);
        ps.setInt(2, studentId);

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
        success = true;
    }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<html>

<html>

<head>
    <title>Unenroll</title>
    <meta http-equiv="refresh" content="2;url=myCourses.jsp" />
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>
    <div class="<%= success ? "success-message" : "error-message" %>">
        <%= success ? "Successfully unenrolled!" : "Failed to unenroll. Please try again." %>
    </div>

</body>

</html>