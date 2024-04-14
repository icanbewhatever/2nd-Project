<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/find_result.css">
<script defer src="./js/find_pw.js"></script>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");

	String find_pw_id = request.getParameter("find_pw_id");
	String find_pw_name = request.getParameter("find_pw_name");
	String find_pw_email = request.getParameter("find_pw_email");

	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "SEMI_PROJECT2";
	String PASSWORD = "123452";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
		
			String sql = "SELECT PW FROM MANAGER WHERE ID=? AND NAME=? AND EMAIL=?";
			
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, find_pw_id);
	        pstmt.setString(2, find_pw_name);
	        pstmt.setString(3, find_pw_email);
	        
	        rs = pstmt.executeQuery();
				
	        
	        if (rs.next()) {
	            // ȸ�� ������ ��ġ�ϴ� ���, ��й�ȣ ���� ���� ����
	            
	        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < 8; i++) {
                int index = random.nextInt(characters.length());
                sb.append(characters.charAt(index));
            }
            String newPassword = sb.toString();
             
            
	            // ��й�ȣ ���� SQL �ۼ� �� ����
	            String updateSql = "UPDATE MANAGER SET pw=? WHERE id=?";
	            pstmt = conn.prepareStatement(updateSql);
	            pstmt.setString(1, newPassword);
	            pstmt.setString(2, find_pw_id);
	            int updateResult = pstmt.executeUpdate();

	            if (updateResult > 0) {
	                // ��й�ȣ ������ �����ߴٸ� ���� �޽��� ���
	            %>    
	             <div class="pw_find">   
	                <p>ȸ������ Ȯ�� �Ϸ��߽��ϴ�.</p>
	                <p>�ӽ� �н�����: <%= newPassword %>
	                <br>
	                <button onclick="location.href='login.jsp'" class="pw_find_but">�α���</button>
	             </div>   
	        <%    
	            } else {
	                // ��й�ȣ ������ ������ ���
	                out.println("<p>��й�ȣ ���濡 �����߽��ϴ�.</p>");
	            } 			
	        } else {
	            // ȸ�� ������ ��ġ���� �ʴ� ���
	            out.println("<p>�Է��� ������ ��ġ�ϴ� ȸ���� �����ϴ�.</p>");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        // ���� ó�� �ڵ� �߰�
	    } finally {
	        // �ڿ� ����
	        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
	    }
	
%>
</body>
</html>