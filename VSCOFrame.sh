# Caleb Renfroe
# Bash script that uses functionality from the vsco-scraper python package and the eye of gnome program.

#!/bin/bash

# Install reqs and setup VSCOFrame
install_reqs()
{
	mkdir ./VSCOProfiles
	python3 -m pip install -r requirements.txt
	apt install eog
	sudo apt-get install eog-plugins -y
}

# Command usage output
help_me()
{
	# Display Help
	echo "Script to display slideshow of pictures taken from VSCO"
	echo
	echo "-h, --help 				Display list of commands"
	echo "-i, --install				Install requirements for the program to run"
	echo "-g, --get-image				Download images from a specified users profile"
	echo "-s, --slide-show 			Display a slideshow of images from a specified directory"
	echo
}

# Scrape all images on a given users profile
get_images()
{
	cd ./VSCOProfiles
	vsco-scraper $1 --getImages
	cd ..
}

# Display a single image specified by a file path
display_image()
{
	if test -f "$1"; 
	then
		eog --fullscreen $1
	else
		echo "Image does not exist"
		exit 1
	fi
}

# Displays directory of images in a random order
show_slideshow()
{
	eog --fullscreen --slide-show $1
}

main()
{
	# If no input params given, output help
	if [ $# -eq 0 ]
	then
		help_me
	fi

	for arg in "$@"
	do
		case $arg in
			-i|--install)
			install_reqs
			shift # remove flag
			;;
			-g|--get-images)
			shift # remove flag
			get_images $1
			shift # remove argument value
			;;
			-d|--display-image)
			shift # remove flag
			display_image $1
			shift
			;;
			-s|--slideshow)
			shift # remove flag
			show_slideshow $1
			shift
			;;
			# Garbage input
			*)
			help_me
			exit 1
			;;
		esac
	done
}

main $@
