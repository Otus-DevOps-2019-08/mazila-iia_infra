output "db_local_ip" {
  value = google_compute_instance.db.network_interface.0.network_ip
}
output "db_external_ip" {
  value = google_compute_instance.db.network_interface.0.access_config.0.nat_ip
}
