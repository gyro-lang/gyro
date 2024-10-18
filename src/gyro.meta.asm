
%define MAX_INPUT_LENGTH 65536
    
%include './lib/asm_macros.asm'
    
section .bss
    last_match resb 512
    
section .bss
    ST resb 65536
    
section .data
    STO dd 12
    
section .data
    VAR_IN_BODY dd 0
    
section .data
    AEXP_SEC_NUM dd 0
    
section .data
    EAX_WAS_NUMBER dd 0
    
section .data
    EBX_WAS_NUMBER dd 0
    
section .text
    global _start
    
_start:
    call _read_file_argument
    call _read_file
    push ebp
    mov ebp, esp
    call PROGRAM
    pop ebp
    mov eax, 1
    mov ebx, 0
    int 0x80
    
PROGRAM:
    call label
    print "section .text"
    call newline
    print "global _start"
    call newline
    call label
    print "_start:"
    call newline
    print "push ebp"
    call newline
    print "mov ebp, esp"
    call newline
    
LA1:
    call vstack_clear
    call LET_EXPRESSION
    call vstack_restore
    jne LA2
    test_input_string ";"
    mov edi, 3
    jne terminate_program ; 3
    
LA2:
    je LA3
    call vstack_clear
    call TYPE_EXPRESSION
    call vstack_restore
    jne LA4
    test_input_string ";"
    mov edi, 4
    jne terminate_program ; 4
    
LA4:
    je LA3
    call vstack_clear
    call COMMENT
    call vstack_restore
    jne LA5
    
LA5:
    je LA3
    call vstack_clear
    call ENUM_EXPRESSION
    call vstack_restore
    jne LA6
    
LA6:
    je LA3
    call vstack_clear
    call FN_EXPRESSION
    call vstack_restore
    jne LA7
    
LA7:
    je LA3
    call vstack_clear
    call DIRECT_ASSEMBLY_EXPRESSION
    call vstack_restore
    jne LA8
    test_input_string ";"
    mov edi, 5
    jne terminate_program ; 5
    
LA8:
    je LA3
    call vstack_clear
    call FN_CALL
    call vstack_restore
    jne LA9
    test_input_string ";"
    mov edi, 6
    jne terminate_program ; 6
    
LA9:
    je LA3
    call vstack_clear
    call IF_STATEMENT
    call vstack_restore
    jne LA10
    
LA10:
    je LA3
    call vstack_clear
    call WHILE_STATEMENT
    call vstack_restore
    jne LA11
    
LA11:
    
LA3:
    je LA1
    call set_true
    mov edi, 7
    jne terminate_program ; 7
    print "pop ebp"
    call newline
    print "mov eax, 1"
    call newline
    print "mov ebx, 0"
    call newline
    print "int 0x80"
    call newline
    
LA12:
    
LA13:
    ret
    
FN_EXPRESSION:
    test_input_string "fn"
    jne LA14
    print "jmp "
    call gn1
    call newline
    call test_for_id
    mov edi, 13
    jne terminate_program ; 13
    call label
    call copy_last_match
    print ":"
    call newline
    print "push ebp"
    call newline
    print "mov ebp, esp"
    call newline
    test_input_string "("
    mov edi, 16
    jne terminate_program ; 16
    
LA15:
    call test_for_id
    jne LA16
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 17
    jne terminate_program ; 17
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 18
    jne terminate_program ; 18
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, dword [STO]
    call print_int
    pop eax
    popfd
    print "], edi"
    call newline
    
LA16:
    
LA17:
    je LA15
    call set_true
    mov edi, 20
    jne terminate_program ; 20
    
LA18:
    test_input_string ","
    jne LA19
    call test_for_id
    mov edi, 21
    jne terminate_program ; 21
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 22
    jne terminate_program ; 22
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 23
    jne terminate_program ; 23
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, dword [STO]
    call print_int
    pop eax
    popfd
    print "], esi"
    call newline
    
LA19:
    
LA20:
    jne LA21
    
LA22:
    test_input_string ","
    jne LA23
    call test_for_id
    mov edi, 25
    jne terminate_program ; 25
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 26
    jne terminate_program ; 26
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 27
    jne terminate_program ; 27
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, dword [STO]
    call print_int
    pop eax
    popfd
    print "], edx"
    call newline
    
LA24:
    test_input_string ","
    jne LA25
    call test_for_id
    mov edi, 29
    jne terminate_program ; 29
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 30
    jne terminate_program ; 30
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 31
    jne terminate_program ; 31
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, dword [STO]
    call print_int
    pop eax
    popfd
    print "], ecx"
    call newline
    
LA26:
    test_input_string ","
    jne LA27
    call test_for_id
    mov edi, 33
    jne terminate_program ; 33
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 34
    jne terminate_program ; 34
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 35
    jne terminate_program ; 35
    
LA27:
    
LA28:
    je LA26
    call set_true
    mov edi, 36
    jne terminate_program ; 36
    
LA25:
    
LA29:
    je LA24
    call set_true
    mov edi, 37
    jne terminate_program ; 37
    
LA23:
    
LA30:
    je LA22
    call set_true
    mov edi, 38
    jne terminate_program ; 38
    
LA21:
    
