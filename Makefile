build: download_images
	foto export --output ./build

deploy: build
	aws s3 sync ./build s3://silverhalide --profile ${USER_AWS_PROFILE}
	aws cloudfront create-invalidation --distribution-id E3H5QQC2IDZY3C --paths "/*" --profile ${USER_AWS_PROFILE}

build_scripts:
	cd scripts && npm install

download_images: build_scripts
	node scripts/index.js -d ./content --development --profile ${USER_AWS_PROFILE}

.PHONY: build_scripts download_images build_hugo