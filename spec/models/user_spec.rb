require 'rails_helper'

RSpec.describe User, type: :model do

  let(:my_neighborhood) { FactoryBot.create :neighborhood }
  let(:user) { FactoryBot.create :user }
  
  it { should respond_to :admin }
  it { should respond_to :blocks }
  it { should respond_to :events }
  it { should respond_to :neighborhoods }

  it 'follows a neighborhood' do
    expect(user.neighborhoods.count).to eq 0
    user.follow my_neighborhood
    expect(user.neighborhoods.count).to eq 1
  end

  it 'unfollows a neighborhood' do
    expect(user.neighborhoods.count).to eq 0
    user.follow my_neighborhood
    expect(user.neighborhoods.count).to eq 1
    user.unfollow my_neighborhood
    expect(user.neighborhoods.count).to eq 0
  end

  it 'checks to see if it follows a neighborhood' do
    expect(user.follows?(my_neighborhood)).to eq false
    user.follow my_neighborhood
    expect(user.follows?(my_neighborhood)).to eq true
  end

end
