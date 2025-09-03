<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    

    <title>
        PowerShell Gallery
        | Functions/Invoke-AESEncryption.ps1 4.0.2.3
    </title>

    <link href="/favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <link title="https://www.powershellgallery.com" type="application/opensearchdescription+xml" href="/opensearch.xml" rel="search">

    <link href="/Content/gallery/css/site.min.css?v=N-FMpZ9py63ZO32Sjay59lx-8krWdY3bkLtzeZMpb8w1" rel="stylesheet"/>

    <link href="/Content/gallery/css/branding.css?v=1.2" rel="stylesheet"/>



    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    

    
    
    
                <!-- Telemetry -->
            <script type="text/javascript">
                var appInsights = window.appInsights || function (config) {
                    function s(config) {
                        t[config] = function () {
                            var i = arguments;
                            t.queue.push(function () { t[config].apply(t, i) })
                        }
                    }

                    var t = { config: config }, r = document, f = window, e = "script", o = r.createElement(e), i, u;
                    for (o.src = config.url || "//az416426.vo.msecnd.net/scripts/a/ai.0.js", r.getElementsByTagName(e)[0].parentNode.appendChild(o), t.cookie = r.cookie, t.queue = [], i = ["Event", "Exception", "Metric", "PageView", "Trace"]; i.length;) s("track" + i.pop());
                    return config.disableExceptionTracking || (i = "onerror", s("_" + i), u = f[i], f[i] = function (config, r, f, e, o) {
                        var s = u && u(config, r, f, e, o);
                        return s !== !0 && t["_" + i](config, r, f, e, o), s
                    }), t
                }({
                    instrumentationKey: '50d4abc3-17d3-4a1b-8361-2d1e9ca8f6d5',
                    samplingPercentage: 100
                });

                window.appInsights = appInsights;
                appInsights.trackPageView();
            </script>

        <script type="text/javascript">

        window.addEventListener('DOMContentLoaded', () => {
            const tabs = document.querySelectorAll('[role="tab"]');
            const tabList = document.querySelector('[role="tablist"]');

            // Add a click event handler to each tab
            tabs.forEach((tab) => {
                tab.addEventListener('click', changeTabs);
            });

            // Enable arrow navigation between tabs in the tab list
            let tabFocus = 0;

            tabList?.addEventListener('keydown', (e) => {
                // Move right
                if (e.keyCode === 39 || e.keyCode === 37) {
                    tabs[tabFocus].setAttribute('tabindex', -1);
                    if (e.keyCode === 39) {
                        tabFocus++;
                        // If we're at the end, go to the start
                        if (tabFocus >= tabs.length) {
                            tabFocus = 0;
                        }
                        // Move left
                    } else if (e.keyCode === 37) {
                        tabFocus--;
                        // If we're at the start, move to the end
                        if (tabFocus < 0) {
                            tabFocus = tabs.length - 1;
                        }
                    }

                    tabs[tabFocus].setAttribute('tabindex', 0);
                    tabs[tabFocus].focus();
                }
            });
        });

        function changeTabs(e) {
            const target = e.target;
            const parent = target.parentNode;
            const grandparent = parent.parentNode;

            // Remove all current selected tabs
            parent
                .querySelectorAll('[aria-selected="true"]')
                .forEach((t) => t.setAttribute('aria-selected', false));

            // Set this tab as selected
            target.setAttribute('aria-selected', true);

            // Hide all tab panels
            grandparent
                .querySelectorAll('[role="tabpanel"]')
                .forEach((p) => p.setAttribute('hidden', true));

            // Show the selected panel
            grandparent.parentNode
                .querySelector(`#${target.getAttribute('aria-controls')}`)
                .removeAttribute('hidden');
        }
    </script>

</head>
<body>
    





