section .data
    factor        dq 0.017453292519943295    ; pi / 180
    x             resq 1
    radians       resq 1
    sinres        resq 1
    cosres        resq 1
    ctanres       resq 1
    mes           db "Rezultat: %lf",10,0
    mes_in        db "Unghi in grade: ",10,0  
    scanformat    db "%lf", 0
    
section .text
    global main
    extern scanf
    extern printf
    extern sin
    extern cos

main:
    push rbp
    mov rbp, rsp

    ; Mesaj inceput
    mov rdi, mes_in 
    call printf

    ; Scanf
    mov rdi, scanformat           
    mov rax, x                
    mov rsi, rax                                         
    call scanf
    
    ; Transformam grade -> radiani
    movsd xmm0, [x]
    movsd xmm1, [factor]
    mulsd xmm0, xmm1
    movsd [radians], xmm0
    
    ; sin
    movsd xmm0, [radians]
    call sin
    movsd [sinres], xmm0
    
    ; cos
    movsd xmm0, [radians]
    call cos
    movsd [cosres], xmm0
    
    ; ctan = cos/sin
    movsd xmm0, [cosres]      
    divsd xmm0, [sinres] 
    movsd [ctanres], xmm0
    
    ; afisam rez
    mov rdi, mes
    movsd xmm0, [ctanres]
    mov rax, 1 
    call printf
    
    leave
    ret
