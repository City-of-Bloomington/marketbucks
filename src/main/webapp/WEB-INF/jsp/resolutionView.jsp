<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Resolution <s:property value="resolution.id" /></h3>
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
<table border="1" width="80%">
	<tr>
	    <td> 
		<table width="100%">
		    <tr>
			<td align="right" width="35%"><label>Dispute ID:</label></td>
			<td align="left">
			    <a href="<s:property value='#application.url' />disputeEdit.action?id=<s:property value='resolution.dispute_id' />"> <s:property value="resolution.dispute_id" /></a></td>					
		    </tr>
		    <tr>
			<td align="right"><label>Disputed MB/GC ID:</label></td>
			<td align="left"><s:property value="resolution.dispute.buck_id" /></td>
		    </tr>
		    <tr>
			<td align="right" valign="top" width="35%"><label>Reason:</label></td>
			<td align="left"><s:property value="resolution.dispute.reason" /></td>
		    </tr>
		    <s:if test="resolution.id != ''">
			<tr>
			    <td align="right" valign="top"><label>Status:</label></td>
			    <td align="left"><s:property value="resolution.status" /></td>
			</tr>					
		    </s:if>		  		  
		</table>
	    </td>
	</tr>
	<s:if test="resolution.dispute.reason == 'Expired'">
	    <tr>
		<td>
		    <table width="100%">
			<tr>
			    <td align="right" valign="top" width="35%"><label>New Expire Date:</label></td>
			    <td align="left"><s:property value="%{resolution.expire_date}" /></td>
			</tr>
		    </table>
		</td>
	    </tr>
	</s:if>
	<s:elseif test="%{resolution.dispute.reason == 'Not Exist'}">
	  <tr>	  
	      <td>	  
		  <table width="100%">
		      <tr>
			  <td align="right" width="35%"><label>New MB/GC ID:</label></td>
			  <td align="left"><s:property value="%{resolution.new_buck_id}" /></td>
		      </tr>
		  </table>
	      </td>
	  </tr>
	  <tr>	  
	      <td>	  
		  <table width="100%">	  
		      <tr>
			  <td align="right" valign="top" width="35%"><label>Value/Expire Date:</label></td>
			  <td align="left"><s:property value="%{resolution.conf.info}" /></td>
		      </tr>
		  </table>
	      </td>
	  </tr>
	  <s:if test="%{resolution.buck.buck_type_id == 1}">
	      <tr>	  
		  <td>	  
		      <table width="100%">
			  <tr>
			      <td align="right" valign="top" width="35%"><label>Authorization #:</label></td>
			      <td align="left"><s:property value="%{resolution.approve}" /></td>
			  </tr>
			  <tr>
			      <td align="right" valign="top"><label>Customer Card #:</label></td>
			      <td align="left"><s:property value="%{resolution.card_last_4}" /></td>
			  </tr>
		      </table>
		  </td>
	      </tr>
	  </s:if>
	  <s:else>
	      <tr>	  
		  <td>	  
		      <table width="100%">					
			  <tr>
			      <td align="right" valign="top" width="35%"><label>Payment Type:</label></td>
			      <td align="left"><s:property value="%{resolution.pay_type}" /></td>
			  </tr>
			  <tr>
			      <td align="right" valign="top"><label>Check #:</label></td>
			      <td align="left"><s:property value="%{resolution.check_no}" /></td>
			  </tr>
		      </table>
		  </td>
	      </tr>
	  </s:else>
	</s:elseif>
	<s:elseif test="%{resolution.dispute.reason == 'Not Issued'}">
	    <tr>	  
		<td>	  
		    <table width="100%">	  	  		
			<s:if test="%{resolution.buck.buck_type_id == 1}">
			    <tr>
				<td align="right" valign="top" width="35%"><label>Authorization #:</label></td>
				<td align="left"><s:property value="%{resolution.approve}" /></td>
			    </tr>
			    <tr>
				<td align="right" valign="top"><label>Customer Card #:</label></td>
				<td align="left"><s:property value="%{resolution.card_last_4}" /></td>
			    </tr>
			</s:if>
			<s:else>
			    <tr>
				<td align="right" valign="top" width="35%"><label>Payment Type:</label></td>
				<td align="left"><s:property value="%{resolution.pay_type}" /></td>
			    </tr>
			    <tr>
				<td align="right" valign="top"><label>Check #:</label></td>
				<td align="left"><s:property value="%{resolution.check_no}" /></td>
			    </tr>
			</s:else>
		    </table>
		</td>
	    </tr>		  
	</s:elseif>
</table>

<s:if test="resolutions != null && resolutions.size() > 0">
  <s:set var="resolutions" value="resolutions" />
  <s:set var="resolutionsTitle" value="resolutionsTitle" />  
  <%@  include file="resolutions.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































