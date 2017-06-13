require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'validations' do
      it { should validate_presence_of(:task) }
    end
end
