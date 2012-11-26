require 'spec_helper'

describe Application, :type => :request, :js => true do
  it "should display navigation panel" do
    visit "/components/Application"
    panel_with_title("Navigation").should_not be_nil
  end
end
