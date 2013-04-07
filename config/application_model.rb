require 'csv'
class  ApplicationModel
  def save
    begin
      class_name = self.class.to_s.downcase
      file = Dir.pwd + "/app/#{class_name}s/#{class_name}s.csv"
      self.id = self.class.next_id
      self.created_at = DateTime.now
      CSV.open file, "ab" do |csv|
        csv << self.instance_variables.map{|v| self.send(v.to_s[1..-1]) }
      end
    rescue Exception => e
      p e.message
      false
    else
      self
    end
  end

  def self.find_all
    result = Array.new
    class_name = self.to_s.downcase
    file = Dir.pwd + "/app/#{class_name}s/#{class_name}s.csv"
    CSV.foreach(file, {headers: true}) do |row|
      result << self.new(row.to_hash.symbolize_keys)
    end
    result
  end

  def self.find id
    class_name = self.to_s.downcase
    file = Dir.pwd + "/app/#{class_name}s/#{class_name}s.csv"
    rows = CSV.read(file, {headers: true})
    row = rows.select{ |r| r["id"] == id.to_s }[0]
    self.new(row.to_hash.symbolize_keys)
  end

  def self.next_id
    class_name = self.to_s.downcase
    file = Dir.pwd + "/app/#{class_name}s/#{class_name}s.csv"
    rows = CSV.read(file, {headers: true})
    rows.empty? ? 1 : rows[-1]["id"].to_i + 1
  end
end
