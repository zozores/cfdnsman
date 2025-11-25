# Cloudflare DNS Manager (cfdnsman)

This Terraform project allows you to manage Cloudflare DNS records across multiple zones using Infrastructure as Code (IaC).

## Features

- **Multi-Zone Support**: Manage DNS records for multiple Cloudflare zones in a single configuration.
- **Flexible Record Management**: Define various record types (A, CNAME, TXT, etc.) with support for TTL, proxy status, and priority.
- **Automated Management**: Use Terraform to version control and automate your DNS updates.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- A [Cloudflare](https://www.cloudflare.com/) account with an API Token.

## Configuration

The project uses the following variables:

| Variable | Description | Type | Sensitive |
|----------|-------------|------|-----------|
| `cloudflare_api_token` | Your Cloudflare API Token. | `string` | Yes |
| `zones` | A map of zones and their associated DNS records. | `map(object)` | No |

### Zone Configuration Structure

The `zones` variable is a map where the key is a unique identifier for the zone (e.g., the domain name), and the value is an object containing:

- `zone_id`: The Cloudflare Zone ID.
- `records`: A map of DNS records for that zone.

Each record object supports:
- `name`: The record name (e.g., "www", "@").
- `value`: The record value (e.g., IP address, domain name).
- `type`: The record type (e.g., "A", "CNAME").
- `ttl`: (Optional) Time to Live in seconds. Default: `1` (automatic).
- `proxied`: (Optional) Whether the record is proxied by Cloudflare. Default: `false`.
- `priority`: (Optional) Priority for MX records.

## Usage

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd cfdnsman
   ```

2. **Initialize Terraform:**

   ```bash
   terraform init
   ```

3. **Configure Variables:**

   Copy the example variable file:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

   Edit `terraform.tfvars` and add your Cloudflare API Token and DNS configurations:

   ```hcl
   cloudflare_api_token = "your-api-token"

   zones = {
     "example-com" = {
       zone_id = "your-zone-id-1"
       records = {
         "www" = {
           name    = "www"
           value   = "192.0.2.1"
           type    = "A"
           proxied = true
         }
       }
     }
   }
   ```

4. **Plan Changes:**

   Review the changes Terraform will make:

   ```bash
   terraform plan
   ```

5. **Apply Changes:**

   Apply the configuration to create/update records:

   ```bash
   terraform apply
   ```

## Files

- `main.tf`: Contains the logic to flatten the zone/record structure and create `cloudflare_record` resources.
- `variables.tf`: Defines the input variables.
- `versions.tf`: Specifies the required Terraform version and Cloudflare provider.
- `terraform.tfvars.example`: An example configuration file.

## License

[MIT](LICENSE)
