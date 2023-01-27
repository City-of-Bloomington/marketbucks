<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="redeemStart" id="form_id" method="post">
  <s:hidden name="action2" id="action_id" value=""/>
  
  <h3>New Redemption</h3>
  <s:if test="hasActionErrors()">
	<div class="errors">
      <s:actionerror/>
	</div>
  </s:if>
  <s:elseif test="hasActionMessages()">
	<div class="welcome">
      <s:actionmessage/>
	</div>
  </s:elseif>
  <p>*indicate a required field</p>
  <table border="1" width="80%">
      <tr><td> 
	  <table width="100%">
	      <tr><td align="center" colspan="2">Start typing vendor name and then pick from the list</td></tr>
	      <tr>
		  <td align="right" width="35%"><label>Vendor name:</label></td>
		  <td align="left"><s:textfield name="vendorName" value="" id="vendorName" /></td>
	      </tr>	      
	      <tr>
		  <td align="right"><label>*Vendor number:</label></td>
		  <td>
		      <s:textfield name="redeem.vendorNum" id="vendor_id" value="%{redeem.vendorNum}" />
		  </td>
	      </tr>

	  </table></td>
      </tr>
      <tr>
	  <td valign="top" align="right">
	      <s:submit name="action" type="button" value="Next" />
	  </td>
      </tr>
  </table>
</s:form>
<br />
For redemption advance search click<a href="<s:property value='#application.url'/>redeemSearch.action"> here. </a>
<br />
<s:if test="redeems != null && redeems.size() > 0">
  <s:set var="redeems" value="redeems" />
  <s:set var="redeemsTitle" value="redeemsTitle" />
  <%@  include file="redeems.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































