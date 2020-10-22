# -*- coding: utf-8 -*-

import argparse
import os


def run(action):
    os.system("sh bin/api.sh {}".format(action))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Process API control")
    parser.add_argument('action',
                        choices=[
                            'restart',
                            'status',
                            'stop',
                        ])
    opts = parser.parse_args()

    run(opts.action)