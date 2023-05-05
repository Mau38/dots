function gov 
	function deactivate -d "Remove GOROOT and GOPATH vars"

		if test -n "$_OLD_PATH"
			set -gx PATH $_OLD_PATH
			set -e _OLD_PATH
		end
		if test -n "$_OLD_GOROOT"
			set -gx GOROOT $_OLD_GOROOT
			set -e _OLD_GOROOT
		end
		if test -n "$_OLD_GOPATH"
			set -gx GOPATH $_OLD_GOPATH
			set -e _OLD_GOPATH
		end
		if test -n "$VIRTUALGO"
			set -e VIRTUALGO
		end

		# remov deactivate function if called from user
		if test "$argv[1]" != "live"
			functions -e deactivate
		end
	end

	# check if there is current version of go set
	asdf where golang > /dev/null 2>&1
	if test $status != "0"
		echo "no version of golang is set in asdf"
		return 1
	end

	# remove all previous variables
	deactivate live

	# get current location og golang
	set -gx VIRTUALGO (asdf where golang) 

	# store previous variables
	set -gx _OLD_PATH $PATH
	set -gx _OLD_GOROOT $GOROOT
	set -gx _OLD_GOPATH $GOPATH

	# store new variables
	set -gx GOROOT $VIRTUALGO/go
	set -gx GOPATH $VIRTUALGO/packages
  fish_add_path $VIRTUALGO/packages/bin
end
