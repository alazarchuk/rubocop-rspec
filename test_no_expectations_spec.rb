xit "handle a failure by stopping session" do
end

it 'notifies via email' do
  #email.body.to_s.strip.should_not be_empty
end

it 'notifies via email' do
  email.body.to_s.strip.should_not be_empty
end

it 'should update order suffix for repo after create new session' do
  expect(repo.latest_session.should).to eq(session)
end

it 'should call update_commit_status using github installation if account does not have active github owner' do
  GithubInstallation.any_instance.should_receive(:update_commit_status).with(options).and_return({})
end

it 'should_receive call update_commit_status using github installation if account does not have active github owner' do
  foo
end

it '#simple delta equals delta' do
  expect(@params[:simple]).to eq(@params[:delta])
end
it 'is do' do
 puts 'hello'
end
