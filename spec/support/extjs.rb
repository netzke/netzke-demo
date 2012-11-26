module Extjs
  def panel_with_title(title)
    page.driver.browser.execute_script(<<-JS)
      // return Ext.ComponentQuery.query('panel[title="#{title}""]')[0];
      return (Ext.ComponentQuery.query('panel[title="#{title}"]')[0] || {}).id;
    JS
  end

  def select_tree_node(text)
    page.driver.browser.execute_script(<<-JS)
      var tree = Ext.ComponentQuery.query('treepanel')[0];
      var r = tree.getRootNode().findChild('text', '#{text}', true);
      tree.getSelectionModel().select(r);
    JS
  end
end