LA31:
    je LA18
    call set_true
    mov edi, 39
    jne terminate_program ; 39
    test_input_string ")"
    mov edi, 40
    jne terminate_program ; 40
    test_input_string "{"
    mov edi, 41
    jne terminate_program ; 41
    call vstack_clear
    call BODY
    call vstack_restore
    mov edi, 42
    jne terminate_program ; 42
    test_input_string "}"
    mov edi, 43
    jne terminate_program ; 43
    pushfd
    push eax
    mov eax, dword [STO]
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    mul ebx
    push ebx
    pop ebx
    pop eax
    sub eax, ebx
    mov dword [STO], eax
    pop eax
    popfd
    mov edi, 44
    jne terminate_program ; 44
    print "pop ebp"
    call newline
    print "ret"
    call newline
    call label
    call gn1
    print ":"
    call newline
    
LA14:
    
LA32:
    ret
    
BODY:
    
LA33:
    call vstack_clear
    call RETURN_EXPRESSION
    call vstack_restore
    jne LA34
    test_input_string ";"
    mov edi, 47
    jne terminate_program ; 47
    
LA34:
    je LA35
    call vstack_clear
    call IF_STATEMENT
    call vstack_restore
    jne LA36
    
LA36:
    je LA35
    call vstack_clear
    call COMMENT
    call vstack_restore
    jne LA37
    
LA37:
    je LA35
    call vstack_clear
    call WHILE_STATEMENT
    call vstack_restore
    jne LA38
    
LA38:
    je LA35
    call vstack_clear
    call LET_EXPRESSION
    call vstack_restore
    jne LA39
    test_input_string ";"
    mov edi, 48
    jne terminate_program ; 48
    
LA39:
    je LA35
    call vstack_clear
    call DIRECT_ASSEMBLY_EXPRESSION
    call vstack_restore
    jne LA40
    test_input_string ";"
    mov edi, 49
    jne terminate_program ; 49
    
LA40:
    je LA35
    call vstack_clear
    call TYPE_EXPRESSION
    call vstack_restore
    jne LA41
    test_input_string ";"
    mov edi, 50
    jne terminate_program ; 50
    
LA41:
    je LA35
    call vstack_clear
    call ENUM_EXPRESSION
    call vstack_restore
    jne LA42
    
LA42:
    je LA35
    call vstack_clear
    call FN_CALL
    call vstack_restore
    jne LA43
    test_input_string ";"
    mov edi, 51
    jne terminate_program ; 51
    
LA43:
    je LA35
    call vstack_clear
    call FN_EXPRESSION
    call vstack_restore
    jne LA44
    
LA44:
    
LA35:
    je LA33
    call set_true
    jne LA45
    
LA45:
    
LA46:
    ret
    
FN_CALL:
    call test_for_id
    jne LA47
    mov edi, str_vector_8192
    mov esi, last_match
    call vector_push_string_mm32
    mov edi, 52
    jne terminate_program ; 52
    test_input_string "("
    mov edi, 53
    jne terminate_program ; 53
    call vstack_clear
    call FN_CALL_ARGUMENTS
    call vstack_restore
    mov edi, 54
    jne terminate_program ; 54
    test_input_string ")"
    mov edi, 55
    jne terminate_program ; 55
    print "call "
    mov edi, str_vector_8192
    call vector_pop_string
    call print_mm32
    call newline
    
LA47:
    
LA48:
    ret
    
FN_CALL_ARGUMENTS:
    
LA49:
    call test_for_number
    jne LA50
    print "mov edi, "
    call copy_last_match
    call newline
    
LA50:
    je LA51
    call test_for_id
    jne LA52
    print "mov edi, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA52:
    je LA51
    test_input_string "*"
    jne LA53
    call test_for_id
    mov edi, 59
    jne terminate_program ; 59
    print "mov edi, dword ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    call newline
    
LA53:
    je LA51
    call test_for_string
    jne LA54
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    print "mov edi, "
    call gn3
    call newline
    
LA54:
    
LA51:
    je LA49
    call set_true
    jne LA55
    
LA56:
    test_input_string ","
    jne LA57
    call test_for_number
    jne LA58
    print "mov esi, "
    call copy_last_match
    call newline
    
LA58:
    je LA59
    call test_for_id
    jne LA60
    print "mov esi, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA60:
    je LA59
    test_input_string "*"
    jne LA61
    call test_for_id
    mov edi, 65
    jne terminate_program ; 65
    print "mov esi, dword ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    call newline
    
LA61:
    je LA59
    call test_for_string
    jne LA62
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    print "mov esi, "
    call gn3
    call newline
    
LA62:
    
LA59:
    mov edi, 69
    jne terminate_program ; 69
    
LA63:
    test_input_string ","
    jne LA64
    call test_for_number
    jne LA65
    print "mov edx, "
    call copy_last_match
    call newline
    
LA65:
    je LA66
    call test_for_id
    jne LA67
    print "mov edx, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA67:
    je LA66
    test_input_string "*"
    jne LA68
    call test_for_id
    mov edi, 72
    jne terminate_program ; 72
    print "mov edx, dword ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    call newline
    
LA68:
    je LA66
    call test_for_string
    jne LA69
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    print "mov edx, "
    call gn3
    call newline
    
LA69:
    
LA66:
    mov edi, 76
    jne terminate_program ; 76
    
LA70:
    test_input_string ","
    jne LA71
    call test_for_number
    jne LA72
    print "mov ecx, "
    call copy_last_match
    call newline
    
LA72:
    je LA73
    call test_for_id
    jne LA74
    print "mov ecx, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA74:
    je LA73
    test_input_string "*"
    jne LA75
    call test_for_id
    mov edi, 79
    jne terminate_program ; 79
    print "mov ecx, dword ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    call newline
    
LA75:
    je LA73
    call test_for_string
    jne LA76
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    print "mov ecx, "
    call gn3
    call newline
    
LA76:
    
LA73:
    mov edi, 83
    jne terminate_program ; 83
    
