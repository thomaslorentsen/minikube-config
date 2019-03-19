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

resource "kubernetes_resource_quota" "cluster-resource-quota" {
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

resource "kubernetes_limit_range" "cluster-limit-range" {
  count    = "${length(var.namespaces)}"
  metadata {
    name = "${var.namespaces[count.index]}"
  }
  spec {
    limit {
      type = "Pod"
      max {
        cpu = "200m"
        memory = "1024M"
      }
    }
    limit {
      type = "PersistentVolumeClaim"
      min {
        storage = "24M"
      }
    }
    limit {
      type = "Container"
      default {
        cpu = "50m"
        memory = "24M"
      }
    }
  }
}

resource "kubernetes_service_account" "example-service-account" {
  metadata {
    name = "example"
  }
}
