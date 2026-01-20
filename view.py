import sys
import urllib.request

# -------------------------------------------
# REPLACE THIS with your actual GitHub username and repo name
BASE_URL = "https://raw.githubusercontent.com/YOUR_USERNAME/my-codes/main/"
# -------------------------------------------

def main():
    # If no file is asked for, warn the user
    if len(sys.argv) < 2:
        print("\n[Error] You forgot to ask for a file.")
        print("Usage example: ... | python - login.html\n")
        return

    filename = sys.argv[1]
    full_url = BASE_URL + filename

    try:
        # Fetch the code securely
        with urllib.request.urlopen(full_url) as response:
            code = response.read().decode('utf-8')
            
        # PRINT THE CODE TO THE SCREEN
        print(f"\n--- BEGIN {filename} ---\n")
        print(code)
        print(f"\n--- END {filename} ---\n")

    except Exception:
        print(f"\n[404] Could not find '{filename}'. Check spelling or extension.\n")

if __name__ == "__main__":
    main()
