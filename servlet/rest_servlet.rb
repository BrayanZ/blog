require 'json'
class RestServlet < HTTPServlet::AbstractServlet
  def do_GET request, response
    if request.unparsed_uri == "/"
      path = ["posts"]
    else
      path = request.path[1..-1].split '/'
    end
    unless path[-1].include? "."
      controller = "#{path[0].capitalize}Controller"
      raise HTTPStatus::NotFound if !Controllers.const_defined?(controller)
      response_class = Controllers.const_get(controller)

      if response_class and response_class.is_a?(Class)
        if path[1]
          response_method = path[1].to_sym
          raise HTTPStatus::NotFound if !response_class.respond_to?(response_method)
          if path.length > 2
            response.body = response_class.send(response_method, path[2..-1])
          else
            response.body = response_class.send(response_method)
          end
          raise HTTPStatus::OK
        else
          raise HTTPStatus::NotFound if !response_class.respond_to?(:index)
          response.body = response_class.send(:index)
          raise HTTPStatus::OK
        end
      else
        raise HTTPStatus::NotFound
      end
    end
  end

  def do_POST request, response
    path = request.path[1..-1].split '/'
    params = JSON.parse request.query.to_json, symbolize_names: true
    controller = "#{path[0].capitalize}Controller"

    raise HTTPStatus::NotFound if !Controllers.const_defined? controller
    response_class = Controllers.const_get controller

    if response_class and response_class.is_a? Class
      if path[1]
        response_method = path[1].to_sym
        raise HTTPStatus::NotFound if !response_class.respond_to? response_method
          result = response_class.send(response_method, params)
          if result.is_a? Hash
            response.set_redirect result[:status] || HTTPStatus::Found, result[:uri]
          else
            response.body = result if result.is_a String
          end
        raise HTTPStatus::OK
      else
        raise HTTPStatus::NotFound
      end
    else
      raise HTTPStatus::NotFound
    end
  end

  private
  def query_to_params query
    p query
    result = Hash.new
    query.split('&').each do |param|
      field = param.split('=')
      result[field[0]] = field[1]
    end
    result
  end
end
