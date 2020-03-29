require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:my_neighborhood) { FactoryBot.create :neighborhood }
  let(:user) { FactoryBot.create :user }
  let(:my_event) { FactoryBot.create(:event, neighborhood: my_neighborhood, user: user) }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :location_description }
  it { should respond_to :event_date}
  it { should respond_to :start_time}
  it { should respond_to :end_time}
  it { should respond_to :user}
  it { should respond_to :neighborhood }
  it { should respond_to :canceled}

  it 'knows its duration' do
    expect(my_event.duration).to eq("10:00 AM to 11:00 AM")
  end

end
