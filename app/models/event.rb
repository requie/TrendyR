class Event < ActiveRecord::Base
  include Ownable
  include Locationable
end
