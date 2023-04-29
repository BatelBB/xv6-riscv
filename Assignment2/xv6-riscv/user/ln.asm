
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	bb058593          	addi	a1,a1,-1104 # bc0 <uthread_self+0x30>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	618080e7          	jalr	1560(ra) # 632 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2c4080e7          	jalr	708(ra) # 2e8 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	316080e7          	jalr	790(ra) # 348 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2a8080e7          	jalr	680(ra) # 2e8 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	b8c58593          	addi	a1,a1,-1140 # bd8 <uthread_self+0x48>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	5dc080e7          	jalr	1500(ra) # 632 <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  60:	1141                	addi	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	addi	s0,sp,16
  extern int main();
  main();
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <main>
  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	276080e7          	jalr	630(ra) # 2e8 <exit>

000000000000007a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	addi	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cb91                	beqz	a5,b4 <strcmp+0x1e>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71763          	bne	a4,a5,b4 <strcmp+0x1e>
    p++, q++;
  aa:	0505                	addi	a0,a0,1
  ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	fbe5                	bnez	a5,a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint
strlen(const char *s)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	addi	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	4685                	li	a3,1
  d4:	9e89                	subw	a3,a3,a0
  d6:	00f6853b          	addw	a0,a3,a5
  da:	0785                	addi	a5,a5,1
  dc:	fff7c703          	lbu	a4,-1(a5)
  e0:	fb7d                	bnez	a4,d6 <strlen+0x14>
    ;
  return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret
  for(n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f2:	ca19                	beqz	a2,108 <memset+0x1c>
  f4:	87aa                	mv	a5,a0
  f6:	1602                	slli	a2,a2,0x20
  f8:	9201                	srli	a2,a2,0x20
  fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 102:	0785                	addi	a5,a5,1
 104:	fee79de3          	bne	a5,a4,fe <memset+0x12>
  }
  return dst;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret

000000000000010e <strchr>:

char*
strchr(const char *s, char c)
{
 10e:	1141                	addi	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	addi	s0,sp,16
  for(; *s; s++)
 114:	00054783          	lbu	a5,0(a0)
 118:	cb99                	beqz	a5,12e <strchr+0x20>
    if(*s == c)
 11a:	00f58763          	beq	a1,a5,128 <strchr+0x1a>
  for(; *s; s++)
 11e:	0505                	addi	a0,a0,1
 120:	00054783          	lbu	a5,0(a0)
 124:	fbfd                	bnez	a5,11a <strchr+0xc>
      return (char*)s;
  return 0;
 126:	4501                	li	a0,0
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfe5                	j	128 <strchr+0x1a>

0000000000000132 <gets>:

char*
gets(char *buf, int max)
{
 132:	711d                	addi	sp,sp,-96
 134:	ec86                	sd	ra,88(sp)
 136:	e8a2                	sd	s0,80(sp)
 138:	e4a6                	sd	s1,72(sp)
 13a:	e0ca                	sd	s2,64(sp)
 13c:	fc4e                	sd	s3,56(sp)
 13e:	f852                	sd	s4,48(sp)
 140:	f456                	sd	s5,40(sp)
 142:	f05a                	sd	s6,32(sp)
 144:	ec5e                	sd	s7,24(sp)
 146:	1080                	addi	s0,sp,96
 148:	8baa                	mv	s7,a0
 14a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 150:	4aa9                	li	s5,10
 152:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 154:	89a6                	mv	s3,s1
 156:	2485                	addiw	s1,s1,1
 158:	0344d863          	bge	s1,s4,188 <gets+0x56>
    cc = read(0, &c, 1);
 15c:	4605                	li	a2,1
 15e:	faf40593          	addi	a1,s0,-81
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	19c080e7          	jalr	412(ra) # 300 <read>
    if(cc < 1)
 16c:	00a05e63          	blez	a0,188 <gets+0x56>
    buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 178:	01578763          	beq	a5,s5,186 <gets+0x54>
 17c:	0905                	addi	s2,s2,1
 17e:	fd679be3          	bne	a5,s6,154 <gets+0x22>
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
 184:	a011                	j	188 <gets+0x56>
 186:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 188:	99de                	add	s3,s3,s7
 18a:	00098023          	sb	zero,0(s3)
  return buf;
}
 18e:	855e                	mv	a0,s7
 190:	60e6                	ld	ra,88(sp)
 192:	6446                	ld	s0,80(sp)
 194:	64a6                	ld	s1,72(sp)
 196:	6906                	ld	s2,64(sp)
 198:	79e2                	ld	s3,56(sp)
 19a:	7a42                	ld	s4,48(sp)
 19c:	7aa2                	ld	s5,40(sp)
 19e:	7b02                	ld	s6,32(sp)
 1a0:	6be2                	ld	s7,24(sp)
 1a2:	6125                	addi	sp,sp,96
 1a4:	8082                	ret

00000000000001a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a6:	1101                	addi	sp,sp,-32
 1a8:	ec06                	sd	ra,24(sp)
 1aa:	e822                	sd	s0,16(sp)
 1ac:	e426                	sd	s1,8(sp)
 1ae:	e04a                	sd	s2,0(sp)
 1b0:	1000                	addi	s0,sp,32
 1b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b4:	4581                	li	a1,0
 1b6:	00000097          	auipc	ra,0x0
 1ba:	172080e7          	jalr	370(ra) # 328 <open>
  if(fd < 0)
 1be:	02054563          	bltz	a0,1e8 <stat+0x42>
 1c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c4:	85ca                	mv	a1,s2
 1c6:	00000097          	auipc	ra,0x0
 1ca:	17a080e7          	jalr	378(ra) # 340 <fstat>
 1ce:	892a                	mv	s2,a0
  close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	00000097          	auipc	ra,0x0
 1d6:	13e080e7          	jalr	318(ra) # 310 <close>
  return r;
}
 1da:	854a                	mv	a0,s2
 1dc:	60e2                	ld	ra,24(sp)
 1de:	6442                	ld	s0,16(sp)
 1e0:	64a2                	ld	s1,8(sp)
 1e2:	6902                	ld	s2,0(sp)
 1e4:	6105                	addi	sp,sp,32
 1e6:	8082                	ret
    return -1;
 1e8:	597d                	li	s2,-1
 1ea:	bfc5                	j	1da <stat+0x34>

00000000000001ec <atoi>:

