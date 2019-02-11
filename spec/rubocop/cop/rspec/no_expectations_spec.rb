# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::NoExpectations do
  subject(:cop) { described_class.new }

  it 'registers an offense ' do
    expect_offense(<<-RUBY.strip_indent)
      it 'is empty' do
      ^^^^^^^^^^^^^^^^ Example has no expectations.
        foo
      end

    RUBY
  end

  it 'registers an offense for empty example with empty body' do
    expect_offense(<<-RUBY.strip_indent)
      it 'is empty' do
      ^^^^^^^^^^^^^^^^ Empty example detected.
      end
    RUBY
  end

  it 'registers no offense for non empty example' do
    expect_no_offenses(<<-RUBY.strip_indent)
      it 'is not empty' do
        expect(bacon.chunky?).to be_truthy
      end
    RUBY
  end
end
