SECTIONS
{
    . = 0x00000000;  /* Start address of the text section */
    .text : {
        *(.text.main)  /* Place the main function at the start of the .text section */
        *(.text*)      /* Place other text sections */
    }
    .data : {
        *(.data)
    }
    .bss : {
        *(.bss)
    }
    /DISCARD/ : {
        *(.note*)
        *(.comment)
        *(.eh_frame)
    }
}