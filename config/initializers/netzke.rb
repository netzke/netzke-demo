# Netzke global configuration
# Netzke::GridPanel.configure :default_config => {:ext_config => {:mode => :config}}
Netzke::GridPanel.configure :default_config => {:persistent_config => true}

# Ext 3.0 doesn't provide filters
Netzke::GridPanel.configure :column_filters_available => false