int
atoi(const char *s)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f2:	00054603          	lbu	a2,0(a0)
 1f6:	fd06079b          	addiw	a5,a2,-48
 1fa:	0ff7f793          	andi	a5,a5,255
 1fe:	4725                	li	a4,9
 200:	02f76963          	bltu	a4,a5,232 <atoi+0x46>
 204:	86aa                	mv	a3,a0
  n = 0;
 206:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 208:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 20a:	0685                	addi	a3,a3,1
 20c:	0025179b          	slliw	a5,a0,0x2
 210:	9fa9                	addw	a5,a5,a0
 212:	0017979b          	slliw	a5,a5,0x1
 216:	9fb1                	addw	a5,a5,a2
 218:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21c:	0006c603          	lbu	a2,0(a3)
 220:	fd06071b          	addiw	a4,a2,-48
 224:	0ff77713          	andi	a4,a4,255
 228:	fee5f1e3          	bgeu	a1,a4,20a <atoi+0x1e>
  return n;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
  n = 0;
 232:	4501                	li	a0,0
 234:	bfe5                	j	22c <atoi+0x40>

0000000000000236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23c:	02b57463          	bgeu	a0,a1,264 <memmove+0x2e>
    while(n-- > 0)
 240:	00c05f63          	blez	a2,25e <memmove+0x28>
 244:	1602                	slli	a2,a2,0x20
 246:	9201                	srli	a2,a2,0x20
 248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24c:	872a                	mv	a4,a0
      *dst++ = *src++;
 24e:	0585                	addi	a1,a1,1
 250:	0705                	addi	a4,a4,1
 252:	fff5c683          	lbu	a3,-1(a1)
 256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
    dst += n;
 264:	00c50733          	add	a4,a0,a2
    src += n;
 268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26a:	fec05ae3          	blez	a2,25e <memmove+0x28>
 26e:	fff6079b          	addiw	a5,a2,-1
 272:	1782                	slli	a5,a5,0x20
 274:	9381                	srli	a5,a5,0x20
 276:	fff7c793          	not	a5,a5
 27a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27c:	15fd                	addi	a1,a1,-1
 27e:	177d                	addi	a4,a4,-1
 280:	0005c683          	lbu	a3,0(a1)
 284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x46>
 28c:	bfc9                	j	25e <memmove+0x28>

000000000000028e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 294:	ca05                	beqz	a2,2c4 <memcmp+0x36>
 296:	fff6069b          	addiw	a3,a2,-1
 29a:	1682                	slli	a3,a3,0x20
 29c:	9281                	srli	a3,a3,0x20
 29e:	0685                	addi	a3,a3,1
 2a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	0005c703          	lbu	a4,0(a1)
 2aa:	00e79863          	bne	a5,a4,2ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ae:	0505                	addi	a0,a0,1
    p2++;
 2b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b2:	fed518e3          	bne	a0,a3,2a2 <memcmp+0x14>
  }
  return 0;
 2b6:	4501                	li	a0,0
 2b8:	a019                	j	2be <memcmp+0x30>
      return *p1 - *p2;
 2ba:	40e7853b          	subw	a0,a5,a4
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	bfe5                	j	2be <memcmp+0x30>

00000000000002c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d0:	00000097          	auipc	ra,0x0
 2d4:	f66080e7          	jalr	-154(ra) # 236 <memmove>
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e0:	4885                	li	a7,1
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e8:	4889                	li	a7,2
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f0:	488d                	li	a7,3
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f8:	4891                	li	a7,4
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <read>:
.global read
read:
 li a7, SYS_read
 300:	4895                	li	a7,5
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <write>:
.global write
write:
 li a7, SYS_write
 308:	48c1                	li	a7,16
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <close>:
.global close
close:
 li a7, SYS_close
 310:	48d5                	li	a7,21
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <kill>:
.global kill
kill:
 li a7, SYS_kill
 318:	4899                	li	a7,6
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <exec>:
.global exec
exec:
 li a7, SYS_exec
 320:	489d                	li	a7,7
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <open>:
.global open
open:
 li a7, SYS_open
 328:	48bd                	li	a7,15
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 330:	48c5                	li	a7,17
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 338:	48c9                	li	a7,18
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 340:	48a1                	li	a7,8
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <link>:
.global link
link:
 li a7, SYS_link
 348:	48cd                	li	a7,19
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 350:	48d1                	li	a7,20
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 358:	48a5                	li	a7,9
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <dup>:
.global dup
dup:
 li a7, SYS_dup
 360:	48a9                	li	a7,10
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 368:	48ad                	li	a7,11
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 370:	48b1                	li	a7,12
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 378:	48b5                	li	a7,13
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 380:	48b9                	li	a7,14
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 388:	1101                	addi	sp,sp,-32
 38a:	ec06                	sd	ra,24(sp)
 38c:	e822                	sd	s0,16(sp)
 38e:	1000                	addi	s0,sp,32
 390:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 394:	4605                	li	a2,1
 396:	fef40593          	addi	a1,s0,-17
 39a:	00000097          	auipc	ra,0x0
 39e:	f6e080e7          	jalr	-146(ra) # 308 <write>
}
 3a2:	60e2                	ld	ra,24(sp)
 3a4:	6442                	ld	s0,16(sp)
 3a6:	6105                	addi	sp,sp,32
 3a8:	8082                	ret

