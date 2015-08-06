require 'rails_helper'

describe Cache, type: :model do

  subject { create :cach }

  it { should be_valid }

end
