<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Market Bucks</title>
</head>
<body>
<h3>Please login below</h3>
<s:form action="login">
    <s:textfield name="username" label="User Name"></s:textfield>
    <s:textfield name="password" label="Password" type="password"></s:textfield>
    <s:submit value="Login"></s:submit>
</s:form>
</body>
</html>
