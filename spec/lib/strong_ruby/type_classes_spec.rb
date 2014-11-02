require 'spec_helper'

describe Or do

  it 'returns true if matched one of some class' do
    expect(Or[Fixnum, Float] === 1).to eq true
  end

  it 'returns true if matched one of some class' do
    expect(Or[Fixnum, Float] === 2.5).to eq true
  end  

  it 'returns false if no classes matched' do
    expect(Or[Fixnum, Float] === '1').to eq false
  end

end


describe Pos do
  it 'returns true if matched value is positive' do
    expect(Pos === 1).to eq true
  end

  it 'returns false if matched value is negative' do
    expect(Pos === -1).to eq false
  end

end

describe Neg do
  it 'returns true if matched value is negative' do
    expect(Neg === -1).to eq true
  end

  it 'returns false if matched value is positive' do
    expect(Neg === 1).to eq false
  end
end

describe And do

  it 'returns true if matched all of classes' do
    expect(And[Fixnum, Pos] === 1).to eq true
  end

  it 'returns false if matched not all of classes' do
    expect(And[Fixnum, Pos] === -1).to eq false
  end

end