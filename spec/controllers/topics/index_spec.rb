require File.expand_path('../../../spec_helper', __FILE__)

Medieval::Wrappers.describe TopicsIndex do
  Medieval::Wrappers.context "#render" do
    Medieval::Wrappers.it "return status 200" do
      status, _, _ = TopicsIndex.render({
      Host: "localhost:1504",
      Connection: "keep-alive",
      Accept: "*/*",
      "User-Agent" =>  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31",
      "Accept-Encoding" => "gzip,deflate,sdch",
      "Accept-Language" => "en-US,en;q=0.8",
      "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.3" })
      status.should_eq 200
    end
  end
end
