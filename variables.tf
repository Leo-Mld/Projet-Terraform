variable "aws_profile" {
  description = "AK/SK profile to use"
  type        = string
  default     = "default"
}

variable "count_instances" {
  description = "How many instances"
  type        = number
  default     = 2
}