LA77:
    test_input_string ","
    jne LA78
    call test_for_number
    jne LA79
    print "push "
    call copy_last_match
    call newline
    
LA79:
    je LA80
    call test_for_id
    jne LA81
    print "push ["
    call copy_last_match
    print "]"
    call newline
    
LA81:
    je LA80
    test_input_string "*"
    jne LA82
    print "push "
    call copy_last_match
    call newline
    
LA82:
    je LA80
    call test_for_string
    jne LA83
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    print "push "
    call gn3
    call newline
    
LA83:
    
LA80:
    mov edi, 89
    jne terminate_program ; 89
    
LA78:
    
LA84:
    je LA77
    call set_true
    mov edi, 90
    jne terminate_program ; 90
    
LA71:
    
LA85:
    je LA70
    call set_true
    mov edi, 91
    jne terminate_program ; 91
    
LA64:
    
LA86:
    je LA63
    call set_true
    mov edi, 92
    jne terminate_program ; 92
    
LA57:
    
LA87:
    je LA56
    call set_true
    mov edi, 93
    jne terminate_program ; 93
    
LA55:
    
LA88:
    ret
    
AEXP:
    call vstack_clear
    call EX1
    call vstack_restore
    jne LA89
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 94
    jne terminate_program ; 94
    
LA90:
    test_input_string "="
    jne LA91
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 95
    jne terminate_program ; 95
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA91:
    
LA92:
    jne LA93
    mov edi, 97
    jne terminate_program ; 97
    mov edi, 98
    jne terminate_program ; 98
    mov edi, 99
    jne terminate_program ; 99
    
LA93:
    je LA94
    test_input_string "+="
    jne LA95
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 100
    jne terminate_program ; 100
    print "add dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA95:
    
LA96:
    jne LA97
    
LA97:
    je LA94
    test_input_string "-="
    jne LA98
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 102
    jne terminate_program ; 102
    print "sub dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA98:
    
LA99:
    jne LA100
    mov edi, 104
    jne terminate_program ; 104
    
LA100:
    je LA94
    test_input_string "*="
    jne LA101
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 105
    jne terminate_program ; 105
    print "imul dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA101:
    
LA102:
    jne LA103
    
LA103:
    je LA94
    test_input_string "/="
    jne LA104
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 107
    jne terminate_program ; 107
    print "idiv dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA104:
    
LA105:
    jne LA106
    
LA106:
    je LA94
    test_input_string "%="
    jne LA107
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 109
    jne terminate_program ; 109
    print "idiv dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    print "push edx"
    call newline
    
LA107:
    
LA108:
    jne LA109
    mov edi, 112
    jne terminate_program ; 112
    
LA109:
    je LA94
    test_input_string "<<="
    jne LA110
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 113
    jne terminate_program ; 113
    print "shl dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA110:
    
LA111:
    jne LA112
    
LA112:
    je LA94
    test_input_string ">>="
    jne LA113
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 115
    jne terminate_program ; 115
    print "shr dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA113:
    
LA114:
    jne LA115
    mov edi, 117
    jne terminate_program ; 117
    
LA115:
    je LA94
    test_input_string "&="
    jne LA116
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 118
    jne terminate_program ; 118
    print "and dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA116:
    
LA117:
    jne LA118
    
LA118:
    je LA94
    test_input_string "^="
    jne LA119
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 120
    jne terminate_program ; 120
    print "xor dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA119:
    
LA120:
    jne LA121
    
LA121:
    je LA94
    test_input_string "|="
    jne LA122
    call vstack_clear
    call EX1
    call vstack_restore
    mov edi, 122
    jne terminate_program ; 122
    print "or dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA122:
    
LA123:
    jne LA124
    
LA124:
    
LA94:
    je LA90
    call set_true
    mov edi, 124
    jne terminate_program ; 124
    
LA89:
    
LA125:
    ret
    
EX1:
    call vstack_clear
    call EX2
    call vstack_restore
    jne LA126
    
LA127:
    test_input_string "?"
    jne LA128
    print "cmp eax, 0"
    call newline
    mov edi, 126
    jne terminate_program ; 126
    print "je "
    call gn1
    call newline
    call vstack_clear
    call EX2
    call vstack_restore
    mov edi, 128
    jne terminate_program ; 128
    mov edi, 129
    jne terminate_program ; 129
    print "jmp "
    call gn2
    call newline
    test_input_string ":"
    mov edi, 131
    jne terminate_program ; 131
    call label
    call gn1
    print ":"
    call newline
    call vstack_clear
    call EX2
    call vstack_restore
    mov edi, 132
    jne terminate_program ; 132
    call label
    call gn2
    print ":"
    call newline
    
LA128:
    
LA129:
    je LA127
    call set_true
    mov edi, 133
    jne terminate_program ; 133
    
LA126:
    
LA130:
    ret
    
EX2:
    call vstack_clear
    call EX3
    call vstack_restore
    jne LA131
    
LA132:
    test_input_string "||"
    jne LA133
    call vstack_clear
    call EX3
    call vstack_restore
    mov edi, 134
    jne terminate_program ; 134
    print "or eax, ebx"
    call newline
    
LA133:
    
LA134:
    je LA132
    call set_true
    mov edi, 136
    jne terminate_program ; 136
    
LA131:
    
LA135:
    ret
    
EX3:
    call vstack_clear
    call EX4
    call vstack_restore
    jne LA136
    
LA137:
    test_input_string "&&"
    jne LA138
    call vstack_clear
    call EX4
    call vstack_restore
    mov edi, 137
    jne terminate_program ; 137
    print "and eax, ebx"
    call newline
    
