variable "name" {
  description = "Name of the Azure resource group."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "The resource group name must not be empty."
  }
}

variable "location" {
  description = "Azure region in which the resource group is created."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "The Azure location must not be empty."
  }
}

variable "tags" {
  description = "Tags to apply to the resource group."
  type        = map(string)
  default     = {}
}

variable "lock" {
  description = "Optional management lock configuration."

  type = object({
    enabled = optional(bool, false)
    level   = optional(string, "CanNotDelete")
  })

  default = {}

  validation {
    condition = contains(
      ["CanNotDelete", "ReadOnly"],
      var.lock.level
    )

    error_message = "Lock level must be either 'CanNotDelete' or 'ReadOnly'."
  }
}
