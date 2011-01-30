require 'cinch'
require 'to_lang'

module Cinch
  module Plugins
    class Translate
      include Cinch::Plugin

      match %r{t (.+?) (.+)},        :method => :translate
      match %r{tf (.+?) (.+?) (.+)}, :method => :translate_from
      match "languages?",            :method => :languages
      match %r{codemap (.+)},        :method => :codemap

      def initialize(*args)
        super
        ::ToLang.start config[:api_key]
      end

      def translate(m, lang, message)
        translation = message.translate(lang) rescue "That's not a valid language."
        m.reply translation
      end

      def translate_from(m, from, to, message)
        translation = message.translate(to, :from => from) rescue "That's not a valid language."
        m.reply translation
      end

      def languages(m)
        m.reply ::ToLang::CODEMAP.keys.join(',')
      end

      def codemap(m, lang)
        code = ::ToLang::CODEMAP[lang] || 'No code exists for that language.'
        m.reply code
      end
    end
  end
end
