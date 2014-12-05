class Gig < ActiveRecord::Base
  include Ownable
  include Locationable
end
