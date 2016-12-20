require 'cowsay'

module Main
  module_function
  def call(env)
    req = Rack::Request.new(env)
    text = req.params['say'] || req.params['text'] || 'say what?!?'
    [200, {'Content-Type' => 'text/plain'}, [say(text)]]
  end

  def say(text)
    Cowsay.say(text, 'Cow')
  end
end
run Main
