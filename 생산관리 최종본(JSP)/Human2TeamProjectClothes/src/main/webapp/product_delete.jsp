<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.lang.Exception" %>    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ����</title>
</head>
<body>
<%
	// �ѱ� ó��
	request.setCharacterEncoding("UTF-8");
	
	String num = request.getParameter("item_num");
	
    String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
    String USER = "semi_project2";
  	String PASSWORD = "123452";
	
  	Connection conn = null; //��� ���� ������ ���� ���� ����
	PreparedStatement pstmt = null; // ���� ���๮
	
	Exception exception = null;

  try {
		// 0.
	  	Class.forName("oracle.jdbc.driver.OracleDriver");
	
		// 1. JDBC�� Oracle����
	  	conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
	  
		// 2. PRODUCTS ���̺� ȭ�� �����κ��� ������ ������ �Է�
		String deleteQuery = "DELETE FROM PRODUCTS WHERE item_num = " + num;
		pstmt = conn.prepareStatement(deleteQuery);

		pstmt.executeUpdate();
  } catch(Exception e) {
	  exception = e;
	  e.printStackTrace();
  } finally {
	  if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>

<%
	if (exception == null) {	//	������ ������ ���
		// 1. ���� �˾� ����
		// 2. ��ǰ ����Ʈ�� �̵�
%>		
<!-- ���� ���̽� html/css/js -->
<script>
	alert('��ǰ�� ���������� �����Ǿ����ϴ�.');	// 1
	location.href = '<%= request.getContextPath() %>/product_list.jsp';
</script>
<%
	} else {									// ������ ������ ���
		// 1. ���б�
		// 2. �������� ǥ��
%>
<!-- ���� ���̽� html/css/js -->
������ �����Ͽ����ϴ�. �ý��� �����ڿ��� �����ϼ���.<br>
��������: <%= exception.getMessage() %>
<%	
	}
%>
</body>
</html>