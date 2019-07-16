#!/usr/bin/python

from python_terraform import *

def main():
    if len(sys.argv) == 1:
        # Check if no argument passed
        print("Must pass command line argument of plan, apply, or destroy")
        return

    # Get argument
    command = sys.argv[1]

    # Check what it does
    if command == "plan":
        tf = Terraform(working_dir="./terraform")
        return_code, stdout, stderr = tf.plan(capture_output=False)
        print("Terraform plan returned with code " + str(return_code))
    elif command == "apply":
        tf = Terraform(working_dir="./terraform")
        return_code, stdout, stderr = tf.apply(capture_output=False)
        print("Terraform apply returned with code " + str(return_code))
    elif command == "destroy":
        tf = Terraform(working_dir="./terraform")
        return_code, stdout, stderr = tf.destroy(capture_output=False)
        print("Terraform destroy returned with code " + str(return_code))
    else:
        print("Must pass command line argument of plan, apply, or destroy")

if __name__ == "__main__":
    main()