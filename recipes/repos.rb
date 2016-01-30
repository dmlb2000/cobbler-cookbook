repos = data_bag(node[:cobbler][:repo][:data_bag])

repos.each do |repo_item|
  repo = data_bag_item(node[:cobbler][:repo][:data_bag], repo_item)
  cobbler_repo repo_item do
    config repo['config']
  end
end
