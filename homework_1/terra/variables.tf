variable "credentials" {
  description = "My Credentials"
  default     = "./keys/my_creds.json"
}

variable "project" {
  description = "Project"
  default     = "terraform-demo-485118"
}

variable "region" {
  description = "Region"
  default     = "europe-west2"
}

variable "location" {
  description = "Project location"
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "My storage bucket name"
  default     = "terraform-demo--terra-bkt"
}

variable "gcs_storage_class" {
  description = "Storage Bucket Class"
  default     = "STANDARD"
}

variable "bq_dataset_name" {
  description = "My Bigquery dataset name"
  default     = "terra_dtst"
}
