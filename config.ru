require 'cowsay'
# Super simple wrapper around Cowsay gem
module Main
  module_function

  def call(env)
    req = Rack::Request.new(env)
    text = req.params['say'] || req.params['text'] || 'say what?!?'
    cow_said = say(text)
    cow_said = fence { cow_said } if req.path_info == '/slack'
    [200, { 'Content-Type' => 'text/plain' }, [cow_said]]
  end

  def fence
    %(```\n#{yield}\n```)
  end

  def say(text)
    Cowsay.say(text, 'Cow')
  end
end
run Main
