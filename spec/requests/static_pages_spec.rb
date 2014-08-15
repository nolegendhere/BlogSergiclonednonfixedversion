require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Blog Sergi') }
    it { should have_title(full_title('Home')) }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:admin) }
      before do
        FactoryGirl.create(:post, user: user, title: "Prueba", content: "Lorem ipsum")
        FactoryGirl.create(:post, user: user, title: "Prueba2", content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        #save_and_open_page
        user.feed.each do |item|
          expect(page).to have_content(item.content)
        end
      end
    end
  end
  
end


