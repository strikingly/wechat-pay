require 'spec_helper'

describe Wechatpay::Sign do
  let (:params) {
    {a:1, b:2}
  }
  let (:inversed_params) {
    {b:2, a:1}
  }
  let (:params_string) { "a=1&b=2&key=#{Wechatpay::Config.payment_key}" }

  describe "#md5" do
    it 'returns the same with different params order' do
      sign1 = Wechatpay::Sign.md5(params)
      sign2 = Wechatpay::Sign.md5(inversed_params)
      expect(sign1).to eq(sign2)
    end

    it 'signs the params with md5' do
      sign = Wechatpay::Sign.md5(params)
      expect(sign).to eq(Digest::MD5.hexdigest(params_string).upcase)
    end
  end
end
