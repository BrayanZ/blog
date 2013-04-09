def routes
  {
    "/" => { action: "Posts#index", method: :get },
    "/posts" => { action: "Posts#index", method: :get },
    "/posts/new" => { action: "Posts#new", method: :get },
    "/posts/:id/show" => { action: "Posts#show", method: :get } ,
    "/posts/create" => { action: "Posts#create", method: :post },

    "/comments/create" => { action: "Comments#create", method: :post }
  }
end
