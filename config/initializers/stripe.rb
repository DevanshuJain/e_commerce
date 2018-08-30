Rails.configuration.stripe = {
  :publishable_key => 'pk_test_ucsmsanPmsgBU5Qfi5JOGD5z',
  :secret_key      => 'sk_test_bYMqAlyqSAsYYgROj9JlJzlv'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]