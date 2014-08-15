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
    
    let(:user) { FactoryGirl.create(:admin) }
    before { sign_in user }

  
    
    before { visit root_path }

    describe "with invalid information" do
      
      it "should not create a post" do
        #save_and_open_page
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        
        before { click_button "Post" }
          it "blank" do
            #save_and_open_page
            should have_content('error')
         end
      end
    end

    describe "with valid information" do
      
      before(:each) do
        fill_in 'post_title', with: "Prueba"
        fill_in 'post_content', with: "Lorem ipsum"
      end

      it "should create a post" do
        #save_and_open_page
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
      
    end
    
  end
  
  describe "post destruction" do
    let(:user) { FactoryGirl.create(:user) }
    #before { sign_in user }
    
    before { FactoryGirl.create(:post, user: user) }
    
    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before {sign_in admin}
      
      describe "from home" do
        before { visit root_path }

        it "should delete a post" do
          #save_and_open_page
           
          #render partial: 'folder/feed_item'
          p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
          p admin?(admin)
          p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
          expect { click_link "delete", match: :first}.to change(Post, :count).by(-1)
        end
      end
      
      
      describe "from content" do
        before { visit posts_path }
  
        it "should delete a post" do
          expect { click_link "delete", match: :first}.to change(Post, :count).by(-1)
        end
      end
    end

    #describe "as correct user from content" do
      #before { visit content_path }

      #it "should delete a post" do
        #expect { click_link "delete" }.to change(Post, :count).by(-1)
      #end
    #end
 
     #describe "as correct user from home" do
      #before { visit root_path }

      #it "should delete a post" do
        #expect { click_link "delete" }.to change(Post, :count).by(-1)
      #end
    #end

  end
  
  describe "post editing" do
    
    
    let(:user) { FactoryGirl.create(:user) }
    let(:another) { FactoryGirl.create(:user) }
    before { FactoryGirl.create(:post, user: user) }
    
    
    
    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:post) { FactoryGirl.create(:post) }
      before do
         sign_in admin
         visit edit_post_path(post)
      end
      
      describe "user is admin" do
        subject { admin }
        it { should be_admin }
        it { should_not be_coadmin }
      end
      
      describe "user user is not admin" do
        subject { user }
        it { should_not be_admin }
        it { should_not be_coadmin }
      end
      
      describe "another user is not admin" do
        subject { another }
        it { should_not be_admin }
        it { should_not be_coadmin }
      end
      
      
      
      describe "page" do
          
        it { should have_content("Update Post") }
        it { should have_title("Edit Post") }
      end
      
      describe "with invalid information" do
        let(:new_title)  { "" }
        let(:new_content) { "" }
        before do
          fill_in "Title",            with: new_title
          fill_in "Content",          with: new_content
          click_button "Save changes"
        end
  
        it { should have_content('error') }
      end
      
      describe "with valid information" do
        let(:new_title)  { "New Name" }
        let(:new_content) { "New Content" }
        before do
          fill_in "Title",            with: new_title
          fill_in "Content",          with: new_content
          click_button "Save changes"
        end
  
        #it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { expect(post.reload.title).to  eq new_title }
        specify { expect(post.reload.content).to eq new_content }
      end
      
      
      describe "from home" do
        
        before { visit root_path }
        
        it "should edit a post" do
          #save_and_open_page
          p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
          p admin?(admin)
          p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
          expect { click_link "edit", match: :first}.not_to change(Post, :count)
        end
      end
      
      describe "from content" do
        before { visit posts_path }
  
        it "should edit a post" do
          expect { click_link "edit", match: :first }.not_to change(Post, :count)
        end
      end
      
      
    end
    
  end
  
  
  
  
end
