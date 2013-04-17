require 'yaml'
class Post
  attr_reader :title, :body, :publicated_at

  def initialize attrs
    @title = attrs[:title]
    @body = attrs[:body]
    @publicated_at = DateTime.parse(attrs[:publicated_at])
  end

  def id
    @id ||= title.downcase.gsub(" ", "-")
  end

  def published?
    @publicated_at < DateTime.now
  end

  def self.create_from_file file
    new(post_data_from_file(file))
  end

  private

  def self.post_data_from_file(file)
    symbolize_keys(Hash[YAML.load_file(file)])
  end

  def self.symbolize_keys(hash)
    Hash[hash.map {|key, value| [key.to_sym, value] }]
  end
end
