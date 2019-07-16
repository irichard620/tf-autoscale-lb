## AutoScaling Group
resource "aws_autoscaling_group" "tf" {
    launch_configuration = "${aws_launch_configuration.tf.id}"
    availability_zones = "${data.aws_availability_zones.available.names}"
    min_size = 5
    max_size = 5
    load_balancers = ["${aws_elb.tf.name}"]
    health_check_type = "ELB"
    tag {
        key = "Name"
        value = "tf-asg"
        propagate_at_launch = true
    }
}

## Launch Configuration
resource "aws_launch_configuration" "tf" {
    image_id = "${var.ami}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.instance.id}"]
    key_name = "${var.keypair_name}"
    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo service httpd start
                sudo chkconfig httpd on
                sudo touch /var/www/html/index.html
                sudo chmod 777 /var/www/html/index.html
                echo "Hello World " > /var/www/html/index.html
                hostname -f >> /var/www/html/index.html
                EOF
    lifecycle {
        create_before_destroy = true
    }
}

## Load Balancer
resource "aws_elb" "tf" {
    name = "tf-lb"
    security_groups = ["${aws_security_group.elb.id}"]
    availability_zones = "${data.aws_availability_zones.available.names}"
    health_check {
        healthy_threshold = 5
        unhealthy_threshold = 2
        timeout = 3
        interval = 30
        target = "HTTP:80/index.html"
    }
    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = 80
        instance_protocol = "http"
    }
}

## Security Group for Instance
resource "aws_security_group" "instance" {
    name = "tf-sg-instance"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

## Security Group for Load Balancer
resource "aws_security_group" "elb" {
    name = "tf-sg-elb"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}