module Beast
  module Plugins

    class ContentEditor < Beast::Plugin
      author 'Aurelian Oancea'
      version '0.02'
      homepage 'http://www.locknet.ro/projects'
      notes 'ContentEditor, a MiniCMS for Beast'

      %w( controllers helpers models ).each do |dir|
        path = File.expand_path(File.join(plugin_path, 'app', dir))
        if File.exist?(path) && !Dependencies.load_paths.include?(path)
          Dependencies.load_paths << path
        end
      end

      route :resources,      'pages'
      route :publish_page,   'pages/publish/:id', :controller => 'pages', :action => 'publish'
      route :page_permalink, '/:permalink',       :controller => 'pages', :action => 'show'
      
      tab 'Pages', :controller => 'pages'

      def initialize
        super
        ApplicationController.prepend_view_path File.join( ContentEditor::plugin_path, 'app', 'views' )      
      end

      class Schema < ActiveRecord::Migration    
        def self.install
          create_table :pages do |t|
            t.integer :user_id
            t.string  :title
            t.string  :permalink
            t.text    :body
            t.text    :body_html
            t.boolean :active
            t.timestamps
          end
        end
      
        def self.uninstall
          drop_table :pages
        end

      end # end Schema class
    end # end Pages class
  end
end
