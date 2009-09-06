require 'faker'
class GridPanelController < ApplicationController
  WIDGETS = %w{ bosses clerks bosses_custom_columns bosses_with_permissions configurable_clerks }
  
  netzke :bosses, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss'

  netzke :bosses_custom_columns, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss', 
    :ext_config => {
      :title => "Bosses",
      :width => 400
    },
    :columns => [:id, # id should always be included and is by default hidden
      :last_name, 
      {:name => :salary, :read_only => true, :label => "$", :renderer => 'usMoney'}, 
      {:name => :email, :width => 180}]

  netzke :clerks, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Clerk'
  
  netzke :bosses_with_permissions, 
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Boss', 
    :ext_config => {
      :prohibit_update => true,
      :prohibit_delete => true
    }
  
  netzke :configurable_clerks, :widget_class_name => "Wrapper", :item => {
    :widget_class_name => "GridPanel", 
    :data_class_name => 'Clerk',
    :persistent_config => true,
    :ext_config => {
      :mode => :config, # here we enable the configuration mode
      :title => "Configurable clerks"
    }
  }
  
  def demo
    @widgets = WIDGETS
  end
  
  def index
    redirect_to :action => "demo"
  end
  
  def regenerate_test_data
    number_of_bosses = 50
    
    Boss.delete_all
    bosses_ids = []
    number_of_bosses.times do
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
        :boss_id => bosses_ids[rand(number_of_bosses)],
        :first_name => first_name,
        :last_name => Faker::Name.last_name,
        :email => email,
        :salary => (rand(10)+1)*1000,
        :subject_to_lay_off => rand > 0.8,
        :created_at => 15.minutes.ago,
        :updated_at => 15.minutes.ago
      })
    end
    
    redirect_to :action => "demo"
  end

  def reset_configs
    # only delete preferences for the grid demo
    WIDGETS.each{ |widget| NetzkePreference.delete_all("widget_name LIKE '#{widget}%'") }
    redirect_to :action => "demo"
  end
end
