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
    setup do
      @text.expects(:translate).with('en').returns('hello')
      @m.expects(:reply).with('hello').returns(true)
    end
    asserts 'that it translates' do
      base.new(@bot).translate(@m,'en',@text)
    end
  end

  context "#translate_from" do
    setup do
      @text.expects(:translate).with('fr',:from=>'en').returns('hello')
      @m.expects(:reply).with('hello').returns(true)
    end

    asserts 'that it translate from' do
      base.new(@bot).translate_from @m, 'en', 'fr', @textt
    end
  end

end