00000000000003aa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3aa:	7139                	addi	sp,sp,-64
 3ac:	fc06                	sd	ra,56(sp)
 3ae:	f822                	sd	s0,48(sp)
 3b0:	f426                	sd	s1,40(sp)
 3b2:	f04a                	sd	s2,32(sp)
 3b4:	ec4e                	sd	s3,24(sp)
 3b6:	0080                	addi	s0,sp,64
 3b8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ba:	c299                	beqz	a3,3c0 <printint+0x16>
 3bc:	0805c863          	bltz	a1,44c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c0:	2581                	sext.w	a1,a1
  neg = 0;
 3c2:	4881                	li	a7,0
 3c4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3ca:	2601                	sext.w	a2,a2
 3cc:	00001517          	auipc	a0,0x1
 3d0:	82c50513          	addi	a0,a0,-2004 # bf8 <digits>
 3d4:	883a                	mv	a6,a4
 3d6:	2705                	addiw	a4,a4,1
 3d8:	02c5f7bb          	remuw	a5,a1,a2
 3dc:	1782                	slli	a5,a5,0x20
 3de:	9381                	srli	a5,a5,0x20
 3e0:	97aa                	add	a5,a5,a0
 3e2:	0007c783          	lbu	a5,0(a5)
 3e6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ea:	0005879b          	sext.w	a5,a1
 3ee:	02c5d5bb          	divuw	a1,a1,a2
 3f2:	0685                	addi	a3,a3,1
 3f4:	fec7f0e3          	bgeu	a5,a2,3d4 <printint+0x2a>
  if(neg)
 3f8:	00088b63          	beqz	a7,40e <printint+0x64>
    buf[i++] = '-';
 3fc:	fd040793          	addi	a5,s0,-48
 400:	973e                	add	a4,a4,a5
 402:	02d00793          	li	a5,45
 406:	fef70823          	sb	a5,-16(a4)
 40a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 40e:	02e05863          	blez	a4,43e <printint+0x94>
 412:	fc040793          	addi	a5,s0,-64
 416:	00e78933          	add	s2,a5,a4
 41a:	fff78993          	addi	s3,a5,-1
 41e:	99ba                	add	s3,s3,a4
 420:	377d                	addiw	a4,a4,-1
 422:	1702                	slli	a4,a4,0x20
 424:	9301                	srli	a4,a4,0x20
 426:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 42a:	fff94583          	lbu	a1,-1(s2)
 42e:	8526                	mv	a0,s1
 430:	00000097          	auipc	ra,0x0
 434:	f58080e7          	jalr	-168(ra) # 388 <putc>
  while(--i >= 0)
 438:	197d                	addi	s2,s2,-1
 43a:	ff3918e3          	bne	s2,s3,42a <printint+0x80>
}
 43e:	70e2                	ld	ra,56(sp)
 440:	7442                	ld	s0,48(sp)
 442:	74a2                	ld	s1,40(sp)
 444:	7902                	ld	s2,32(sp)
 446:	69e2                	ld	s3,24(sp)
 448:	6121                	addi	sp,sp,64
 44a:	8082                	ret
    x = -xx;
 44c:	40b005bb          	negw	a1,a1
    neg = 1;
 450:	4885                	li	a7,1
    x = -xx;
 452:	bf8d                	j	3c4 <printint+0x1a>

