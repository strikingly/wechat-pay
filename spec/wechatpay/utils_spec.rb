require 'spec_helper'

describe Wechatpay::Utils do
  let (:utils) { Wechatpay::Utils }
  let (:hash) { {a:1, b:'TEST'} }

  describe '.cdata_cell' do
    it 'doesnt convert number' do
      result = utils.cdata_cell(1)
      expect(result).to eq(1)
    end

    it 'wrap others' do
      result = utils.cdata_cell("TEST")
      expect(result).to eq('<![CDATA[TEST]]>')
    end
  end

  describe '.cdata' do
    it 'cdata a hash' do
      result = utils.cdata(hash)
      expect(result).to eq({a: 1, b: '<![CDATA[TEST]]>'})
    end

    it 'raise error when not a hash' do
      expect { utils.cdata("123") }.to raise_error ArgumentError
    end
  end

end
