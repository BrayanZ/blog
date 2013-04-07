class Comment < ApplicationModel
  attr_accessor :id, :body, :author, :post_id, :created_at

  def initialize attrs={}
    @id = attrs[:id].to_i ||= 0
    @body = attrs[:body]
    @author = attrs[:author]
    @post_id = attrs[:post_id].to_i
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
