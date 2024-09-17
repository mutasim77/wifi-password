# wifi-password 🔐 
`wifi-password` is a command-line tool that retrieves the password of the currently connected Wi-Fi network on macOS. It provides a simple and quick way to access Wi-Fi passwords without navigating through system preferences.

## Features
- Retrieves the password of the currently connected Wi-Fi network
- Works on macOS systems
- Provides verbose output option for detailed information
- Simple and easy-to-use command-line interface

## Installation
1. Clone this repository:
```bash
git clone https://github.com/mutasim77/wifi-password.git
```

2. Navigate to the project directory:
```bash
cd wifi-password
```

3. Make the script executable:
```bash
chmod +x wifi-password.sh
```

4. (Optional) Move the script to a directory in your PATH for easy access:
```bash
sudo mv wifi-password.sh /usr/local/bin/wifi-password
```

## Usage
Run the script with sudo privileges:
```bash
sudo wifi-password
```

## Options
`-h, --help`: Show help message and exit

`-v, --verbose`: Enable verbose output

## Requirements
- **macOS** (this script uses macOS-specific commands)
- **Sudo** privileges (to access the Keychain)

## But How It Works?

1. The script first checks if it's running on macOS.
2. It then retrieves the name of the currently connected Wi-Fi network using the networksetup command.
3. Using the security command, it accesses the macOS Keychain to retrieve the password for the identified network.
4. Finally, it displays the password to the user.

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

Built with ❤️ by [mutasim](https://www.mutasim.top/)
