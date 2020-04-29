
# Docker

```sh
docker stack deploy -c gitlab.yaml gitlab
```


## Gitlab

https://gitlab.mobime.dev/help/user/project/clusters/add_remove_clusters.md#add-existing-cluster


kubectl get secrets
kubectl get secret default-token-6sjvd -o jsonpath="{['data']['ca\.crt']}" | base64 --decode\n\n
kubectl apply -f gitlab-k8s-sa.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab-admin | awk '{print $1}')\n
