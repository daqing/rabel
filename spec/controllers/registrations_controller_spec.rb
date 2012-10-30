require 'spec_helper'

describe RegistrationsController do
  it { should extend_the_controller(Devise::RegistrationsController) }
end
