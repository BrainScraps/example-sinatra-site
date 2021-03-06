require "sinatra/base"
require "sinatra/reloader"
require "yaml"
require "forgery"

module DemoSite
  class App < Sinatra::Base

    # If you want to set password protection for a particular environment,
    # uncomment this and set the username/password:
    #if ENV['RACK_ENV'] == 'staging'
      #use Rack::Auth::Basic, "Please sign in" do |username, password|
        #[username, password] == ['theusername', 'thepassword']
      #end
    #end

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      # Set your Google Analytics ID here if you have one:
      # set :google_analytics_id, 'UA-12345678-1'

      set :layouts_dir, 'views/_layouts'
      set :partials_dir, 'views/_partials'
    end

    helpers do
      def show_404
        status 404
        @page_name = '404'
        @page_title = '404'
        haml :'404', :layout => :with_sidebar,
                    :layout_options => {:views => settings.layouts_dir}
      end
    end


    not_found do
      show_404
    end


    # Redirect any URLs without a trailing slash to the version with.
    get %r{(/.*[^\/])$} do
      redirect "#{params[:captures].first}/"
    end


    get '/' do
      @page_name = 'home'
      @page_title = 'Home page'
      @people = YAML.load_file('./people.yml')
      haml :index,
        :layout => :full_width,
        :layout_options => {:views => settings.layouts_dir}
    end

    get '/docflow/' do
      @page_name = 'document flow'
      @page_title = 'document flow'
      haml :docflow,
        :layout => :full_width,
        :layout_options => {:views => settings.layouts_dir}
    end

    get '/position/' do
      @page_name = 'position'
      @page_title = 'position'
      haml :position,
        :layout => :full_width,
        :layout_options => {:views => settings.layouts_dir}
    end

    get '/floats/' do
      @page_name = 'floats'
      @page_title = 'floats'
      @people = YAML.load_file('./people.yml')
      haml :floats,
        :layout => :full_width,
        :layout_options => {:views => settings.layouts_dir}
    end

    # Routes for pages that have unique things...

    get '/special/' do
      @page_name = 'special'
      @page_title = 'A special page'
      @time = Time.now
      haml :special,
        :layout => :full_width,
        :layout_options => {:views => settings.layouts_dir}
    end
  end
end
