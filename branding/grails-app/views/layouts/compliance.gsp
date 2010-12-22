<!DOCTYPE html>

<html>
  <head>
    <title><g:message code="fedreg.title" /> | <g:layoutTitle /></title>

	<!--[if lt IE 9]>
		<script type="text/javascript" src="${resource(dir: 'js', file: '/html5.js')}"></script>
	<![endif]-->
	<script type="text/javascript" src="${resource(dir: 'js', file: '/modernizr-1.5.min.js')}"></script>

	<link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui-1.8.2.custom.css')}" />
	<link rel="stylesheet/less" href="${resource(dir:'css',file:'frtheme.less')}" />
		
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery-1.4.2.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery-ui-1.8.2.custom.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'less-1.0.35.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.jgrowl.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.validate.pack.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.validate.additional-methods.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.form.wizard-2.0.1-min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: '/jquery/jquery.datatables.min.js')}"></script>
	
	<script type="text/javascript" src="${resource(dir: 'js', file: '/fedreg-members.js')}"></script>
		
    <g:layoutHead />
</head>

<body>

    <header>
		<g:render template='/templates/frheader' />
    </header>
	
	<nav>
	<n:isLoggedIn>
		<g:render template='/templates/frtopnavigation'/>
		
		<ul class="level2a">
			<li class="${controllerName == 'IDPSSODescriptorAttributeCompliance' ? 'active':''}">
				<g:link controller="IDPSSODescriptorAttributeCompliance" action="summary"><g:message code="label.attributesummary" /></g:link>
		 	</li>
			<li class="${controllerName == 'attributeRelease' ? 'active':''}">
				<g:link controller="attributeRelease" action="index"><g:message code="label.attributerelease" /></g:link>
		 	</li>
			<li class="${controllerName == 'certifyingAuthorityUsage' ? 'active':''}">
				<g:link controller="certifyingAuthorityUsage" action="index"><g:message code="label.cautilization" /></g:link>
			</li>
		</ul>	
	</n:isLoggedIn>
	</nav>

	<section>
		<div id="working"><img src="${resource(dir:'images', file:'spinner.gif')}" width="20" height="20"><br/><g:message code="label.working"/></div>

		<g:layoutBody/>
    </section>

	<footer>
		<g:render template='/templates/frfooter' />
	</footer>

<n:sessionterminated/>

</body>

</html>