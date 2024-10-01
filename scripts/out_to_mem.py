import sys

def convert_to_mem():
    input_lines = sys.stdin.readlines()

    # Start with the radix declaration and initialization vector
    mem_lines = [
        "memory_initialization_radix=16;",
        "memory_initialization_vector="
    ]

    # Process each line from the input
    for line in input_lines:
        # Skip lines starting with '@'
        if line.startswith('@'):
            continue
        # Remove whitespace and split into chunks of 8 characters
        data = line.strip().replace(' ', '')
        for i in range(0, len(data), 8):
            chunk = data[i:i+8]
            mem_lines.append(f"{chunk},")

    # Remove the trailing comma from the last line and add a semicolon
    if mem_lines[-1].endswith(','):
        mem_lines[-1] = mem_lines[-1][:-1] + ';'

    # Print the result to stdout
    for mem_line in mem_lines:
        print(mem_line)

if __name__ == "__main__":
    convert_to_mem()
