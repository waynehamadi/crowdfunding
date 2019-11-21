require 'rails_helper'
RSpec.describe GetContributors, type: :transactions do
  subject { GetContributors.new.call(project_id: project.id) }
  let(:project) { FactoryBot.create(:project)  }

  context 'When the project has no contributor' do

    it 'the transaction fails' do
      expect(subject).to be_failure
    end
  end
  context 'When the project has 3 contributors' do
    before(:each) do
      FactoryBot.create_list(:contribution, 3, project: project)
    end

    it 'the transaction succeeds' do
      expect(subject).to be_success
    end

    it 'a csv file is created' do
       expect(File.exist?(subject.success[:filepath])).to be true
    end

    it 'the csv file has 4 lines ' do
      expect(File.readlines(subject.success[:filepath]).size).to be 4
    end
  end
end