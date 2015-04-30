module Base
  class ConversationsController < ApplicationController
    layout 'base/main'

    before_action :authenticate_user!, :authorize_namespace!
    before_action :set_profile
    before_filter :set_mailbox

    def index
      @conversations = @mailbox.conversations
    end

    def show
    end

    def new
    end

    def create
    end

    private

    def set_mailbox
      @mailbox = current_user.mailbox
    end

    def set_profile
      @profile = current_user.profile
    end

    def authorize_namespace!
      authorize :base, :access?
    end
  end
end
