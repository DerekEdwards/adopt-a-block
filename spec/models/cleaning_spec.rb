require 'rails_helper'

RSpec.describe Cleaning, type: :model do

  let(:my_neighborhood) { FactoryBot.create :neighborhood }
  let(:my_block) { FactoryBot.create(:block, neighborhood: my_neighborhood) }
  let(:cleaning_yesterday) { FactoryBot.create(:cleaning, block: my_block, time: (Time.now - 1.days)) }
  let(:cleaning_now) { FactoryBot.create(:cleaning, block: my_block, time: (Time.now)) }
  let(:cleaning_3_days_ago) { FactoryBot.create(:cleaning, block: my_block, time: (Time.now - 3.days), created_at: (Time.now - 2.days)) }
  
  it { should respond_to :note }
  it { should respond_to :time }
  it { should respond_to :days_since_cleaned }
  it { should respond_to :editable? }
  it { should respond_to :days_since_cleaned}
  it { should respond_to :block}

  it 'know how many days ago it was cleaned' do
    expect(cleaning_now.days_since_cleaned).to eq("cleaned today")
    expect(cleaning_yesterday.days_since_cleaned).to eq("cleaned yesterday")
    expect(cleaning_3_days_ago.days_since_cleaned).to eq("cleaned 3 days ago")
  end

  it 'knows if it is editable' do
    expect(cleaning_now.editable?).to eq true
    expect(cleaning_yesterday.editable?).to eq true
    expect(cleaning_3_days_ago.editable?).to eq false
  end

end
