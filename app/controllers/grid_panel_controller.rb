require 'faker'
class GridPanelController < ApplicationController
  netzke :bosses, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss', 
    :ext_config => {
      :rows_per_page => 20
    }

  netzke :bosses_custom_columns, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss', 
    :ext_config => {
      :rows_per_page => 20, 
      :title => "Bosses",
      :width => 400
    },
    :columns => [:id, # id should always be included and is by default hidden
      :last_name, 
      {:name => :salary, :read_only => true, :label => "$", :renderer => 'usMoney'}, 
      {:name => :email, :width => 180}]

  netzke :clerks, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Clerk', 
    :ext_config => {
      :rows_per_page => 50
    }
  
  netzke :bosses_with_permissions, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss', 
    :prohibit => [:delete, :update],
    :ext_config => {
      :rows_per_page => 20, 
      :title => "Bosses"
    }
  
  netzke :clerks_with_config_tool, :widget_class_name => "Wrapper", :item => {
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Clerk', 
    :ext_config => {
      :rows_per_page => 50,
      :title => "Clerks",
      :config_tool => true # enable the configuration tool
    }}
  
  def demo
    @widgets = %w{ bosses clerks bosses_custom_columns bosses_with_permissions clerks_with_config_tool }
  end
  
  def index
    redirect_to :action => "demo"
  end
  
  def regenerate_test_data
    Boss.delete_all
    bosses_ids = []
    50.times do
      first_name = Faker::Name.first_name
      email = "#{first_name.downcase}@#{Faker::Internet.email.split("@").last}"
      a_boss = Boss.create({
        :first_name => first_name,
        :last_name => Faker::Name.last_name,
        :email => email,
        :salary => (rand(10)+1)*10000
      })
      bosses_ids << a_boss.id
    end
    
    
    Clerk.delete_all
    200.times do
      first_name = Faker::Name.first_name
      email = "#{first_name.downcase}@#{Faker::Internet.email.split("@").last}"
      Clerk.create({
        :boss_id => bosses_ids[rand(50)],
        :first_name => first_name,
        :last_name => Faker::Name.last_name,
        :email => email,
        :salary => (rand(10)+1)*1000,
        :subject_to_lay_off => rand > 0.8
      })
    end
    
    redirect_to :action => "demo"
  end

  def reset_columns
    NetzkeLayout.delete_all
    NetzkeGridPanelColumn.delete_all
    redirect_to :action => "demo"
  end

  def reset_configs
    NetzkePreference.delete_all
    redirect_to :action => "demo"
  end
end
