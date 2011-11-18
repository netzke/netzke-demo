module Portlet
  class Base < Netzke::Base
    portal_path = Netzke::Core.ext_path.join("examples/portal")
    js_include(portal_path.join("classes/Portlet.js"))

    js_base_class "Ext.app.Portlet"
  end
end
