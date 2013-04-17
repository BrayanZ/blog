require 'yaml'
class Post
  attr_reader :title, :body, :id, :publicated_at

  def initialize attrs
    @title, @body, @id, @publicated_at = attrs[:title], attrs[:body], generate_id(attrs[:title]), DateTime.parse(attrs[:publicated_at])
  end

  def generate_id title
    title.downcase.gsub(" ", "-")
  end

  def self.create_from_file file
   post = Hash[YAML.load_file(file).map {|key, value| [key.to_sym, value] }]
   new post
  end
end
