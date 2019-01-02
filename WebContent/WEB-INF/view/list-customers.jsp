<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>List Customers</title>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css ">
</head>

<body>

	<div id="wrapper">
		<div id="header">
			<h2>CRM - Customer Relationship Manager</h2>
		</div>
	</div>
	
	<div id="container">
		<div id="content">
		
		<!-- put new button: Add Customer -->
		
		<input type="button" value="addCustomer" onclick="window.location.href='showFormForAdd'; return false;"
		class="add-button" >
		
		<!--  add a search box -->
        <form:form action="search" method="POST">
        	Search customer: <input type="text" name="searchName" />
                
            <input type="submit" value="Search" class="add-button" />
        </form:form>
		
		<!-- add out html table -->
		<table>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Action</th>
			</tr>
			
			<!-- loop over and print customers -->
			
			<c:forEach var="customer" items="${customers}">
				
				<!-- construct an update link with customer id -->
				<c:url var="updateLink" value="/customer/showFormForUpdate">
					<c:param name="customerId" value="${customer.id}"/>
				</c:url>
				
				<!-- construct a delete link with customer id -->
				<c:url var="deleteLink" value="/customer/delete">
					<c:param name="customerId" value="${customer.id}"/>
				</c:url>
				
				<tr>
					<td> ${customer.firstName} </td>
					<td> ${customer.lastName} </td>
					<td> ${customer.email} </td>
					
					<td>
						<a href="${updateLink}">Update</a>
						|
						<a href="${deleteLink}" 
						onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false;">Delete</a>
					</td>
				</tr>
				
			</c:forEach>
			
		</table>
		
		</div>
	</div>

</body>

</html>