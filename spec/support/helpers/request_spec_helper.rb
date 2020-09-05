module RequestSpecHelper
  def json
    JSON.parse(response_body)
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper
end
