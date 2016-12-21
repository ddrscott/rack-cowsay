require 'cowsay'
require 'json'
# Super simple wrapper around Cowsay gem
module Main
  module_function

  def call(env)
    req = Rack::Request.new(env)
    text = req.params['say'] || req.params['text'] || 'say what?!?'
    cow_said = say(text)
    if req.path_info == '/slack'
      cow_said = slack { cow_said } 
      [200, { 'Content-Type' => 'application/json' }, [cow_said]]
    else
      [200, { 'Content-Type' => 'text/plain' }, [cow_said]]
    end
  end

  # # Sample Slack Request:
  #
  #     method=GET
  #     path="/slack?
  #     token=foo
  #     &team_id=T32SB8PNU
  #     &team_domain=foo
  #     &channel_id=D342PPTNF
  #     &channel_name=directmessage
  #     &user_id=bar
  #     &user_name=foo
  #     &command=%2Fcowsay
  #     &text=foobar
  #     &response_url=xyz
  def slack
    {
      response_type: 'in_channel',
      text: %(```\n#{yield}\n```) 
    }.to_json
  end

  def say(text)
    Cowsay.say(text, 'Cow')
  end
end
run Main
