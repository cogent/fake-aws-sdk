require "fake_aws/s3/object_collection"

module FakeAWS
  class S3

    class Bucket

      def initialize(name)
        @name = name
        @objects = ObjectCollection.new(self)
      end

      attr_reader :name
      attr_reader :objects

      def exists?
        true
      end

    end

  end

end
