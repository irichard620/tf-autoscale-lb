# tf-autoscale-lb

tf-autoscale-lb is a project that interfaces with AWS to create an autoscaling group of VMs behind a load balancer It uses terraform to create plans, apply them, and destroy infrastructure. Terraform commands are triggered using python in main.py.

# Pre-reqs:
  - Must have terraform installed on your computer
  - Must have python3 installed on your computer
  - Install requirements using pip3 install -r requirements.txt

# How to Use
  - Open main directory of project
  - Type python3 main.py <cmd>
  - <cmd> can be plan, apply, or destroy