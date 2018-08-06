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
  <link rel="SHORTCUT ICON" href="https://apps.bloomington.in.gov/favicon.ico" />
  <link rel="stylesheet" href="<s:property value='#application.url' />js/jquery-ui2.css" type="text/css" media="all" />
  <link rel="stylesheet" href="<s:property value='#application.url' />js/jquery.ui.theme.css" type="text/css" media="all" />
  <link rel="stylesheet" href="<s:property value='#application.url' />css/open-sans/open-sans.css" type="text/css" />
  <link rel="stylesheet" href="<s:property value='#application.url' />css/screen.css" type="text/css" />

  <title>Market Bucks</title>
  <script type="text/javascript">
    var APPLICATION_URL = '<s:property value='#application.url' />';
  </script>
</head>
<body>
  <header>
    <div class="container">
      <div class="site-title">
        <h1 id="application_name"><a href="<s:property value='#application.url'/>">Market Bucks</a></h1>
        <div class="site-location" id="location_name"><a href="<s:property value='#application.url'/>">City of Bloomington, IN</a></div>
      </div>
      <s:if test="#session != null && #session.user != null">
        <div class="site-utilityBar">
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
				
              </s:if>
            </div>
          </nav>
        </div>
	  </s:if>
	</div>
	
	<div class="nav1">
      <nav class="container">
        <a href="<s:property value='#application.url'/>ebtAdd.action">Issue MB</a>
        <a href="<s:property value='#application.url'/>giftAdd.action">Issue GC</a>
        <a href="<s:property value='#application.url'/>redeemStart.action">Redemptions</a>
        <a href="<s:property value='#application.url'/>disputeSearch.action">Disputes</a>
        <a href="<s:property value='#application.url'/>buckSearch.action">Search</a>				
        <a href="<s:property value='#application.url'/>help.action">User Guide</a>
      </nav>
    </div>
  </header>
  <main>
    <div class="container">
