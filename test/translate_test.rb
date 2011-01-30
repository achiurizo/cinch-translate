require File.expand_path('../teststrap',__FILE__)

context "Translate" do
  dont_register!
  setup { @bot = mock() }

  helper :base do
    Cinch::Plugins::Translate.any_instance.stubs(:config).returns({:api_key => '12345'})
    ToLang.expects(:start).with('12345').returns(true)
    Cinch::Plugins::Translate
  end

  context "#translate" do
    context "with language" do
      asserts 'that it translates' do
        @text.expects(:translate).with('en').returns('hello')
        @m.expects(:reply).with('hello').returns(true)
        base.new(@bot).translate(@m,'en',@text)
      end
    end

    context "with invalid language" do
      asserts 'that it returns a message' do
        @text.expects(:translate).with("baka").raises(RuntimeError)
        @m.expects(:reply).with("That's not a valid language.").returns(true)
        base.new(@bot).translate(@m, 'baka', @text)
      end
    end
  end

  context "#translate_from" do
    context "with language" do
      asserts 'that its translates' do
        @text.expects(:translate).with('fr',:from=>'en').returns('hello')
        @m.expects(:reply).with('hello').returns(true)
        base.new(@bot).translate_from @m, 'en', 'fr', @text
      end
    end

    context "with invalid langauge" do
      asserts 'that it returns a message' do
        @text.expects(:translate).with('baka').raises(RuntimeError)
        @m.expects(:reply).with("That's not a valid language.").returns(true)
      end
    end
  end

  context "#languages" do
  
    context "with no options" do
      asserts "that it shows list" do
        @m.expects(:reply).with(regexp_matches(/english/)).returns(true)
        base.new(@bot).languages @m
      end
    end
  end

  context "#codemap" do

    context "with language" do
      asserts "that it shows code" do
        @m.expects(:reply).with('en').returns(true)
        base.new(@bot).codemap @m, 'english'
      end
    end

    context "with no language" do
      asserts "that it shows message" do
        @m.expects(:reply).with('No code exists for that language.').returns(true)
        base.new(@bot).codemap @m, 'bakaaa'
      end
    end
  end
end