0000000000000454 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 454:	7119                	addi	sp,sp,-128
 456:	fc86                	sd	ra,120(sp)
 458:	f8a2                	sd	s0,112(sp)
 45a:	f4a6                	sd	s1,104(sp)
 45c:	f0ca                	sd	s2,96(sp)
 45e:	ecce                	sd	s3,88(sp)
 460:	e8d2                	sd	s4,80(sp)
 462:	e4d6                	sd	s5,72(sp)
 464:	e0da                	sd	s6,64(sp)
 466:	fc5e                	sd	s7,56(sp)
 468:	f862                	sd	s8,48(sp)
 46a:	f466                	sd	s9,40(sp)
 46c:	f06a                	sd	s10,32(sp)
 46e:	ec6e                	sd	s11,24(sp)
 470:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 472:	0005c903          	lbu	s2,0(a1)
 476:	18090f63          	beqz	s2,614 <vprintf+0x1c0>
 47a:	8aaa                	mv	s5,a0
 47c:	8b32                	mv	s6,a2
 47e:	00158493          	addi	s1,a1,1
  state = 0;
 482:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 484:	02500a13          	li	s4,37
      if(c == 'd'){
 488:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 48c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 490:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 494:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 498:	00000b97          	auipc	s7,0x0
 49c:	760b8b93          	addi	s7,s7,1888 # bf8 <digits>
 4a0:	a839                	j	4be <vprintf+0x6a>
        putc(fd, c);
 4a2:	85ca                	mv	a1,s2
 4a4:	8556                	mv	a0,s5
 4a6:	00000097          	auipc	ra,0x0
 4aa:	ee2080e7          	jalr	-286(ra) # 388 <putc>
 4ae:	a019                	j	4b4 <vprintf+0x60>
    } else if(state == '%'){
 4b0:	01498f63          	beq	s3,s4,4ce <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4b4:	0485                	addi	s1,s1,1
 4b6:	fff4c903          	lbu	s2,-1(s1)
 4ba:	14090d63          	beqz	s2,614 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4be:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4c2:	fe0997e3          	bnez	s3,4b0 <vprintf+0x5c>
      if(c == '%'){
 4c6:	fd479ee3          	bne	a5,s4,4a2 <vprintf+0x4e>
        state = '%';
 4ca:	89be                	mv	s3,a5
 4cc:	b7e5                	j	4b4 <vprintf+0x60>
      if(c == 'd'){
 4ce:	05878063          	beq	a5,s8,50e <vprintf+0xba>
      } else if(c == 'l') {
 4d2:	05978c63          	beq	a5,s9,52a <vprintf+0xd6>
      } else if(c == 'x') {
 4d6:	07a78863          	beq	a5,s10,546 <vprintf+0xf2>
      } else if(c == 'p') {
 4da:	09b78463          	beq	a5,s11,562 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4de:	07300713          	li	a4,115
 4e2:	0ce78663          	beq	a5,a4,5ae <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4e6:	06300713          	li	a4,99
 4ea:	0ee78e63          	beq	a5,a4,5e6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4ee:	11478863          	beq	a5,s4,5fe <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4f2:	85d2                	mv	a1,s4
 4f4:	8556                	mv	a0,s5
 4f6:	00000097          	auipc	ra,0x0
 4fa:	e92080e7          	jalr	-366(ra) # 388 <putc>
        putc(fd, c);
 4fe:	85ca                	mv	a1,s2
 500:	8556                	mv	a0,s5
 502:	00000097          	auipc	ra,0x0
 506:	e86080e7          	jalr	-378(ra) # 388 <putc>
      }
      state = 0;
 50a:	4981                	li	s3,0
 50c:	b765                	j	4b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 50e:	008b0913          	addi	s2,s6,8
 512:	4685                	li	a3,1
 514:	4629                	li	a2,10
 516:	000b2583          	lw	a1,0(s6)
 51a:	8556                	mv	a0,s5
 51c:	00000097          	auipc	ra,0x0
 520:	e8e080e7          	jalr	-370(ra) # 3aa <printint>
 524:	8b4a                	mv	s6,s2
      state = 0;
 526:	4981                	li	s3,0
 528:	b771                	j	4b4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 52a:	008b0913          	addi	s2,s6,8
 52e:	4681                	li	a3,0
 530:	4629                	li	a2,10
 532:	000b2583          	lw	a1,0(s6)
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	e72080e7          	jalr	-398(ra) # 3aa <printint>
 540:	8b4a                	mv	s6,s2
      state = 0;
 542:	4981                	li	s3,0
 544:	bf85                	j	4b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 546:	008b0913          	addi	s2,s6,8
 54a:	4681                	li	a3,0
 54c:	4641                	li	a2,16
 54e:	000b2583          	lw	a1,0(s6)
 552:	8556                	mv	a0,s5
 554:	00000097          	auipc	ra,0x0
 558:	e56080e7          	jalr	-426(ra) # 3aa <printint>
 55c:	8b4a                	mv	s6,s2
      state = 0;
 55e:	4981                	li	s3,0
 560:	bf91                	j	4b4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 562:	008b0793          	addi	a5,s6,8
 566:	f8f43423          	sd	a5,-120(s0)
 56a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 56e:	03000593          	li	a1,48
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e14080e7          	jalr	-492(ra) # 388 <putc>
  putc(fd, 'x');
 57c:	85ea                	mv	a1,s10
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e08080e7          	jalr	-504(ra) # 388 <putc>
 588:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 58a:	03c9d793          	srli	a5,s3,0x3c
 58e:	97de                	add	a5,a5,s7
 590:	0007c583          	lbu	a1,0(a5)
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	df2080e7          	jalr	-526(ra) # 388 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 59e:	0992                	slli	s3,s3,0x4
 5a0:	397d                	addiw	s2,s2,-1
 5a2:	fe0914e3          	bnez	s2,58a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5a6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	b721                	j	4b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ae:	008b0993          	addi	s3,s6,8
 5b2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5b6:	02090163          	beqz	s2,5d8 <vprintf+0x184>
        while(*s != 0){
 5ba:	00094583          	lbu	a1,0(s2)
 5be:	c9a1                	beqz	a1,60e <vprintf+0x1ba>
          putc(fd, *s);
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	dc6080e7          	jalr	-570(ra) # 388 <putc>
          s++;
 5ca:	0905                	addi	s2,s2,1
        while(*s != 0){
 5cc:	00094583          	lbu	a1,0(s2)
 5d0:	f9e5                	bnez	a1,5c0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 5d2:	8b4e                	mv	s6,s3
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	bdf9                	j	4b4 <vprintf+0x60>
          s = "(null)";
 5d8:	00000917          	auipc	s2,0x0
 5dc:	61890913          	addi	s2,s2,1560 # bf0 <uthread_self+0x60>
        while(*s != 0){
 5e0:	02800593          	li	a1,40
 5e4:	bff1                	j	5c0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5e6:	008b0913          	addi	s2,s6,8
 5ea:	000b4583          	lbu	a1,0(s6)
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	d98080e7          	jalr	-616(ra) # 388 <putc>
 5f8:	8b4a                	mv	s6,s2
      state = 0;
 5fa:	4981                	li	s3,0
 5fc:	bd65                	j	4b4 <vprintf+0x60>
        putc(fd, c);
 5fe:	85d2                	mv	a1,s4
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	d86080e7          	jalr	-634(ra) # 388 <putc>
      state = 0;
 60a:	4981                	li	s3,0
 60c:	b565                	j	4b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 60e:	8b4e                	mv	s6,s3
      state = 0;
 610:	4981                	li	s3,0
 612:	b54d                	j	4b4 <vprintf+0x60>
    }
  }
}
 614:	70e6                	ld	ra,120(sp)
 616:	7446                	ld	s0,112(sp)
 618:	74a6                	ld	s1,104(sp)
 61a:	7906                	ld	s2,96(sp)
 61c:	69e6                	ld	s3,88(sp)
 61e:	6a46                	ld	s4,80(sp)
 620:	6aa6                	ld	s5,72(sp)
 622:	6b06                	ld	s6,64(sp)
 624:	7be2                	ld	s7,56(sp)
 626:	7c42                	ld	s8,48(sp)
 628:	7ca2                	ld	s9,40(sp)
 62a:	7d02                	ld	s10,32(sp)
 62c:	6de2                	ld	s11,24(sp)
 62e:	6109                	addi	sp,sp,128
 630:	8082                	ret

0000000000000632 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 632:	715d                	addi	sp,sp,-80
 634:	ec06                	sd	ra,24(sp)
 636:	e822                	sd	s0,16(sp)
 638:	1000                	addi	s0,sp,32
 63a:	e010                	sd	a2,0(s0)
 63c:	e414                	sd	a3,8(s0)
 63e:	e818                	sd	a4,16(s0)
 640:	ec1c                	sd	a5,24(s0)
 642:	03043023          	sd	a6,32(s0)
 646:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 64a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 64e:	8622                	mv	a2,s0
 650:	00000097          	auipc	ra,0x0
 654:	e04080e7          	jalr	-508(ra) # 454 <vprintf>
}
 658:	60e2                	ld	ra,24(sp)
 65a:	6442                	ld	s0,16(sp)
 65c:	6161                	addi	sp,sp,80
 65e:	8082                	ret

0000000000000660 <printf>:

void
printf(const char *fmt, ...)
{
 660:	711d                	addi	sp,sp,-96
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	e40c                	sd	a1,8(s0)
 66a:	e810                	sd	a2,16(s0)
 66c:	ec14                	sd	a3,24(s0)
 66e:	f018                	sd	a4,32(s0)
 670:	f41c                	sd	a5,40(s0)
 672:	03043823          	sd	a6,48(s0)
 676:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 67a:	00840613          	addi	a2,s0,8
 67e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 682:	85aa                	mv	a1,a0
 684:	4505                	li	a0,1
 686:	00000097          	auipc	ra,0x0
 68a:	dce080e7          	jalr	-562(ra) # 454 <vprintf>
}
 68e:	60e2                	ld	ra,24(sp)
 690:	6442                	ld	s0,16(sp)
 692:	6125                	addi	sp,sp,96
 694:	8082                	ret

0000000000000696 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 696:	1141                	addi	sp,sp,-16
 698:	e422                	sd	s0,8(sp)
 69a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a0:	00001797          	auipc	a5,0x1
 6a4:	9607b783          	ld	a5,-1696(a5) # 1000 <freep>
 6a8:	a805                	j	6d8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6aa:	4618                	lw	a4,8(a2)
 6ac:	9db9                	addw	a1,a1,a4
 6ae:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b2:	6398                	ld	a4,0(a5)
 6b4:	6318                	ld	a4,0(a4)
 6b6:	fee53823          	sd	a4,-16(a0)
 6ba:	a091                	j	6fe <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6bc:	ff852703          	lw	a4,-8(a0)
 6c0:	9e39                	addw	a2,a2,a4
 6c2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6c4:	ff053703          	ld	a4,-16(a0)
 6c8:	e398                	sd	a4,0(a5)
 6ca:	a099                	j	710 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cc:	6398                	ld	a4,0(a5)
 6ce:	00e7e463          	bltu	a5,a4,6d6 <free+0x40>
 6d2:	00e6ea63          	bltu	a3,a4,6e6 <free+0x50>
{
 6d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d8:	fed7fae3          	bgeu	a5,a3,6cc <free+0x36>
 6dc:	6398                	ld	a4,0(a5)
 6de:	00e6e463          	bltu	a3,a4,6e6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	fee7eae3          	bltu	a5,a4,6d6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6e6:	ff852583          	lw	a1,-8(a0)
 6ea:	6390                	ld	a2,0(a5)
 6ec:	02059713          	slli	a4,a1,0x20
 6f0:	9301                	srli	a4,a4,0x20
 6f2:	0712                	slli	a4,a4,0x4
 6f4:	9736                	add	a4,a4,a3
 6f6:	fae60ae3          	beq	a2,a4,6aa <free+0x14>
    bp->s.ptr = p->s.ptr;
 6fa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6fe:	4790                	lw	a2,8(a5)
 700:	02061713          	slli	a4,a2,0x20
 704:	9301                	srli	a4,a4,0x20
 706:	0712                	slli	a4,a4,0x4
 708:	973e                	add	a4,a4,a5
 70a:	fae689e3          	beq	a3,a4,6bc <free+0x26>
  } else
    p->s.ptr = bp;
 70e:	e394                	sd	a3,0(a5)
  freep = p;
 710:	00001717          	auipc	a4,0x1
 714:	8ef73823          	sd	a5,-1808(a4) # 1000 <freep>
}
 718:	6422                	ld	s0,8(sp)
 71a:	0141                	addi	sp,sp,16
 71c:	8082                	ret

