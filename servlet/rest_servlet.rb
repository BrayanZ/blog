class RestServlet < HTTPServlet::AbstractServlet
  def do_GET request, response
    path = request.path[1..-1].split '/'
    controller = "#{path[0].capitalize}Controller"
    raise HTTPStatus::NotFound if !Controllers.const_defined?(controller)
    response_class = Controllers.const_get(controller)

    if response_class and response_class.is_a?(Class)
      if path[1]
        response_method = path[1].to_sym
        raise HTTPStatus::NotFound if !response_class.respond_to?(response_method)
        if path.length > 2
          resp.body = response_class.send(response_method, path[2..-1])
        else
          resp.body = response_class.send(response_method)
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
