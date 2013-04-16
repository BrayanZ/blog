require 'yaml'
class Post
  attr_reader :title, :body, :id

  def initialize attrs
    @title, @body, @id = attrs[:title], attrs[:body], attrs[:id].to_i
  end

  def self.create_from_file file, id = 0
   post = Hash[YAML.load_file(file).map {|key, value| [key.to_sym, value] }]
   new post.merge({id: id})
  end
end
