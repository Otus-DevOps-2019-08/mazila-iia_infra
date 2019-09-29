resource "google_compute_target_pool" "reddit-app-pool" {
  name = "reddit-app-pool"
  instances = "${google_compute_instance.app.*.self_link}"

  health_checks = [
    "${google_compute_http_health_check.reddit-app-health.name}",
  ]
}


resource "google_compute_http_health_check" "reddit-app-health" {
  name        = "reddit-app-health"
  port        = "9292"
}


resource "google_compute_forwarding_rule" "reddit-app-forwarding" {
  name = "reddit-app-forwarding"

  target = "${google_compute_target_pool.reddit-app-pool.self_link}"

  port_range = "9292"
}
