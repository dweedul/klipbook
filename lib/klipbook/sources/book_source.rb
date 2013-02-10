module Klipbook::Sources
  class BookSource
    def initialize(source_spec, max_books)
      raise InvalidSourceError unless valid_source?(source_spec)

      if (source_spec =~ /file:(.+)/)
        raw_file = File.open($1, 'r')
        @source = Klipbook::Sources::KindleDevice::File.new(raw_file.read.strip, max_books)
      elsif (source_spec =~ /site:(.+):(.+)/)
        username = $1
        password = $2
        @source = Klipbook::Sources::AmazonSite::SiteScraper.new(username, password, max_books)
      end
    end

    def books
      @source.books
    end

    private

    def valid_source?(source_spec)
      source_spec =~ /(file:|site:.+:.+)/
    end
  end
end