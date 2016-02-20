# Salt to ensure passwords are encrypted securely
Caboose::salt = '0b02ae0511161029bba25f67697101719f0f51df'

# Where page asset files will be uploaded
Caboose::assets_path = Rails.root.join('app', 'assets', 'caboose')

# Register any caboose plugins
Caboose::plugins << 'LawPlugin'

# Tell the host app about the caboose assets
Rails.application.config.assets.paths << Rails.root.join('vendor','gems','caboose-cms','app','assets','javascripts')
Rails.application.config.assets.paths << Rails.root.join('vendor','gems','caboose-cms','app','assets','stylesheets')
Rails.application.config.assets.precompile += [
  'login.css',
  'caboose/admin.js',
  'caboose/application.js',
  'caboose/login.js',
  'caboose/model.form.page.js',
  'caboose/station.js',
  'caboose/admin.css',
  'caboose/application.css',
  'caboose/caboose.css',
  'caboose/fonts.css',
  'caboose/tinymce.css'
]

