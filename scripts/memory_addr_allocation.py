devices = [
    ('button', 2),
    ('led', 50),
    ('vga', 80)
]

offset = 0

BUS_WIDTH = 32

def format_hex(value : int, width : int = BUS_WIDTH) -> str:
    return f'{width}\'h{hex(offset)[2:].rjust(8,"0")}'

def clog2(value : int) -> int:    
    return value.bit_length() - ((value & (value - 1)) == 0)

for name, size in devices:
    allocation = clog2(size)
    addr = f'localparam [{BUS_WIDTH-1}:0] {name.upper()}_ADDR = {format_hex(allocation)};'
    mask = f'localparam [{BUS_WIDTH-1}:0] {name.upper()}_MASK = {format_hex(2**BUS_WIDTH - 1 - 2**allocation)};'

    print(addr)
    print(mask)
    
    offset += allocation


