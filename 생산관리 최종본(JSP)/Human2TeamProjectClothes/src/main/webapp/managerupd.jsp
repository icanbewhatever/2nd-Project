<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/manager.css">
</head>
<body>
<%
				String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
				String USER = "SEMI_PROJECT2";
				String PASSWORD = "123452";
  
			    Connection conn = null; //��� ���� ������ ���� ���� ����
				Statement stmt = null; //������ �����ϱ� ��ü ����
				ResultSet rs = null;
	
				Exception exception = null;
				
				String id = "";
				String name = "";
				String phone = "";
				String email = "";
				String join_date = "";
				
  try {
	  // 0.
				  Class.forName("oracle.jdbc.driver.OracleDriver");
				  
				  // 1. JDBC�� Oracle����
				  		conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
				  // System.out.println("����Ŭ ���� ����");
				  
					// 2. BO_FREE ���̺��� SQL�� ������ ��������
						 	stmt = conn.createStatement();	// 2-1. Statement ����
						 	rs = stmt.executeQuery("SELECT * FROM MANAGER WHERE ID = '?'"); // 2-2. SQL ���� ����
				 	
							 	if (rs.next()) {
							 					id = rs.getString("ID");
							 					name = rs.getString("NAME");
							 					phone = rs.getString("PHONE");
							 					email = rs.getString("EMAIL");
							 					join_date = rs.getString("JOIN_DATE");
								   }
  } catch(Exception e) {
	  						System.out.println("����Ŭ ���� ����: " + e);
	  
  } finally {
								  if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
								  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>

<div class="manager_box">
	���̵�: <input type="text" value="<%= id %>">
	�̸�: <input type="text" value="<%= name %>">
	�޴�����ȣ: <input type="text" value="<%= phone %>">
	�̸���: <input type="text" value="<%= email %>">
	������: <input type="text" value="<%= join_date %>">
</div>
</body>
</html>