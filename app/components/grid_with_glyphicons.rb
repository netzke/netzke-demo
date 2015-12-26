# To enable FontAwesome, include this line in the application template:
#
#    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
class GridWithGlyphicons < Bosses
  action :add do |c|
    super c
    glyph_icon(c, "f055")
  end

  action :edit do |c|
    super c
    glyph_icon(c, "f14b")
  end

  action :delete do |c|
    super c
    glyph_icon(c, "f056")
  end

  action :search do |c|
    super c
    glyph_icon(c, "f002")
  end

  def configure(c)
    super
    c.glyph = "xf21b@FontAwesome" # panel header
  end

  private

  def glyph_icon(c, unicode)
    c.glyph = "x#{unicode}@FontAwesome"
    c.icon = false
  end
end
