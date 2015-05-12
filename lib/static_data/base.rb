module StaticData
  class Base
    class << self
      def producing_type
        {
          artist: 'Artist',
          musicians: 'Musicians',
          djs: 'Djs'
        }
      end

      def producing_var
        {
          all: 'All',
          concerts: 'Concerts',
          djs: 'Djs',
          tv: 'Tv',
          events: 'Events',
          radio: 'Radio'
        }
      end

      def producing_skill
        {
          novice: '1 - 3 years',
          mid: '3 - 5 years',
          profi: '5 - 10 years'
        }
      end

      def song_type
        {
          top: 'Top',
          featured: 'Featured',
          new: 'New'
        }
      end
    end
  end
end
