require 'socket'
module Controllers
  class PostsController
    def self.index
      @posts = Post.find_all
        """
      <html>
        <head>
          <link href='/assets/css/application.css' rel='stylesheet' type='text/css'>
        </head>
        <body>
        <div class='page'>
          <div class='header'>
            <img class='logo' src='/assets/img/medieval_logo.png'>
            <div class='menu'>
              <ul>
                <li><a href='posts/new' class=button>New Entry</a></li>
              </ul>
            </div>
          </div>
          <div class='content'>
            <div class='posts'>
              #{
              @posts.map do |post|
                """
                <div class='post'>
                  <div class='title'>
                    #{post.title}
                  </div>
                  <div class='post_body'>
                    #{post.body}
                  </div>
                  <a href='posts/show/#{post.id}'> Read More </a>
                </div>
                """
              end.join
              }
            </div>
          </div>
        </div>
        </body>
      </html>
      """
    end

    def test
      @var = 5
    end
  end
end
