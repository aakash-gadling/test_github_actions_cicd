variable "region" {
  default = "ap-south-1"
}


variable "services" {
  description = "List of services"
  type        = list(string)
  default     = ["service-a", "service-b", "service-c"]
}
