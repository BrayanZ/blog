class Post < ApplicationModel
  attr_accessor :id, :body, :title, :created_at, :author

  def initialize attrs = {}
    @id = attrs[:id].to_i || 0
    @body = attrs[:body]
    @title = attrs[:title]
    @author = attrs[:author]
    @created_at = case attrs[:created_at].class.to_s
                  when "String"
                    DateTime.parse(attrs[:created_at])
                  when "DateTime"
                    attrs[:created_at]
                  else
                    nil
                  end
  end
end
