<?xml version="1.0" encoding="utf-8"?>
<!--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

-->

<!-- ========================================================================= -->
<!-- ========== CAUTION:  EXPERIMENTAL ======================================= -->
<!-- ========================================================================= -->
<!-- 
 | Respondr is a prototype theme based on the principals of Responsive Design 
 | and Twitter Bootsrap technology.  It was developed by Gary Tompson (Unicon) 
 | and integrated into uPortal 4.1 by Drew Wills (Unicon).
 |
 | More work is needed to make this theme fully-functional in uPortal.  (Can you help?)
 |
 | To enable:  Change the theme name property to "Respondr" in one or more of 
 | the profile database records within src/main/data and import.  The profile 
 | records that come with uPortal are:
 | - system_default/defaultTemplateUser_default (required_entities)
 | - system_mobileDefault/defaultTemplateUser_mobileDefault (default_entities)
 -->

<!-- ========================================================================= -->
<!-- ========== README ======================================================= -->
<!-- ========================================================================= -->
<!-- 
 | The theme is written in XSL. For more information on XSL, refer to [http://www.w3.org/Style/XSL/].
 | Baseline XSL skill is strongly recommended before modifying this file.
 |
 | This file has two purposes:
 | 1. To instruct the portal how to compile and configure the Respondr theme for all device classes.
 | 2. To provide theme configuration and customization.
 |
 | As such, this file has a mixture of code that should not be modified, and code that exists explicitly to be modified.
 | To help make clear what is what, a RED-YELLOW-GREEN legend has been added to all of the sections of the file.
 |
 | RED: Stop! Do not modify.
 | YELLOW: Warning, proceed with caution.  Modifications can be made, but should not generally be necessary and may require more advanced skill.
 | GREEN: Go! Modify as desired.
 -->

<!-- ========================================================================= -->
<!-- ========== DOCUMENT DESCRIPTION ========================================= -->
<!-- ========================================================================= -->
<!-- 
 | Date: 07/30/2013
 | Author: Drew Wills
 | Company: Unicon,Inc.
 | uPortal Version: uP4.1.0
 | 
 | General Description: This file, respondr.xsl, was developed with mcolumn.xsl in order 
 | to enable uPortal 4.1 to be viewable by desktop, smartphone, and tablet devices.
 | 
 | This file transforms the xml content generated by the mcolumn.xsl file into html, which 
 | is then rendered in a mobile device. This file formats the html markup to render uPortal's tabs 
 | and their associated channels and portlets for mobile display.
 -->


<!-- ========================================================================= -->
<!-- ========== STYLESHEET DELCARATION ======================================= -->
<!-- ========================================================================= -->
<!-- 
 | RED
 | This statement defines this document as XSL.
 -->
<xsl:stylesheet 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:dlm="http://www.uportal.org/layout/dlm"
    xmlns:upAuth="http://xml.apache.org/xalan/java/org.jasig.portal.security.xslt.XalanAuthorizationHelper"
    xmlns:upGroup="http://xml.apache.org/xalan/java/org.jasig.portal.security.xslt.XalanGroupMembershipHelper"
    xmlns:upMsg="http://xml.apache.org/xalan/java/org.jasig.portal.security.xslt.XalanMessageHelper"
    xmlns:url="https://source.jasig.org/schemas/uportal/layout/portal-url"
    xsi:schemaLocation="
            https://source.jasig.org/schemas/uportal/layout/portal-url https://source.jasig.org/schemas/uportal/layout/portal-url-4.0.xsd"
    exclude-result-prefixes="url upAuth upGroup upMsg" 
    version="1.0">

<!-- ========================================================================= -->


<!-- ========================================================================= -->
<!-- ========== IMPORTS ====================================================== -->
<!-- ========================================================================= -->
<!-- 
 | RED
 | Imports are the XSL files that build the theme.
 | Import statments and the XSL files they refer to should not be modified.
 -->
<xsl:import href="../resourcesTemplates.xsl" />  <!-- Templates for Skin Resource generation -->
<xsl:import href="../urlTemplates.xsl" />        <!-- Templates for URL generation -->
<xsl:import href="content.xsl" />     <!-- Templates for content elements (rows and portlets) -->
<!-- ========================================================================= -->


<!-- ========================================= -->
<!-- ========== OUTPUT DELCARATION =========== -->
<!-- ========================================= -->
<!-- 
 | RED
 | This statement instructs the XSL how to output.
 -->
<xsl:output method="xml" indent="yes" media-type="text/html" doctype-system="EMPTY"/>
<!-- ========================================= -->

<!-- ============================================== -->
<!-- ========== VARIABLES and PARAMETERS ========== -->
<!-- ============================================== -->
<!-- 
 | YELLOW - GREEN
 | These variables and parameters provide flexibility and customization of the user interface.
 | Changing the values of the variables and parameters signals the theme to reconfigure use 
 | and location of user interface components. Most text used within the theme is localized.  
 -->


<!-- ****** XSL UTILITY PARAMETERS ****** -->
<!-- 
| RED
| Parameters used by XSL->Java Callbacks
-->
<xsl:param name="CURRENT_REQUEST" />
<xsl:param name="RESOURCES_ELEMENTS_HELPER" />
<xsl:param name="XSLT_PORTAL_URL_PROVIDER" />


<!-- ****** SKIN SETTINGS ****** -->
<!-- 
| YELLOW
| Skin Settings can be used to change the location of skin files.
--> 
<xsl:param name="skin">uPortal4</xsl:param>
<xsl:param name="CONTEXT_PATH">/NOT_SET</xsl:param>
<xsl:variable name="SKIN" select="$skin"/>
<xsl:variable name="MEDIA_PATH">media/skins/respondr</xsl:variable>
<xsl:variable name="ABSOLUTE_MEDIA_PATH" select="concat($CONTEXT_PATH,'/',$MEDIA_PATH)"/>
<xsl:variable name="SKIN_RESOURCES_PATH" select="concat('/',$MEDIA_PATH,'/',$SKIN,'/skin.xml')"/>
<xsl:variable name="SKIN_PATH" select="concat($ABSOLUTE_MEDIA_PATH,'/',$SKIN)"/>
<xsl:variable name="PORTAL_SHORTCUT_ICON" select="concat($CONTEXT_PATH,'/favicon.ico')" />
<xsl:variable name="FOCUSED_CLASS">
    <xsl:choose>
        <xsl:when test="//content/focused">focused <xsl:value-of select="//content/focused/channel/@fname"/></xsl:when>
        <xsl:otherwise>dashboard</xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<!-- ======================================== -->


<!-- ****** LOCALIZATION SETTINGS ****** -->
<!-- 
 | GREEN
 | Locatlization Settings can be used to change the localization of the theme.
 -->
<xsl:param name="USER_LANG">en</xsl:param>
<!-- ======================================== -->


<!-- ****** PORTAL SETTINGS ****** -->
<!-- 
 | YELLOW
 | Portal Settings should generally not be (and not need to be) modified.
 -->
<xsl:param name="AUTHENTICATED" select="'false'"/>
<xsl:param name="HOST_NAME"></xsl:param>
<xsl:param name="USER_ID">guest</xsl:param>
<xsl:param name="userName">Guest User</xsl:param>
<xsl:param name="USER_NAME"><xsl:value-of select="$userName"/></xsl:param>
<xsl:param name="uP_productAndVersion">uPortal</xsl:param>
<xsl:param name="UP_VERSION"><xsl:value-of select="$uP_productAndVersion"/></xsl:param>
<xsl:param name="baseActionURL">render.uP</xsl:param>
<xsl:variable name="BASE_ACTION_URL"><xsl:value-of select="$baseActionURL"/></xsl:variable>
<xsl:param name="EXTERNAL_LOGIN_URL"></xsl:param>
<xsl:variable name="IS_FRAGMENT_ADMIN_MODE">
  <xsl:choose>
    <xsl:when test="//channel[@fname = 'fragment-admin-exit']">true</xsl:when>
    <xsl:otherwise>false</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- ****** PORTLET SETTINGS ****** -->
<!--
 | GREEN
 | Portlet Settings can be used to change aspects of the portlet chrome.
 -->
<xsl:param name="USE_PORTLET_MINIMIZE_CONTENT" select="'true'" /> <!-- Sets the use of a content show/hide control.  Values are 'true' or 'false'. -->
<xsl:param name="USE_PORTLET_CONTROL_ICONS" select="'true'" /> <!-- Sets the use of icons in portlet chrome controls.  Values are 'true' or 'false'. -->


<!-- ========================================================================= -->
<!-- ========== TEMPLATE: PAGE TITLE ========================================= -->
<!-- ========================================================================= -->
<!--
 | GREEN
 | This template renders the page title in the <head>.
 | Template contents can be any valid XSL or XHTML.
 -->
<xsl:template name="page.title">
   <title><xsl:value-of select="upMsg:getMessage('portal.page.title', $USER_LANG)" /></title>
</xsl:template>
<!-- ========================================================================= -->


<!-- ========================================================================= -->
<!-- ========== TEMPLATE: PAGE META ========================================== -->
<!-- ========================================================================= -->
<!--
 | GREEN
 | This template renders keywords and descriptions in the <head>.
 | Template contents can be any valid XSL or XHTML.
 -->
<xsl:template name="page.meta">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="description" content="{upMsg:getMessage('portal.page.meta.description', $USER_LANG)}" />
    <meta name="keywords" content="{upMsg:getMessage('portal.page.meta.keywords', $USER_LANG)}" />
</xsl:template>
<!-- ========================================================================= -->


<!-- ========================================================================= -->
<!-- ========== TEMPLATE: PAGE JAVASCRIPT ==================================== -->
<!-- ========================================================================= -->
<!-- 
 | YELLOW
 | This template initializes portal-wide JavaScript and cleans up the global namespace.
 -->
<xsl:template name="page.js">
  <script type="text/javascript">
    var up = up || {};
    up.jQuery = jQuery.noConflict(true);

    (function($) {
      $(function() {
        var navMenuToggle = function() {
          var menu = $(".portal-nav .menu"), menuToggle = $(".portal-nav .menu-toggle");
          // Toggle the menu visibility when the button is clicked.
          menuToggle.click(function() {
            //alert("Handler for .click() called.");
            menu.toggleClass("show");
            return false;
          });
          // Console for debugging.
          console.debug("menu", menu, "menuToggle", menuToggle);
        }

        navMenuToggle();
      });
    })(up.jQuery);
  </script>
</xsl:template>
<!-- ========================================================================= -->


<!-- ========================================================================= -->
<!-- ========== TEMPLATE: NAVIGATION ==================================== -->
<!-- ========================================================================= -->
<!-- 
 | YELLOW
 | This template renders the tabs at the top of the page.
 -->
<xsl:template match="navigation">
    <nav class="portal-nav">
        <div class="container">
            <a href="#" class="menu-toggle"><i class="icon-align-justify"></i> Menu</a>
            <ul class="menu">
                <xsl:for-each select="tab">
                    <li>
                        <xsl:if test="@activeTab='true'">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="portalUrl">
                                    <xsl:with-param name="url">
                                        <url:portal-url>
                                            <url:layoutId><xsl:value-of select="@ID"/></url:layoutId>
                                        </url:portal-url>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <i class="icon-chevron-right"></i>
                            <xsl:value-of select="@name" />
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </nav>
</xsl:template>
<!-- ========================================================================= -->


<!-- ========================================================================= -->
<!-- ========== TEMPLATE: ROOT =============================================== -->
<!-- ========================================================================= -->
<!-- 
 | RED
 | This is the root xsl template and it defines the overall structure of the html markup. 
 | Focused and Non-focused content is controlled through an xsl:choose statement.
 | Template contents can be any valid XSL or XHTML.
 -->
<xsl:template match="/">
    <html lang="{$USER_LANG}">
        <head>
            <xsl:call-template name="page.title" />
            <xsl:call-template name="page.meta" />
            <xsl:call-template name="skinResources">
                <xsl:with-param name="path" select="$SKIN_RESOURCES_PATH" />
            </xsl:call-template>
            <xsl:call-template name="page.js" />
        </head>
        <body class="up dashboard portal">

            <div id="wrapper">
                <header class="portal-header" role="banner">
                    <div class="portal-global">
                        <div class="container">
                            <!--ul class="portal-editing">
                                <li><a href="#">Edit Page</a></li>
                            </ul-->
                            <div class="portal-user">
                                <span class="portal-username">User Name</span>
                                <!--span class="portal-signout"><a href="#">Sign out</a></span-->
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <h1 class="portal-logo">uPortal</h1>
                    </div>
                    <xsl:apply-templates select="layout/navigation" />
                </header>
                <div class="portal-content" role="main">
                    <div class="container">
                        <xsl:apply-templates select="layout/content" />
                    </div>
                </div>
                <footer class="portal-footer" role="contentinfo">
                    <div class="container">
                        <div class="portal-power">
                            <h2><a href="http://www.jasig.org/uportal" target="_blank">Powered by uPortal</a>, an open-source project by <a href="http://www.jasig.org" title="Jasig.org - Open for Higher Education">Jasig</a></h2>
                            <ul>
                                <li><a href="http://www.jasig.org/" target="_blank">Jasig.org</a></li>
                                <li><a href="http://www.jasig.org/uportal" target="_blank">uPortal.org</a></li>
                                <li><a href="http://www.jasig.org/uportal/download" target="_blank">Download</a></li>
                                <li><a href="http://www.jasig.org/uportal/community" target="_blank">Community</a></li>
                                <li><a href="http://www.jasig.org/uportal/privacy" target="_blank">Privacy Policy</a></li>
                                <li><a href="http://www.jasig.org/uportal/accessibility" target="_blank">Accessibility</a></li>
                            </ul>
                            <p><a href="http://www.jasig.org/uportal/about/license" title="uPortal" target="_blank">uPortal</a> is licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0" title="Apache License, Version 2.0" target="_blank">Apache License, Version 2.0</a> as approved by the Open Source Initiative (OSI), an <a href="http://www.opensource.org/docs/osd" title="OSI-certified" target="_blank">OSI-certified</a> ("open") and <a href="http://www.gnu.org/licenses/license-list.html" title="Gnu/FSF-recognized" target="_blank">Gnu/FSF-recognized</a> ("free") license.</p>
                        </div>
                    </div>
                </footer>
            </div>

            <script type="text/javascript">
                up.analytics = up.analytics || {};
                up.analytics.host = '<xsl:value-of select="$HOST_NAME" />';
                up.analytics.portletData = <portlet-analytics-data/>;
                up.analytics.pageData = <page-analytics-data/>;
            </script>
        </body>
    </html>
</xsl:template>
<!-- ========================================================================= -->


</xsl:stylesheet>