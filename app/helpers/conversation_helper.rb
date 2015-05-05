module ConversationHelper
  def message_time(time)
    format = time.today? ? :time : :dotted
    time.to_s(format)
  end

  def message_sender(sender)
    if sender == current_user
      'Me'
    else
      sender.first_name
    end
  end

  def message_class(message)
    message.sender == current_user ? 'messageMe' : 'messageUser'
  end

  def last_message_class(message)
    message.is_unread?(current_user) ? 'newMessage' : 'message'
  end
end
