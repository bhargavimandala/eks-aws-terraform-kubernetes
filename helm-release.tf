resource "helm_release" "nginx" {
  #provider  = helm.my_cluster
  name       = "nginx-mbr"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  namespace = "mbr-ns"
}
