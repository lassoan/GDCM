<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:dk="http://docbook.org/ns/docbook" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="dk">
<xsl:output method="xml" omit-xml-declaration="no" encoding="UTF-8" indent="no" />

<xsl:template match="text()" />

<xsl:template match="/">
<xsl:comment> to produce output use:
$ xsltproc ma2html.xsl ModuleAttributes.xml
    </xsl:comment>
    <xsl:comment>
  Program: GDCM (Grassroots DICOM). A DICOM library

  Copyright (c) 2006-2011 Mathieu Malaterre
  All rights reserved.
  See Copyright.txt or http://gdcm.sourceforge.net/Copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.  See the above copyright notice for more information.
</xsl:comment>
<tables edition="2008">
   <xsl:apply-templates />
</tables>
</xsl:template>

<xsl:template match="dk:caption" mode="module"/>
<xsl:template match="dk:caption" mode="macro"/>
<xsl:template match="dk:caption" mode="iod"/>

<xsl:template match="dk:table">
  <xsl:variable name="caption" select="dk:caption"/>
  <xsl:choose>
  <xsl:when test="contains($caption,'Macro')">
  <macro table="{@label}" name="{$caption}">
   <xsl:apply-templates mode="macro"/>
  </macro>
  </xsl:when>
  <xsl:when test="contains($caption,'Module') and not(contains($caption,'IOD'))">
  <module table="{@label}" name="{$caption}">
   <xsl:apply-templates mode="module"/>
  </module>
  </xsl:when>
  <xsl:when test="contains($caption,'IOD Modules')">
  <iod table="{@label}" name="{$caption}">
   <xsl:apply-templates mode="iod"/>
  </iod>
  </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="dk:thead/dk:tr" mode="macro"/>
<xsl:template match="dk:tbody/dk:tr" mode="macro">
  <xsl:variable name="name" select="dk:td[1]/dk:para"/>
  <xsl:variable name="tag" select="dk:td[2]/dk:para"/> <!-- keep upper case for now -->
  <xsl:variable name="group" select="substring-after(substring-before($tag,','), '(')"/>
  <xsl:variable name="element" select="substring-after(substring-before($tag,')'), ',')"/>
  <xsl:variable name="type" select="dk:td[3]/dk:para"/>
  <xsl:variable name="description" select="dk:td[4]/dk:para"/> <!--fixme -->
  <entry group="{$group}" element="{$element}" name="{$name}" type="{$type}">
     <description><xsl:value-of select="$description"/></description>
  </entry>
</xsl:template>

<xsl:template match="dk:thead/dk:tr" mode="module"/>
<xsl:template match="dk:tbody/dk:tr" mode="module">
  <xsl:variable name="name" select="dk:td[1]/dk:para"/>
  <xsl:variable name="tag" select="dk:td[2]/dk:para"/> <!-- keep upper case for now -->
  <xsl:variable name="group" select="substring-after(substring-before($tag,','), '(')"/>
  <xsl:variable name="element" select="substring-after(substring-before($tag,')'), ',')"/>
  <xsl:variable name="type" select="dk:td[3]/dk:para"/>
  <xsl:variable name="description" select="dk:td[4]/dk:para"/> <!--fixme -->
  <entry group="{$group}" element="{$element}" name="{$name}" type="{$type}">
     <description><xsl:value-of select="$description"/></description>
  </entry>
</xsl:template>

<xsl:template match="dk:thead/dk:tr" mode="iod"/>
<xsl:template match="dk:tbody/dk:tr" mode="iod">
  <xsl:variable name="ie" select="dk:td[1]/dk:para"/>
  <xsl:variable name="module" select="dk:td[2]/dk:para"/>
  <xsl:variable name="reference" select="dk:td[3]/dk:para/dk:xref/@linkend"/>
  <xsl:variable name="ref" select="translate($reference,'sect_','')"/>
  <xsl:variable name="usage" select="dk:td[4]/dk:para"/>
  <entry ie="{$ie}" name="{$module}" ref="{$ref}" usage="{$usage}"/>
</xsl:template>


<!--
<xsl:template match="@*|node()">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()" />
  </xsl:copy>
</xsl:template>
-->

</xsl:stylesheet>