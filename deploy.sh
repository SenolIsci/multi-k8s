docker build -t senolisci/multi-client-k8s:latest -t senolisci/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t senolisci/multi-server-k8s-pgfix:latest -t senolisci/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t senolisci/multi-worker-k8s:latest -t senolisci/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push senolisci/multi-client-k8s:latest
docker push senolisci/multi-server-k8s-pgfix:latest
docker push senolisci/multi-worker-k8s:latest

docker push senolisci/multi-client-k8s:$SHA
docker push senolisci/multi-server-k8s-pgfix:$SHA
docker push senolisci/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=senolisci/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=senolisci/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=senolisci/multi-worker-k8s:$SHA