000000000000071e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 71e:	7139                	addi	sp,sp,-64
 720:	fc06                	sd	ra,56(sp)
 722:	f822                	sd	s0,48(sp)
 724:	f426                	sd	s1,40(sp)
 726:	f04a                	sd	s2,32(sp)
 728:	ec4e                	sd	s3,24(sp)
 72a:	e852                	sd	s4,16(sp)
 72c:	e456                	sd	s5,8(sp)
 72e:	e05a                	sd	s6,0(sp)
 730:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	02051493          	slli	s1,a0,0x20
 736:	9081                	srli	s1,s1,0x20
 738:	04bd                	addi	s1,s1,15
 73a:	8091                	srli	s1,s1,0x4
 73c:	0014899b          	addiw	s3,s1,1
 740:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 742:	00001517          	auipc	a0,0x1
 746:	8be53503          	ld	a0,-1858(a0) # 1000 <freep>
 74a:	c515                	beqz	a0,776 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 74c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 74e:	4798                	lw	a4,8(a5)
 750:	02977f63          	bgeu	a4,s1,78e <malloc+0x70>
 754:	8a4e                	mv	s4,s3
 756:	0009871b          	sext.w	a4,s3
 75a:	6685                	lui	a3,0x1
 75c:	00d77363          	bgeu	a4,a3,762 <malloc+0x44>
 760:	6a05                	lui	s4,0x1
 762:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 766:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 76a:	00001917          	auipc	s2,0x1
 76e:	89690913          	addi	s2,s2,-1898 # 1000 <freep>
  if(p == (char*)-1)
 772:	5afd                	li	s5,-1
 774:	a88d                	j	7e6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 776:	00001797          	auipc	a5,0x1
 77a:	8aa78793          	addi	a5,a5,-1878 # 1020 <base>
 77e:	00001717          	auipc	a4,0x1
 782:	88f73123          	sd	a5,-1918(a4) # 1000 <freep>
 786:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 788:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 78c:	b7e1                	j	754 <malloc+0x36>
      if(p->s.size == nunits)
 78e:	02e48b63          	beq	s1,a4,7c4 <malloc+0xa6>
        p->s.size -= nunits;
 792:	4137073b          	subw	a4,a4,s3
 796:	c798                	sw	a4,8(a5)
        p += p->s.size;
 798:	1702                	slli	a4,a4,0x20
 79a:	9301                	srli	a4,a4,0x20
 79c:	0712                	slli	a4,a4,0x4
 79e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7a0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7a4:	00001717          	auipc	a4,0x1
 7a8:	84a73e23          	sd	a0,-1956(a4) # 1000 <freep>
      return (void*)(p + 1);
 7ac:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7b0:	70e2                	ld	ra,56(sp)
 7b2:	7442                	ld	s0,48(sp)
 7b4:	74a2                	ld	s1,40(sp)
 7b6:	7902                	ld	s2,32(sp)
 7b8:	69e2                	ld	s3,24(sp)
 7ba:	6a42                	ld	s4,16(sp)
 7bc:	6aa2                	ld	s5,8(sp)
 7be:	6b02                	ld	s6,0(sp)
 7c0:	6121                	addi	sp,sp,64
 7c2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7c4:	6398                	ld	a4,0(a5)
 7c6:	e118                	sd	a4,0(a0)
 7c8:	bff1                	j	7a4 <malloc+0x86>
  hp->s.size = nu;
 7ca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7ce:	0541                	addi	a0,a0,16
 7d0:	00000097          	auipc	ra,0x0
 7d4:	ec6080e7          	jalr	-314(ra) # 696 <free>
  return freep;
 7d8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7dc:	d971                	beqz	a0,7b0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7e0:	4798                	lw	a4,8(a5)
 7e2:	fa9776e3          	bgeu	a4,s1,78e <malloc+0x70>
    if(p == freep)
 7e6:	00093703          	ld	a4,0(s2)
 7ea:	853e                	mv	a0,a5
 7ec:	fef719e3          	bne	a4,a5,7de <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 7f0:	8552                	mv	a0,s4
 7f2:	00000097          	auipc	ra,0x0
 7f6:	b7e080e7          	jalr	-1154(ra) # 370 <sbrk>
  if(p == (char*)-1)
 7fa:	fd5518e3          	bne	a0,s5,7ca <malloc+0xac>
        return 0;
 7fe:	4501                	li	a0,0
 800:	bf45                	j	7b0 <malloc+0x92>

