.model small
.stack 100h
.data
	message db 'Hello World!', 13, 10, '$'
.code
start:
	mov AX, @data ; տվյալների սեգմենտի հասցեն հիշվում է DS սեգմենտային ռեգիստրում

	mov DS, AX
	mov DX, offset message ; message տողի շեղումը հիշվում է DX ռեգիստրում
	mov AH, 09h ; message տողը էկրան է արտածվում

	int 21h
	mov AX, 4C00h ; աշխատանքի/ ծրագրի ավարտը
	int 21h
end start