<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
    // 1: ������ ���� �����͸� ��� ����
    session.invalidate();
    // 2: �α��� �������� �̵���Ŵ.
    response.sendRedirect("index.jsp");
%>    
