<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="redeemEdit" id="form_1" method="post">    
  <h3>Redeem MB & GC</h3>
  <s:hidden name="redeem.id" value="%{redeem.id}" />
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
  <p>*indicates a required field</p>
  <table width="90%">
      <caption>Redemption ID:<s:property value="redeem.id" /></caption>
      <tr>
	  <th><b>Vendor:</b></th>
	  <td align="left"><s:property value="redeem.vendor" /></td>
      </tr>
      <tr>
	  <th><b>User:</b></th>
	  <td align="left"><s:property value="redeem.user" /></td>		  
      </tr>
      <tr>
	  <th><b>Date & Time:</b></th>
	  <td align="left"><s:property value="redeem.date_time" /></td>
      </tr>
      <tr>
	  <th><b>Total:</b></th>
	  <td align="left">$<s:property value="redeem.total" />.00</td>
      </tr>
      <tr>
	  <th><b>Count:</b></th>
	  <td align="left"><s:property value="redeem.count" /></td>
      </tr>
      <tr>
	  <th><label for="notes">Invoice notes:</lablek> </th>
	  <td align="left"><s:textarea name="redeem.notes" value="%{redeem.notes}" rows="5" cols="80" id="notes" /></td>
      </tr>		
      <tr>
	  <th valign="top" align="right">
	      <s:submit name="action" type="button" value="Update" />
	  </th>
	  <s:if test="redeem.canCancel()">
	      <td valign="top" align="left">
		  <s:submit name="action" type="button" value="Cancel" />
	      </td>
	  </s:if>
	  <s:else>
	      <td>&nbsp;</td>
	  </s:else>
      </tr>
      <tr>
	  <s:if test="redeem.status == 'Open'">
	      <th>
		  <s:submit name="action" type="button" value="Scan more MB/GC" />
	      </th>
	      <td>&nbsp;</td>
	  </s:if>
	  <s:else>
	      <td align="center" colspan="2">
		  <button onclick="document.location='<s:property value='#application.url' />RedeemInvoice.do?id=<s:property value='redeem.id' />';return false;">Generate Invoice</button>
	      </td>
	  </s:else>
      </tr>
  </table>
</s:form>
<s:if test="redeem.canFinalize()">
  <s:form action="redeemAdd" id="form_2" method="post">
      <s:hidden name="redeem.id" value="%{redeem.id}" />
      <table border="1" width="90%">
	  <tr>
	      <td>If you are done, click on 'Finalize' to complete this transaction and produce the 'Invoice':
		  <s:submit name="action" type="button" value="Finalize" />		
	      </td>
	  </tr>
      </table>
  </s:form>
</s:if>
<s:if test="redeem.bucks != null && redeem.bucks.size() > 0">
  <table border="1" width="90%">
      <tr><td align="center">
	  <s:set var="bucks" value="redeem.bucks" />
	  <s:set var="bucksTitle" value="bucksTitle" />
	  <s:set var="total" value="redeem.total" />
	  <%@  include file="bucks.jsp" %>
      </td></tr>
  </table>
</s:if>
<s:if test="redeem.disputes != null && redeem.disputes.size() > 0">
  <s:set var="disputes" value="redeem.disputes" />
  <s:set var="disputesTitle" value="disputesTitle" />
  <%@  include file="disputes.jsp" %>
</s:if>
<%@  include file="footer.jsp" %>	






































