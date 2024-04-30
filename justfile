run:
  ./bin/dev

docker:
  docker build --platform linux/amd64 -t rabel .

push:
  docker tag rabel reg.yy1986.com/daqing/rabel
  docker push reg.yy1986.com/daqing/rabel
