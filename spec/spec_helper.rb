require 'pry'
require 'wechatpay'


Wechatpay.configure do |w|
  w.payment_key = 'test_key'
end