0000000000000802 <uswtch>:
 802:	00153023          	sd	ra,0(a0)
 806:	00253423          	sd	sp,8(a0)
 80a:	e900                	sd	s0,16(a0)
 80c:	ed04                	sd	s1,24(a0)
 80e:	03253023          	sd	s2,32(a0)
 812:	03353423          	sd	s3,40(a0)
 816:	03453823          	sd	s4,48(a0)
 81a:	03553c23          	sd	s5,56(a0)
 81e:	05653023          	sd	s6,64(a0)
 822:	05753423          	sd	s7,72(a0)
 826:	05853823          	sd	s8,80(a0)
 82a:	05953c23          	sd	s9,88(a0)
 82e:	07a53023          	sd	s10,96(a0)
 832:	07b53423          	sd	s11,104(a0)
 836:	0005b083          	ld	ra,0(a1)
 83a:	0085b103          	ld	sp,8(a1)
 83e:	6980                	ld	s0,16(a1)
 840:	6d84                	ld	s1,24(a1)
 842:	0205b903          	ld	s2,32(a1)
 846:	0285b983          	ld	s3,40(a1)
 84a:	0305ba03          	ld	s4,48(a1)
 84e:	0385ba83          	ld	s5,56(a1)
 852:	0405bb03          	ld	s6,64(a1)
 856:	0485bb83          	ld	s7,72(a1)
 85a:	0505bc03          	ld	s8,80(a1)
 85e:	0585bc83          	ld	s9,88(a1)
 862:	0605bd03          	ld	s10,96(a1)
 866:	0685bd83          	ld	s11,104(a1)
 86a:	8082                	ret

000000000000086c <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 86c:	1141                	addi	sp,sp,-16
 86e:	e422                	sd	s0,8(sp)
 870:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 872:	00000797          	auipc	a5,0x0
 876:	79a78793          	addi	a5,a5,1946 # 100c <ids>
 87a:	0007a303          	lw	t1,0(a5)
 87e:	2305                	addiw	t1,t1,1
 880:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 884:	00001717          	auipc	a4,0x1
 888:	74c70713          	addi	a4,a4,1868 # 1fd0 <uthreads+0xfa0>
 88c:	4781                	li	a5,0
 88e:	6605                	lui	a2,0x1
 890:	02060613          	addi	a2,a2,32 # 1020 <base>
 894:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 896:	4314                	lw	a3,0(a4)
 898:	c699                	beqz	a3,8a6 <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 89a:	2785                	addiw	a5,a5,1
 89c:	9732                	add	a4,a4,a2
 89e:	ff079ce3          	bne	a5,a6,896 <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 8a2:	557d                	li	a0,-1
 8a4:	a889                	j	8f6 <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 8a6:	4711                	li	a4,4
 8a8:	04e78a63          	beq	a5,a4,8fc <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 8ac:	00000897          	auipc	a7,0x0
 8b0:	78488893          	addi	a7,a7,1924 # 1030 <uthreads>
 8b4:	00779693          	slli	a3,a5,0x7
 8b8:	00f68633          	add	a2,a3,a5
 8bc:	0616                	slli	a2,a2,0x5
 8be:	9646                	add	a2,a2,a7
 8c0:	6805                	lui	a6,0x1
 8c2:	00c80e33          	add	t3,a6,a2
 8c6:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 8ca:	00f68733          	add	a4,a3,a5
 8ce:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 8d0:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x3a8>
 8d4:	972a                	add	a4,a4,a0
 8d6:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 8d8:	0721                	addi	a4,a4,8
 8da:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 8de:	4709                	li	a4,2
 8e0:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 8e4:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 8e8:	00000717          	auipc	a4,0x0
 8ec:	72c73423          	sd	a2,1832(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 8f0:	006e2e23          	sw	t1,28(t3)

    return 0;
 8f4:	4501                	li	a0,0
}
 8f6:	6422                	ld	s0,8(sp)
 8f8:	0141                	addi	sp,sp,16
 8fa:	8082                	ret
        return -1;
 8fc:	557d                	li	a0,-1
 8fe:	bfe5                	j	8f6 <uthread_create+0x8a>

0000000000000900 <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 900:	1141                	addi	sp,sp,-16
 902:	e422                	sd	s0,8(sp)
 904:	0800                	addi	s0,sp,16
  switch (s)
 906:	4705                	li	a4,1
 908:	02e50763          	beq	a0,a4,936 <get_state+0x36>
 90c:	87aa                	mv	a5,a0
 90e:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 910:	00000517          	auipc	a0,0x0
 914:	30850513          	addi	a0,a0,776 # c18 <digits+0x20>
  switch (s)
 918:	00e78763          	beq	a5,a4,926 <get_state+0x26>
  }

  return "ERROR";
 91c:	00000517          	auipc	a0,0x0
 920:	2f450513          	addi	a0,a0,756 # c10 <digits+0x18>
  switch (s)
 924:	c781                	beqz	a5,92c <get_state+0x2c>
}
 926:	6422                	ld	s0,8(sp)
 928:	0141                	addi	sp,sp,16
 92a:	8082                	ret
    return "FREE";
 92c:	00000517          	auipc	a0,0x0
 930:	30450513          	addi	a0,a0,772 # c30 <digits+0x38>
 934:	bfcd                	j	926 <get_state+0x26>
  switch (s)
 936:	00000517          	auipc	a0,0x0
 93a:	2f250513          	addi	a0,a0,754 # c28 <digits+0x30>
 93e:	b7e5                	j	926 <get_state+0x26>

