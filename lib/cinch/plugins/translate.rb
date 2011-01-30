require 'cinch'
require 'to_lang'

module Cinch
  module Plugins
    class Translate
      include Cinch::Plugin

      match %r{t (.+?) (.+)},              :method => :translate
      match %r{tf (.+?) (.+?) (.+)},       :method => :translate_from
      match "languages?",                  :method => :languages
      match %r{codemap (.+)},              :method => :codemap
      match "auto_translate",              :method => :auto_translate
      match %r{auto\_translate to (.+)},   :method => :auto_to
      match %r{auto\_translate from (.+)}, :method => :auto_from

      listen_to :channel

      def initialize(*args)
        super
        @auto = config[:auto] || false
        @from = config[:from] || nil
        @to   = config[:to]   || 'en'
        ::ToLang.start config[:api_key]
      end

      def listen(m)
        return if m.message =~ /^!/ # ignore any commands
        if @auto
          if @from
            translation = m.message.translate(@to, :from => @from) rescue "That's not a valid language."
          else
            translation = m.message.translate(@to) rescue "That's not a valid language."
          end
          m.reply "#{m.user.nick}: #{translation}"
        end
      end

      def auto_translate(m)
        msg = (@auto = !@auto ? "on" : "off")
        m.reply "Auto Translate is #{msg}"
      end

      def auto_to(m, lang)
        m.reply "To Language set to #{@to = lang}"
      end

      def auto_from(m, lang)
        @from = (lang == 'auto' ? nil : lang)
        m.reply "From Language set to #{lang}"
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
