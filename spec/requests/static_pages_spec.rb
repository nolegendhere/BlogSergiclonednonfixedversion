require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Blog Sergi'" do
      visit '/static_pages/home'
      expect(page).to have_content('Blog Sergi')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Blog Sergi | Home")
    end

  end
  
end


