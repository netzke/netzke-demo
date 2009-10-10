# Netzke global configuration

# Ext 3.0 doesn't provide filters
Netzke::GridPanel.configure :column_filters_available, false

# Netzke::GridPanel.configure :extended_search_available, false

Netzke::GridPanel.configure :default_config => {:persistent_config => true}
Netzke::FormPanel.configure :default_config => {:persistent_config => true}