LA138:
    
LA139:
    je LA137
    call set_true
    mov edi, 139
    jne terminate_program ; 139
    
LA136:
    
LA140:
    ret
    
EX4:
    call vstack_clear
    call EX5
    call vstack_restore
    jne LA141
    
LA142:
    test_input_string "|"
    jne LA143
    call vstack_clear
    call EX5
    call vstack_restore
    mov edi, 140
    jne terminate_program ; 140
    print "or eax, ebx"
    call newline
    
LA143:
    
LA144:
    je LA142
    call set_true
    mov edi, 142
    jne terminate_program ; 142
    
LA141:
    
LA145:
    ret
    
EX5:
    call vstack_clear
    call EX6
    call vstack_restore
    jne LA146
    
LA147:
    test_input_string "^"
    jne LA148
    call vstack_clear
    call EX6
    call vstack_restore
    mov edi, 143
    jne terminate_program ; 143
    print "xor eax, ebx"
    call newline
    
LA148:
    
LA149:
    je LA147
    call set_true
    mov edi, 145
    jne terminate_program ; 145
    
LA146:
    
LA150:
    ret
    
EX6:
    call vstack_clear
    call EX7
    call vstack_restore
    jne LA151
    
LA152:
    test_input_string "&"
    jne LA153
    call vstack_clear
    call EX7
    call vstack_restore
    mov edi, 146
    jne terminate_program ; 146
    print "and eax, ebx"
    call newline
    
LA153:
    
LA154:
    je LA152
    call set_true
    mov edi, 148
    jne terminate_program ; 148
    
LA151:
    
LA155:
    ret
    
EX7:
    call vstack_clear
    call EX8
    call vstack_restore
    jne LA156
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 149
    jne terminate_program ; 149
    
LA157:
    test_input_string "=="
    jne LA158
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 150
    jne terminate_program ; 150
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 151
    jne terminate_program ; 151
    print "cmp eax, ebx"
    call newline
    print "je "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA158:
    je LA159
    test_input_string "!="
    jne LA160
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 157
    jne terminate_program ; 157
    print "cmp eax, ebx"
    call newline
    print "jne "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA160:
    
LA159:
    je LA157
    call set_true
    mov edi, 163
    jne terminate_program ; 163
    
LA156:
    
LA161:
    ret
    
EX8:
    call vstack_clear
    call EX9
    call vstack_restore
    jne LA162
    
LA163:
    test_input_string "<="
    jne LA164
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 164
    jne terminate_program ; 164
    print "cmp eax, ebx"
    call newline
    print "jle "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA164:
    je LA165
    test_input_string ">="
    jne LA166
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 170
    jne terminate_program ; 170
    print "cmp eax, ebx"
    call newline
    print "jge "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA166:
    je LA165
    test_input_string "<"
    jne LA167
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 176
    jne terminate_program ; 176
    print "cmp eax, ebx"
    call newline
    print "jl "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA167:
    je LA165
    test_input_string ">"
    jne LA168
    call vstack_clear
    call EX9
    call vstack_restore
    mov edi, 182
    jne terminate_program ; 182
    print "cmp eax, ebx"
    call newline
    print "jg "
    call gn1
    call newline
    print "mov eax, 0"
    call newline
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    print "mov eax, 1"
    call newline
    call label
    call gn2
    print ":"
    call newline
    
LA168:
    
LA165:
    je LA163
    call set_true
    mov edi, 188
    jne terminate_program ; 188
    
LA162:
    
LA169:
    ret
    
EX9:
    call vstack_clear
    call EX10
    call vstack_restore
    jne LA170
    
LA171:
    test_input_string "<<"
    jne LA172
    call vstack_clear
    call EX10
    call vstack_restore
    mov edi, 189
    jne terminate_program ; 189
    print "shl eax, ebx"
    call newline
    
LA172:
    je LA173
    test_input_string ">>"
    jne LA174
    call vstack_clear
    call EX10
    call vstack_restore
    mov edi, 191
    jne terminate_program ; 191
    print "shr eax, ebx"
    call newline
    
LA174:
    
LA173:
    je LA171
    call set_true
    mov edi, 193
    jne terminate_program ; 193
    
LA170:
    
LA175:
    ret
    
EX10:
    call vstack_clear
    call EX11
    call vstack_restore
    jne LA176
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 194
    jne terminate_program ; 194
    
LA177:
    test_input_string "+"
    jne LA178
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 195
    jne terminate_program ; 195
    call vstack_clear
    call EX11
    call vstack_restore
    mov edi, 196
    jne terminate_program ; 196
    print "add eax, ebx"
    call newline
    
LA178:
    je LA179
    test_input_string "-"
    jne LA180
    call vstack_clear
    call EX11
    call vstack_restore
    mov edi, 198
    jne terminate_program ; 198
    print "sub eax, ebx"
    call newline
    
LA180:
    
LA179:
    je LA177
    call set_true
    mov edi, 200
    jne terminate_program ; 200
    
LA176:
    
LA181:
    ret
    
EX11:
    call vstack_clear
    call EX12
    call vstack_restore
    jne LA182
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 201
    jne terminate_program ; 201
    
LA183:
    test_input_string "*"
    jne LA184
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 202
    jne terminate_program ; 202
    call vstack_clear
    call EX12
    call vstack_restore
    mov edi, 203
    jne terminate_program ; 203
    print "imul ebx"
    call newline
    
