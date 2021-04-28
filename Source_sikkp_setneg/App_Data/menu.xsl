<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="menu">
        <menu>
            <xsl:apply-templates select="level"/>
        </menu>
    </xsl:template>
    <xsl:template match="level">
        <level>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="menu_parent"/>
        </level>
    </xsl:template>
    <xsl:template match="menu_parent">
        <menu_parent>
            <xsl:element name="title">
                <xsl:value-of select="title"/>
            </xsl:element>
            <xsl:element name="url">
                <xsl:value-of select="url"/>
            </xsl:element>
			<xsl:element name="title_en">
				<xsl:value-of select="title_en"/>
			</xsl:element>
			<xsl:apply-templates select="menu_child" />
        </menu_parent>
    </xsl:template>
    <xsl:template match="menu_child">
        <menu_child>
            <xsl:attribute name="subtitle">
                <xsl:value-of select="subtitle"/>
            </xsl:attribute>
            <xsl:attribute name="url">
                <xsl:value-of select="url"/>
            </xsl:attribute>
			<xsl:attribute name="subtitle_en">
				<xsl:value-of select="subtitle_en"/>
			</xsl:attribute>
			<xsl:apply-templates select="menu_child2"/>
        </menu_child>
    </xsl:template>
    <xsl:template match="menu_child2">
        <menu_child>
            <xsl:attribute name="subtitle2">
                <xsl:value-of select="subtitle2"/>
            </xsl:attribute>
            <xsl:attribute name="url">
                <xsl:value-of select="url"/>
            </xsl:attribute>
			<xsl:attribute name="subtitle2_en">
				<xsl:value-of select="subtitle2_en"/>
			</xsl:attribute>
			<xsl:apply-templates select="menu_child3"/>
        </menu_child>
    </xsl:template>
  <xsl:template match="menu_child3">
    <menu_child>
      <xsl:attribute name="subtitle3">
        <xsl:value-of select="subtitle3"/>
      </xsl:attribute>
      <xsl:attribute name="url">
        <xsl:value-of select="url"/>
	  </xsl:attribute>
	  <xsl:attribute name="subtitle3_en">
		  <xsl:value-of select="subtitle3_en"/>
	  </xsl:attribute>
	  <xsl:apply-templates />
    </menu_child>
  </xsl:template>
</xsl:stylesheet>
