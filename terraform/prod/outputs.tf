output "app_external_ip" {
  value = module.app.app_external_ip
}
output "db_external_ip" {
  value = module.db.db_external_ip
}
#output "app2_external_ip" {
#  value = google_compute_instance.app[1].network_interface[0].access_config[0].nat_ip
#}
#output "balancer_ip" {
#  value = google_compute_forwarding_rule.reddit-app-forwarding.ip_address
#}
