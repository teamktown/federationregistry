<html>
  <head>
    <meta name="layout" content="public" />
  </head>
  
  <body>
    <h2>Session establishment error</h2>

    <div class="alert alert-block alert-error">
      <p>Unfortunately an error occured while attempting to establish your session with this service. Additional details have been provided Federation Registry administrators.</p>
    </div>

    <p> If this problem persists please contact the <a href="http://support.aaf.edu.au">AAF support desk</a> for help in resolving this fault</strong>.</p>

    <div class="row-spacer">
      <h2>Are you an Identity Provider Administrator?</h2>
      <p>Here are some common things you might need to configure at your Identity Provider in order to successfully login:</p>
      <h3>1. Metadata</h3>
      <p>Ensure you've correctly configured AAF metadata for use with your Identity Provider. Double check by taking a look at this guide <a href="http://support.aaf.edu.au/entries/338216-three-versions-of-the-aaf-metadata-available">http://support.aaf.edu.au/entries/338216-three-versions-of-the-aaf-metadata-available</a>.
      <h3>2. Time Synchronization</h3>
      <p>
        Ensure your Identity Provider server is synced to an upstream time server, this is critically important for federated authentication.
      </p>
      <h3>3. Required Attributes</h3>
      <p>
        In order to get access to the Federation Registry, you need an account provided by an Identity Provider that is active within the federation. Your Identity Provider <strong>must be configured to release the following attributes</strong> to this service:
        <ul>
          <li>commonName</li>
          <li>mail</li>
          <li>eduPersonTargetedID</li>
          <li>auEduPersonSharedToken</li>
        </ul>
      </p>
      <p>
        Within the AAF we recommend automating this process, take a look at this guide for more information <a href="http://support.aaf.edu.au/entries/321600-automating-attribute-release">http://support.aaf.edu.au/entries/321600-automating-attribute-release</a>. Don't know the value for [YOUR UNIQUE URL]? Get in touch with AAF support who'll be able to help you out.
      </p>
      <h3>4. auEduPersonSharedToken value change</h3>
      <p>If you've previously used Federation Registry it is possible that this error has occured because your Identity Provider has supplied a changed value for your auEduPersonSharedToken.</p>
      <p>However this should <strong>never be the case</strong> and must be investigated further. If you believe this to be the case please contact AAF support for resolution.</p>
    </div>
    
    <div class="row-spacer">
      <h2>Complete Request Details</h2>
      <div class="row">
        <div class="span12">
          <g:include controller="auth" action="echo" />
        </div>
      </div>
    </div>
  </body>
</html>