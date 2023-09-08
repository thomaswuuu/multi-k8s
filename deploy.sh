docker build -t thomaswu27/multi-client-k8s:latest -t thomaswu27/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t thomaswu27/multi-server-k8s:latest -t thomaswu27/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t thomaswu27/multi-worker-k8s:latest -t thomaswu27/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push thomaswu27/multi-client-k8s:latest
docker push thomaswu27/multi-server-k8s:latest
docker push thomaswu27/multi-worker-k8s:latest

docker push thomaswu27/multi-client-k8s:$SHA
docker push thomaswu27/multi-server-k8s:$SHA
docker push thomaswu27/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rallycoding/multi-server-k8s
kubectl set image deployments/client-deployment client=rallycoding/multi-client-k8s
kubectl set image deployments/worker-deployment worker=rallycoding/multi-worker-k8s