#!/usr/bin/env python

'''Recreates secret key file
'''

from __future__ import (
    absolute_import,
    division,
    print_function,
    unicode_literals,
    with_statement,
)

import sys
from random import SystemRandom
from string import printable


def main():
    '''Main method
    '''
    rnd = SystemRandom()
    all_chars = printable.strip()
    key = ''.join([rnd.choice(all_chars) for _ in range(50)])
    with open(sys.argv[1], 'w') as fd_obj:
        fd_obj.write(key)


if __name__ == '__main__':
    main()
