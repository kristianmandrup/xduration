module RubyDuration 
	module Rails
		class Engine < ::Rails::Engine
			initializer 'duration setup' do
				unless locale_files.blank?
					locale_files.each do |file|
						I18n.load_path << file
					end
				end
			end

			def locale_files
				@locale_files ||= Dir[::Rails.root.join('config', 'locales', 'duration', '*.yml')]
			rescue
				[]
			end
		end
	end
end