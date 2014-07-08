require 'spec_helper'
describe "User pages" do
	
  subject{page}
  describe "signup page" do
  
  	before { visit signup_path }
  
    it {should have_content('Sign Up')}
    it {should have_title(full_title('Sign'))}
    end
  describe "profile page" do 
    let(:user) {FactoryGirl.create(:user)}
  	before{visit user_path(user)}
    it { should have_content(user.name)}
  	it { should have_title(user.name)}
  	it { should have_content(user.email)}
    it { should have_gravata()}
  end
  
  describe "sign up" do
    before{visit signup_path}
    let(:submit) {"Create my account"}
      describe "Invalid creation" do
        it "should not create account of user" do
        expect(click_button sumbit).not_to change(User, :count)
      end
      end  
      describe "Valid creation" do
        before do
          fill_in "Name", wiht: "Rishabh Wadhawan"
          fill_in "Email", wiht: "fire.blackfire@gmail.com"
          fill_in "Password", wiht: "Rishabh"
          fill_in "Confirmation", wiht: "Rishabh"
        end 
        it "should create a valid user" do
          expect {click_button submit}.to change(User, :count).by(1)
        end
      end
      end
end