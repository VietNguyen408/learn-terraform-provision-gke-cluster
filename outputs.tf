output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_client_ca_certificate" {
  value = google_container_cluster.primary.cluster_ca_certificate
}

output "kubernetes_client_certificate" {
  value = google_container_cluster.primary.client_certificate
}

output "kubernetes_client_key" {
  value = google_container_cluster.primary.client_key
  sensitive = true
}

output "kubernetes_username" {
  value = google_container_cluster.primary.username
}

output "kubernetes_password" {
  value = google_container_cluster.primary.password
  sensitive = true
}