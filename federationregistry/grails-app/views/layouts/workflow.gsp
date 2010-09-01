<!DOCTYPE html>

<html>
  <head>
    <title><g:message code="fedreg.title" /> | <g:layoutTitle /></title>
    
	<link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui-1.8.2.custom.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'jquery.jqplot.min.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'jquery.jgrowl.css')}" />
	
	<link rel="stylesheet/less" href="${resource(dir:'css',file:'aaftheme.less')}" />
		
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery-1.4.2.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery-ui-1.8.2.custom.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'less-1.0.32.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.jgrowl.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.validate.pack.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.validate.additional-methods.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.form.wizard-2.0.1-min.js')}"></script>
			
	<script type="text/javascript" src="${resource(dir: 'js', file: '/fedreg-members.js')}"></script>
	<nh:nimbleui/>
		
	<script type="text/javascript">
      <njs:flashgrowl/>
	</script>
	
    <g:layoutHead />

</head>

<body>

    <header>
		<g:render template='/templates/aafheader' />
    </header>
    
	<nav>
		<n:isLoggedIn>
			<g:render template='/templates/aaftopnavigation'/>

			<ul class="level2">
				<li class="${controllerName == 'workflowProcess' ? 'active':''}">
					<g:link controller="workflowProcess" action="list"><g:message code="label.processes" /></g:link>
				</li>
				<li class="${controllerName == 'workflowScript' ? 'active':''}">
					<g:link controller="workflowScript" action="list"><g:message code="label.scripts" /></g:link>
				</li>
			</ul>
			
			<g:if test="${controllerName == 'workflowProcess'}">
				<ul class="level3a">
					<li class="${actionName == 'list' ? 'active':''}"><g:link controller="workflowProcess" action="list"><g:message code="label.list"/></g:link></li>
					<li class="${actionName == 'create' ? 'active':''}"><g:link controller="workflowProcess" action="create"><g:message code="label.create"/></g:link></li>
					<g:if test="${actionName in ['show', 'edit']}">
					<li> | </li>
					<li><g:message code="fedreg.view.workflow.process.show.heading" args="[process.name]"/>: </li>
					<li class="${actionName == 'show' ? 'active':''}"><g:link controller="workflowProcess" action="show" id="${process.id}"><g:message code="label.view"/></g:link></li>
					<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="workflowProcess" action="edit" id="${process.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
					</g:if>
				</ul>
			</g:if>
			
			<g:if test="${controllerName == 'workflowScript'}">
				<ul class="level3a">
					<li class="${actionName == 'list' ? 'active':''}"><g:link controller="workflowScript" action="list"><g:message code="label.list"/></g:link></li>
					<li class="${actionName == 'create' ? 'active':''}"><g:link controller="workflowScript" action="create"><g:message code="label.create"/></g:link></li>
					<g:if test="${actionName in ['show', 'edit']}">
					<li> | </li>
					<li><g:message code="fedreg.view.workflow.script.show.heading" args="[script.name]"/>: </li>
					<li class="${actionName == 'show' ? 'active':''}"><g:link controller="workflowScript" action="show" id="${script.id}"><g:message code="label.view"/></g:link></li>
					<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="workflowScript" action="edit" id="${script.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
					</g:if>
				</ul>
			</g:if>
			
		</n:isLoggedIn>
	</nav>
	<section>
		<div id="working"><img src="${resource(dir:'images', file:'spinner.gif')}" width="20" height="20"> <br> <g:message code="label.working"/></div>

		<g:layoutBody/>
    </section>

<n:sessionterminated/>

</body>

</html>
