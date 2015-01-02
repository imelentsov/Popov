#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Merkle puzzle.
    Programm will illustrate Merkle asymmetric hack.
"""

'''
Created on 2014-12-14 15:03
@summary: 
@author: i.melentsov
'''
import getopt, sys
from madryga import encrypt, decrypt, encrypt_weak, decrypt_weak
import random
import struct

blockSize = 128
messages = 4096
max_key = 65535

def main():
    # server creates weak encrypted keys:
    encrypted_messages = {}
    for key in range(messages):
        message = bytearray(blockSize)
        message_id = id(message)
        for i, key_byte in enumerate(struct.pack('<H', key)):
            message[i] = key_byte
        for i, hash_bytes in enumerate(struct.pack('<Q', message_id)):
            message[i + 2] = hash_bytes
        for i in range(11, blockSize):
            message[i] = random.randint(0, 127)
        encrypt_weak(message, random.randint(0, max_key))
        encrypted_messages[message_id] = message
    print("Server keys were generated.")

    # client choose random key
    encrypted_message = encrypted_messages[list(encrypted_messages.keys())[random.randint(0, messages - 1)]] 
    # imagine that we took encrypted_message not from encrypted_messages (which known only for server)

    # brute message 
    decrypted_message = brute(encrypted_message)
    

    client_key = struct.unpack("<H", decrypted_message[:2])[0]
    message_id = struct.unpack('<Q', decrypted_message[2:10])[0]
    print("Client found key - ", client_key)
    print("And server message id - ", message_id)

    # server takes encrypted_message by message_id and brute it
    decrypted_message = brute(encrypted_messages[message_id])
    server_key = struct.unpack("<H", decrypted_message[:2])[0]
    print("Server found key - ", server_key)

    # server and client tests key ecodeing them on strong cipher
    client_key_enc = bytearray(blockSize)
    for i, key_byte in enumerate(struct.pack('<H', client_key)):
        client_key_enc[i] = key_byte
    encrypt(client_key_enc, client_key)

    server_key_enc = bytearray(blockSize)
    for i, key_byte in enumerate(struct.pack('<H', server_key)):
        server_key_enc[i] = key_byte
    encrypt(server_key_enc, server_key)

    if server_key_enc == client_key_enc:
        print("Perfect, keys are the same.")
    else:
        print("Life of pain.")


def brute(encrypted_message):
    message = bytearray()
    for key in range(max_key + 1):
        message[:] = encrypted_message
        decrypt_weak(message, key)
        try:
            message[10:].decode('ascii')
            return message
        except Exception:
            pass
    print("Can not decrypt message.")
    print("Exit.")
    sys.exit(2)

if __name__ == '__main__':
    main()