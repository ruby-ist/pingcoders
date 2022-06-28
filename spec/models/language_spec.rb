require 'rails_helper'

RSpec.describe Language, type: :model do
    let(:language) { Language.create(name: "Ruby") }

    it "has users" do
        expect(language.users).to be_empty
    end
end