require 'spec_helper'

describe MakeMeAGemCalled do

  let(:gem){MakeMeAGemCalled.new("test_gem")}

  it 'should take a name when created' do
    expect(gem.name).to eq 'test_gem'
  end

  it 'should not create without a name passed' do
    expect{MakeMeAGemCalled.new}.to raise_error(ArgumentError)
  end

end