LA184:
    je LA185
    test_input_string "/"
    jne LA186
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 205
    jne terminate_program ; 205
    call vstack_clear
    call EX12
    call vstack_restore
    mov edi, 206
    jne terminate_program ; 206
    print "idiv eax, ebx"
    call newline
    
LA186:
    je LA185
    test_input_string "%"
    jne LA187
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 208
    jne terminate_program ; 208
    call vstack_clear
    call EX12
    call vstack_restore
    mov edi, 209
    jne terminate_program ; 209
    print "idiv eax, ebx"
    call newline
    print "push edx"
    call newline
    
LA187:
    
LA185:
    je LA183
    call set_true
    mov edi, 212
    jne terminate_program ; 212
    
LA182:
    
LA188:
    ret
    
EX12:
    call vstack_clear
    call EX13
    call vstack_restore
    jne LA189
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 213
    jne terminate_program ; 213
    
LA190:
    test_input_string "**"
    jne LA191
    pushfd
    push eax
    mov eax, 1
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 214
    jne terminate_program ; 214
    call vstack_clear
    call EX12
    call vstack_restore
    mov edi, 215
    jne terminate_program ; 215
    print "exp"
    call newline
    
LA191:
    
LA192:
    je LA190
    call set_true
    mov edi, 217
    jne terminate_program ; 217
    
LA189:
    
LA193:
    ret
    
EX13:
    test_input_string "++"
    jne LA194
    call vstack_clear
    call EX14
    call vstack_restore
    mov edi, 218
    jne terminate_program ; 218
    print "mov eax, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    print "inc eax"
    call newline
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    
LA194:
    je LA195
    test_input_string "--"
    jne LA196
    call vstack_clear
    call EX14
    call vstack_restore
    mov edi, 222
    jne terminate_program ; 222
    print "mov eax, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    print "dec eax"
    call newline
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "], eax"
    call newline
    mov edi, 226
    jne terminate_program ; 226
    
LA196:
    je LA195
    test_input_string "*"
    jne LA197
    call test_for_id
    mov edi, 227
    jne terminate_program ; 227
    print "mov eax, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    print "mov eax, dword [eax]"
    call newline
    mov edi, 230
    jne terminate_program ; 230
    
LA197:
    je LA195
    test_input_string "&"
    jne LA198
    call test_for_id
    mov edi, 231
    jne terminate_program ; 231
    print "lea eax, [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA198:
    je LA195
    test_input_string "+"
    jne LA199
    call vstack_clear
    call EX14
    call vstack_restore
    mov edi, 233
    jne terminate_program ; 233
    
LA199:
    je LA195
    test_input_string "-"
    jne LA200
    call vstack_clear
    call EX14
    call vstack_restore
    mov edi, 234
    jne terminate_program ; 234
    print "neg eax"
    call newline
    
LA200:
    je LA195
    call vstack_clear
    call ARRAY_SUBSCRIPTING
    call vstack_restore
    jne LA201
    
LA201:
    je LA195
    call vstack_clear
    call EX14
    call vstack_restore
    jne LA202
    
LA202:
    
LA195:
    ret
    
EX14:
    call test_for_id
    jne LA203
    mov edi, str_vector_8192
    mov esi, last_match
    call vector_push_string_mm32
    mov edi, 236
    jne terminate_program ; 236
    test_input_string "("
    jne LA204
    
LA205:
    call vstack_clear
    call FN_CALL_ARGUMENTS
    call vstack_restore
    je LA205
    call set_true
    mov edi, 237
    jne terminate_program ; 237
    test_input_string ")"
    mov edi, 238
    jne terminate_program ; 238
    print "call "
    mov edi, str_vector_8192
    call vector_pop_string
    call print_mm32
    call newline
    
LA204:
    
LA206:
    jne LA207
    mov edi, 240
    jne terminate_program ; 240
    
LA207:
    je LA208
    test_input_string "++"
    jne LA209
    print "inc dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    mov edi, 242
    jne terminate_program ; 242
    
LA209:
    je LA208
    test_input_string "--"
    jne LA210
    print "dec dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA210:
    je LA208
    call set_true
    jne LA211
    mov eax, dword [AEXP_SEC_NUM]
    cmp eax, 0
    jne LA212
    print "mov eax, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    
LA212:
    je LA213
    print "mov ebx, dword [ebp+"
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    call hash_get
    pop eax
    popfd
    print "]"
    call newline
    call set_true
    
LA214:
    
LA213:
    mov edi, 246
    jne terminate_program ; 246
    
LA211:
    
LA208:
    mov edi, 247
    jne terminate_program ; 247
    
LA203:
    je LA215
    call test_for_number
    jne LA216
    mov eax, dword [AEXP_SEC_NUM]
    cmp eax, 0
    jne LA217
    print "mov eax, "
    call copy_last_match
    call newline
    
LA217:
    je LA218
    print "mov ebx, "
    call copy_last_match
    call newline
    call set_true
    
LA219:
    
LA218:
    mov edi, 250
    jne terminate_program ; 250
    
LA216:
    je LA215
    call test_for_string
    jne LA220
    call label
    print "section .data"
    call newline
    call gn3
    print " db "
    call copy_last_match
    print ", 0x00"
    call newline
    call label
    print "section .text"
    call newline
    mov eax, dword [AEXP_SEC_NUM]
    cmp eax, 0
    jne LA221
    print "mov eax, "
    call gn3
    call newline
    
LA221:
    je LA222
    print "mov ebx, "
    call gn3
    call newline
    call set_true
    
LA223:
    
LA222:
    mov edi, 254
    jne terminate_program ; 254
    
LA224:
    
LA225:
    mov edi, 255
    jne terminate_program ; 255
    
