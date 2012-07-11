require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "AutomagicalValidations" do
  subject { Post.new }

  context 'model without database table' do
    it 'should be automagically validatable' do
      expect { Comment.automagically_validate(:string, :text) }.to_not raise_error
    end
  end

  context "maximum length validator" do
    context "presence of validators" do
      before(:all) do
        Post.rebuild_table do |t|
          t.string  :title
          t.text    :content
        end

        Post.automagically_validate :string
      end

      it "should define length validator on specified type of column" do
        Post.should have(1).validators_on(:title)
        Post.validators_on(:title).first.should be_a ActiveModel::Validations::LengthValidator
      end

      it "should not define any validators on other types of columns" do
        Post.validators_on(:content).should be_empty
      end
    end

    context "when asked to define validation on column that provides no limit information" do
      before(:all) do
        Post.rebuild_table do |t|
          t.date :published_at
        end

        Post.automagically_validate :date
      end

      it "should not define any validators" do
        Post.validators_on(:published_at).should be_empty
      end
    end

    context "when column type is provided as string" do
      before(:all) do
        Post.rebuild_table do |t|
          t.string  :title
        end

        Post.automagically_validate 'string'
      end

      it "should define validators" do
        Post.should have(1).validators_on(:title)
      end
    end

    context "when a table is defined with implicit limits (defaults)" do
      before(:all) do
        Post.rebuild_table do |t|
          t.string  :title
        end

        Post.automagically_validate :string
      end

      it "should be valid when content is not specified" do
        subject.should be_valid
      end

      it "should be valid when content is empty" do
        subject.title = ''
        subject.should be_valid
      end

      it "should be valid when under or equal to default Rails string column length (255)" do
        subject.title = "a"*255
        subject.should be_valid
      end

      it "should not be valid when over default Rails string column length (255)" do
        subject.title = "a"*256
        subject.should_not be_valid
      end
    end

    context "when a table is defined with explicit limits" do
      before(:all) do
        Post.rebuild_table do |t|
          t.string  :title, :limit => 20
        end

        Post.automagically_validate :string
      end

      it "should be valid when content is not specified" do
        subject.should be_valid
      end

      it "should be valid when content is empty" do
        subject.title = ''
        subject.should be_valid
      end

      it "should be valid when under or equal to specified limit" do
        subject.title = "a"*20
        subject.should be_valid
      end

      it "should not be valid when over specified limit" do
        subject.title = "a"*21
        subject.should_not be_valid
      end
    end

    context "when explicit validation exists" do
      context "when explicit validation is defined before automagical validation" do
        before(:all) do
          Post.rebuild_table do |t|
            t.string  :title,   :limit => 20
          end

          Post.validates_length_of :title, :maximum => 10
          Post.automagically_validate :string
        end

        it "should not overwrite explicit validation" do
          subject.title = "a"*15
          subject.should_not be_valid
        end

        it "should not define additional validation" do
          Post.should have(1).validators_on(:title)
        end
      end

      context "when explicit validation without maximum parameter is defined before automagical validation" do
        before(:all) do
          Post.rebuild_table do |t|
            t.string  :title,   :limit => 20
          end

          Post.validates_length_of :title, :minimum => 10
          Post.automagically_validate :string
        end

        it "should provide validation for max value" do
          subject.title = "a"*21
          subject.should_not be_valid
        end

        it "should define additional validation to take care of maximum length" do
          Post.should have(2).validators_on(:title)
        end
      end

      context "when explicit validation is defined after automagical validation" do
        before(:all) do
          Post.rebuild_table do |t|
            t.string  :title,   :limit => 20
          end

          Post.automagically_validate :string
          Post.validates_length_of :title, :maximum => 10
        end

        it "explicit validation should take precedence" do
          subject.title = "a"*15
          subject.should_not be_valid
        end
      end
    end

    context "passing options to validator" do
      let(:validator_options){ {:message => 'Custom message'} }

      before(:all) do
        Post.rebuild_table do |t|
          t.string  :title
          t.text    :content
        end

        Post.automagically_validate :string => validator_options
      end

      it "should define validator" do
        Post.should have(1).validators_on(:title)
      end

      it "should define options for validator" do
        Post.validators_on(:title).first.options[:message].should eq validator_options[:message]
      end
    end
  end
end
