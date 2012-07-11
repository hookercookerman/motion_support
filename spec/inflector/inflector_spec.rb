describe "Inflector" do

  it "should pluarlize 'pluarls'" do
    MotionSupport::Inflector.pluralize("plurals").should.equal("plurals")
    MotionSupport::Inflector.pluralize("Plurals").should.equal("Plurals")
  end

  it "should return empty string with empty string" do
    MotionSupport::Inflector.pluralize("").should.equal("")
  end

  MotionSupport::Inflector.inflections.uncountable.each do |word|
    it "should not puralize #{word}" do
      MotionSupport::Inflector.singularize(word).should.equal(word)
      MotionSupport::Inflector.pluralize(word).should.equal(word)
      MotionSupport::Inflector.singularize(word).should.equal(MotionSupport::Inflector.pluralize(word))
    end
  end

  it "uncountables should not be gready" do
    with_dup do
      uncountable_word = "ors"
      countable_word = "sponsor"

      MotionSupport::Inflector.inflections.uncountable << uncountable_word

      MotionSupport::Inflector.singularize(uncountable_word).should.equal(uncountable_word)
      MotionSupport::Inflector.pluralize(uncountable_word).should.equal(uncountable_word)
      MotionSupport::Inflector.singularize(uncountable_word).should.equal(MotionSupport::Inflector.pluralize(uncountable_word))
      MotionSupport::Inflector.singularize(countable_word).should.equal "sponsor"
      MotionSupport::Inflector.pluralize(countable_word).should.equal("sponsors")
      MotionSupport::Inflector.singularize(MotionSupport::Inflector.pluralize(countable_word)).should.equal("sponsor")
    end
  end

  InflectorTestCases::SingularToPlural.each do |singular, plural|
    it "Should pluralize singular #{singular}" do
      MotionSupport::Inflector.pluralize(singular).should.equal(plural)
      MotionSupport::Inflector.pluralize(singular.capitalize).should.equal(plural.capitalize)
    end
  end

  InflectorTestCases::SingularToPlural.each do |singular, plural|
    it "Should singularize plural #{plural}" do
      MotionSupport::Inflector.singularize(plural).should.equal(singular)
      MotionSupport::Inflector.singularize(plural.capitalize).should.equal(singular.capitalize)
    end
  end


  InflectorTestCases::SingularToPlural.each do |singular, plural|
    it "Should singularize singular #{singular}" do
      MotionSupport::Inflector.singularize(singular).should.equal(singular)
      MotionSupport::Inflector.singularize(singular.capitalize).should.equal(singular.capitalize)
    end
  end

  it "should overwite previous inflections" do
    MotionSupport::Inflector.singularize("series").should.equal("series")
    MotionSupport::Inflector.inflections.singular "series", "serie"
    MotionSupport::Inflector.singularize("series").should.equal("serie")
    MotionSupport::Inflector.inflections.uncountable "series" # return to normal
  end


  InflectorTestCases::MixtureToTitleCase.each do |before, titleized|
    it "should titelize_#{before}" do
      MotionSupport::Inflector.titleize(before).should.equal(titleized)
    end
  end

  describe ".camelize" do
    InflectorTestCases::CamelToUnderscore.each do |camel, underscore|
      it "should camelize #{camel}" do
        MotionSupport::Inflector.camelize(underscore).should.equal(camel)
      end
    end

    it "should camelize with underscores" do
      MotionSupport::Inflector.camelize('Camel_Case').should.equal("CamelCase")
    end

    it "shoudl camelize with lower downcases for the first letter" do
      MotionSupport::Inflector.camelize('Capital', false).should.equal("capital")
    end
  end

  describe "acronyms" do
    MotionSupport::Inflector.inflections do |inflect|
      inflect.acronym("API")
      inflect.acronym("HTML")
      inflect.acronym("HTTP")
      inflect.acronym("RESTful")
      inflect.acronym("W3C")
      inflect.acronym("PhD")
      inflect.acronym("RoR")
      inflect.acronym("SSL")
          ##  camelize             underscore            humanize              titleize
      [
        ["API",               "api",                "API",                "API"],
        ["APIController",     "api_controller",     "API controller",     "API Controller"],
        ["Nokogiri::HTML",    "nokogiri/html",      "Nokogiri/HTML",      "Nokogiri/HTML"],
        ["HTTPAPI",           "http_api",           "HTTP API",           "HTTP API"],
        ["HTTP::Get",         "http/get",           "HTTP/get",           "HTTP/Get"],
        ["SSLError",          "ssl_error",          "SSL error",          "SSL Error"],
        ["RESTful",           "restful",            "RESTful",            "RESTful"],
        ["RESTfulController", "restful_controller", "RESTful controller", "RESTful Controller"],
        ["IHeartW3C",         "i_heart_w3c",        "I heart W3C",        "I Heart W3C"],
        ["PhDRequired",       "phd_required",       "PhD required",       "PhD Required"],
        ["IRoRU",             "i_ror_u",            "I RoR u",            "I RoR U"],
        ["RESTfulHTTPAPI",    "restful_http_api",   "RESTful HTTP API",   "RESTful HTTP API"],

        # misdirection
        ["Capistrano",        "capistrano",         "Capistrano",       "Capistrano"],
        ["CapiController",    "capi_controller",    "Capi controller",  "Capi Controller"],
        ["HttpsApis",         "https_apis",         "Https apis",       "Https Apis"],
        ["Html5",             "html5",              "Html5",            "Html5"],
        ["Restfully",         "restfully",          "Restfully",        "Restfully"],
        ["RoRails",           "ro_rails",           "Ro rails",         "Ro Rails"]
      ].each do |camel, under, human, title|
        it "should camelize #{under} to equal #{camel}" do
          MotionSupport::Inflector.camelize(under).should.equal(camel)
        end
        it "should camelize #{camel} to equal #{camel}" do
          MotionSupport::Inflector.camelize(camel).should.equal(camel)
        end
        it "should underscore #{under} to equal #{under}" do
          MotionSupport::Inflector.underscore(under).should.equal(under)
        end
        it "should underscore #{camel} to equal #{under}" do
          MotionSupport::Inflector.underscore(camel).should.equal(under)
        end
        it "should titleize #{under} to equal #{title}" do
          MotionSupport::Inflector.titleize(under).should.equal(title)
        end
        it "should titleize #{camel} to equal #{title}" do
          MotionSupport::Inflector.titleize(camel).should.equal(title)
        end
        it "should humanize #{under} to equal #{human}" do
          MotionSupport::Inflector.humanize(under).should.equal(human)
        end
      end
    end
  end

  describe "acronym override" do
    MotionSupport::Inflector.inflections do |inflect|
      inflect.acronym("API")
      inflect.acronym("LegacyApi")
    end

    it "should camelize 'legacyapi' to be 'LegacyApi'" do
      MotionSupport::Inflector.camelize("legacyapi").should.equal("LegacyApi")
    end

    it "should camelize 'legacy_api' to be 'LegacyAPI'" do
      MotionSupport::Inflector.camelize("legacy_api").should.equal("LegacyAPI")
    end

    it "should camelize 'legacy_api' to be 'LegacyAPI'" do
      MotionSupport::Inflector.camelize("some_legacyapi").should.equal("SomeLegacyApi")
    end

    it "should camelize 'legacy_api' to be 'LegacyAPI'" do
      MotionSupport::Inflector.camelize("nonlegacyapi").should.equal("Nonlegacyapi")
    end
  end

  describe "acronyms camelize lower" do
    MotionSupport::Inflector.inflections do |inflect|
      inflect.acronym("API")
      inflect.acronym("HTML")
    end

    it "should camelize html_api with false to be 'htmlAPI'" do
      MotionSupport::Inflector.camelize("html_api", false).should.equal("htmlAPI")
    end

    it "should camelize html_api with false to be 'htmlAPI'" do
      MotionSupport::Inflector.camelize("htmlAPI", false).should.equal("htmlAPI")
    end

     it "should camelize html_api with false to be 'htmlAPI'" do
      MotionSupport::Inflector.camelize("HTMLAPI", false).should.equal("htmlAPI")
    end
  end

  describe "underscore acronym sequence" do
    before do
      with_dup do
        MotionSupport::Inflector.inflections do |inflect|
          inflect.acronym("API")
          inflect.acronym("HTML5")
          inflect.acronym("HTML")
        end
      end
    end

    it "should underscore 'HTML5HTMLAPI' to equal  'html5_html_api'" do
      MotionSupport::Inflector.underscore("HTML5HTMLAPI").should.equal("html5_html_api")
    end
  end

  describe "underscore" do
    InflectorTestCases::CamelToUnderscore.each do |camel, underscore|
      it "should underscore #{camel} to equal #{underscore}" do
        MotionSupport::Inflector.underscore(camel).should.equal(underscore)
      end
    end
  end

  describe "camelize with module" do
    InflectorTestCases::CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "should camelize #{underscore} to equal #{camel}" do
        MotionSupport::Inflector.camelize(underscore).should.equal(camel)
      end
    end
  end

  describe "underscore with slashes" do
    InflectorTestCases::CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "should underscore #{underscore} to equal #{camel}" do
        MotionSupport::Inflector.camelize(underscore).should.equal(camel)
      end
    end
  end

  describe "demodulize" do
    it "should demodulize 'MyApplication::Billing::Account'" do
      MotionSupport::Inflector.demodulize("MyApplication::Billing::Account").should.equal("Account")
    end

    it "should demodulize 'Account' to 'Account'" do
      MotionSupport::Inflector.demodulize("Account").should.equal("Account")
    end

    it "should demodulize to empty string with empty string" do
      MotionSupport::Inflector.demodulize("").should.equal("")
    end
  end

  describe "deconstantize" do
    it "should deconstantize 'MyApplication::Billing::Account' to equal 'MyApplication::Billing'" do
      MotionSupport::Inflector.deconstantize("MyApplication::Billing::Account").should.equal("MyApplication::Billing")
    end

    it "should deconstantize '::MyApplication::Billing::Account' to equal '::MyApplication::Billing'" do
      MotionSupport::Inflector.deconstantize("::MyApplication::Billing::Account").should.equal("::MyApplication::Billing")
    end

    it "should deconstantize 'MyApplication::Billing' to equal 'MyApplication'" do
      MotionSupport::Inflector.deconstantize("MyApplication::Billing").should.equal("MyApplication")
    end

    it "should deconstantize '::MyApplication::Billing' to equal '::MyApplication'" do
      MotionSupport::Inflector.deconstantize("::MyApplication::Billing").should.equal("::MyApplication")
    end

    it "should deconstantize 'Account' to equal ''" do
      MotionSupport::Inflector.deconstantize("Account").should.equal("")
    end

    it "should deconstantize '::Account' to equal ''" do
      MotionSupport::Inflector.deconstantize("::Account").should.equal("")
    end

    it "should deconstantize '' to equal ''" do
      MotionSupport::Inflector.deconstantize("").should.equal("")
    end
  end

  describe ".foreign_key" do
    InflectorTestCases::ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
      it "should give  #{foreign_key} with given klass #{klass}" do
        MotionSupport::Inflector.foreign_key(klass).should.equal(foreign_key)
      end
    end

     InflectorTestCases::ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
       it "should give foreign_key for #{klass} as #{foreign_key}" do
         MotionSupport::Inflector.foreign_key(klass, false).should.equal(foreign_key)
       end
    end
  end

  describe "tableize" do
    InflectorTestCases::ClassNameToTableName.each do |class_name, table_name|
      it "should tableize #{class_name} to #{table_name}" do
        MotionSupport::Inflector.tableize(class_name).should.equal(table_name)
      end
    end
  end

  describe "classify" do
    InflectorTestCases::ClassNameToTableName.each do |class_name, table_name|
      it "should classify #{table_name} to equal #{class_name}" do
        MotionSupport::Inflector.classify(table_name).should.equal(class_name)
      end

      it "should classify table_prefix.#{table_name} to equal #{class_name}" do
        MotionSupport::Inflector.classify("table_prefix." + table_name).should.equal(class_name)
      end
    end
  end

  describe "classify with symbol" do
    it "should not raise nothing with :foo_bars" do
      lambda{MotionSupport::Inflector.classify(:foo_bars)}.should.not.raise(Exception)
    end

    it "should give 'FooBar' given 'foo_bars'" do
      MotionSupport::Inflector.classify(:foo_bars).should.equal("FooBar")
    end
  end

  describe "classify with leading schema name" do
    it "should classify 'schema.foo_bar' to equal 'FooBar'" do
      MotionSupport::Inflector.classify('schema.foo_bar').should.equal("FooBar")
    end
  end

  describe "hamanize" do
    InflectorTestCases::UnderscoreToHuman.each do |underscore, human| 
      it "should humanize #{underscore} to equal #{human}" do
        MotionSupport::Inflector.humanize(underscore).should.equal(human)
      end
    end
  end

  describe "humanize by rule" do
    before do
      with_dup do
        MotionSupport::Inflector.inflections do |inflect|
          inflect.human(/_cnt$/i, '\1_count')
          inflect.human(/^prefx_/i, '\1')
        end
      end
    end

    it "should humanize 'jargon_cnt' to equal 'Jargon count'" do
      MotionSupport::Inflector.humanize("jargon_cnt").should.equal("Jargon count")
    end

    it "should humanize 'prefx_request' to equal 'Request'" do
      MotionSupport::Inflector.humanize("prefx_request").should.equal("Request")
    end
  end

  describe "humanize by string" do
    before do
      with_dup do
        MotionSupport::Inflector.inflections do |inflect|
          inflect.human("col_rpted_bugs", "Reported bugs")
        end
      end
    end

    it "should humanize 'col_rpted_bugs' to equal 'Reported bugs'" do
      MotionSupport::Inflector.humanize("col_rpted_bugs").should.equal("Reported bugs")
    end
    it "should humaize 'COL_rpted_bugs' to equal 'Col rpted bugs'" do
      MotionSupport::Inflector.humanize("COL_rpted_bugs").should.equal('Col rpted bugs')
    end
  end

  describe "constantize" do
    #def test_constantize
      #run_constantize_tests_on do |string|
        #ActiveSupport::Inflector.constantize(string)
      #end
    #end

    #def test_safe_constantize
      #run_safe_constantize_tests_on do |string|
        #ActiveSupport::Inflector.safe_constantize(string)
      #end
    #end
  end

  describe "ordinal" do
    InflectorTestCases::OrdinalNumbers.each do |number, ordinalized| 
      it "should ordinal #{number} to equal #{ordinalized}" do
        (number + MotionSupport::Inflector.ordinal(number)).should.equal(ordinalized)
      end
    end
  end

  describe "ordinalize" do
    InflectorTestCases::OrdinalNumbers.each do |number, ordinalized| 
      it "should ordinalized #{number} to equal #{ordinalized}" do
        MotionSupport::Inflector.ordinalize(number).should.equal(ordinalized)
      end
    end
  end

  describe "dasherize" do
    InflectorTestCases::UnderscoresToDashes.each do |underscored, dasherized|
      it "should dasherize '#{underscored}' to equal '#{dasherized}'" do
        MotionSupport::Inflector.dasherize(underscored).should.equal(dasherized)
      end
    end
  end

  describe "reverse of dasherize" do
    InflectorTestCases::UnderscoresToDashes.each do |underscored, dasherized|
      it "should underscore dasherized '#{underscored}' to equal '#{underscored}'" do
        MotionSupport::Inflector.underscore(MotionSupport::Inflector.dasherize(underscored)).should.equal(underscored)
      end
    end
  end

  describe "camelize with lower" do
    InflectorTestCases::UnderscoreToLowerCamel.each do |underscored, lower_camel|
      it "should lower camelized '#{underscored}' to equal '#{lower_camel}'" do
        MotionSupport::Inflector.camelize(underscored, false).should.equal(lower_camel)
      end
    end
  end

  describe "symbol_to_lower_camel" do
    InflectorTestCases::SymbolToLowerCamel.each do |symbol, lower_camel|
      it "should camelize symbol '#{symbol}' to equal '#{lower_camel}'" do
        MotionSupport::Inflector.camelize(symbol, false).should.equal(lower_camel)
      end
    end
  end

  #def test_symbol_to_lower_camel
    #SymbolToLowerCamel.each do |symbol, lower_camel|
      #assert_equal(lower_camel, ActiveSupport::Inflector.camelize(symbol, false))
    #end
  #end

  #%w{plurals singulars uncountables humans}.each do |inflection_type|
    #class_eval <<-RUBY, __FILE__, __LINE__ + 1
      #def test_clear_#{inflection_type}
        #with_dup do
          #ActiveSupport::Inflector.inflections.clear :#{inflection_type}
          #assert ActiveSupport::Inflector.inflections.#{inflection_type}.empty?, \"#{inflection_type} inflections should be empty after clear :#{inflection_type}\"
        #end
      #end
    #RUBY
  #end

  #def test_clear_all
    #with_dup do
      #ActiveSupport::Inflector.inflections do |inflect|
        ## ensure any data is present
        #inflect.plural(/(quiz)$/i, '\1zes')
        #inflect.singular(/(database)s$/i, '\1')
        #inflect.uncountable('series')
        #inflect.human("col_rpted_bugs", "Reported bugs")

        #inflect.clear :all

        #assert inflect.plurals.empty?
        #assert inflect.singulars.empty?
        #assert inflect.uncountables.empty?
        #assert inflect.humans.empty?
      #end
    #end
  #end

  #def test_clear_with_default
    #with_dup do
      #ActiveSupport::Inflector.inflections do |inflect|
        ## ensure any data is present
        #inflect.plural(/(quiz)$/i, '\1zes')
        #inflect.singular(/(database)s$/i, '\1')
        #inflect.uncountable('series')
        #inflect.human("col_rpted_bugs", "Reported bugs")

        #inflect.clear

        #assert inflect.plurals.empty?
        #assert inflect.singulars.empty?
        #assert inflect.uncountables.empty?
        #assert inflect.humans.empty?
      #end
    #end
  #end

  #Irregularities.each do |irregularity|
    #singular, plural = *irregularity
    #ActiveSupport::Inflector.inflections do |inflect|
      #define_method("test_irregularity_between_#{singular}_and_#{plural}") do
        #inflect.irregular(singular, plural)
        #assert_equal singular, ActiveSupport::Inflector.singularize(plural)
        #assert_equal plural, ActiveSupport::Inflector.pluralize(singular)
      #end
    #end
  #end

  #Irregularities.each do |irregularity|
    #singular, plural = *irregularity
    #ActiveSupport::Inflector.inflections do |inflect|
      #define_method("test_pluralize_of_irregularity_#{plural}_should_be_the_same") do
        #inflect.irregular(singular, plural)
        #assert_equal plural, ActiveSupport::Inflector.pluralize(plural)
      #end
    #end
  #end

  #Irregularities.each do |irregularity|
    #singular, plural = *irregularity
    #ActiveSupport::Inflector.inflections do |inflect|
      #define_method("test_singularize_of_irregularity_#{singular}_should_be_the_same") do
        #inflect.irregular(singular, plural)
        #assert_equal singular, ActiveSupport::Inflector.singularize(singular)
      #end
    #end
  #end

  #[ :all, [] ].each do |scope|
    #ActiveSupport::Inflector.inflections do |inflect|
      #define_method("test_clear_inflections_with_#{scope.kind_of?(Array) ? "no_arguments" : scope}") do
        ## save all the inflections
        #singulars, plurals, uncountables = inflect.singulars, inflect.plurals, inflect.uncountables

        ## clear all the inflections
        #inflect.clear(*scope)

        #assert_equal [], inflect.singulars
        #assert_equal [], inflect.plurals
        #assert_equal [], inflect.uncountables

        ## restore all the inflections
        #singulars.reverse.each { |singular| inflect.singular(*singular) }
        #plurals.reverse.each   { |plural|   inflect.plural(*plural) }
        #inflect.uncountable(uncountables)

        #assert_equal singulars, inflect.singulars
        #assert_eq
  #end


  # @todo finish rest of specs arhhhh!

end

