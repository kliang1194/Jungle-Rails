require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe 'Validations' do

    it 'should save if user fields are valid' do 
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(@user).to be_present
    end

    it 'should fail if password and password confirmation do not match' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '654321'
      })

      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should fail if the password is empty' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => nil,
        :password_confirmation => '123456'
        })

      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should fail if the email is empty' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => nil,
        :password => '123456',
        :password_confirmation => '123456'
        })

      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should fail if the first name is empty' do
      @user = User.new({
        :first_name => nil,
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
  
    it 'should fail if the last name is empty' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => nil,
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
        })

      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    
    it 'should fail if the password is too short' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123',
        :password_confirmation => '123'
        })

      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    
  end

  describe '.authenticate_with_credentials' do
    it 'should log in a user given correct credentials' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it 'should not log in a user with an incorrect email' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(User.authenticate_with_credentials('incorrect@example.com', @user.password)).to eq(nil)
    end

    it 'should not log in a user with an incorrect password' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(User.authenticate_with_credentials(@user.email, '1234567')).to eq(nil)
    end

    it 'should log in a user with correct credentials but with white spaces around the email' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })

      @user.save
      expect(User.authenticate_with_credentials('  kyle.liang@example.com  ', @user.password)).to eq(@user)
    end

    it 'should log in a user with correct credentials but varied cases in the email' do
      @user = User.new({
        :first_name => 'Kyle',
        :last_name => 'Liang',
        :email => 'kyle.liang@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })
      
      @user.save
      expect(User.authenticate_with_credentials('kyLe.LiANg@examPLe.com', @user.password)).to eq(@user)
    end
  end
end

