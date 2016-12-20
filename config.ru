require 'cowsay'

module Main
  module_function
  def call(env)
    req = Rack::Request.new(env)
    text = req.params['say']
    [200, {'Content-Type' => 'text/html'}, [say(text || 'say what?')]]
  end

  def say(text)
    <<-HTML
<pre>#{Cowsay.say(text, 'Cow')}</pre>
    HTML
  end
end
run Main
