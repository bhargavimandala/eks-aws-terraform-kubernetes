resource "helm_release" "nginx" {
  #provider  = helm.my_cluster
  name       = "nginx-bas"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  namespace = "sbr-ns"
}