<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 text-center">
                <a href="#" id="skipToContent" class="showOnFocus" title="Skip To Content">Skip To Content</a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-1 col-sm-2">
                <div class="navbar-header">
                    <a href="/" class="nvabar-header-aLink">
                        <div class="navbar-logo-container">
                            <img class="navbar-logo img-responsive" alt="PowerShell Gallery Home"
                             src="/Content/Images/Branding/psgallerylogo.svg"
                                 onerror="this.src='https://powershellgallery.com/Content/Images/Branding/psgallerylogo-whiteinlay.png'; this.onerror = null;"
 />
                            <p class="navbar-logo-text">PowerShell Gallery</p>
                        </div>
                    </a>
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" title="Open Main Menu and profile dropdown">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
            </div>
            <div class="col-sm-12 col-md-8 special-margin-left">
                <div id="navbar" class="navbar-collapse collapse" aria-label="Navigation Bar">
                    <table>
                        <tr>
                            <td colspan="3">
                                <ul class="nav navbar-nav" role="list">
                                        <li class="">
        <a role="link" href="/packages" target="" aria-label="Packages">
            <span aria-hidden="true">Packages</span>
        </a>
    </li>

                                        <li class="">
        <a role="link" href="/packages/manage/upload" target="" aria-label="Publish">
            <span aria-hidden="true">Publish</span>
        </a>
    </li>

                                                                            <li class="">
        <a role="link" href="https://go.microsoft.com/fwlink/?LinkID=825202&amp;clcid=0x409" target="_blank" aria-label="Documentation">
            <span aria-hidden="true">Documentation</span>
        </a>
    </li>

                                </ul>
                            </td>
                            <td colspan="1" class="td-align-topright">
                                    <div class="nav navbar-nav navbar-right">
    <li class="">
        <a role="link" href="/users/account/LogOn?returnUrl=%2Fpackages%2FDRTools%2F4.0.2.3%2FContent%2FFunctions%2FInvoke-AESEncryption.ps1" target="" aria-label="Sign in">
            <span aria-hidden="true">Sign in</span>
        </a>
    </li>
                                    </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

        <div class="container-fluid search-container">
            <div class="row" id="search-row">
                <form aria-label="Package search bar" action="/packages" method="get">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-offset-1 col-sm-2"></div>
                            <div class="col-sm-12 col-md-8">
                                <div class="form-group special-margin-left">
                                    <label for="search">Search PowerShell packages:</label>
<div class="input-group"  role="presentation">
    <input name="q" type="text" class="form-control ms-borderColor-blue search-box" id="search" aria-label="Enter packages to search, use the arrow keys to autofill."
           placeholder="Az, etc..." autocomplete="on"
           value=""
           />
    <span class="input-group-btn">
        <button class="btn btn-default btn-search ms-borderColor-blue ms-borderColor-blue--hover" type="submit"
                title="Search PowerShell packages" aria-label="Search PowerShell packages">
            <span class="ms-Icon ms-Icon--Search" aria-hidden="true"></span>
        </button>
    </span>
</div>

                                    <div id="autocomplete-results-container" class="text-left" tabindex="0"></div>

<script type="text/html" id="autocomplete-results-row">
    <!-- ko if: $data -->
    <!-- ko if: $data.PackageRegistration -->
    <div class="col-sm-4 autocomplete-row-id autocomplete-row-data">
        <span data-bind="attr: { id: 'autocomplete-result-id-' + $data.PackageRegistration.Id, title: $data.PackageRegistration.Id }, text: $data.PackageRegistration.Id"></span>
    </div>
    <div class="col-sm-4 autocomplete-row-downloadcount text-right autocomplete-row-data">
        <span data-bind="text: $data.DownloadCount + ' downloads'"></span>
    </div>
    <div class="col-sm-4 autocomplete-row-owners text-left autocomplete-row-data">
        <span data-bind="text: $data.OwnersString + ' '"></span>
    </div>
    <!-- /ko -->
    <!-- ko ifnot: $data.PackageRegistration -->
    <div class="col-sm-12 autocomplete-row-id autocomplete-row-data">
        <span data-bind="attr: { id: 'autocomplete-result-id-' + $data, title: $data  }, text: $data"></span>
    </div>
    <!-- /ko -->
    <!-- /ko -->
</script>

<script type="text/html" id="autocomplete-results-template">
    <!-- ko if: $data.data.length > 0 -->
    <div data-bind="foreach: $data.data" id="autocomplete-results-list">
        <a data-bind="attr: { id: 'autocomplete-result-row-' + $data, href: '/packages/' + $data, title: $data }" tabindex="-1">
            <div data-bind="attr:{ id: 'autocomplete-container-' + $data }" class="autocomplete-results-row">
            </div>
        </a>
    </div>
    <!-- /ko -->