LA220:
    je LA215
    test_input_string "("
    jne LA226
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 256
    jne terminate_program ; 256
    test_input_string ")"
    mov edi, 257
    jne terminate_program ; 257
    
LA226:
    
LA215:
    ret
    
ARRAY_SUBSCRIPTING:
    call test_for_id
    jne LA227
    print "mov eax, "
    mov edi, str_vector_8192
    call vector_pop_string
    call print_mm32
    call newline
    test_input_string "["
    mov edi, 259
    jne terminate_program ; 259
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 260
    jne terminate_program ; 260
    test_input_string "]"
    mov edi, 261
    jne terminate_program ; 261
    
LA227:
    
LA228:
    ret
    
BASIC_TYPE:
    test_input_string "i8"
    jne LA229
    print "; type: i8"
    call newline
    
LA229:
    je LA230
    test_input_string "i16"
    jne LA231
    print "; type: i16"
    call newline
    
LA231:
    je LA230
    test_input_string "i32"
    jne LA232
    print "; type: i32"
    call newline
    
LA232:
    je LA230
    test_input_string "i64"
    jne LA233
    print "; type: i64"
    call newline
    
LA233:
    je LA230
    test_input_string "u8"
    jne LA234
    print "; type: u8"
    call newline
    
LA234:
    je LA230
    test_input_string "u16"
    jne LA235
    print "; type: u16"
    call newline
    
LA235:
    je LA230
    test_input_string "u32"
    jne LA236
    print "; type: u32"
    call newline
    
LA236:
    je LA230
    test_input_string "u64"
    jne LA237
    print "; type: u64"
    call newline
    
LA237:
    je LA230
    test_input_string "f32"
    jne LA238
    print "; type: f32"
    call newline
    
LA238:
    je LA230
    test_input_string "f64"
    jne LA239
    print "; type: f64"
    call newline
    
LA239:
    je LA230
    test_input_string "bool"
    jne LA240
    print "; type: bool"
    call newline
    
LA240:
    je LA230
    test_input_string "char"
    jne LA241
    print "; type: char"
    call newline
    
LA241:
    
LA230:
    ret
    
UNION_TYPE:
    call vstack_clear
    call BASIC_TYPE
    call vstack_restore
    jne LA242
    
LA242:
    je LA243
    call vstack_clear
    call POINTER_TYPE
    call vstack_restore
    jne LA244
    
LA244:
    je LA243
    call vstack_clear
    call DEREFERENCE_TYPE
    call vstack_restore
    jne LA245
    
LA245:
    je LA243
    call vstack_clear
    call FN_TYPE
    call vstack_restore
    jne LA246
    
LA246:
    je LA243
    test_input_string "("
    jne LA247
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 274
    jne terminate_program ; 274
    test_input_string ")"
    mov edi, 275
    jne terminate_program ; 275
    
LA247:
    
LA248:
    jne LA249
    
LA249:
    je LA243
    call test_for_id
    jne LA250
    print "; type: "
    call copy_last_match
    print " (alias)"
    call newline
    
LA250:
    
LA251:
    jne LA252
    
LA252:
    je LA243
    call vstack_clear
    call ARRAY_TYPE
    call vstack_restore
    jne LA253
    
LA253:
    
LA243:
    jne LA254
    
LA255:
    test_input_string "|"
    jne LA256
    print "; or"
    call newline
    call vstack_clear
    call BASIC_TYPE
    call vstack_restore
    jne LA257
    
LA257:
    je LA258
    call vstack_clear
    call POINTER_TYPE
    call vstack_restore
    jne LA259
    
LA259:
    je LA258
    call vstack_clear
    call DEREFERENCE_TYPE
    call vstack_restore
    jne LA260
    
LA260:
    je LA258
    call vstack_clear
    call FN_TYPE
    call vstack_restore
    jne LA261
    
LA261:
    je LA258
    test_input_string "("
    jne LA262
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 278
    jne terminate_program ; 278
    test_input_string ")"
    mov edi, 279
    jne terminate_program ; 279
    
LA262:
    
LA263:
    jne LA264
    
LA264:
    je LA258
    call test_for_id
    jne LA265
    print "; type: "
    call copy_last_match
    print " (alias)"
    call newline
    
LA265:
    
LA266:
    jne LA267
    
LA267:
    je LA258
    call vstack_clear
    call ARRAY_TYPE
    call vstack_restore
    jne LA268
    
LA268:
    
LA258:
    mov edi, 281
    jne terminate_program ; 281
    
LA256:
    
LA269:
    je LA255
    call set_true
    mov edi, 282
    jne terminate_program ; 282
    
LA254:
    
LA270:
    ret
    
POINTER_TYPE:
    test_input_string "*"
    jne LA271
    print "; pointer"
    call newline
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 284
    jne terminate_program ; 284
    
LA271:
    
LA272:
    ret
    
DEREFERENCE_TYPE:
    test_input_string "&"
    jne LA273
    print "; dereference"
    call newline
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 286
    jne terminate_program ; 286
    
LA273:
    
LA274:
    ret
    
FN_TYPE:
    test_input_string "fn"
    jne LA275
    print "; fn type"
    call newline
    test_input_string "<"
    jne LA276
    print "; is generic"
    call newline
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 289
    jne terminate_program ; 289
    test_input_string ">"
    mov edi, 290
    jne terminate_program ; 290
    
LA276:
    je LA277
    call set_true
    jne LA278
    
LA278:
    
LA277:
    mov edi, 291
    jne terminate_program ; 291
    test_input_string "("
    mov edi, 292
    jne terminate_program ; 292
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    jne LA279
    print "; input"
    call newline
    
