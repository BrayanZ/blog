require 'json'
require Dir.pwd + "/routes"

class RestServlet < HTTPServlet::AbstractServlet

  def do_GET request, response
    Routes.get request.unparsed_uri, response,  self
  end

  def do_POST request, response
    Routes.post request.path, response, request.query.symbolize_keys, self
  end

  def redirect_found response
    raise HTTPStatus::Found
  end

  def route_found response
    raise HTTPStatus::OK
  end

  def route_not_found
    raise HTTPStatus::NotFound
  end
end
