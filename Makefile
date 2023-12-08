build: download_images
	foto export --output ./build

deploy: build
	aws s3 sync ./build s3://silverhalide 

build_scripts:
	cd scripts && npm install

download_images: build_scripts
	node scripts/index.js -d ./content

.PHONY: build_scripts download_images build_hugo