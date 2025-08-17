<%@ include file="header.jsp" %>

    <h2 style="text-align: center;">Edit Profile</h2>
    <form action="updateProfile.jsp" method="post" class="auth-form">

        <label>Name:</label>
        <input type="text" name="name" required><br><br>

        <label>Email:</label>
        <input type="email" name="email" required><br><br>

        <button type="submit" class="btn">Save Changes</button>
    </form>

    <%@ include file="footer.jsp" %>