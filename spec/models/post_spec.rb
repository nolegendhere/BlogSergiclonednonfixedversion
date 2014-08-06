require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    #@post = Post.new(title: "Prueba", content: "Lorem ipsum", user_id: user.id)
    @post = user.posts.build(title:"Prueba",content: "Lorem ipsum") 
  end
  
  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @post.title = " " }
    it { should_not be_valid }
  end
end


