int table[5];

int* ram_start = (int*) 0x80000000;

int main(){
/*     ram_start[0] = 2;
    ram_start[1] = 3;
    ram_start[2] = table[0] + table[1]; */

    *ram_start = 2;

    return 0;
}