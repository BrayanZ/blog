require 'csv'
class Post
  attr_reader :id, :body, :title, :created_at, :author

  def initialize attrs = {}
    @body = attrs[:body]
    @title = attrs[:title]
    @author = attrs[:author]
  end

  def self.find_all file = nil
    posts = Array.new
    file ||= Dir.pwd + "/app/posts/posts.csv"
    CSV.foreach(file, {headers: true}) do |row|
      posts << Post.new({body: row["body"], title: row["title"], created_at: row["created_at"], author: row["author"]}) unless row.header_row?
    end
    posts
  end

  def save file = nil
    file ||= Dir.pwd + "/app/posts/posts.csv"
    CSV.open file, "ab" do |csv|
      csv << [Post.next_id, self.body, self.title, DateTime.now, self.author]
    end
  end

  def self.next_id file = nil
    file ||= Dir.pwd + "/app/posts/posts.csv"
    rows = CSV.read(file, {headers: true})
    rows.empty? ? 1 : rows[-1]["id"].to_i + 1
  end
end
