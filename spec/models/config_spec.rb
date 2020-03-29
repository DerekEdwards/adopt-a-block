require 'rails_helper'

RSpec.describe Config, type: :model do
  let!(:color_config) { FactoryBot.create :config}

  it { should respond_to :key }
  it { should respond_to :value }

  it 'handles a missing config' do 
    expect(Config.bad_one).to eq nil
  end

  it 'handles a missing config' do 
    expect(Config.favorite_color).to eq "blue"
  end

  it 'creates a new config' do
    Config.new_one = "new one"
    expect(Config.new_one).to eq "new one"
  end

  it 'updates a config' do
    expect(Config.favorite_color).to eq "blue"
    Config.favorite_color = "green"
    expect(Config.favorite_color).to eq "green"
  end

end
