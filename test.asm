global _start
_start:
        call main
exit:
				mov ebx, eax
        mov eax, 1
        int 0x80
main:
        push ebp
        mov ebp, esp
        call name
        mov [ebp-4], eax
        pop ebp
        ret
name:
        push ebp
        mov ebp, esp
        mov eax, 5
        pop ebp
        ret
