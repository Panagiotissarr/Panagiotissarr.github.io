import random

# Made by Stadof
# Github: https://github.com/stadof/

def generate_keys():
    characters = "123456789abcdefghijklmnopqrstuvwxyz".upper()
    print()
    print(" - Keys - \n")
    try:
        while True:
            final_key = ''
            for number_chact in range(25):
                final_key += random.choice(characters)
            final_key_1 = '-'.join(final_key[i:i+5] for i in range(0, 25, 5))
            print("", final_key_1)
    except KeyboardInterrupt:
        print("\nStopped key generation. Returning to menu...\n")

def main_menu():
    print()
    print("             ------------------------------------------")
    print("             ~~~~~~~~ WINDOWS 10 KEY GENERATOR ~~~~~~~~")
    print("             ------------------------------------------")
    print()
    print("This program uses Microsoft's algorithm to generate random Windows 10 keys")
    print("   Feel free to run the program several times to find a working key")
    print("                  --- NOT ALL KEYS WILL WORK ---")
    print()

    while True:
        print("Main Menu:")
        print("1. Generate keys continuously (press Ctrl+C to stop)")
        print("2. Exit")
        choice = input("Enter your choice (1/2): ").strip()

        if choice == "1":
            generate_keys()
        elif choice == "2":
            print("Exiting program. Goodbye!")
            break
        else:
            print("Invalid choice. Please select 1 or 2.")

if __name__ == "__main__":
    main_menu()

