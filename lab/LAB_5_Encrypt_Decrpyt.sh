import math

def gcd(a, b):
    return math.gcd(a, b)

def mod_inverse(a, m=26):
    a = a % m
    for x in range(1, m):
        if (a * x) % m == 1:
            return x
    raise ValueError(f"Modular inverse for a={a} and m={m} does not exist.")

def validate_text(text):
    if not isinstance(text, str):
        raise TypeError("Text must be a string.")

def encrypt_shift(text, shift):
    validate_text(text)
    if not isinstance(shift, int):
        raise TypeError("Shift must be an integer.")
    
    result = []
    shift = shift % 26
    for char in text:
        if char.isupper():
            result.append(chr((ord(char) - 65 + shift) % 26 + 65))
        elif char.islower():
            result.append(chr((ord(char) - 97 + shift) % 26 + 97))
        else:
            result.append(char)
    return "".join(result)

def decrypt_shift(text, shift):
    return encrypt_shift(text, -shift)

def encrypt_caesar(text):
    return encrypt_shift(text, 3)

def decrypt_caesar(text):
    return decrypt_shift(text, 3)

def encrypt_rot13(text):
    return encrypt_shift(text, 13)

def decrypt_rot13(text):
    return encrypt_shift(text, 13)

def encrypt_atbash(text):
    validate_text(text)
    result = []
    for char in text:
        if char.isupper():
            result.append(chr(90 - (ord(char) - 65)))
        elif char.islower():
            result.append(chr(122 - (ord(char) - 97)))
        else:
            result.append(char)
    return "".join(result)

def decrypt_atbash(text):
    return encrypt_atbash(text)

def encrypt_affine(text, a, b):
    validate_text(text)
    if not isinstance(a, int) or not isinstance(b, int):
        raise TypeError("Keys 'a' and 'b' must be integers.")
    if gcd(a, 26) != 1:
        raise ValueError(f"Key 'a' ({a}) must be coprime to 26 (no shared factors).")
    
    result = []
    for char in text:
        if char.isupper():
            x = ord(char) - 65
            result.append(chr((a * x + b) % 26 + 65))
        elif char.islower():
            x = ord(char) - 97
            result.append(chr((a * x + b) % 26 + 97))
        else:
            result.append(char)
    return "".join(result)

def decrypt_affine(text, a, b):
    validate_text(text)
    if not isinstance(a, int) or not isinstance(b, int):
        raise TypeError("Keys 'a' and 'b' must be integers.")
    if gcd(a, 26) != 1:
        raise ValueError(f"Key 'a' ({a}) must be coprime to 26 (no shared factors).")
    
    a_inv = mod_inverse(a, 26)
    result = []
    for char in text:
        if char.isupper():
            y = ord(char) - 65
            result.append(chr((a_inv * (y - b)) % 26 + 65))
        elif char.islower():
            y = ord(char) - 97
            result.append(chr((a_inv * (y - b)) % 26 + 97))
        else:
            result.append(char)
    return "".join(result)

def main():
    while True:
        print("\n=== Classical Cipher Toolkit ===")
        print("1. Shift Cipher")
        print("2. Caesar Cipher")
        print("3. ROT13")
        print("4. Atbash Cipher")
        print("5. Affine Cipher")
        print("6. Exit")
        
        choice = input("Select a cipher (1-6): ").strip()
        
        if choice == '6':
            print("Exiting tool. Goodbye!")
            break
            
        if choice not in ['1', '2', '3', '4', '5']:
            print("Invalid selection. Please choice a number between 1 and 6.")
            continue
            
        mode = input("Choose action - (E)ncrypt or (D)ecrypt: ").strip().upper()
        if mode not in ['E', 'D']:
            print("Invalid action. Please enter 'E' or 'D'.")
            continue
            
        text = input("Enter your target text: ")
        
        try:
            if choice == '1':
                shift = int(input("Enter integer shift key value: "))
                if mode == 'E':
                    print("Result:", encrypt_shift(text, shift))
                else:
                    print("Result:", decrypt_shift(text, shift))
                    
            elif choice == '2':
                if mode == 'E':
                    print("Result:", encrypt_caesar(text))
                else:
                    print("Result:", decrypt_caesar(text))
                    
            elif choice == '3':
                if mode == 'E':
                    print("Result:", encrypt_rot13(text))
                else:
                    print("Result:", decrypt_rot13(text))
                    
            elif choice == '4':
                if mode == 'E':
                    print("Result:", encrypt_atbash(text))
                else:
                    print("Result:", decrypt_atbash(text))
                    
            elif choice == '5':
                a = int(input("Enter integer key 'a' (must be coprime to 26): "))
                b = int(input("Enter integer key 'b': "))
                if mode == 'E':
                    print("Result:", encrypt_affine(text, a, b))
                else:
                    print("Result:", decrypt_affine(text, a, b))
                    
        except ValueError as ve:
            print(f"Validation Error: {ve}")
        except Exception as e:
            print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()

