module Touch
  class SimpleList < Netzke::Base
    js_base_class "Ext.List"

    js_mixin :main

    # What this method returns, is going to be used as configuration for the
    # JavaScript instance of our component (thus, accessible in the `initComponent` method)
    def configuration
      sup = super

      # extract model attributes that participate in the list
      attrs = extract_attrs(sup)

      # model's class
      data_class = sup[:model].constantize

      sup.merge(
        # For simplicity, we'll be fetching all records
        :data => data_class.all.map{ |r| attrs.inject({}){|hsh,a| hsh.merge(a.to_sym => r.send(a))}},

        # While not necessary, I like to camelize the attribute names so that they read
        # more naturally in JavaScript
        :attrs => attrs.map{|a| a.camelize(:lower)},

        # Same here: "Name: {last_name}" => "Name: {lastName}"
        :item_tpl => sup[:item_tpl].gsub(/\{(\w+)\}/){|m| m.camelize(:lower)},

        # Attribute used for sorting/grouping (defaults to the first found in the template)
        :sort_attr => (sup[:sort_attr] || attrs.first).to_s.camelize(:lower)
      )
    end

    protected
      # Extracts names of the attributes from the temalpate, e.g.:
      # "{last_name}, ${salary}" =>
      # ["last_name", "salary"]
      def extract_attrs(config)
        config[:item_tpl].scan(/\{(\w+)\}/).map{ |m| m.first }
      end
  end
end
