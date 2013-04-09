class Routes
  require Dir.pwd + "/routes"

  def self.get route, response, listener
    self.exec_route route, :get, response, listener
  end

  def self.post route, response, params, listener
    self.exec_route route, :post, response, listener, params
  end

  def self.match_route route, method, params = {}
    path = route.split "/"
    routes.select{ |r, d| d[:method] == method }.each do |server_route, definition|
      result = self.compare_routes path, server_route.split("/"), params
      return self.action_to_class definition[:action] if result
    end
    false
  end

  private
  def self.exec_route route, method, response, listener, params = {}
    action = self.match_route route, method, params
    if action
      result = self.call_action(action)
      if result.is_a? Hash
        response.header['location'] = result[:uri]
        listener.redirect_found response
      else
        response.body = result
        listener.route_found response
      end
    else
      listener.route_not_found
    end
  end

  def self.compare_routes route, system_route, params
    @params = params.merge({})
    result =  route.count == system_route.count
    system_route.each_with_index do |part, i|
      if !part.start_with? ":"
        result &&= part == route[i] ? true : false
      else
        @params[eval(part)] = route[i]
      end
    end
    result
  end

  def self.action_to_class action
    splits = action.split "#"
    return "#{splits[0]}Controller##{splits[1]}"
  end

  def self.call_action action
    controller = action.split "#"
    Controllers.const_get(controller[0]).send(controller[1], @params)
  end
end
