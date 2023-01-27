<?xml version="1.0" encoding="UTF-8" ?>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<s:head />
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<link rel="SHORTCUT ICON" href="<s:property value='#application.url'/>/images/favicon.ico" />
	<link rel="stylesheet" href="<s:property value='#application.url'/>css/jquery-ui.min-1.13.2.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value='#application.url'/>css/jquery-ui.theme.min-1.13.2.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value='#application.url'/>css/open-sans/open-sans.css" type="text/css" />
	<link rel="stylesheet" href="//bloomington.in.gov/static/fn1-releases/dev/css/default.css" type="text/css" />
	<link rel="stylesheet" href="//bloomington.in.gov/static/fn1-releases/dev/css/kirkwood.css" type="text/css" />
	<title>Market Bucks</title>
	<script type="text/javascript">
	 var APPLICATION_URL = '<s:property value='#application.url' />';
	</script>	
    </head>
    <body class="fn1-body">
	<header class="fn1-siteHeader">
	    <div class="fn1-siteHeader-container">
		<div class="fn1-site-title">		
		    <h1 id="application_name"><a href="<s:property value='#application.url'/>">Market Bucks</a></h1>
		    <div class="fn1-site-location" id="location_name"><a href="<s:property value='#application.url'/>">City of Bloomington, IN</a></div>
		</div>
		<s:if test="#session != null && #session.user != null">
		<div class="fn1-site-utilityBar">				
		    <nav id="user_menu">
			<div class="menuLauncher"><s:property value='#session.user.fullName' /></div>
			<div class="menuLinks closed">
			    <a href="<s:property value='#application.url'/>logout.action">Logout</a>
			</div>
		    </nav>
		    <nav id="admin_menu">
			<div class="menuLauncher">Admin</div>
			<div class="menuLinks closed">
			    <s:if test="#session.user.isAdmin()">
				<a href="<s:property value='#application.url'/>buckConf.action">Configuration</a>
				<a href="<s:property value='#application.url'/>batchStart.action">Generate & Print</a>
				<a href="<s:property value='#application.url'/>cancelledSearch.action">Voided MB/GC</a>
				<a href="<s:property value='#application.url'/>mailNotification.action">Inventory Mail Notifications</a>				
				<a href="<s:property value='#application.url'/>exportStart.action">Exports</a>
				<a href="<s:property value='#application.url'/>vendor.action">Vendors</a>
				<a href="<s:property value='#application.url'/>report.action">Reports</a>
				<a href="<s:property value='#application.url'/>user.action">Users</a>				
			    </s:if>
			</div>
		    </nav>
		</div>
		</s:if>
	    </div>
	    <div class="fn1-nav1">
		<nav class="fn1-nav1-container">		
		    <a href="<s:property value='#application.url'/>snapStart.action">Online Purchase</a>
		    <a href="<s:property value='#application.url'/>ebtAdd.action">Ebt MB</a>
		    <a href="<s:property value='#application.url'/>wicAdd.action">FMNP WIC</a>
		    <a href="<s:property value='#application.url'/>seniorAdd.action">FMNP Senior</a>
		    <a href="<s:property value='#application.url'/>redeemStart.action">Redemptions</a>				
		    <a href="<s:property value='#application.url'/>otherMenu.action">More Options</a>	      	      
		</nav>
	    </div>
	</header>
	<main>
	    <div class="fn1-main-container">
		
