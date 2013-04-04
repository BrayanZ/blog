class TopicsIndex < WEBrick::HTTPServlet::AbstractServlet

  def do_GET request, response
    puts request
    status, content_type,body = render(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def render request
    html = 
      """
      <html>
        <body>
          <h1>Hola</h1>
        </body>
      </html>
    """

    return 200, "text/html", html
  end
end
