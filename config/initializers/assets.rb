# add bower components to the assets path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'components')

Rails.application.config.assets.precompile += %w( landing.css )
# Zenpen Assets.
Rails.application.config.assets.precompile += %w(
  zenpen/css/style.css
  zenpen/css/fonts.css
  zenpen/js/libs/Blob.js
  zenpen/js/libs/FileSaver.min.js
  zenpen/js/libs/fullScreen.js
  zenpen/js/libs/head.min.js
  zenpen/js/editor.js
  zenpen/js/ui.js
  zenpen/js/utils.js
)

