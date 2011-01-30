Cinch-Translate
===========

The Cinch Translate Plugin. Translate your messages via the Google
Translate API! 

Installation
---------------------

if you haven't already...

    $ gem install cinch
    
then install this gem.

    $ gem install cinch-translate

Installation and Setup
----------

#### Configuration ####

  * :api_key - Your Google Translate API Key
  * :to      - The language you want to translate to(using codemap key, this is for auto translate). default is 'en'
  * :from    - The language you want to tranlsate from(using codemap key, or can be set to auto to auto-discover). default is 'auto'
  * :auto    - turn auto translate on or off. default is off

#### Commands ####

  * !translate [codemap] [message]         - translate the given message to the language codemap 
  * !translate-from [from] [to] [message]      - translate from the given codemape to the to codemap
  * !languages?                    - List all the available languages
  * !codemap [language]            - return the codemap for the given language
  * !auto_translate                - toggle auto translate on or off
  * !auto_translate to [codemap]   - set the to language for auto translate 
  * !auto_translate from [codemap] - set the from language for auto translate
  
## Integration with Cinch ##

It's simple. follow the guide on cinch or do something like:
    
    # mybot.rb
    require 'cinch'
    require 'cinch/plugins/translate'

    bot = Cinch::Bot.new do
      configure do |c|
        c.server           = "irc.freenode.net"
        c.nick             = "cinch"
        c.channels         = ["#padrino"]
        c.plugins.plugins  = [Cinch::Plugins::Memo::Base]
        c.plugins.options[Cinch::Plugins::Translate][:api_key] = 'your_api_key"
        c.plugins.options[Cinch::Plugins::Translate][:to]      = 'fr'
        c.plugins.options[Cinch::Plugins::Translate][:from]    = 'en'
        c.plugins.options[Cinch::Plugins::Translate][:auto]    = true
      end

    end

    bot.start

Finally, run your bot.

    ruby -rubygems mybot.rb

And there you go!


TODO
-----

  * Maybe add bot as middleman in conversation
  * Come up with more cool ideas.



