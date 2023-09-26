#!/usr/bin/python

# Author: 0xA

import socket
import sys
import argparse
from termcolor import colored

def create_empty_file(output_file):
    with open(output_file, 'w') as output:
        pass  # Creates an empty file or overwrites if it already exists

def enumerate_users(ip, wordlist, output_file=None, batch_size=10):
    batch_count = 0
    s = None  # Initialize the socket outside the loop

    if output_file:
        create_empty_file(output_file)

    try:
        with open(wordlist, 'r') as file:
            total_users = len(file.readlines())
            file.seek(0)  # Reset file position to the beginning
            users_found = []

            for idx, line in enumerate(file):
                if batch_count == 0:
                    if s:
                        s.close()  # Close the previous connection if it exists
                    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    connect = s.connect((ip, 25))
                    banner = s.recv(1024)
                    batch_count = batch_size

                user = line.strip().encode()
                s.send(b'VRFY ' + user + b'\r\n')
                result = s.recv(1024)

                if b'252' in result:
                    found_user = user.decode()
                    users_found.append(found_user)
                    print(colored(f" User {found_user} found!", 'green'))
                    if output_file:
                        with open(output_file, 'a') as output:
                            output.write(found_user + '\n')

                progress_message = f"Checking users... [{idx + 1}/{total_users}]"
                sys.stdout.write('\r' + progress_message)
                sys.stdout.flush()
                batch_count -= 1

            sys.stdout.write('\n')  # Print a newline to clear the progress message

        print("Enumeration complete.")

    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if s:
            s.close()  # Close the connection if it's still open

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='SMTP User Enumeration Script')
    parser.add_argument('ip', help='SMTP server IP address')
    parser.add_argument('wordlist', help='Wordlist file containing usernames')
    parser.add_argument('--output', help='Optional output file to store valid usernames')
    parser.add_argument('--batch-size', type=int, default=10, help='Batch size for opening connections')

    args = parser.parse_args()

    enumerate_users(args.ip, args.wordlist, args.output, args.batch_size)