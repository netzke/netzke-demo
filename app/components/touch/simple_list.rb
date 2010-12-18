module Touch
  class SimpleList < Netzke::Base
    js_base_class "Ext.List"

    js_mixin :main

    def configuration
      super.merge(
        :data => Boss.all.map{ |b| {:first_name => b.last_name, :last_name => b.last_name} }
      )
    end
  end
end