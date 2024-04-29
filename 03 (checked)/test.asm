.model small
.stack 100h
.data
	message db 'Hello World!', 13, 10, '$'
.code
start:
	mov ax, @data ; տվյալների սեգմենտի հասցեն հիշվում է DS սեգմենտային ռեգիստրում

	mov ds, ax
	mov dx, offset message ; message տողի շեղումը հիշվում է DX ռեգիստրում
	mov ah, 09h ; message տողը էկրան է արտածվում

	int 21h
	mov ax, 4C00h ; աշխատանքի/ ծրագրի ավարտը
	int 21h
end start