LA280:
    test_input_string ","
    jne LA281
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 294
    jne terminate_program ; 294
    print "; input"
    call newline
    
LA281:
    
LA282:
    je LA280
    call set_true
    mov edi, 296
    jne terminate_program ; 296
    
LA279:
    je LA283
    call set_true
    jne LA284
    
LA284:
    
LA283:
    mov edi, 297
    jne terminate_program ; 297
    test_input_string ")"
    mov edi, 298
    jne terminate_program ; 298
    test_input_string "->"
    mov edi, 299
    jne terminate_program ; 299
    print "; output"
    call newline
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 301
    jne terminate_program ; 301
    
LA275:
    
LA285:
    ret
    
ARRAY_TYPE:
    test_input_string "["
    jne LA286
    call vstack_clear
    call UNION_TYPE
    call vstack_restore
    jne LA287
    
LA287:
    je LA288
    call vstack_clear
    call POINTER_TYPE
    call vstack_restore
    jne LA289
    
LA289:
    je LA288
    call vstack_clear
    call DEREFERENCE_TYPE
    call vstack_restore
    jne LA290
    
LA290:
    je LA288
    call vstack_clear
    call BASIC_TYPE
    call vstack_restore
    jne LA291
    
LA291:
    je LA288
    call vstack_clear
    call FN_TYPE
    call vstack_restore
    jne LA292
    
LA292:
    
LA288:
    mov edi, 302
    jne terminate_program ; 302
    test_input_string ";"
    mov edi, 303
    jne terminate_program ; 303
    call test_for_number
    jne LA293
    
LA293:
    je LA294
    test_input_string "*"
    jne LA295
    
LA295:
    
LA294:
    mov edi, 304
    jne terminate_program ; 304
    test_input_string "]"
    mov edi, 305
    jne terminate_program ; 305
    
LA286:
    
LA296:
    jne LA297
    
LA297:
    je LA298
    call vstack_clear
    call UNION_TYPE
    call vstack_restore
    jne LA299
    
LA299:
    je LA300
    call vstack_clear
    call BASIC_TYPE
    call vstack_restore
    jne LA301
    
LA301:
    je LA300
    call vstack_clear
    call FN_TYPE
    call vstack_restore
    jne LA302
    
LA302:
    
LA300:
    jne LA303
    test_input_string "["
    mov edi, 306
    jne terminate_program ; 306
    call test_for_number
    jne LA304
    
LA304:
    je LA305
    test_input_string "*"
    jne LA306
    
LA306:
    je LA305
    call set_true
    jne LA307
    
LA307:
    
LA305:
    mov edi, 307
    jne terminate_program ; 307
    test_input_string "]"
    mov edi, 308
    jne terminate_program ; 308
    
LA303:
    
LA308:
    jne LA309
    
LA309:
    
LA298:
    ret
    
COMPLEX_TYPE:
    call vstack_clear
    call UNION_TYPE
    call vstack_restore
    jne LA310
    
LA310:
    je LA311
    call vstack_clear
    call POINTER_TYPE
    call vstack_restore
    jne LA312
    
LA312:
    je LA311
    call vstack_clear
    call DEREFERENCE_TYPE
    call vstack_restore
    jne LA313
    
LA313:
    je LA311
    call vstack_clear
    call BASIC_TYPE
    call vstack_restore
    jne LA314
    
LA314:
    je LA311
    call vstack_clear
    call FN_TYPE
    call vstack_restore
    jne LA315
    
LA315:
    je LA311
    test_input_string "("
    jne LA316
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 309
    jne terminate_program ; 309
    test_input_string ")"
    mov edi, 310
    jne terminate_program ; 310
    
LA316:
    
LA317:
    jne LA318
    
LA318:
    je LA311
    call test_for_id
    jne LA319
    print "; type: "
    call copy_last_match
    print " (alias)"
    call newline
    
LA319:
    
LA320:
    jne LA321
    
LA321:
    je LA311
    call vstack_clear
    call ARRAY_TYPE
    call vstack_restore
    jne LA322
    
LA322:
    
LA311:
    ret
    
TYPE_ANNOTATION:
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    jne LA323
    
LA323:
    
LA324:
    ret
    
TYPE_EXPRESSION:
    test_input_string "type"
    jne LA325
    call test_for_id
    mov edi, 312
    jne terminate_program ; 312
    print "; define type "
    call copy_last_match
    call newline
    test_input_string "="
    mov edi, 314
    jne terminate_program ; 314
    call vstack_clear
    call COMPLEX_TYPE
    call vstack_restore
    mov edi, 315
    jne terminate_program ; 315
    
LA325:
    
LA326:
    ret
    
ENUM_EXPRESSION:
    test_input_string "enum"
    jne LA327
    call test_for_id
    mov edi, 316
    jne terminate_program ; 316
    print "; define enum "
    call copy_last_match
    call newline
    test_input_string "{"
    mov edi, 318
    jne terminate_program ; 318
    call test_for_id
    jne LA328
    print "; enum value "
    call copy_last_match
    call newline
    
LA328:
    je LA329
    call set_true
    jne LA330
    
LA330:
    
LA329:
    mov edi, 320
    jne terminate_program ; 320
    
LA331:
    test_input_string ","
    jne LA332
    call test_for_id
    mov edi, 321
    jne terminate_program ; 321
    print "; enum value "
    call copy_last_match
    call newline
    
LA332:
    
LA333:
    je LA331
    call set_true
    mov edi, 323
    jne terminate_program ; 323
    test_input_string "}"
    mov edi, 324
    jne terminate_program ; 324
    
