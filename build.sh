#!/bin/sh

SOLVER_VERSION=$(cat ./version.txt)
IMAGE_BINARIES=yfirmy/eternity2-solver-binaries

echo Prepare building version $SOLVER_VERSION

sed -e "s/{{solver.version}}/$SOLVER_VERSION/g" ./src/E2Logic/E2Application.cpp.j2 > ./src/E2Logic/E2Application.cpp

echo Building $IMAGE_BINARIES:$SOLVER_VERSION

docker build -t $IMAGE_BINARIES:$SOLVER_VERSION .

docker create --name binaries $IMAGE_BINARIES:$SOLVER_VERSION  
docker cp 'binaries:/app/eternity2-solver/bin' ./web/
docker cp 'binaries:/app/eternity2-solver/bin' ./puller/
docker rm -f binaries

# Only keep necessary binaries for each image type
rm -f ./web/bin/E2*-dfs
rm -f ./puller/bin/E2*-bfs

cd ./puller
./build-puller.sh $SOLVER_VERSION

cd ..

cd ./web
./build-web.sh $SOLVER_VERSION

cd ..

# clean-up
rm -f ./web/bin/E2*-bfs
rm -f ./puller/bin/E2*-dfs
rm -f ./src/E2Logic/E2Application.cpp

rmdir ./web/bin
rmdir ./puller/bin

#
# To run these docker images, don't forget options to attach stdin/stdout :

# docker run -a stdin -a stdout -it --rm yfirmy/eternity2-solver-clue1:latest
