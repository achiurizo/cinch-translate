require 'cinch'
require 'to_lang'

module Cinch
  module Plugins
    class Translate
      include Cinch::Plugin

      def initialize(*args)
        ToLang.start(config[:api_key])
      end

      match %r{t (.+?) (.+)},        :method => :translate
      match %r{tf (.+?) (.+?) (.+)}, :method => :translate_from

      def translate(m, lang, message)
        m.reply message.translate(lang)
      end

      def translate_from(m, from, to, message)
        m.reply message.translate(to, :from => from)
      end

    end
  end
end
