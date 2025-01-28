output "jenkins_url" {
  description = "Jenkins url"
  value       = "${aws_instance.ubuntu-vm-instance.public_ip}:8080"
}