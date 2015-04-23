class SongPolicy
  attr_reader :user, :song

  def initialize(user, song)
    @user = user
    @song = song
  end

  def destroy?
    song.uploaded_by?(user)
  end
end
