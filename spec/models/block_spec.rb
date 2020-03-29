require 'rails_helper'

RSpec.describe Block, type: :model do

  let(:my_neighborhood) { FactoryBot.create :neighborhood }
  let(:my_block) { FactoryBot.create(:block, neighborhood: my_neighborhood) }
  let(:user) { FactoryBot.create :user }
  
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :neighborhood }
  it { should respond_to :polyline }
  it { should respond_to :user }
  it { should respond_to :adoption_expiration }
  it { should respond_to :adopted_since }
  it { should respond_to :adopted_description }
  it { should respond_to :content }
  it { should respond_to :hex_color }
  it { should respond_to :center }

  it 'has a name' do
    expect(my_block.name).to eq("Basic Block")
  end 

  it 'can be cleaned' do
    now = Time.now 
    expect(my_block.cleanings.count).to eq(0)
    my_block.clean("Note", now)
    expect(my_block.cleanings.count).to eq(1)
    cleaning = my_block.cleanings.first
    expect(cleaning.note).to eq("Note")
    expect(cleaning.time.in_time_zone.to_s).to eq(now.in_time_zone.to_s)
  end 

  it 'knows its most recent cleaning' do
    last_week = Time.now - 7.days
    last_month = Time.now - 1.months
    my_block.clean("last_week", last_week)
    my_block.clean("now")
    my_block.clean("last_month", last_month)

    expect(my_block.cleanings.count).to eq(3)
    last_cleaning = my_block.last_cleaning
    expect(last_cleaning.note).to eq("now")
  end 

  it 'knows when it was last_cleaned' do
    last_week = Time.now - 7.days
    now = Time.now
    last_month = Time.now - 1.months
    my_block.clean("last_week", last_week)
    my_block.clean("now", now)
    my_block.clean("last_month", last_month)

    expect(my_block.cleanings.count).to eq(3)
    expect(my_block.last_cleaned.in_time_zone.to_s).to eq(now.in_time_zone.to_s)
  end 

  it 'knows if it was never cleaned' do
    expect(my_block.days_since_cleaned).to eq("Never cleaned.")
  end

  it 'can be adopted' do
    expect(my_block.adopted?).to eq(false)
    my_block.adopt user, false
    expect(my_block.adopted?).to eq(true)
  end

  it 'can be un-adopted' do
    expect(my_block.adopted?).to eq(false)
    my_block.adopt user, false
    expect(my_block.adopted?).to eq(true)
    my_block.unadopt
    expect(my_block.adopted?).to eq(false)
  end

  it 'knows when adoption expires' do
    now = Time.now
    my_block.adopt user, false
    sleep 5

    # With no cleanings, it expires 3 months after adoption.
    expect(my_block.end_of_adoption).to be < Time.now + 3.months 
    expect(my_block.end_of_adoption).to be > now + 3.months

    # Create an old cleaning
    my_block.clean("Last week", Time.now - 7.days)

    # With a cleaning older than adoption, we should expect the same end of adoption as before.
    expect(my_block.end_of_adoption).to be < Time.now + 3.months 
    expect(my_block.end_of_adoption).to be > now + 3.months

    # Create a future cleaning (this is weird but useful for testing)
    my_block.clean("Now", Time.now + 1.days)
    sleep 5

    # With a cleaning newer than adoption, we should expect the cleaning to extend the adoption period
    expect(my_block.end_of_adoption).to be > Time.now + 3.months 
    expect(my_block.end_of_adoption).to be < Time.now + 3.months + 1.days
  end

  it 'knows what color it should be' do 

    # Never Cleaned 
    expect(my_block.color).to eq "black"

    # Cleaned a year ago
    my_block.clean("", Time.now - 1.years)
    expect(my_block.color).to eq "black"

    # Cleaned 32 days ago
    my_block.clean("", Time.now - 32.days)
    expect(my_block.color).to eq "red"

    # Cleaned 22 days ago
    my_block.clean("", Time.now - 22.days)
    expect(my_block.color).to eq "orange"

    # Cleaned 12 days ago
    my_block.clean("", Time.now - 12.days)
    expect(my_block.color).to eq "yellow"

    # Cleaned 2 days ago
    my_block.clean("", Time.now - 2.days)
    expect(my_block.color).to eq "green"

  end


  it 'knows how many cleanings in the X days' do 

    # Never Cleaned 
    expect(my_block.cleanings_past_x_days(10)).to eq 0
    expect(my_block.cleanings_past_x_days(5)).to eq 0

    # Cleaned 7 days ago
    my_block.clean("", Time.now - 7.days)
    expect(my_block.cleanings_past_x_days(10)).to eq 1
    expect(my_block.cleanings_past_x_days(5)).to eq 0
    expect(my_block.cleanings_past_x_days(1)).to eq 0

    # Cleaned 2 days ago
    my_block.clean("", Time.now - 2.days)
    expect(my_block.cleanings_past_x_days(10)).to eq 2
    expect(my_block.cleanings_past_x_days(5)).to eq 1
    expect(my_block.cleanings_past_x_days(1)).to eq 0

    # Cleaned Just Now
    my_block.clean
    expect(my_block.cleanings_past_x_days(10)).to eq 3
    expect(my_block.cleanings_past_x_days(5)).to eq 2
    expect(my_block.cleanings_past_x_days(1)).to eq 1


  end

end
