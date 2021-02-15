#!/bin/bash

install_reqs()
{
	python3 -m pip install -r requirements.txt
	apt install eog
	sudo apt-get install eog-plugins -y
}

help_me()
{
	# Display Help
	echo "Script to display slideshow of pictures taken from VSCO"
	echo
	echo "-i, --install				install requirements for the program to run"
	echo "-g, --get-image				Download images from a specified users profile"
}

get_images()
{
	vsco-scraper $1 --getImages
}

display_image()
{
	eog --fullscreen $1
}

show_slideshow()
{
	if [ $1 = "-s"]
	then
		eog --fullscreen --slide-show $1
	else
		eog --fullscreen --slide-show
	fi
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
			shift
			display_image $1
			shift
			;;
			-s|--slideshow)
			shift
			show_slideshow $1
			;;
		esac
	done
}

echo $@
main $@
