# add bower components to the assets path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'components')

Rails.application.config.assets.precompile += %w( landing.css )
