module Guest
  # Guest controller is a parent class for all controllers under Guest module
  # Do not add any actions to it, extend each controller under Guest module with it
  class GuestController < ApplicationController
    layout 'guest'
  end
end
