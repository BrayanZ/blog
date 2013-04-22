require 'yaml'
require 'Kramdown'
class PostParser
  def self.post_from_file file
    file_data = Hash[YAML.load_file file]
    Post.new title: file_data["title"], body: parse_body(file_data["body"]), publicated_at: file_data["publicated_at"]
  end

  private
  def self.parse_body body
    Kramdown::Document.new(body).to_html
  end
end
