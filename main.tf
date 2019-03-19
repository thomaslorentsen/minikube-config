provider "kubernetes" {

}

variable "namespaces" {
  type = "list"
  default = [
    "test",
    "staging",
    "live"
  ]
}

resource "kubernetes_namespace" "namespace-test" {
  count    = "${length(var.namespaces)}"
  metadata {
    name = "${var.namespaces[count.index]}"
  }
}

resource "kubernetes_resource_quota" "test-resource-quota" {
  count    = "${length(var.namespaces)}"
  metadata {
    name = "${var.namespaces[count.index]}"
  }
  spec {
    hard {
      pods = 1
    }
    scopes = ["BestEffort"]
  }
}