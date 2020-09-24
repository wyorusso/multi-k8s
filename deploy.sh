docker build -t wyorusso/multi-client:latest -t wyorusso/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wyorusso/multi-server:latest -t wyorusso/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wyorusso.multi-worker:latest -t wyorusso.multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wyorusso/multi-client:latest
docker push wyorusso/multi-client:$SHA
docker push wyorusso/multi-server:latest
docker push wyorusso/multi-server:$SHA
docker push wyorusso/multi-worker:latest
docker push wyorusso/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wyorusso/multi-server:$SHA
kubectl set image deployments/client-deployment client=wyorusso/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wyorusso/multi-worker:$SHA