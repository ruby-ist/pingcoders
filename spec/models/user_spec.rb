require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { User.create(email: "srira123@gmail.com", password: "1234567") }

    it "can be created without skills and languages" do
        expect(User.create(email: "srira@gmail.com", password: "1234567")).to be_instance_of User
    end

    it "has an empty skills array" do
        expect(user.skills).to be_empty
    end

    it "has an empty languages array" do
        expect(user.languages).to be_empty
    end

    it "has contact informations" do
        expect(user.addresses).to be_empty
        expect(user.numbers).to be_empty
        expect(user.emails).to be_empty
    end
end
