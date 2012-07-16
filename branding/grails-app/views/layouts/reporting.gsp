<!DOCTYPE html>

<html>
  <head>
    <title><g:message code='fr.branding.title' default='Federation Registry'/></title>
    <r:require modules="modernizr, bootstrap, bootstrap-notify, bootstrap-datepicker, validate, highcharts, zenbox, jreject, app"/>
    <g:render template='/templates/frbrowsercheck' />
    <r:layoutResources/>
    <g:layoutHead />
  </head>

  <body>

    <div class="container">
      <header>
        <div class="row">
          <div class="span12">
            <g:render template='/templates/frheader' />
          </div>
        </div>
      </header>
  
      <nav>
        <div class="row">
          <div class="span12">
            <g:render template='/templates/layouts/reporting_nav' />  
          </div>
        </div>
      </nav>

      <section>
        <div class='notifications top-right'></div>
        <g:layoutBody/>
      </section>

      <footer>
        <div class="row">
          <div class="span12">
            <g:render template='/templates/frfooter' />
          </div>
        </div>
      </footer>
    </div>
    
    <g:render template="/templates/ajaxload-modal" />
    <r:layoutResources/>
  </body>
</html>
