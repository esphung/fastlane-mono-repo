all: clean ruby_check gem_install nvm_install mv_dir
	# ./scripts/main.sh
	echo "ls -al"
	echo "Done!"

nvm_install: ruby_check
	./scripts/nvm_install.sh

mv_dir: gem_install Gemfile Gemfile.lock .ruby-lock
	cp -rf Gemfile ../Gemfile
	cp -rf Gemfile.lock ../Gemfile.lock
	cp -rf fastlane ../fastlane
	cp -rf .ruby-lock ../.ruby-lock
	cp -rf bundle ../bundle

gem_install: ruby_check
	./scripts/gem_install.sh

main_install:
	./scripts/main_install.sh

ruby_check:
	./scripts/ruby_check.sh

clean:
	rm -rf Gemfile Gemfile.lock
	rm -rf fastlane .ruby-lock ,gitignore .bundle