0000000000000940 <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 940:	1141                	addi	sp,sp,-16
 942:	e422                	sd	s0,8(sp)
 944:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 946:	00000717          	auipc	a4,0x0
 94a:	6ca73703          	ld	a4,1738(a4) # 1010 <currentThread>
 94e:	00000797          	auipc	a5,0x0
 952:	6e278793          	addi	a5,a5,1762 # 1030 <uthreads>
 956:	8f1d                	sub	a4,a4,a5
 958:	8715                	srai	a4,a4,0x5
 95a:	00000797          	auipc	a5,0x0
 95e:	2567b783          	ld	a5,598(a5) # bb0 <uthread_self+0x20>
 962:	02f70733          	mul	a4,a4,a5
 966:	0705                	addi	a4,a4,1
 968:	43f75793          	srai	a5,a4,0x3f
 96c:	03e7d693          	srli	a3,a5,0x3e
 970:	00d707b3          	add	a5,a4,a3
 974:	8b8d                	andi	a5,a5,3
 976:	8f95                	sub	a5,a5,a3
 978:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 97a:	00000597          	auipc	a1,0x0
 97e:	6b658593          	addi	a1,a1,1718 # 1030 <uthreads>
 982:	6605                	lui	a2,0x1
 984:	4805                	li	a6,1
 986:	a819                	j	99c <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 988:	2785                	addiw	a5,a5,1
 98a:	41f7d71b          	sraiw	a4,a5,0x1f
 98e:	01e7571b          	srliw	a4,a4,0x1e
 992:	9fb9                	addw	a5,a5,a4
 994:	8b8d                	andi	a5,a5,3
 996:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 998:	36fd                	addiw	a3,a3,-1
 99a:	ce9d                	beqz	a3,9d8 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 99c:	00779713          	slli	a4,a5,0x7
 9a0:	973e                	add	a4,a4,a5
 9a2:	0716                	slli	a4,a4,0x5
 9a4:	972e                	add	a4,a4,a1
 9a6:	9732                	add	a4,a4,a2
 9a8:	fa072703          	lw	a4,-96(a4)
 9ac:	377d                	addiw	a4,a4,-1
 9ae:	fce86de3          	bltu	a6,a4,988 <find_next+0x48>
 9b2:	00779713          	slli	a4,a5,0x7
 9b6:	973e                	add	a4,a4,a5
 9b8:	0716                	slli	a4,a4,0x5
 9ba:	972e                	add	a4,a4,a1
 9bc:	9732                	add	a4,a4,a2
 9be:	4f18                	lw	a4,24(a4)
 9c0:	fca714e3          	bne	a4,a0,988 <find_next+0x48>
      next = &uthreads[j];
 9c4:	00779513          	slli	a0,a5,0x7
 9c8:	953e                	add	a0,a0,a5
 9ca:	0516                	slli	a0,a0,0x5
 9cc:	00000797          	auipc	a5,0x0
 9d0:	66478793          	addi	a5,a5,1636 # 1030 <uthreads>
 9d4:	953e                	add	a0,a0,a5
      break;
 9d6:	a011                	j	9da <find_next+0x9a>
  struct uthread* next = 0;
 9d8:	4501                	li	a0,0
  }

  return next;
}
 9da:	6422                	ld	s0,8(sp)
 9dc:	0141                	addi	sp,sp,16
 9de:	8082                	ret

00000000000009e0 <schedule>:
void schedule(){
 9e0:	1101                	addi	sp,sp,-32
 9e2:	ec06                	sd	ra,24(sp)
 9e4:	e822                	sd	s0,16(sp)
 9e6:	e426                	sd	s1,8(sp)
 9e8:	1000                	addi	s0,sp,32
  cur = currentThread;
 9ea:	00000497          	auipc	s1,0x0
 9ee:	6264b483          	ld	s1,1574(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 9f2:	4509                	li	a0,2
 9f4:	00000097          	auipc	ra,0x0
 9f8:	f4c080e7          	jalr	-180(ra) # 940 <find_next>
  if(next == 0)
 9fc:	c915                	beqz	a0,a30 <schedule+0x50>
  currentThread = next;
 9fe:	00000797          	auipc	a5,0x0
 a02:	60a7b923          	sd	a0,1554(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 a06:	6785                	lui	a5,0x1
 a08:	00f50733          	add	a4,a0,a5
 a0c:	4685                	li	a3,1
 a0e:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 a12:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x3b0>
 a16:	00f505b3          	add	a1,a0,a5
 a1a:	00f48533          	add	a0,s1,a5
 a1e:	00000097          	auipc	ra,0x0
 a22:	de4080e7          	jalr	-540(ra) # 802 <uswtch>
}
 a26:	60e2                	ld	ra,24(sp)
 a28:	6442                	ld	s0,16(sp)
 a2a:	64a2                	ld	s1,8(sp)
 a2c:	6105                	addi	sp,sp,32
 a2e:	8082                	ret
    next = find_next(MEDIUM);
 a30:	4505                	li	a0,1
 a32:	00000097          	auipc	ra,0x0
 a36:	f0e080e7          	jalr	-242(ra) # 940 <find_next>
  if(next == 0)
 a3a:	f171                	bnez	a0,9fe <schedule+0x1e>
    next = find_next(LOW);
 a3c:	00000097          	auipc	ra,0x0
 a40:	f04080e7          	jalr	-252(ra) # 940 <find_next>
  if(next == 0)
 a44:	fd4d                	bnez	a0,9fe <schedule+0x1e>
    exit(-1);
 a46:	557d                	li	a0,-1
 a48:	00000097          	auipc	ra,0x0
 a4c:	8a0080e7          	jalr	-1888(ra) # 2e8 <exit>

0000000000000a50 <uthread_yield>:
{
 a50:	1141                	addi	sp,sp,-16
 a52:	e406                	sd	ra,8(sp)
 a54:	e022                	sd	s0,0(sp)
 a56:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 a58:	00000797          	auipc	a5,0x0
 a5c:	5b87b783          	ld	a5,1464(a5) # 1010 <currentThread>
 a60:	6705                	lui	a4,0x1
 a62:	97ba                	add	a5,a5,a4
 a64:	4709                	li	a4,2
 a66:	fae7a023          	sw	a4,-96(a5)
  schedule();
 a6a:	00000097          	auipc	ra,0x0
 a6e:	f76080e7          	jalr	-138(ra) # 9e0 <schedule>
}
 a72:	60a2                	ld	ra,8(sp)
 a74:	6402                	ld	s0,0(sp)
 a76:	0141                	addi	sp,sp,16
 a78:	8082                	ret

0000000000000a7a <uthread_exit>:

void uthread_exit()
{
 a7a:	1141                	addi	sp,sp,-16
 a7c:	e406                	sd	ra,8(sp)
 a7e:	e022                	sd	s0,0(sp)
 a80:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 a82:	00000797          	auipc	a5,0x0
 a86:	58e7b783          	ld	a5,1422(a5) # 1010 <currentThread>
 a8a:	6705                	lui	a4,0x1
 a8c:	97ba                	add	a5,a5,a4
 a8e:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 a92:	00001797          	auipc	a5,0x1
 a96:	53e78793          	addi	a5,a5,1342 # 1fd0 <uthreads+0xfa0>
 a9a:	00005597          	auipc	a1,0x5
 a9e:	5b658593          	addi	a1,a1,1462 # 6050 <uthreads+0x5020>
  int remainingThreads = 0;
 aa2:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 aa4:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 aa6:	6685                	lui	a3,0x1
 aa8:	02068693          	addi	a3,a3,32 # 1020 <base>
 aac:	a021                	j	ab4 <uthread_exit+0x3a>
 aae:	97b6                	add	a5,a5,a3
 ab0:	00b78763          	beq	a5,a1,abe <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 ab4:	4398                	lw	a4,0(a5)
 ab6:	fec71ce3          	bne	a4,a2,aae <uthread_exit+0x34>
      remainingThreads++;
 aba:	2505                	addiw	a0,a0,1
 abc:	bfcd                	j	aae <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 abe:	c909                	beqz	a0,ad0 <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 ac0:	00000097          	auipc	ra,0x0
 ac4:	f20080e7          	jalr	-224(ra) # 9e0 <schedule>
  }
}
 ac8:	60a2                	ld	ra,8(sp)
 aca:	6402                	ld	s0,0(sp)
 acc:	0141                	addi	sp,sp,16
 ace:	8082                	ret
    exit(0);
 ad0:	00000097          	auipc	ra,0x0
 ad4:	818080e7          	jalr	-2024(ra) # 2e8 <exit>

0000000000000ad8 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 ad8:	1141                	addi	sp,sp,-16
 ada:	e422                	sd	s0,8(sp)
 adc:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 ade:	00000797          	auipc	a5,0x0
 ae2:	5327b783          	ld	a5,1330(a5) # 1010 <currentThread>
 ae6:	6705                	lui	a4,0x1
 ae8:	97ba                	add	a5,a5,a4
 aea:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 aec:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 aee:	853a                	mv	a0,a4
 af0:	6422                	ld	s0,8(sp)
 af2:	0141                	addi	sp,sp,16
 af4:	8082                	ret

0000000000000af6 <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 af6:	1141                	addi	sp,sp,-16
 af8:	e422                	sd	s0,8(sp)
 afa:	0800                	addi	s0,sp,16
    return currentThread->priority;
 afc:	00000797          	auipc	a5,0x0
 b00:	5147b783          	ld	a5,1300(a5) # 1010 <currentThread>
 b04:	6705                	lui	a4,0x1
 b06:	97ba                	add	a5,a5,a4
}
 b08:	4f88                	lw	a0,24(a5)
 b0a:	6422                	ld	s0,8(sp)
 b0c:	0141                	addi	sp,sp,16
 b0e:	8082                	ret

