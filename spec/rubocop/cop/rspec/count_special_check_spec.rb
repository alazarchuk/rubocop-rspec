# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::CountSpecialCheck do
  subject(:cop) { described_class.new }

  it 'registers an offense for count check' do
    expect_offense(<<-RUBY.strip_indent)
      it "should handle a page of results" do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In this example please use .count method for testing state that appeared as a result of some actions,not after some actions.
        expect(subscribers.count).to eq(2)
        
        expect(subscribers.count).to eq(2)
        expect(receivers.count).to eq(3)
        expect(subscribers.count).to eq(3)
        expect(subscribers.count).to eq(3)
        expect(subscribers.count).to eq(3)
      end
    RUBY
  end

  it 'registers no offense for non count inside block' do
    expect_no_offenses(<<-RUBY.strip_indent)
      it 'create new github installation and set github organization name' do
        expect { subject.perform }.to change { GithubInstallation.count }.by(1)
      end
    RUBY
  end

  it 'registers no offense for count that has corresponding count' do
    expect_no_offenses(<<-RUBY.strip_indent)
      it "should synchronize existing snapshots" do
        expect(Snapshot.count).to eq(0)
        Snapshot.foo
        expect(Snapshot.count).to eq(1)
      end
    RUBY
  end
end
