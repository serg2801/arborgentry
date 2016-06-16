# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( registration.js )
Rails.application.config.assets.precompile += %w( registration.css )

Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( home.css )

Rails.application.config.assets.precompile += %w( charts-flot.js )
Rails.application.config.assets.precompile += %w( charts-morris.js )
Rails.application.config.assets.precompile += %w( charts-chartjs.js )
Rails.application.config.assets.precompile += %w( charts-other.js )

Rails.application.config.assets.precompile += %w( forms-basic.js )
Rails.application.config.assets.precompile += %w( forms-wizard.js )
Rails.application.config.assets.precompile += %w( forms-advanced.js )
Rails.application.config.assets.precompile += %w( blank.js )
Rails.application.config.assets.precompile += %w( forms-validation.js )

Rails.application.config.assets.precompile += %w( tables-basic.js )