load Rails.root.join("config/environment.rb")
Rake::Task["read_models:rebuild_rfc_counts"].invoke