0000000000000b10 <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 b10:	7175                	addi	sp,sp,-144
 b12:	e506                	sd	ra,136(sp)
 b14:	e122                	sd	s0,128(sp)
 b16:	fca6                	sd	s1,120(sp)
 b18:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 b1a:	00000497          	auipc	s1,0x0
 b1e:	4ee4a483          	lw	s1,1262(s1) # 1008 <uthreadStarted>
 b22:	e4ad                	bnez	s1,b8c <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 b24:	4785                	li	a5,1
 b26:	00000717          	auipc	a4,0x0
 b2a:	4ef72123          	sw	a5,1250(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 b2e:	4509                	li	a0,2
 b30:	00000097          	auipc	ra,0x0
 b34:	e10080e7          	jalr	-496(ra) # 940 <find_next>
  if(next == 0)
 b38:	c915                	beqz	a0,b6c <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 b3a:	00000797          	auipc	a5,0x0
 b3e:	4ca7bb23          	sd	a0,1238(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 b42:	6585                	lui	a1,0x1
 b44:	00b507b3          	add	a5,a0,a1
 b48:	4705                	li	a4,1
 b4a:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 b4e:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x3b0>
 b52:	95aa                	add	a1,a1,a0
 b54:	f7040513          	addi	a0,s0,-144
 b58:	00000097          	auipc	ra,0x0
 b5c:	caa080e7          	jalr	-854(ra) # 802 <uswtch>

  return 0;
}
 b60:	8526                	mv	a0,s1
 b62:	60aa                	ld	ra,136(sp)
 b64:	640a                	ld	s0,128(sp)
 b66:	74e6                	ld	s1,120(sp)
 b68:	6149                	addi	sp,sp,144
 b6a:	8082                	ret
    next = find_next(MEDIUM);
 b6c:	4505                	li	a0,1
 b6e:	00000097          	auipc	ra,0x0
 b72:	dd2080e7          	jalr	-558(ra) # 940 <find_next>
  if(next == 0)
 b76:	f171                	bnez	a0,b3a <uthread_start_all+0x2a>
    next = find_next(LOW);
 b78:	00000097          	auipc	ra,0x0
 b7c:	dc8080e7          	jalr	-568(ra) # 940 <find_next>
  if(next == 0)
 b80:	fd4d                	bnez	a0,b3a <uthread_start_all+0x2a>
    exit(-1);
 b82:	557d                	li	a0,-1
 b84:	fffff097          	auipc	ra,0xfffff
 b88:	764080e7          	jalr	1892(ra) # 2e8 <exit>
    return -1;
 b8c:	54fd                	li	s1,-1
 b8e:	bfc9                	j	b60 <uthread_start_all+0x50>

0000000000000b90 <uthread_self>:


struct uthread *uthread_self()
{
 b90:	1141                	addi	sp,sp,-16
 b92:	e422                	sd	s0,8(sp)
 b94:	0800                	addi	s0,sp,16
    return currentThread;
 b96:	00000517          	auipc	a0,0x0
 b9a:	47a53503          	ld	a0,1146(a0) # 1010 <currentThread>
 b9e:	6422                	ld	s0,8(sp)
 ba0:	0141                	addi	sp,sp,16
 ba2:	8082                	ret