</script>

                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
</nav>





    <div id="skippedToContent">
        

<div role="main" class="container page-display-filecontent">
    <div class="row package-page-heading">
        <div class="col-xs-12 col-sm-offset-1 col-sm-10">
            <h1><a href="/packages/DRTools/">DRTools</a></h1>
            <h4><a href="/packages/DRTools/4.0.2.3"> 4.0.2.3</a></h4>
        </div>
    </div>
    <div class="row package-page-MoreInfo">
        <div class="col-xs-12 col-sm-offset-1 col-sm-10">
            <h3>Functions/Invoke-AESEncryption.ps1</h3>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-sm-offset-1 col-sm-10 div-fileContentDisplay">          
            <div class="row fileContentDisplay">
                <table class="fileContentDisplay-table">
                    <tbody>
                        <tr>
                            <td class="fileContent col-sm-10">
                                <span style='color:#006400'>&lt;#<BR />
.SYNOPSIS<BR />
Encryptes or Decrypts Strings or Byte-Arrays with AES<BR />
&nbsp;<BR />
.DESCRIPTION<BR />
Takes a String or File and a Key and encrypts or decrypts it with AES256 (CBC)<BR />
&nbsp;<BR />
.PARAMETER Mode<BR />
Encryption or Decryption Mode<BR />
&nbsp;<BR />
.PARAMETER Key<BR />
Key used to encrypt or decrypt<BR />
&nbsp;<BR />
.PARAMETER Text<BR />
String value to encrypt or decrypt<BR />
&nbsp;<BR />
.PARAMETER Path<BR />
Filepath for file to encrypt or decrypt<BR />
&nbsp;<BR />
.EXAMPLE<BR />
Invoke-AESEncryption -Mode Encrypt -Key &quot;p@ssw0rd&quot; -Text &quot;Secret Text&quot;<BR />
&nbsp;<BR />
Description<BR />
-----------<BR />
Encrypts the string &quot;Secret Test&quot; and outputs a Base64 encoded cipher text.<BR />
&nbsp;<BR />
.EXAMPLE<BR />
Invoke-AESEncryption -Mode Decrypt -Key &quot;p@ssw0rd&quot; -Text &quot;LtxcRelxrDLrDB9rBD6JrfX/czKjZ2CUJkrg++kAMfs=&quot;<BR />
&nbsp;<BR />
Description<BR />
-----------<BR />
Decrypts the Base64 encoded string &quot;LtxcRelxrDLrDB9rBD6JrfX/czKjZ2CUJkrg++kAMfs=&quot; and outputs plain text.<BR />
&nbsp;<BR />
.EXAMPLE<BR />
Invoke-AESEncryption -Mode Encrypt -Key &quot;p@ssw0rd&quot; -Path file.bin<BR />
&nbsp;<BR />
Description<BR />
-----------<BR />
Encrypts the file &quot;file.bin&quot; and outputs an encrypted file &quot;file.bin.aes&quot;<BR />
&nbsp;<BR />
.EXAMPLE<BR />
Invoke-AESEncryption -Mode Encrypt -Key &quot;p@ssw0rd&quot; -Path file.bin.aes<BR />
&nbsp;<BR />
Description<BR />
-----------<BR />
Decrypts the file &quot;file.bin.aes&quot; and outputs an encrypted file &quot;file.bin&quot;<BR />
#&gt;</span><br />
<span style='color:#00008B'>function</span><span style='color:#000000'>&nbsp;</span><span style='color:#8A2BE2'>Invoke-AESEncryption</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>CmdletBinding</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>OutputType</span><span style='color:#000000'>(</span><span style='color:#008080'>[string]</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>Param</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>(</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>Parameter</span><span style='color:#000000'>(</span><span style='color:#000000'>Mandatory</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$true</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>ValidateSet</span><span style='color:#000000'>(</span><span style='color:#8B0000'>&#39;Encrypt&#39;</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&#39;Decrypt&#39;</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[String]</span><span style='color:#D93900'>$Mode</span><span style='color:#737373'>,</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>Parameter</span><span style='color:#000000'>(</span><span style='color:#000000'>Mandatory</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$true</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[String]</span><span style='color:#D93900'>$Key</span><span style='color:#737373'>,</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>Parameter</span><span style='color:#000000'>(</span><span style='color:#000000'>Mandatory</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$true</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>ParameterSetName</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;CryptText&quot;</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[String]</span><span style='color:#D93900'>$Text</span><span style='color:#737373'>,</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#737373'>[</span><span style='color:#007BA6'>Parameter</span><span style='color:#000000'>(</span><span style='color:#000000'>Mandatory</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$true</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>ParameterSetName</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;CryptFile&quot;</span><span style='color:#000000'>)</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[String]</span><span style='color:#D93900'>$Path</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>)</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>Begin</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$shaManaged</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#0000FF'>New-Object</span><span style='color:#000000'>&nbsp;</span><span style='color:#8A2BE2'>System.Security.Cryptography.SHA256Managed</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#0000FF'>New-Object</span><span style='color:#000000'>&nbsp;</span><span style='color:#8A2BE2'>System.Security.Cryptography.AesManaged</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Mode</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Security.Cryptography.CipherMode]</span><span style='color:#737373'>::</span><span style='color:#000000'>CBC</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Padding</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Security.Cryptography.PaddingMode]</span><span style='color:#737373'>::</span><span style='color:#000000'>Zeros</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>BlockSize</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#800080'>128</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>KeySize</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#800080'>256</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>Process</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Key</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$shaManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>ComputeHash</span><span style='color:#000000'>(</span><span style='color:#008080'>[System.Text.Encoding]</span><span style='color:#737373'>::</span><span style='color:#000000'>UTF8</span><span style='color:#737373'>.</span><span style='color:#000000'>GetBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Key</span><span style='color:#000000'>)</span><span style='color:#000000'>)</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>switch</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Mode</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#8B0000'>&#39;Encrypt&#39;</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><span style='color:#D93900'>$plainBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Text.Encoding]</span><span style='color:#737373'>::</span><span style='color:#000000'>UTF8</span><span style='color:#737373'>.</span><span style='color:#000000'>GetBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#0000FF'>Get-Item</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-Path</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-ErrorAction</span><span style='color:#000000'>&nbsp;</span><span style='color:#8A2BE2'>SilentlyContinue</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#737373'>!</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#0000FF'>Write-Error</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-Message</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;File not found!&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>break</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$plainBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.IO.File]</span><span style='color:#737373'>::</span><span style='color:#000000'>ReadAllBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$outPath</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>+</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;.aes&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$encryptor</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>CreateEncryptor</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$encryptedBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$encryptor</span><span style='color:#737373'>.</span><span style='color:#000000'>TransformFinalBlock</span><span style='color:#000000'>(</span><span style='color:#D93900'>$plainBytes</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#800080'>0</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$plainBytes</span><span style='color:#737373'>.</span><span style='color:#000000'>Length</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$encryptedBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>IV</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>+</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$encryptedBytes</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Dispose</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><span style='color:#00008B'>return</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Convert]</span><span style='color:#737373'>::</span><span style='color:#000000'>ToBase64String</span><span style='color:#000000'>(</span><span style='color:#D93900'>$encryptedBytes</span><span style='color:#000000'>)</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[System.IO.File]</span><span style='color:#737373'>::</span><span style='color:#000000'>WriteAllBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$outPath</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$encryptedBytes</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>(</span><span style='color:#0000FF'>Get-Item</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$outPath</span><span style='color:#000000'>)</span><span style='color:#737373'>.</span><span style='color:#000000'>LastWriteTime</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>LastWriteTime</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>return</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;File encrypted to $outPath&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#8B0000'>&#39;Decrypt&#39;</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><span style='color:#D93900'>$cipherBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Convert]</span><span style='color:#737373'>::</span><span style='color:#000000'>FromBase64String</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#0000FF'>Get-Item</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-Path</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-ErrorAction</span><span style='color:#000000'>&nbsp;</span><span style='color:#8A2BE2'>SilentlyContinue</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#737373'>!</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#0000FF'>Write-Error</span><span style='color:#000000'>&nbsp;</span><span style='color:#000080'>-Message</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;File not found!&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>break</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$cipherBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.IO.File]</span><span style='color:#737373'>::</span><span style='color:#000000'>ReadAllBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$outPath</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>FullName</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>-replace</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;.aes&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>IV</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$cipherBytes</span><span style='color:#737373'>[</span><span style='color:#800080'>0</span><span style='color:#737373'>..</span><span style='color:#800080'>15</span><span style='color:#737373'>]</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$decryptor</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>CreateDecryptor</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$decryptedBytes</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$decryptor</span><span style='color:#737373'>.</span><span style='color:#000000'>TransformFinalBlock</span><span style='color:#000000'>(</span><span style='color:#D93900'>$cipherBytes</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#800080'>16</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$cipherBytes</span><span style='color:#737373'>.</span><span style='color:#000000'>Length</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>-</span><span style='color:#000000'>&nbsp;</span><span style='color:#800080'>16</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Dispose</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Text</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><span style='color:#00008B'>return</span><span style='color:#000000'>&nbsp;</span><span style='color:#008080'>[System.Text.Encoding]</span><span style='color:#737373'>::</span><span style='color:#000000'>UTF8</span><span style='color:#737373'>.</span><span style='color:#000000'>GetString</span><span style='color:#000000'>(</span><span style='color:#D93900'>$decryptedBytes</span><span style='color:#000000'>)</span><span style='color:#737373'>.</span><span style='color:#000000'>Trim</span><span style='color:#000000'>(</span><span style='color:#008080'>[char]</span><span style='color:#800080'>0</span><span style='color:#000000'>)</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>if</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>(</span><span style='color:#D93900'>$Path</span><span style='color:#000000'>)</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#008080'>[System.IO.File]</span><span style='color:#737373'>::</span><span style='color:#000000'>WriteAllBytes</span><span style='color:#000000'>(</span><span style='color:#D93900'>$outPath</span><span style='color:#737373'>,</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$decryptedBytes</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>(</span><span style='color:#0000FF'>Get-Item</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$outPath</span><span style='color:#000000'>)</span><span style='color:#737373'>.</span><span style='color:#000000'>LastWriteTime</span><span style='color:#000000'>&nbsp;</span><span style='color:#737373'>=</span><span style='color:#000000'>&nbsp;</span><span style='color:#D93900'>$File</span><span style='color:#737373'>.</span><span style='color:#000000'>LastWriteTime</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>return</span><span style='color:#000000'>&nbsp;</span><span style='color:#8B0000'>&quot;File decrypted to $outPath&quot;</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#00008B'>End</span><span style='color:#000000'>&nbsp;</span><span style='color:#000000'>{</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$shaManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Dispose</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#D93900'>$aesManaged</span><span style='color:#737373'>.</span><span style='color:#000000'>Dispose</span><span style='color:#000000'>(</span><span style='color:#000000'>)</span><br />
<span style='color:#000000'>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='color:#000000'>}</span><br />
<span style='color:#000000'>}</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
    </div>
    <footer class="footer">
    <div class="container footer-container" >
        <div class="row">
            <div class="hidden-xs footer-heading">
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-1 col-sm-1 footer-heading">
                <span><a href="/policies/Contact">Contact Us</a></span>
            </div>
            <div class="col-sm-1 footer-heading">
                <span><a href="/policies/Terms">Terms of Use</a></span>
            </div>
            <div class="col-sm-1 footer-heading">
                <span><a href="https://go.microsoft.com/fwlink/?LinkId=521839">Privacy Policy</a></span>
            </div>
            <div class="col-sm-1 footer-heading">
                <span><a href="https://aka.ms/psgallery-status/">Gallery Status</a></span>
            </div>
            <div class="col-sm-1 footer-heading">
                <span><a href="https://github.com/PowerShell/PowerShellGallery/issues">Feedback</a></span>
            </div>
            <div class="col-sm-1 footer-heading">
                <span><a href="https://aka.ms/PSGalleryPreviewFAQ">FAQs</a></span>
            </div>
            <div class="col-sm-4 footer-heading">
                <span class="footer-heading-last">&copy; 2025 Microsoft Corporation</span>
            </div>
        </div>  
    </div>
</footer>

    <script src="/Scripts/gallery/site.min.js?v=s-Nycwu4c-T9eVJC1tGlnrSh8SDtsEN_92Vs4B72tZk1"></script>

    
</body>
</html>
