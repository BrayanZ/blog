require 'webrick'
require 'csv'

Dir[File.dirname(__FILE__) + "/../config/**/*.rb"].each do |file|
  require file
end

Dir[File.dirname(__FILE__) + "/../app/**/*.rb"].each do |file|
  require file
end

def with_clear_files
  file_posts = Dir.pwd + "/app/posts/posts.csv"
  file_comments = Dir.pwd + "/app/comments/comments.csv"

  content_posts = CSV.read(file_posts)
  content_comments = CSV.read(file_comments)

  CSV.open file_posts, "wb" do |csv|
    csv << ["id", "body", "title", "author", "created_at"]
  end

  CSV.open file_comments, "wb" do |csv|
    csv << ["id", "body", "author", "post_id", "created_at"]
  end

  yield

  CSV.open file_posts, "wb" do |csv|
    content_posts.each do |row|
      csv << row
    end
  end

  CSV.open file_comments, "wb" do |csv|
    content_comments.each do |row|
      csv << row
    end
  end
end

include Medieval
include Controllers
