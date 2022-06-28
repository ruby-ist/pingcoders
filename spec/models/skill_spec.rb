require 'rails_helper'

RSpec.describe Skill, type: :model do
    let(:skill) { Skill.create(name: "Ruby on Rails") }
    let(:user) { User.create(email: "srira@gmail.com", password: "1234567") }

    it "has users" do
        expect(skill.users).to be_empty
    end

    it "can belong" do
        skill.users << user
        skill = Skill.first
        expect(skill.users).not_to be_empty
    end

    it "remains" do
        skill.users << user
        user.destroy
        skill = Skill.first
        expect(skill.users).to be_empty
        expect(User.first).to be_nil
    end
end
