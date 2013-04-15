require "fake_aws/s3/object_collection"

module FakeAWS
  class S3

    class Bucket

      def initialize(name)
        @name = name
        clear!
      end

      attr_reader :name
      attr_reader :objects

      def exists?
        true
      end

      def empty?
        objects.empty?
      end

      def clear!
        @objects = ObjectCollection.new(self)
      end

    end

  end

end
