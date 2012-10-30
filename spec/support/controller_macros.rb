module Rabel 
  module ControllerMacros
    def login_user(nickname_or_user)
      before(:each) do
        create(:user) # make sure the user is not root
        @request.env["devise.mapping"] = Devise.mappings[:user]
        if nickname_or_user.is_a? Symbol
          user = FactoryGirl.create(:user, :nickname => nickname_or_user.to_s)
        else
          user = nickname_or_user
        end
        # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
        sign_in user
      end
    end

    def login_admin(nickname_or_user)
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        if nickname_or_user.is_a? Symbol
          user = FactoryGirl.create(:admin, :nickname => nickname_or_user.to_s)
        else
          user = nickname_or_user
        end
        # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
        sign_in user
      end
    end

    def login_as_root
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        root = FactoryGirl.create(:root)
        sign_in root
      end
    end
  end
end
