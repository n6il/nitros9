<?xml version="1.0"?>
<!--
  This is an example of an xmlto stylesheet module to be use when generating PDF
  you call it with xmtto pdf -m article.xsl articles.docbook
  I don't think it works
-->
<xsl:stylesheet xsl:version='1.0'
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="articleinfo/title">
  <fo:block font-family="sans-serif" color="blue"
         font-weight="bold" font-size="18pt"
         space-after="0.5em">
    <xsl:number level="multiple" count="chapter"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>
</xsl:stylesheet>

