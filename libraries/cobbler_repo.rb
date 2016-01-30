#
# Cookbook Name:: cobblerd
# Library:: profile
#
# Copyright (C) 2014 Bloomberg Finance L.P.
#
class Chef
  class Resource::CobblerRepo < Resource
    include Poise
    include Cobbler::Parse

    actions(:create)
    actions(:sync)

    attribute(:name, kind_of: String)
    attribute(:config, kind_of: Hash, default: {} )
    config_dir = "/var/lib/cobbler/config/repos.d"
  end

  class Provider::CobblerRepo < Provider
    include Poise

    def action_delete
      converge_by("deleting #{new_resource.name} into cobbler") do
        notifying_block do
          cobbler_repo_delete
        end
      end
    end

    def action_create
      converge_by("creating #{new_resource.name} into cobbler") do
        notifying_block do
          cobbler_repo_create
        end
      end
    end

    def action_sync
      converge_by("syncing #{new_resource.name} into cobbler") do
        notifying_block do
          cobbler_repo_sync
        end
      end
    end

    private
    def cobbler_repo_create
      service 'cobblerd'
      file "#{new_resource.name}-cobbler-repo-add" do
        path "#{config_dir}/#{new_resource.name}.json"
        content JSON.parse(new_resource.config)
        not_if { File.exist?("#{config_dir}/#{new_resource.name}.json") }
        notifies :restart, 'service[cobblerd]'
      end
    end

    private
    def cobbler_repo_delete
      service 'cobblerd'
      file "#{new_resource.name}-cobbler-repo-delete" do
        path "#{config_dir}/#{new_resource.name}.json"
        only_if { File.exist?("#{config_dir}/#{new_resource.name}.json") }
        notifies :restart, 'service[cobblerd]'
        action :delete
      end
    end

    private
    def cobbler_repo_sync
      execute "#{new_resource.name}-cobbler-repo-sync" do
        command "cobbler reposync --only=#{new_resource.name}"
        only_if { File.exist?("#{config_dir}/#{new_resource.name}.json") }
      end
    end
  end
end
