require "fake_aws/s3/bucket"
require "fake_aws/s3/s3_object"

describe FakeAWS::S3::S3Object do

  let(:object) { FakeAWS::S3::S3Object.new("test-object") }

  subject { object }

  describe "#key" do
    it "returns the object key" do
      subject.key.should eq("test-object")
    end
  end

  context "before it has been written" do

    it { should_not exist }

    describe "#read" do

      it "raises a KeyError" do
        lambda { object.read }.should raise_error(KeyError)
      end

    end

    describe "#content_length" do

      it "raises a KeyError" do
        lambda { object.content_length }.should raise_error(KeyError)
      end

    end

  end

  context "after being written" do

    let(:data) { "foobarbaz" }

    before do
      object.write(data)
    end

    it { should exist }

    describe "#read" do

      it "returns the data written" do
        object.read.should eq(data)
      end

    end

    describe "#content_length" do

      it "returns the size of data written" do
        object.content_length.should eq(data.length)
      end

    end

  end

  context "after being deleted" do

    before do
      object.write("whatever")
      object.delete
    end

    it { should_not exist }

    describe "#read" do

      it "raises a KeyError" do
        lambda { object.read }.should raise_error(KeyError)
      end

    end

  end

  describe "#write" do

    context "with an IO object" do

      let(:data) { "stream-of-stuff" }

      before do
        object.write(StringIO.new(data))
      end

      it "saves the streamed data" do
        object.read.should eq(data)
      end

    end

  end

end
