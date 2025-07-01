# LAMP Stack Infrastructure on AWS

A comprehensive Terraform project that deploys a scalable 3-tier LAMP (Linux, Apache, MySQL, PHP) stack architecture on AWS with proper security and networking configurations.

# Live Demo
Access the application using link : [`http://](http://18.193.116.73/)

##  Architecture Overview

This project creates a robust 3-tier architecture:

- **Web Tier**: Apache web server in public subnet serving the frontend
- **Application Tier**: PHP application server in private subnet handling business logic
- **Database Tier**: MySQL/MariaDB database server in private subnet for data persistence

### Infrastructure Components

- **VPC**: Custom Virtual Private Cloud with DNS support
- **Subnets**: 2 public and 2 private subnets across multiple AZs
- **Security Groups**: Layered security with specific port access controls
- **NAT Gateway**: Enables internet access for private subnet instances
- **Internet Gateway**: Provides internet connectivity for public resources
- **EC2 Instances**: Three instances for web, app, and database tiers

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions
- EC2 Key Pair for SSH access

## 🚀 Quick Start

### 1. Clone and Setup

```bash
git clone https://github.com/amt-kwame-agyabeng/lamp

```

### 2. Configure Variables

Create a `terraform.tfvars` file with your specific values:


### 3. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

### 4. Access Your Application

After deployment, get the web server's public IP:

```bash
terraform output
```

Access your feedback application at: `http://<web-server-public-ip>`

##  Project Structure

```
lamp/
├── modules/
│   ├── 01-Networking/         
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── output.tf
│   │   ├── locals.tf
│   │   └── ssm.tf
│   ├── 02-Security/            
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── output.tf
│   │   ├── locals.tf
│   │   └── ssm.tf
│   └── 03-Compute/            
│       ├── main.tf
│       ├── variables.tf
│       ├── output.tf
│       ├── locals.tf
│       └── ssm.tf
├── scripts/
│   ├── web_userdata.sh         # Web server setup script
│   ├── app_userdata.sh         # Application server setup script
│   └── db_userdata.sh          # Database server setup script
├── main.tf                     # Root module configuration
├── variables.tf                # Input variables
├── output.tf                   # Output values
├── provider.tf                 # AWS provider configuration
├── terraform.tfvars            # Variable values (create this)
└── README.md                   
```

##  Module Details

### Networking Module (01-Networking)

- Creates VPC with configurable CIDR block
- Sets up 2 public and 2 private subnets across different AZs
- Configures Internet Gateway for public internet access
- Creates NAT Gateways with Elastic IPs for private subnet internet access
- Sets up route tables and associations

### Security Module (02-Security)

- **Web Security Group**: Allows HTTP (80), HTTPS (443), and SSH (22) from internet
- **App Security Group**: Allows HTTP from web tier and SSH from bastion
- **Database Security Group**: Allows MySQL (3306) from app tier only

### Compute Module (03-Compute)

- **Web Server**: Apache + PHP in public subnet
- **App Server**: PHP + MySQL client in private subnet
- **Database Server**: MariaDB in private subnet
- Automated setup via user data scripts

## Security Features

- **Network Segmentation**: Multi-tier architecture with proper subnet isolation
- **Security Groups**: Principle of least privilege access
- **Private Subnets**: Database and application servers not directly accessible from internet
- **NAT Gateway**: Secure outbound internet access for private instances
- **SSH Key Authentication**: Secure instance access

## Application Features

The deployed application includes:

- **Feedback Form**: Simple web interface for user input
- **Data Processing**: PHP backend for form handling and storage
- **Database Storage**: MySQL database for persistent feedback data


### Application Endpoints

- `/` - Main feedback form (web server)
- `/submit.php` - Form submission handler (app server)


### Security Enhancements

 **Secrets Manager**: Use AWS Secrets Manager for credentials


## Monitoring and Troubleshooting

### Log Locations

- **User Data Logs**: `/var/log/user-data.log` on each instance
- **Apache Logs**: `/var/log/httpd/` on web and app servers
- **MySQL Logs**: `/var/log/mariadb/` on database server

### Common Issues

1. **Connection Timeouts**: Check security group rules and NACLs
2. **Database Connection**: Verify credentials and network connectivity
3. **Web Server 500 Errors**: Check PHP configuration and file permissions

### Testing Connectivity

```bash
# SSH to web server (replace with actual IP)
ssh -i your-key.pem ec2-user@<web-server-public-ip>

# Test app server connectivity from web server
curl http://<app-server-private-ip>/submit.php

# Test database connectivity from app server
mysql -h <db-server-private-ip> -u db_user -p feedback_db
```

##  Cost Optimization

- Use `t2.micro` instances for development (eligible for free tier)
- Consider Reserved Instances for production workloads
- Monitor NAT Gateway usage (charges for data processing)
- Use CloudWatch for resource utilization monitoring

##  Cleanup

To destroy all resources:

```bash
terraform destroy
```

** Warning**: This will permanently delete all resources and data.





