module Touch

  class SimpleList < Netzke::Base
    js_base_class "Ext.List"

    js_mixin :main

    def configuration
      sup = super

      attrs = extract_attrs(sup)
      data_class = sup[:model].constantize

      sup.merge(
        :data => data_class.all.map{ |r| attrs.inject({}){|hsh,a| hsh.merge(a.to_sym => r.send(a))}},
        :attrs => attrs.map{|a| a.camelize(:lower)},
        :item_tpl => sup[:item_tpl].gsub(/\{(\w+)\}/){|m| m.camelize(:lower)},
        :sort_attr => (sup[:sort_attr] || attrs.first).to_s.camelize(:lower)
      )
    end

    protected

      def extract_attrs(config)
        config[:item_tpl].scan(/\{(\w+)\}/).map{ |m| m.first }
      end
  end
end
