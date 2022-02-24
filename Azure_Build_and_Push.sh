#! /bin/sh

# Variables you should set for your image
imageName="qe/popeye"
imageTag="latest"

# our Azure paths
registryName='crcloudplatformeastus001'
imagePath="${registryName}.azurecr.io/${imageName}:${imageTag}"

# login to our registry
az acr login -n $registryName

# build and push the docker image to Azure Registry
# docker build . -t $imagePath
# docker push $imagePath

# alternative multi-arch build and push to Azure Registry, for future use ;-)
docker buildx build \
  --output=type=registry \
  --platform linux/amd64 \
  -t $imagePath \
  .

# see the versions of my image in the repo sorted by time
echo $imagePath
az acr repository show-tags --name $registryName --repository $imageName --orderby time_desc --detail | jq -r '.[]|.lastUpdateTime,.name' | paste - -
