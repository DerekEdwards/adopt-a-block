require 'rails_helper'

RSpec.describe Neighborhood, type: :model do

  let(:my_neighborhood) { FactoryBot.create :neighborhood }
  let(:my_neighborhood_with_block) { FactoryBot.create :neighborhood_with_block }
  let(:user) { FactoryBot.create :user }
  let(:user2) { FactoryBot.create :user2 }
  let!(:admin) { FactoryBot.create :admin }

  it { should respond_to :name }
  it { should respond_to :followers }
  it { should respond_to :published }
  it { should respond_to :adopted_chart }
  it { should respond_to :year_chart }
  it { should respond_to :busiest_chart }

  it 'is named Basic Neighorbood' do
    expect(my_neighborhood.name).to eq("Basic Neighborhood")
  end 

  it 'generates a map hash' do
    my_neighborhood_with_block.map_hash.each do |block_hash|
      expect(block_hash).to have_key(:adopted)
      expect(block_hash).to have_key(:polyline)
      expect(block_hash).to have_key(:color)
      expect(block_hash).to have_key(:content)
      expect(block_hash).to have_key(:center)
    end
  end

  it 'is creates a hash for its center' do 
    expect(my_neighborhood.center).to eq({lat: my_neighborhood.lat.to_f, lng: my_neighborhood.lng.to_f})
  end

  it 'adds a follower' do
    expect(my_neighborhood_with_block.followers.count).to eq(0)
    my_neighborhood_with_block.add_follower user 
    expect(my_neighborhood_with_block.followers.count).to eq(1)
  end

  it 'removes a follower' do
    expect(my_neighborhood_with_block.followers.count).to eq(0)
    my_neighborhood_with_block.add_follower user 
    expect(my_neighborhood_with_block.followers.count).to eq(1)
    my_neighborhood_with_block.remove_follower user 
    expect(my_neighborhood_with_block.followers.count).to eq(0)
  end

  it 'knows how to generate a mailing list' do 
    # Initially there are not followers
    expect(my_neighborhood_with_block.mailing_list.count).to eq(0)
    
    # One of the blocks is adopted
    block = my_neighborhood_with_block.blocks.first 
    block.adopt(user2, false)
    expect(my_neighborhood_with_block.mailing_list.count).to eq(1)
     expect(my_neighborhood_with_block.mailing_list).to include(user2)
    
    # A Follower is added
    my_neighborhood_with_block.add_follower user 
    expect(my_neighborhood_with_block.mailing_list).to include(user)
    expect(my_neighborhood_with_block.mailing_list).to include(user)
    expect(my_neighborhood_with_block.mailing_list.count).to eq(2)
  end

  it 'can have blocks' do
    expect(my_neighborhood.blocks.count).to eq(0)
    expect(my_neighborhood_with_block.blocks.count).to eq(1)
  end

end
