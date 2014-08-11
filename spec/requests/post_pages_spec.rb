require 'spec_helper'

describe "PostPages" do
  
    subject { page }
    
  describe "Content page" do
    
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:post, user: user, title: "Prueba", content: "Foo") }
    let!(:m2) { FactoryGirl.create(:post, user: user, title: "Prueba2",content: "Bar") }
 

    before { visit posts_path }

    it { should have_title(full_title('Content')) }

    describe "posts" do
      it { should have_content(m1.user.name) }
      it { should have_content(m2.user.name) }
      it { should have_content(m1.title) }
      it { should have_content(m2.title) }
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
    end
    
  end
  
  describe "post creation" do
    
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

  
    
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      
      before(:each) do
        fill_in 'post_title', with: "Prueba"
        fill_in 'post_content', with: "Lorem ipsum"
      end

      it "should create a post" do
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
      
    end
    
  end
  
  describe "post destruction" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    
    before { FactoryGirl.create(:post, user: user) }

    describe "as correct user from content" do
      before { visit content_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
 
     describe "as correct user from home" do
      before { visit root_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
 
  end
  
end
