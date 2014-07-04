require 'spec_helper'

describe User do
	before do
  	@user  = User.new(name: "Rishabh", email: "a@b.com", password: "rishabh1", password_confirmation: "rishabh1")
	end

subject{@user}
	it{should respond_to(:name)}
	it{should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it{should respond_to(:authenticate)}
	it{should be_valid}

describe "password not short" do
	before { @user.password = @user.password_confirmation = "a" * 5 }
	it{should be_invalid}
end

describe "user email should be downcase before saving" do
let(:any_case_email) {"A@b.com"}
it "should be converted to downcase" do
	@user.email = any_case_email
	@user.save
	expect(@user.reload.email).to eq any_case_email.downcase
end
end

describe "password authentication of user" do
	before{@user.save}
	let(:found_user) { User.find_by(email: @user.email)}
	describe "valid password of user" do
	it{ should eq found_user.authenticate(@user.password)}
	end
	describe"invalid password" do
	let(:invalid_password_user) { found_user.authenticate("invalid")}
	it {should_not eq invalid_password_user}
	it { expect(invalid_password_user).to be_false }
end
end

describe "When name is not present" do
	before{@user.name = " "}
	it {should_not be_valid}
end

describe "when password is not present" do
	before do
		@user = User.new(name: "Rishabh", email: "a@b.com", password: " ", password_confirmation: " ")
	it {should_not be_valid} 
end
end

describe "the password should match" do
	before{ @user.password_confirmation ="mismatch"}
it{should_not be_valid}
end

describe "When email not valid" do
 	before{@user.email = " "}
 	it {should_not be_valid}
end
describe " Limited name length of user" do
	before{ @user.name = "a"*31}
	it {should_not be_valid}
end
describe " Limited email length of user" do
	before{ @user.email = "a"*51}
	it {should_not be_valid}
end
describe "Emails are not valid" do
	it "should be invalid" do
	emailadd = %w[abc@a..com, afe@gae+afw, egE@aefa_qwdq]
	emailadd.each do |invalid_address|
	@user.email = invalid_address
	expect(@user).not_to be_valid
end
end
end
describe "Emails are valid" do
	it"should be valid" do
	emailadd = %w[efw@asd.com]
	emailadd.each do |valid_address|
	@user.email = valid_address
	expect(@user).to be_valid
end
end
end
describe "Unique emails" do
	before do
		user_with_same_email = @user.dup
		user_with_same_email.email = @user.email.upcase
		user_with_same_email.save
	end
	it {should_not be_valid}
end
end 