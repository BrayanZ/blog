module Controllers
  class PostsController
    def self.index
      @posts = []
        """
      <html>
        <body>
          <h1>Hola</h1>
        </body>
      </html>
      """
    end

    def test
      @var = 5
    end
  end
end
