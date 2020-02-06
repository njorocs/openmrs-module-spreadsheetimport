<%--
  The contents of this file are subject to the OpenMRS Public License
  Version 1.0 (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://license.openmrs.org

  Software distributed under the License is distributed on an "AS IS"
  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
  License for the specific language governing rights and limitations
  under the License.

  Copyright (C) OpenMRS, LLC.  All Rights Reserved.

--%>
<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Import Spreadsheet Import Templates" otherwise="/login.htm" redirect="/module/spreadsheetimport/spreadsheetimportImport.form"/>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>
<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    table {
        border-collapse: collapse;
        width: 40%;
    }

    tr:nth-child(even) {background-color: #f2f2f2;}

    th, td {
        padding: 12px;
        text-align: left;
    }

</style>

<script type="text/javascript">

    $j(document).ready(function () {

        $j("#migrateAll").click(function(event){
            event.preventDefault();
            $j("#completionMsg").html("Migration process has started");
            $j(this).attr('disabled', true);
            processAllDatasets();
        });

        setInterval(getMigrationDatasetUpdates, 20000);

    });


    function processAllDatasets() {
        DWRMigrationService.processAllDatasets(function(completionMsg){
            $j("#completionMsg").html(completionMsg);
        });
    }

    function getMigrationDatasetUpdates() {
        DWRMigrationService.getMigrationDatasetUpdates(function(mapResult){
            $j("#migrationUpdates").find("tbody").empty();
            var tableRef = document.getElementById("migrationUpdates").getElementsByTagName('tbody')[0];
            for (var key in mapResult) {

                var myHtmlContent = "<td>" + key + "</td><td>" + mapResult[key] + "</td>";
                var newRow = tableRef.insertRow(tableRef.rows.length);
                newRow.innerHTML = myHtmlContent;
            }
        });
    }



</script>

<form method="post" enctype="multipart/form-data">
    <form:errors path="*" cssClass="error"/>

    <h3>Migrate Data</h3>
    <br/>
    <button id="migrateAll">Migrate all Datasets</button>
    <br/>
    <br/>
    <div id="completionMsg"></div>

    <br/>


    <table id="migrationUpdates">
        <thead>
        <tr>
            <th>Dataset Name</th>
            <th>Records processed</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</form>



<%@ include file="/WEB-INF/template/footer.jsp"%>
