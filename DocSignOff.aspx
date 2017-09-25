<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta name="WebPartPageExpansion" content="full" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
	<SharePoint:CssRegistration Name="default" runat="server"/>
	<script type="text/javascript" src="/SiteAssets/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="/SiteAssets/jquery.SPServices-2014.02.js"></script>
	
	<style type="text/css">
		
		.SignOffBody
		{
			font: 14px/100% arial, sans-serif;	
		}
		.SignOffCheckBoxes
		{
			text-align:left;
		}
		.SignOffHeader
		{
			font: 16px/100% arial, sans-serif;
			padding-bottom:10px;	
		}
		
	</style>
	<script type="text/javascript">
		
		$(document).ready(function() {
			//alert('Jquery loaded');
			SignOffButton.disabled = true;			
		});
		
		function getDocumentID() {
			
			var URLVars = window.location.search.substring(1);
			var queryValuesArray = URLVars.split('=');
			var DocumentID = queryValuesArray[1];

			return DocumentID;
		}
				
		function createSignOffRecord(DocumentID, Document_Read_Flag)
		{
		
			//alert('Document ID: ' + DocumentID + ' Document Read Flag: ' + Document_Read_Flag);
			
			$().SPServices({
			    operation: "UpdateListItems",
			    async: false,
			    batchCmd: "New",
			    listName: "Document_Sign_Off",
			    valuepairs: [["DocumentID", DocumentID],["Document_Read_Flag", Document_Read_Flag]],
			    completefunc: function (xData, Status) {
			    }
			});
			
		}
		
		function EnableSignOff()
		{
			SignOffButton.disabled = false;		
		}
				
		function saveSignOffRecord()
		{
			
			var blnReadFlagChecked = document.getElementById("DocumentRead").checked;
			var ReadFlagCheckedYN;
			
			if(blnReadFlagChecked)
			{
				ReadFlagCheckedYN = 'Y';
			} else {
				ReadFlagCheckedYN = 'N';
			}
						
			//alert('Read Flag: ' + ReadFlagCheckedYN + ' DNAFlagYN: ' + DoesNotApplyCheckedYN);
			var DocumentID = getDocumentID();
			
			createSignOffRecord(DocumentID, ReadFlagCheckedYN);
			
			window.location = "https://sp13build.viha.ca/sites/ePaydev/DocSignOff/SitePages/Thankyou.aspx"
		}

	</script>
</head>
<body>
	<div class="SignOffBody">
		<div class="SignOffHeader">
			Document Sign Off
		</div>
		<div class="SignOffCheckBoxes">
			<input type="checkbox" id="DocumentRead" onclick='EnableSignOff()'/>I have read this document and understand the content within.<br/>
		</div>
		<div class="SignOffButton">
			<input type="button" id="SignOffButton" value="Register Choice" onclick="saveSignOffRecord()"/>
		</div>
	
	</div>

<br/><br/><a href="/DocSignOff.aspx?&DocumentID=22">Sign Off Link with Doc ID attached</a>

</body>

</html>
