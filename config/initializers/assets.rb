# add bower components to the assets path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'components')

Rails.application.config.assets.precompile += %w( landing.css )
# Zenpen Assets.
Rails.application.config.assets.precompile += %w(
  writer/css/style.css
  writer/css/fonts.css
  writer/js/libs/Blob.js
  writer/js/libs/FileSaver.min.js
  writer/js/libs/fullScreen.js
  writer/js/libs/head.min.js
  writer/js/editor.js
  writer/js/ui.js
  writer/js/utils.js
)

