<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="tabpage" content="jobs"/>
    <meta name="layout" content="base"/>
    <title><g:message code="main.app.name"/> - Edit <g:message code="domain.ScheduledExecution.title"/></title>
    <asset:javascript src="jobEditPage_bundle.js"/>
    <g:javascript>
        var workflowEditor=new WorkflowEditor();
    </g:javascript>
</head>
<body>


    <tmpl:editForm model="[scheduledExecution:scheduledExecution,crontab:crontab,authorized:authorized, notificationPlugins: notificationPlugins]"/>
</body>
</html>