LA327:
    
LA334:
    ret
    
DIRECT_ASSEMBLY_EXPRESSION:
    test_input_string "asm"
    jne LA335
    call test_for_string_raw
    mov edi, 325
    jne terminate_program ; 325
    call copy_last_match
    call newline
    
LA335:
    
LA336:
    ret
    
COMMENT:
    test_input_string "//"
    jne LA337
    match_not 10
    mov edi, 327
    jne terminate_program ; 327
    
LA337:
    
LA338:
    ret
    
IF_STATEMENT:
    test_input_string "if"
    jne LA339
    test_input_string "("
    mov edi, 328
    jne terminate_program ; 328
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 329
    jne terminate_program ; 329
    test_input_string ")"
    mov edi, 330
    jne terminate_program ; 330
    print "cmp eax, 0"
    call newline
    print "je "
    call gn1
    call newline
    test_input_string "{"
    mov edi, 333
    jne terminate_program ; 333
    call vstack_clear
    call BODY
    call vstack_restore
    mov edi, 334
    jne terminate_program ; 334
    test_input_string "}"
    mov edi, 335
    jne terminate_program ; 335
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    
LA340:
    call vstack_clear
    call ELIF
    call vstack_restore
    jne LA341
    
LA341:
    
LA342:
    je LA340
    call set_true
    mov edi, 337
    jne terminate_program ; 337
    
LA343:
    call vstack_clear
    call ELSE
    call vstack_restore
    jne LA344
    
LA344:
    
LA345:
    je LA343
    call set_true
    mov edi, 338
    jne terminate_program ; 338
    call label
    call gn2
    print ":"
    call newline
    
LA339:
    
LA346:
    ret
    
ELIF:
    test_input_string "elif"
    jne LA347
    test_input_string "("
    mov edi, 339
    jne terminate_program ; 339
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 340
    jne terminate_program ; 340
    test_input_string ")"
    mov edi, 341
    jne terminate_program ; 341
    print "cmp eax, 0"
    call newline
    print "jne "
    call gn1
    call newline
    test_input_string "{"
    mov edi, 344
    jne terminate_program ; 344
    call vstack_clear
    call BODY
    call vstack_restore
    mov edi, 345
    jne terminate_program ; 345
    test_input_string "}"
    mov edi, 346
    jne terminate_program ; 346
    call label
    call gn1
    print ":"
    call newline
    
LA347:
    
LA348:
    ret
    
ELSE:
    test_input_string "else"
    jne LA349
    test_input_string "{"
    mov edi, 347
    jne terminate_program ; 347
    call vstack_clear
    call BODY
    call vstack_restore
    mov edi, 348
    jne terminate_program ; 348
    test_input_string "}"
    mov edi, 349
    jne terminate_program ; 349
    
LA349:
    
LA350:
    ret
    
LET_EXPRESSION:
    test_input_string "let"
    jne LA351
    call test_for_id
    mov edi, 350
    jne terminate_program ; 350
    pushfd
    push eax
    mov edi, ST
    mov esi, last_match
    mov eax, dword [STO]
    push eax
    mov ebx, 4
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [STO], eax
    mov edx, eax
    call hash_set
    pop eax
    popfd
    mov edi, 351
    jne terminate_program ; 351
    pushfd
    push eax
    mov eax, dword [VAR_IN_BODY]
    push eax
    mov ebx, 1
    push ebx
    pop ebx
    pop eax
    add eax, ebx
    mov dword [VAR_IN_BODY], eax
    pop eax
    popfd
    mov edi, 352
    jne terminate_program ; 352
    test_input_string ":"
    jne LA352
    call vstack_clear
    call TYPE_ANNOTATION
    call vstack_restore
    mov edi, 353
    jne terminate_program ; 353
    
LA352:
    je LA353
    call set_true
    jne LA354
    
LA354:
    
LA353:
    mov edi, 354
    jne terminate_program ; 354
    test_input_string "="
    mov edi, 355
    jne terminate_program ; 355
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 356
    jne terminate_program ; 356
    print "mov dword [ebp+"
    pushfd
    push eax
    mov edi, dword [STO]
    call print_int
    pop eax
    popfd
    print "], eax"
    call newline
    
LA351:
    
LA355:
    ret
    
WHILE_STATEMENT:
    test_input_string "while"
    jne LA356
    call label
    call gn2
    print ":"
    call newline
    test_input_string "("
    mov edi, 358
    jne terminate_program ; 358
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 359
    jne terminate_program ; 359
    test_input_string ")"
    mov edi, 360
    jne terminate_program ; 360
    test_input_string "{"
    mov edi, 361
    jne terminate_program ; 361
    print "cmp eax, 0"
    call newline
    print "je "
    call gn1
    call newline
    call vstack_clear
    call BODY
    call vstack_restore
    mov edi, 364
    jne terminate_program ; 364
    test_input_string "}"
    mov edi, 365
    jne terminate_program ; 365
    print "jmp "
    call gn2
    call newline
    call label
    call gn1
    print ":"
    call newline
    
LA356:
    
LA357:
    ret
    
RETURN_EXPRESSION:
    test_input_string "return"
    jne LA358
    pushfd
    push eax
    mov eax, 0
    mov dword [AEXP_SEC_NUM], eax
    pop eax
    popfd
    mov edi, 367
    jne terminate_program ; 367
    call vstack_clear
    call AEXP
    call vstack_restore
    mov edi, 368
    jne terminate_program ; 368
    
LA358:
    
LA359:
    ret
    
