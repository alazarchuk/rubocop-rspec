# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::EmptyExample do
  subject(:cop) { described_class.new }

  it 'registers an offense for empty example with no body' do
    expect_offense(<<-RUBY.strip_indent)
      it 'is empty'
      ^^^^^^^^^^^^^ Empty example detected.
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
