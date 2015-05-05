module Base
  class ConversationsController < BaseController
    DEFAULT_SUBJECT = 'new message'

    skip_before_action :set_location_for_js
    before_action :set_mailbox
    before_action :set_recipient, only: [:new, :create]
    before_action :set_conversation, only: [:show, :update, :destroy]
    before_action :set_new_message, only: [:show, :new]

    def index
      @conversations = @mailbox.conversations.participant(current_user).merge(Mailboxer::Receipt.not_deleted)
    end

    def show
      @conversation.mark_as_read(current_user) if @conversation.is_unread?(current_user)
      @messages = @conversation.messages.order(created_at: :asc)
    end

    def new
    end

    def create
      @conversation = current_user.conversation_with(@recipient)
      if @conversation.present?
        current_user.reply_to_conversation(@conversation, message_body)
      else
        current_user.send_message(@recipient, message_body, DEFAULT_SUBJECT)
      end
      redirect_to base_public_profile_path(@recipient.profile), notice: t('conversations.success')
    end

    def update
      current_user.reply_to_conversation(@conversation, message_body)
      redirect_to action: :show
    end

    def destroy
      @conversation.mark_as_deleted(current_user)
      redirect_to action: :index
    end

    private

    def set_mailbox
      @mailbox = current_user.mailbox
    end

    def set_recipient
      @recipient = User.find(params[:recipient_id])
    end

    def set_conversation
      @conversation = @mailbox.conversations.find(params[:id])
    end

    def set_new_message
      @message = Mailboxer::Message.new
    end

    def message_body
      params.fetch(:message, {})[:body]
    end
  end
end
