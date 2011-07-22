### hacked by @AlexeyMK for a project... do not use w/o modification ###

require 'guard'
require 'guard/guard'

require 'sprockets'

module Guard
  class Sprockets < Guard
    def initialize(watchers=[], options={})
      super 
      @destination = options[:destination]
    end

    def start
       UI.info "Sprockets waiting for js file changes..."
    end
    
    def run_all
      true
    end

    def run_on_change(paths)
      sprocketize paths.first
    end
    
    private
    
    def sprocketize(path)
      secretary = Sprockets::Secretary.new(
        :root         => '.',
        :asset_root   => 'staging',
        :load_path    => ['javascripts/'],
        :source_files => ['javascripts/*.js'],
        :interpolate_constants => false
      )

      secretary.concatenation.save_to('staging/mobile.js')

      secretary.install_assets
      UI.info "sprocket written to staging/mobile.js (lame, I know, but for now..."
    end
  end
end
