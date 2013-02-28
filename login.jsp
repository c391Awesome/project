<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<% 

	if(request.getParameter("Submit") != null)
        {

	        //get the user input from the login page
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
        	out.println("<p>Your input User Name is "+userName+"</p>");
        	out.println("<p>Your input password is "+passwd+"</p>");


	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	        try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"kwanyin","*****");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
		//and identify user class
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select password, class from users where user_name = '"+userName+"'";
	        out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = "";
		String cls = "";
		String user_class = "";
	
        	while(rset != null && rset.next()) {
	        	truepwd = (rset.getString(1)).trim();
			cls = (rset.getString(2)).trim();
			if (cls.equals("a"))
				user_class = "administrator";
			if (cls.equals("p"))
				user_class = "patient";
			if (cls.equals("d"))
				user_class = "doctor";
			if (cls.equals("r"))
				user_class = "radiologist";
		}

	
        	//display the result
	        if(passwd.equals(truepwd) && !passwd.equals("")) {
		        out.println("<p><b>Login is Successful!</b></p>");
			out.println("<p><b>You are "+user_class+" "+userName+".</b></p>");
			out.println("<p><a href=\"http://ui06.cs.ualberta.ca:16140/proj1/mainPage.html\">Go to Main page</a></p>");
		}
        	else
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }    
%>



</BODY>
</HTML>

