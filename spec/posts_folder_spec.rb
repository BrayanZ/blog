require Dir.pwd + '/lib/post_folder'

describe 'posts folder' do
  let(:post_folder_path){ Dir.pwd + "/spec/test_posts/*.yml" }
  let(:post_folder){ PostFolder.new post_folder_path }

  it 'knows the path od the folder' do
    expect( post_folder.instance_variable_get("@folder") ).to eq post_folder_path
  end

  it 'load all the posts in the folder' do
    expect( post_folder.posts.count ).to eq 1
  end
end
