class Category < ActiveRecord::Base
  ALL = {"gigs" => ["Live", "Licensing", "Contest"],
         "producers" => ["Artist", "Musician", "Featured", "Band"],
         "music" => ["Artist", "Musician", "Band"],
         "events" => ["Concert", "Event", "Festivel"],
         "venues" => ["Concert", "Event", "Festivel"],
         "labels" => ["Artist", "Musician", "Djs"],
         "managers" => ["Artist", "Musician", "Djs"] }

  has_many :category_categorizable
  has_many :categorizable, through: :category_categorizable, source_type: "Categorizable"
end
