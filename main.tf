provider "google" {
 credentials = "${file("CREDENTIALS_FILE.json")}"
 project     = "tech2hire"
 region      = "asia-southeast1"
}


data "google_compute_subnetwork" "my-subnetwork" {
  name   = "default-us-east1"
  region = "us-east1"
}



resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-private-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.custom-test.self_link}"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_subnetwork" "network-with-public-secondary-ip-ranges" {
  name          = "test-public-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = "asia-east1"
  network       = "${google_compute_network.custom-test.self_link}"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update2"
    ip_cidr_range = "192.168.0.0/24"
	
  }
}



resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
}


resource "random_id" "instance_id" {
 byte_length = 8
}


resource "google_compute_instance" "default" {
 name         = "tech2hire2"
 machine_type = "n1-standard-2"
 zone         = "us-central1-b"

 boot_disk {
   initialize_params {
     image = "rhel-7-v20190326"
   }
 }


 network_interface {
   network = "test-network"
   subnetwork = "test-public-subnetwork"

   access_config {
     
   }
 }
}