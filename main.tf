variable "ami" {
    default = "ami-b80b6db8"
}

variable "key_name" {}
variable "iam_instance_profile" {}

provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "sv01" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    associate_public_ip_address = true
    iam_instance_profile = "${var.iam_instance_profile}"
    root_block_device = {
        delete_on_termination = true
        volume_type = "gp2"
    }
    tags {
        Name = "sv01"
    }
    user_data = <<EOS
        #cloud-config
        hostname: sv01
        runcmd:
          - systemctl restart rsyslog
        write_files:
          - path: /etc/sudoers.d/99-requiretty
            owner: root:root
            permissions: "0440"
            content: |+
                Defaults !requiretty
EOS
}

resource "aws_instance" "sv02" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    associate_public_ip_address = true
    iam_instance_profile = "${var.iam_instance_profile}"
    root_block_device = {
        delete_on_termination = true
        volume_type = "gp2"
    }
    tags {
        Name = "sv02"
    }
    user_data = <<EOS
        #cloud-config
        hostname: sv02
        runcmd:
          - systemctl restart rsyslog
        write_files:
          - path: /etc/sudoers.d/99-requiretty
            owner: root:root
            permissions: "0440"
            content: |+
                Defaults !requiretty
EOS
}

resource "aws_instance" "sv03" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    associate_public_ip_address = true
    iam_instance_profile = "${var.iam_instance_profile}"
    root_block_device = {
        delete_on_termination = true
        volume_type = "gp2"
    }
    tags {
        Name = "sv03"
    }
    user_data = <<EOS
        #cloud-config
        hostname: sv03
        runcmd:
          - systemctl restart rsyslog
        write_files:
          - path: /etc/sudoers.d/99-requiretty
            owner: root:root
            permissions: "0440"
            content: |+
                Defaults !requiretty
EOS
}

output "sv01" { value = "${aws_instance.sv01.public_ip}" }
output "sv02" { value = "${aws_instance.sv02.public_ip}" }
output "sv03" { value = "${aws_instance.sv03.public_ip}" }
