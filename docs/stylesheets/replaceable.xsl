<?xml version='1.0'?>
<!-- vim:set sts=2 shiftwidth=2 syntax=sgml: -->
<!--
  This is an example of an xmlto stylesheet module to be use when generating HTML
  you call it with xmtto pdf -m replaceable.xsl articles.docbook
  Instead of using italics for the <replaceable> element it uses < and >
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>
<xsl:template match="replaceable">
<xsl:text>&lt;</xsl:text>
<xsl:apply-templates/>
<xsl:text>&gt;</xsl:text>
</xsl:template>

</xsl:stylesheet>
