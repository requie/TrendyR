module PaymentHelper
  CREDIT_CARDS = %w(express discover maestro mastercard visa)

  def credit_cards_list
    content_tag(:ul, class: 'payments clearfix') do
      CREDIT_CARDS.each do |credit_card|
        li_content = link_to(image_tag("pay/#{credit_card}.png"), 'javascript: void(0)', class: 'payments_link')
        concat content_tag(:li, li_content, class: 'payments_list')
      end
    end
  end
end
