
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2a2080e7          	jalr	674(ra) # 2aa <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	29c080e7          	jalr	668(ra) # 2b2 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	322080e7          	jalr	802(ra) # 342 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  extern int main();
  main();
  32:	00000097          	auipc	ra,0x0
  36:	fce080e7          	jalr	-50(ra) # 0 <main>
  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	276080e7          	jalr	630(ra) # 2b2 <exit>

0000000000000044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  44:	1141                	addi	sp,sp,-16
  46:	e422                	sd	s0,8(sp)
  48:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	87aa                	mv	a5,a0
  4c:	0585                	addi	a1,a1,1
  4e:	0785                	addi	a5,a5,1
  50:	fff5c703          	lbu	a4,-1(a1)
  54:	fee78fa3          	sb	a4,-1(a5)
  58:	fb75                	bnez	a4,4c <strcpy+0x8>
    ;
  return os;
}
  5a:	6422                	ld	s0,8(sp)
  5c:	0141                	addi	sp,sp,16
  5e:	8082                	ret

0000000000000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  66:	00054783          	lbu	a5,0(a0)
  6a:	cb91                	beqz	a5,7e <strcmp+0x1e>
  6c:	0005c703          	lbu	a4,0(a1)
  70:	00f71763          	bne	a4,a5,7e <strcmp+0x1e>
    p++, q++;
  74:	0505                	addi	a0,a0,1
  76:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  78:	00054783          	lbu	a5,0(a0)
  7c:	fbe5                	bnez	a5,6c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  7e:	0005c503          	lbu	a0,0(a1)
}
  82:	40a7853b          	subw	a0,a5,a0
  86:	6422                	ld	s0,8(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret

000000000000008c <strlen>:

uint
strlen(const char *s)
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  92:	00054783          	lbu	a5,0(a0)
  96:	cf91                	beqz	a5,b2 <strlen+0x26>
  98:	0505                	addi	a0,a0,1
  9a:	87aa                	mv	a5,a0
  9c:	4685                	li	a3,1
  9e:	9e89                	subw	a3,a3,a0
  a0:	00f6853b          	addw	a0,a3,a5
  a4:	0785                	addi	a5,a5,1
  a6:	fff7c703          	lbu	a4,-1(a5)
  aa:	fb7d                	bnez	a4,a0 <strlen+0x14>
    ;
  return n;
}
  ac:	6422                	ld	s0,8(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret
  for(n = 0; s[n]; n++)
  b2:	4501                	li	a0,0
  b4:	bfe5                	j	ac <strlen+0x20>

00000000000000b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  bc:	ca19                	beqz	a2,d2 <memset+0x1c>
  be:	87aa                	mv	a5,a0
  c0:	1602                	slli	a2,a2,0x20
  c2:	9201                	srli	a2,a2,0x20
  c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  cc:	0785                	addi	a5,a5,1
  ce:	fee79de3          	bne	a5,a4,c8 <memset+0x12>
  }
  return dst;
}
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	addi	sp,sp,16
  d6:	8082                	ret

00000000000000d8 <strchr>:

char*
strchr(const char *s, char c)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	addi	s0,sp,16
  for(; *s; s++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cb99                	beqz	a5,f8 <strchr+0x20>
    if(*s == c)
  e4:	00f58763          	beq	a1,a5,f2 <strchr+0x1a>
  for(; *s; s++)
  e8:	0505                	addi	a0,a0,1
  ea:	00054783          	lbu	a5,0(a0)
  ee:	fbfd                	bnez	a5,e4 <strchr+0xc>
      return (char*)s;
  return 0;
  f0:	4501                	li	a0,0
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret
  return 0;
  f8:	4501                	li	a0,0
  fa:	bfe5                	j	f2 <strchr+0x1a>

00000000000000fc <gets>:

char*
gets(char *buf, int max)
{
  fc:	711d                	addi	sp,sp,-96
  fe:	ec86                	sd	ra,88(sp)
 100:	e8a2                	sd	s0,80(sp)
 102:	e4a6                	sd	s1,72(sp)
 104:	e0ca                	sd	s2,64(sp)
 106:	fc4e                	sd	s3,56(sp)
 108:	f852                	sd	s4,48(sp)
 10a:	f456                	sd	s5,40(sp)
 10c:	f05a                	sd	s6,32(sp)
 10e:	ec5e                	sd	s7,24(sp)
 110:	1080                	addi	s0,sp,96
 112:	8baa                	mv	s7,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 11a:	4aa9                	li	s5,10
 11c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 11e:	89a6                	mv	s3,s1
 120:	2485                	addiw	s1,s1,1
 122:	0344d863          	bge	s1,s4,152 <gets+0x56>
    cc = read(0, &c, 1);
 126:	4605                	li	a2,1
 128:	faf40593          	addi	a1,s0,-81
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	19c080e7          	jalr	412(ra) # 2ca <read>
    if(cc < 1)
 136:	00a05e63          	blez	a0,152 <gets+0x56>
    buf[i++] = c;
 13a:	faf44783          	lbu	a5,-81(s0)
 13e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 142:	01578763          	beq	a5,s5,150 <gets+0x54>
 146:	0905                	addi	s2,s2,1
 148:	fd679be3          	bne	a5,s6,11e <gets+0x22>
  for(i=0; i+1 < max; ){
 14c:	89a6                	mv	s3,s1
 14e:	a011                	j	152 <gets+0x56>
 150:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 152:	99de                	add	s3,s3,s7
 154:	00098023          	sb	zero,0(s3)
  return buf;
}
 158:	855e                	mv	a0,s7
 15a:	60e6                	ld	ra,88(sp)
 15c:	6446                	ld	s0,80(sp)
 15e:	64a6                	ld	s1,72(sp)
 160:	6906                	ld	s2,64(sp)
 162:	79e2                	ld	s3,56(sp)
 164:	7a42                	ld	s4,48(sp)
 166:	7aa2                	ld	s5,40(sp)
 168:	7b02                	ld	s6,32(sp)
 16a:	6be2                	ld	s7,24(sp)
 16c:	6125                	addi	sp,sp,96
 16e:	8082                	ret

0000000000000170 <stat>:

int
stat(const char *n, struct stat *st)
{
 170:	1101                	addi	sp,sp,-32
 172:	ec06                	sd	ra,24(sp)
 174:	e822                	sd	s0,16(sp)
 176:	e426                	sd	s1,8(sp)
 178:	e04a                	sd	s2,0(sp)
 17a:	1000                	addi	s0,sp,32
 17c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17e:	4581                	li	a1,0
 180:	00000097          	auipc	ra,0x0
 184:	172080e7          	jalr	370(ra) # 2f2 <open>
  if(fd < 0)
 188:	02054563          	bltz	a0,1b2 <stat+0x42>
 18c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 18e:	85ca                	mv	a1,s2
 190:	00000097          	auipc	ra,0x0
 194:	17a080e7          	jalr	378(ra) # 30a <fstat>
 198:	892a                	mv	s2,a0
  close(fd);
 19a:	8526                	mv	a0,s1
 19c:	00000097          	auipc	ra,0x0
 1a0:	13e080e7          	jalr	318(ra) # 2da <close>
  return r;
}
 1a4:	854a                	mv	a0,s2
 1a6:	60e2                	ld	ra,24(sp)
 1a8:	6442                	ld	s0,16(sp)
 1aa:	64a2                	ld	s1,8(sp)
 1ac:	6902                	ld	s2,0(sp)
 1ae:	6105                	addi	sp,sp,32
 1b0:	8082                	ret
    return -1;
 1b2:	597d                	li	s2,-1
 1b4:	bfc5                	j	1a4 <stat+0x34>

00000000000001b6 <atoi>:

int
atoi(const char *s)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bc:	00054603          	lbu	a2,0(a0)
 1c0:	fd06079b          	addiw	a5,a2,-48
 1c4:	0ff7f793          	andi	a5,a5,255
 1c8:	4725                	li	a4,9
 1ca:	02f76963          	bltu	a4,a5,1fc <atoi+0x46>
 1ce:	86aa                	mv	a3,a0
  n = 0;
 1d0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1d2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1d4:	0685                	addi	a3,a3,1
 1d6:	0025179b          	slliw	a5,a0,0x2
 1da:	9fa9                	addw	a5,a5,a0
 1dc:	0017979b          	slliw	a5,a5,0x1
 1e0:	9fb1                	addw	a5,a5,a2
 1e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e6:	0006c603          	lbu	a2,0(a3)
 1ea:	fd06071b          	addiw	a4,a2,-48
 1ee:	0ff77713          	andi	a4,a4,255
 1f2:	fee5f1e3          	bgeu	a1,a4,1d4 <atoi+0x1e>
  return n;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
  n = 0;
 1fc:	4501                	li	a0,0
 1fe:	bfe5                	j	1f6 <atoi+0x40>

0000000000000200 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 206:	02b57463          	bgeu	a0,a1,22e <memmove+0x2e>
    while(n-- > 0)
 20a:	00c05f63          	blez	a2,228 <memmove+0x28>
 20e:	1602                	slli	a2,a2,0x20
 210:	9201                	srli	a2,a2,0x20
 212:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 216:	872a                	mv	a4,a0
      *dst++ = *src++;
 218:	0585                	addi	a1,a1,1
 21a:	0705                	addi	a4,a4,1
 21c:	fff5c683          	lbu	a3,-1(a1)
 220:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 224:	fee79ae3          	bne	a5,a4,218 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
    dst += n;
 22e:	00c50733          	add	a4,a0,a2
    src += n;
 232:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 234:	fec05ae3          	blez	a2,228 <memmove+0x28>
 238:	fff6079b          	addiw	a5,a2,-1
 23c:	1782                	slli	a5,a5,0x20
 23e:	9381                	srli	a5,a5,0x20
 240:	fff7c793          	not	a5,a5
 244:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 246:	15fd                	addi	a1,a1,-1
 248:	177d                	addi	a4,a4,-1
 24a:	0005c683          	lbu	a3,0(a1)
 24e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 252:	fee79ae3          	bne	a5,a4,246 <memmove+0x46>
 256:	bfc9                	j	228 <memmove+0x28>

0000000000000258 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e422                	sd	s0,8(sp)
 25c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 25e:	ca05                	beqz	a2,28e <memcmp+0x36>
 260:	fff6069b          	addiw	a3,a2,-1
 264:	1682                	slli	a3,a3,0x20
 266:	9281                	srli	a3,a3,0x20
 268:	0685                	addi	a3,a3,1
 26a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 26c:	00054783          	lbu	a5,0(a0)
 270:	0005c703          	lbu	a4,0(a1)
 274:	00e79863          	bne	a5,a4,284 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 278:	0505                	addi	a0,a0,1
    p2++;
 27a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 27c:	fed518e3          	bne	a0,a3,26c <memcmp+0x14>
  }
  return 0;
 280:	4501                	li	a0,0
 282:	a019                	j	288 <memcmp+0x30>
      return *p1 - *p2;
 284:	40e7853b          	subw	a0,a5,a4
}
 288:	6422                	ld	s0,8(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret
  return 0;
 28e:	4501                	li	a0,0
 290:	bfe5                	j	288 <memcmp+0x30>

0000000000000292 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 29a:	00000097          	auipc	ra,0x0
 29e:	f66080e7          	jalr	-154(ra) # 200 <memmove>
}
 2a2:	60a2                	ld	ra,8(sp)
 2a4:	6402                	ld	s0,0(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2aa:	4885                	li	a7,1
 ecall
 2ac:	00000073          	ecall
 ret
 2b0:	8082                	ret

00000000000002b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2b2:	4889                	li	a7,2
 ecall
 2b4:	00000073          	ecall
 ret
 2b8:	8082                	ret

00000000000002ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ba:	488d                	li	a7,3
 ecall
 2bc:	00000073          	ecall
 ret
 2c0:	8082                	ret

00000000000002c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2c2:	4891                	li	a7,4
 ecall
 2c4:	00000073          	ecall
 ret
 2c8:	8082                	ret

00000000000002ca <read>:
.global read
read:
 li a7, SYS_read
 2ca:	4895                	li	a7,5
 ecall
 2cc:	00000073          	ecall
 ret
 2d0:	8082                	ret

00000000000002d2 <write>:
.global write
write:
 li a7, SYS_write
 2d2:	48c1                	li	a7,16
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <close>:
.global close
close:
 li a7, SYS_close
 2da:	48d5                	li	a7,21
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2e2:	4899                	li	a7,6
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 2ea:	489d                	li	a7,7
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <open>:
.global open
open:
 li a7, SYS_open
 2f2:	48bd                	li	a7,15
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2fa:	48c5                	li	a7,17
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 302:	48c9                	li	a7,18
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 30a:	48a1                	li	a7,8
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <link>:
.global link
link:
 li a7, SYS_link
 312:	48cd                	li	a7,19
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 31a:	48d1                	li	a7,20
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 322:	48a5                	li	a7,9
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <dup>:
.global dup
dup:
 li a7, SYS_dup
 32a:	48a9                	li	a7,10
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 332:	48ad                	li	a7,11
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 33a:	48b1                	li	a7,12
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 342:	48b5                	li	a7,13
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 34a:	48b9                	li	a7,14
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 352:	1101                	addi	sp,sp,-32
 354:	ec06                	sd	ra,24(sp)
 356:	e822                	sd	s0,16(sp)
 358:	1000                	addi	s0,sp,32
 35a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 35e:	4605                	li	a2,1
 360:	fef40593          	addi	a1,s0,-17
 364:	00000097          	auipc	ra,0x0
 368:	f6e080e7          	jalr	-146(ra) # 2d2 <write>
}
 36c:	60e2                	ld	ra,24(sp)
 36e:	6442                	ld	s0,16(sp)
 370:	6105                	addi	sp,sp,32
 372:	8082                	ret

0000000000000374 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 374:	7139                	addi	sp,sp,-64
 376:	fc06                	sd	ra,56(sp)
 378:	f822                	sd	s0,48(sp)
 37a:	f426                	sd	s1,40(sp)
 37c:	f04a                	sd	s2,32(sp)
 37e:	ec4e                	sd	s3,24(sp)
 380:	0080                	addi	s0,sp,64
 382:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 384:	c299                	beqz	a3,38a <printint+0x16>
 386:	0805c863          	bltz	a1,416 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 38a:	2581                	sext.w	a1,a1
  neg = 0;
 38c:	4881                	li	a7,0
 38e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 392:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 394:	2601                	sext.w	a2,a2
 396:	00000517          	auipc	a0,0x0
 39a:	7f250513          	addi	a0,a0,2034 # b88 <digits>
 39e:	883a                	mv	a6,a4
 3a0:	2705                	addiw	a4,a4,1
 3a2:	02c5f7bb          	remuw	a5,a1,a2
 3a6:	1782                	slli	a5,a5,0x20
 3a8:	9381                	srli	a5,a5,0x20
 3aa:	97aa                	add	a5,a5,a0
 3ac:	0007c783          	lbu	a5,0(a5)
 3b0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3b4:	0005879b          	sext.w	a5,a1
 3b8:	02c5d5bb          	divuw	a1,a1,a2
 3bc:	0685                	addi	a3,a3,1
 3be:	fec7f0e3          	bgeu	a5,a2,39e <printint+0x2a>
  if(neg)
 3c2:	00088b63          	beqz	a7,3d8 <printint+0x64>
    buf[i++] = '-';
 3c6:	fd040793          	addi	a5,s0,-48
 3ca:	973e                	add	a4,a4,a5
 3cc:	02d00793          	li	a5,45
 3d0:	fef70823          	sb	a5,-16(a4)
 3d4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3d8:	02e05863          	blez	a4,408 <printint+0x94>
 3dc:	fc040793          	addi	a5,s0,-64
 3e0:	00e78933          	add	s2,a5,a4
 3e4:	fff78993          	addi	s3,a5,-1
 3e8:	99ba                	add	s3,s3,a4
 3ea:	377d                	addiw	a4,a4,-1
 3ec:	1702                	slli	a4,a4,0x20
 3ee:	9301                	srli	a4,a4,0x20
 3f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3f4:	fff94583          	lbu	a1,-1(s2)
 3f8:	8526                	mv	a0,s1
 3fa:	00000097          	auipc	ra,0x0
 3fe:	f58080e7          	jalr	-168(ra) # 352 <putc>
  while(--i >= 0)
 402:	197d                	addi	s2,s2,-1
 404:	ff3918e3          	bne	s2,s3,3f4 <printint+0x80>
}
 408:	70e2                	ld	ra,56(sp)
 40a:	7442                	ld	s0,48(sp)
 40c:	74a2                	ld	s1,40(sp)
 40e:	7902                	ld	s2,32(sp)
 410:	69e2                	ld	s3,24(sp)
 412:	6121                	addi	sp,sp,64
 414:	8082                	ret
    x = -xx;
 416:	40b005bb          	negw	a1,a1
    neg = 1;
 41a:	4885                	li	a7,1
    x = -xx;
 41c:	bf8d                	j	38e <printint+0x1a>

000000000000041e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 41e:	7119                	addi	sp,sp,-128
 420:	fc86                	sd	ra,120(sp)
 422:	f8a2                	sd	s0,112(sp)
 424:	f4a6                	sd	s1,104(sp)
 426:	f0ca                	sd	s2,96(sp)
 428:	ecce                	sd	s3,88(sp)
 42a:	e8d2                	sd	s4,80(sp)
 42c:	e4d6                	sd	s5,72(sp)
 42e:	e0da                	sd	s6,64(sp)
 430:	fc5e                	sd	s7,56(sp)
 432:	f862                	sd	s8,48(sp)
 434:	f466                	sd	s9,40(sp)
 436:	f06a                	sd	s10,32(sp)
 438:	ec6e                	sd	s11,24(sp)
 43a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 43c:	0005c903          	lbu	s2,0(a1)
 440:	18090f63          	beqz	s2,5de <vprintf+0x1c0>
 444:	8aaa                	mv	s5,a0
 446:	8b32                	mv	s6,a2
 448:	00158493          	addi	s1,a1,1
  state = 0;
 44c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 44e:	02500a13          	li	s4,37
      if(c == 'd'){
 452:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 456:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 45a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 45e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 462:	00000b97          	auipc	s7,0x0
 466:	726b8b93          	addi	s7,s7,1830 # b88 <digits>
 46a:	a839                	j	488 <vprintf+0x6a>
        putc(fd, c);
 46c:	85ca                	mv	a1,s2
 46e:	8556                	mv	a0,s5
 470:	00000097          	auipc	ra,0x0
 474:	ee2080e7          	jalr	-286(ra) # 352 <putc>
 478:	a019                	j	47e <vprintf+0x60>
    } else if(state == '%'){
 47a:	01498f63          	beq	s3,s4,498 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 47e:	0485                	addi	s1,s1,1
 480:	fff4c903          	lbu	s2,-1(s1)
 484:	14090d63          	beqz	s2,5de <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 488:	0009079b          	sext.w	a5,s2
    if(state == 0){
 48c:	fe0997e3          	bnez	s3,47a <vprintf+0x5c>
      if(c == '%'){
 490:	fd479ee3          	bne	a5,s4,46c <vprintf+0x4e>
        state = '%';
 494:	89be                	mv	s3,a5
 496:	b7e5                	j	47e <vprintf+0x60>
      if(c == 'd'){
 498:	05878063          	beq	a5,s8,4d8 <vprintf+0xba>
      } else if(c == 'l') {
 49c:	05978c63          	beq	a5,s9,4f4 <vprintf+0xd6>
      } else if(c == 'x') {
 4a0:	07a78863          	beq	a5,s10,510 <vprintf+0xf2>
      } else if(c == 'p') {
 4a4:	09b78463          	beq	a5,s11,52c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4a8:	07300713          	li	a4,115
 4ac:	0ce78663          	beq	a5,a4,578 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4b0:	06300713          	li	a4,99
 4b4:	0ee78e63          	beq	a5,a4,5b0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4b8:	11478863          	beq	a5,s4,5c8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4bc:	85d2                	mv	a1,s4
 4be:	8556                	mv	a0,s5
 4c0:	00000097          	auipc	ra,0x0
 4c4:	e92080e7          	jalr	-366(ra) # 352 <putc>
        putc(fd, c);
 4c8:	85ca                	mv	a1,s2
 4ca:	8556                	mv	a0,s5
 4cc:	00000097          	auipc	ra,0x0
 4d0:	e86080e7          	jalr	-378(ra) # 352 <putc>
      }
      state = 0;
 4d4:	4981                	li	s3,0
 4d6:	b765                	j	47e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4d8:	008b0913          	addi	s2,s6,8
 4dc:	4685                	li	a3,1
 4de:	4629                	li	a2,10
 4e0:	000b2583          	lw	a1,0(s6)
 4e4:	8556                	mv	a0,s5
 4e6:	00000097          	auipc	ra,0x0
 4ea:	e8e080e7          	jalr	-370(ra) # 374 <printint>
 4ee:	8b4a                	mv	s6,s2
      state = 0;
 4f0:	4981                	li	s3,0
 4f2:	b771                	j	47e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4f4:	008b0913          	addi	s2,s6,8
 4f8:	4681                	li	a3,0
 4fa:	4629                	li	a2,10
 4fc:	000b2583          	lw	a1,0(s6)
 500:	8556                	mv	a0,s5
 502:	00000097          	auipc	ra,0x0
 506:	e72080e7          	jalr	-398(ra) # 374 <printint>
 50a:	8b4a                	mv	s6,s2
      state = 0;
 50c:	4981                	li	s3,0
 50e:	bf85                	j	47e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 510:	008b0913          	addi	s2,s6,8
 514:	4681                	li	a3,0
 516:	4641                	li	a2,16
 518:	000b2583          	lw	a1,0(s6)
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	e56080e7          	jalr	-426(ra) # 374 <printint>
 526:	8b4a                	mv	s6,s2
      state = 0;
 528:	4981                	li	s3,0
 52a:	bf91                	j	47e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 52c:	008b0793          	addi	a5,s6,8
 530:	f8f43423          	sd	a5,-120(s0)
 534:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 538:	03000593          	li	a1,48
 53c:	8556                	mv	a0,s5
 53e:	00000097          	auipc	ra,0x0
 542:	e14080e7          	jalr	-492(ra) # 352 <putc>
  putc(fd, 'x');
 546:	85ea                	mv	a1,s10
 548:	8556                	mv	a0,s5
 54a:	00000097          	auipc	ra,0x0
 54e:	e08080e7          	jalr	-504(ra) # 352 <putc>
 552:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 554:	03c9d793          	srli	a5,s3,0x3c
 558:	97de                	add	a5,a5,s7
 55a:	0007c583          	lbu	a1,0(a5)
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	df2080e7          	jalr	-526(ra) # 352 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 568:	0992                	slli	s3,s3,0x4
 56a:	397d                	addiw	s2,s2,-1
 56c:	fe0914e3          	bnez	s2,554 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 570:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 574:	4981                	li	s3,0
 576:	b721                	j	47e <vprintf+0x60>
        s = va_arg(ap, char*);
 578:	008b0993          	addi	s3,s6,8
 57c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 580:	02090163          	beqz	s2,5a2 <vprintf+0x184>
        while(*s != 0){
 584:	00094583          	lbu	a1,0(s2)
 588:	c9a1                	beqz	a1,5d8 <vprintf+0x1ba>
          putc(fd, *s);
 58a:	8556                	mv	a0,s5
 58c:	00000097          	auipc	ra,0x0
 590:	dc6080e7          	jalr	-570(ra) # 352 <putc>
          s++;
 594:	0905                	addi	s2,s2,1
        while(*s != 0){
 596:	00094583          	lbu	a1,0(s2)
 59a:	f9e5                	bnez	a1,58a <vprintf+0x16c>
        s = va_arg(ap, char*);
 59c:	8b4e                	mv	s6,s3
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	bdf9                	j	47e <vprintf+0x60>
          s = "(null)";
 5a2:	00000917          	auipc	s2,0x0
 5a6:	5de90913          	addi	s2,s2,1502 # b80 <uthread_self+0x26>
        while(*s != 0){
 5aa:	02800593          	li	a1,40
 5ae:	bff1                	j	58a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5b0:	008b0913          	addi	s2,s6,8
 5b4:	000b4583          	lbu	a1,0(s6)
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	d98080e7          	jalr	-616(ra) # 352 <putc>
 5c2:	8b4a                	mv	s6,s2
      state = 0;
 5c4:	4981                	li	s3,0
 5c6:	bd65                	j	47e <vprintf+0x60>
        putc(fd, c);
 5c8:	85d2                	mv	a1,s4
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	d86080e7          	jalr	-634(ra) # 352 <putc>
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b565                	j	47e <vprintf+0x60>
        s = va_arg(ap, char*);
 5d8:	8b4e                	mv	s6,s3
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b54d                	j	47e <vprintf+0x60>
    }
  }
}
 5de:	70e6                	ld	ra,120(sp)
 5e0:	7446                	ld	s0,112(sp)
 5e2:	74a6                	ld	s1,104(sp)
 5e4:	7906                	ld	s2,96(sp)
 5e6:	69e6                	ld	s3,88(sp)
 5e8:	6a46                	ld	s4,80(sp)
 5ea:	6aa6                	ld	s5,72(sp)
 5ec:	6b06                	ld	s6,64(sp)
 5ee:	7be2                	ld	s7,56(sp)
 5f0:	7c42                	ld	s8,48(sp)
 5f2:	7ca2                	ld	s9,40(sp)
 5f4:	7d02                	ld	s10,32(sp)
 5f6:	6de2                	ld	s11,24(sp)
 5f8:	6109                	addi	sp,sp,128
 5fa:	8082                	ret

00000000000005fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5fc:	715d                	addi	sp,sp,-80
 5fe:	ec06                	sd	ra,24(sp)
 600:	e822                	sd	s0,16(sp)
 602:	1000                	addi	s0,sp,32
 604:	e010                	sd	a2,0(s0)
 606:	e414                	sd	a3,8(s0)
 608:	e818                	sd	a4,16(s0)
 60a:	ec1c                	sd	a5,24(s0)
 60c:	03043023          	sd	a6,32(s0)
 610:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 614:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 618:	8622                	mv	a2,s0
 61a:	00000097          	auipc	ra,0x0
 61e:	e04080e7          	jalr	-508(ra) # 41e <vprintf>
}
 622:	60e2                	ld	ra,24(sp)
 624:	6442                	ld	s0,16(sp)
 626:	6161                	addi	sp,sp,80
 628:	8082                	ret

000000000000062a <printf>:

void
printf(const char *fmt, ...)
{
 62a:	711d                	addi	sp,sp,-96
 62c:	ec06                	sd	ra,24(sp)
 62e:	e822                	sd	s0,16(sp)
 630:	1000                	addi	s0,sp,32
 632:	e40c                	sd	a1,8(s0)
 634:	e810                	sd	a2,16(s0)
 636:	ec14                	sd	a3,24(s0)
 638:	f018                	sd	a4,32(s0)
 63a:	f41c                	sd	a5,40(s0)
 63c:	03043823          	sd	a6,48(s0)
 640:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 644:	00840613          	addi	a2,s0,8
 648:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 64c:	85aa                	mv	a1,a0
 64e:	4505                	li	a0,1
 650:	00000097          	auipc	ra,0x0
 654:	dce080e7          	jalr	-562(ra) # 41e <vprintf>
}
 658:	60e2                	ld	ra,24(sp)
 65a:	6442                	ld	s0,16(sp)
 65c:	6125                	addi	sp,sp,96
 65e:	8082                	ret

0000000000000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	1141                	addi	sp,sp,-16
 662:	e422                	sd	s0,8(sp)
 664:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 666:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66a:	00001797          	auipc	a5,0x1
 66e:	9967b783          	ld	a5,-1642(a5) # 1000 <freep>
 672:	a805                	j	6a2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 674:	4618                	lw	a4,8(a2)
 676:	9db9                	addw	a1,a1,a4
 678:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 67c:	6398                	ld	a4,0(a5)
 67e:	6318                	ld	a4,0(a4)
 680:	fee53823          	sd	a4,-16(a0)
 684:	a091                	j	6c8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 686:	ff852703          	lw	a4,-8(a0)
 68a:	9e39                	addw	a2,a2,a4
 68c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 68e:	ff053703          	ld	a4,-16(a0)
 692:	e398                	sd	a4,0(a5)
 694:	a099                	j	6da <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 696:	6398                	ld	a4,0(a5)
 698:	00e7e463          	bltu	a5,a4,6a0 <free+0x40>
 69c:	00e6ea63          	bltu	a3,a4,6b0 <free+0x50>
{
 6a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a2:	fed7fae3          	bgeu	a5,a3,696 <free+0x36>
 6a6:	6398                	ld	a4,0(a5)
 6a8:	00e6e463          	bltu	a3,a4,6b0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	fee7eae3          	bltu	a5,a4,6a0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6b0:	ff852583          	lw	a1,-8(a0)
 6b4:	6390                	ld	a2,0(a5)
 6b6:	02059713          	slli	a4,a1,0x20
 6ba:	9301                	srli	a4,a4,0x20
 6bc:	0712                	slli	a4,a4,0x4
 6be:	9736                	add	a4,a4,a3
 6c0:	fae60ae3          	beq	a2,a4,674 <free+0x14>
    bp->s.ptr = p->s.ptr;
 6c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6c8:	4790                	lw	a2,8(a5)
 6ca:	02061713          	slli	a4,a2,0x20
 6ce:	9301                	srli	a4,a4,0x20
 6d0:	0712                	slli	a4,a4,0x4
 6d2:	973e                	add	a4,a4,a5
 6d4:	fae689e3          	beq	a3,a4,686 <free+0x26>
  } else
    p->s.ptr = bp;
 6d8:	e394                	sd	a3,0(a5)
  freep = p;
 6da:	00001717          	auipc	a4,0x1
 6de:	92f73323          	sd	a5,-1754(a4) # 1000 <freep>
}
 6e2:	6422                	ld	s0,8(sp)
 6e4:	0141                	addi	sp,sp,16
 6e6:	8082                	ret

00000000000006e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e8:	7139                	addi	sp,sp,-64
 6ea:	fc06                	sd	ra,56(sp)
 6ec:	f822                	sd	s0,48(sp)
 6ee:	f426                	sd	s1,40(sp)
 6f0:	f04a                	sd	s2,32(sp)
 6f2:	ec4e                	sd	s3,24(sp)
 6f4:	e852                	sd	s4,16(sp)
 6f6:	e456                	sd	s5,8(sp)
 6f8:	e05a                	sd	s6,0(sp)
 6fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fc:	02051493          	slli	s1,a0,0x20
 700:	9081                	srli	s1,s1,0x20
 702:	04bd                	addi	s1,s1,15
 704:	8091                	srli	s1,s1,0x4
 706:	0014899b          	addiw	s3,s1,1
 70a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 70c:	00001517          	auipc	a0,0x1
 710:	8f453503          	ld	a0,-1804(a0) # 1000 <freep>
 714:	c515                	beqz	a0,740 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 716:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 718:	4798                	lw	a4,8(a5)
 71a:	02977f63          	bgeu	a4,s1,758 <malloc+0x70>
 71e:	8a4e                	mv	s4,s3
 720:	0009871b          	sext.w	a4,s3
 724:	6685                	lui	a3,0x1
 726:	00d77363          	bgeu	a4,a3,72c <malloc+0x44>
 72a:	6a05                	lui	s4,0x1
 72c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 730:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 734:	00001917          	auipc	s2,0x1
 738:	8cc90913          	addi	s2,s2,-1844 # 1000 <freep>
  if(p == (char*)-1)
 73c:	5afd                	li	s5,-1
 73e:	a88d                	j	7b0 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 740:	00001797          	auipc	a5,0x1
 744:	8e078793          	addi	a5,a5,-1824 # 1020 <base>
 748:	00001717          	auipc	a4,0x1
 74c:	8af73c23          	sd	a5,-1864(a4) # 1000 <freep>
 750:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 752:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 756:	b7e1                	j	71e <malloc+0x36>
      if(p->s.size == nunits)
 758:	02e48b63          	beq	s1,a4,78e <malloc+0xa6>
        p->s.size -= nunits;
 75c:	4137073b          	subw	a4,a4,s3
 760:	c798                	sw	a4,8(a5)
        p += p->s.size;
 762:	1702                	slli	a4,a4,0x20
 764:	9301                	srli	a4,a4,0x20
 766:	0712                	slli	a4,a4,0x4
 768:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 76a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 76e:	00001717          	auipc	a4,0x1
 772:	88a73923          	sd	a0,-1902(a4) # 1000 <freep>
      return (void*)(p + 1);
 776:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 77a:	70e2                	ld	ra,56(sp)
 77c:	7442                	ld	s0,48(sp)
 77e:	74a2                	ld	s1,40(sp)
 780:	7902                	ld	s2,32(sp)
 782:	69e2                	ld	s3,24(sp)
 784:	6a42                	ld	s4,16(sp)
 786:	6aa2                	ld	s5,8(sp)
 788:	6b02                	ld	s6,0(sp)
 78a:	6121                	addi	sp,sp,64
 78c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 78e:	6398                	ld	a4,0(a5)
 790:	e118                	sd	a4,0(a0)
 792:	bff1                	j	76e <malloc+0x86>
  hp->s.size = nu;
 794:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 798:	0541                	addi	a0,a0,16
 79a:	00000097          	auipc	ra,0x0
 79e:	ec6080e7          	jalr	-314(ra) # 660 <free>
  return freep;
 7a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7a6:	d971                	beqz	a0,77a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7aa:	4798                	lw	a4,8(a5)
 7ac:	fa9776e3          	bgeu	a4,s1,758 <malloc+0x70>
    if(p == freep)
 7b0:	00093703          	ld	a4,0(s2)
 7b4:	853e                	mv	a0,a5
 7b6:	fef719e3          	bne	a4,a5,7a8 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 7ba:	8552                	mv	a0,s4
 7bc:	00000097          	auipc	ra,0x0
 7c0:	b7e080e7          	jalr	-1154(ra) # 33a <sbrk>
  if(p == (char*)-1)
 7c4:	fd5518e3          	bne	a0,s5,794 <malloc+0xac>
        return 0;
 7c8:	4501                	li	a0,0
 7ca:	bf45                	j	77a <malloc+0x92>

00000000000007cc <uswtch>:
 7cc:	00153023          	sd	ra,0(a0)
 7d0:	00253423          	sd	sp,8(a0)
 7d4:	e900                	sd	s0,16(a0)
 7d6:	ed04                	sd	s1,24(a0)
 7d8:	03253023          	sd	s2,32(a0)
 7dc:	03353423          	sd	s3,40(a0)
 7e0:	03453823          	sd	s4,48(a0)
 7e4:	03553c23          	sd	s5,56(a0)
 7e8:	05653023          	sd	s6,64(a0)
 7ec:	05753423          	sd	s7,72(a0)
 7f0:	05853823          	sd	s8,80(a0)
 7f4:	05953c23          	sd	s9,88(a0)
 7f8:	07a53023          	sd	s10,96(a0)
 7fc:	07b53423          	sd	s11,104(a0)
 800:	0005b083          	ld	ra,0(a1)
 804:	0085b103          	ld	sp,8(a1)
 808:	6980                	ld	s0,16(a1)
 80a:	6d84                	ld	s1,24(a1)
 80c:	0205b903          	ld	s2,32(a1)
 810:	0285b983          	ld	s3,40(a1)
 814:	0305ba03          	ld	s4,48(a1)
 818:	0385ba83          	ld	s5,56(a1)
 81c:	0405bb03          	ld	s6,64(a1)
 820:	0485bb83          	ld	s7,72(a1)
 824:	0505bc03          	ld	s8,80(a1)
 828:	0585bc83          	ld	s9,88(a1)
 82c:	0605bd03          	ld	s10,96(a1)
 830:	0685bd83          	ld	s11,104(a1)
 834:	8082                	ret

0000000000000836 <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 836:	1141                	addi	sp,sp,-16
 838:	e422                	sd	s0,8(sp)
 83a:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 83c:	00000797          	auipc	a5,0x0
 840:	7d078793          	addi	a5,a5,2000 # 100c <ids>
 844:	0007a303          	lw	t1,0(a5)
 848:	2305                	addiw	t1,t1,1
 84a:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 84e:	00001717          	auipc	a4,0x1
 852:	78270713          	addi	a4,a4,1922 # 1fd0 <uthreads+0xfa0>
 856:	4781                	li	a5,0
 858:	6605                	lui	a2,0x1
 85a:	02060613          	addi	a2,a2,32 # 1020 <base>
 85e:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 860:	4314                	lw	a3,0(a4)
 862:	c699                	beqz	a3,870 <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 864:	2785                	addiw	a5,a5,1
 866:	9732                	add	a4,a4,a2
 868:	ff079ce3          	bne	a5,a6,860 <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 86c:	557d                	li	a0,-1
 86e:	a889                	j	8c0 <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 870:	4711                	li	a4,4
 872:	04e78a63          	beq	a5,a4,8c6 <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 876:	00000897          	auipc	a7,0x0
 87a:	7ba88893          	addi	a7,a7,1978 # 1030 <uthreads>
 87e:	00779693          	slli	a3,a5,0x7
 882:	00f68633          	add	a2,a3,a5
 886:	0616                	slli	a2,a2,0x5
 888:	9646                	add	a2,a2,a7
 88a:	6805                	lui	a6,0x1
 88c:	00c80e33          	add	t3,a6,a2
 890:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 894:	00f68733          	add	a4,a3,a5
 898:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 89a:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x418>
 89e:	972a                	add	a4,a4,a0
 8a0:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 8a2:	0721                	addi	a4,a4,8
 8a4:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 8a8:	4709                	li	a4,2
 8aa:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 8ae:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74c73f23          	sd	a2,1886(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 8ba:	006e2e23          	sw	t1,28(t3)

    return 0;
 8be:	4501                	li	a0,0
}
 8c0:	6422                	ld	s0,8(sp)
 8c2:	0141                	addi	sp,sp,16
 8c4:	8082                	ret
        return -1;
 8c6:	557d                	li	a0,-1
 8c8:	bfe5                	j	8c0 <uthread_create+0x8a>

00000000000008ca <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 8ca:	1141                	addi	sp,sp,-16
 8cc:	e422                	sd	s0,8(sp)
 8ce:	0800                	addi	s0,sp,16
  switch (s)
 8d0:	4705                	li	a4,1
 8d2:	02e50763          	beq	a0,a4,900 <get_state+0x36>
 8d6:	87aa                	mv	a5,a0
 8d8:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 8da:	00000517          	auipc	a0,0x0
 8de:	2ce50513          	addi	a0,a0,718 # ba8 <digits+0x20>
  switch (s)
 8e2:	00e78763          	beq	a5,a4,8f0 <get_state+0x26>
  }

  return "ERROR";
 8e6:	00000517          	auipc	a0,0x0
 8ea:	2ba50513          	addi	a0,a0,698 # ba0 <digits+0x18>
  switch (s)
 8ee:	c781                	beqz	a5,8f6 <get_state+0x2c>
}
 8f0:	6422                	ld	s0,8(sp)
 8f2:	0141                	addi	sp,sp,16
 8f4:	8082                	ret
    return "FREE";
 8f6:	00000517          	auipc	a0,0x0
 8fa:	2ca50513          	addi	a0,a0,714 # bc0 <digits+0x38>
 8fe:	bfcd                	j	8f0 <get_state+0x26>
  switch (s)
 900:	00000517          	auipc	a0,0x0
 904:	2b850513          	addi	a0,a0,696 # bb8 <digits+0x30>
 908:	b7e5                	j	8f0 <get_state+0x26>

000000000000090a <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 90a:	1141                	addi	sp,sp,-16
 90c:	e422                	sd	s0,8(sp)
 90e:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 910:	00000717          	auipc	a4,0x0
 914:	70073703          	ld	a4,1792(a4) # 1010 <currentThread>
 918:	00000797          	auipc	a5,0x0
 91c:	71878793          	addi	a5,a5,1816 # 1030 <uthreads>
 920:	8f1d                	sub	a4,a4,a5
 922:	8715                	srai	a4,a4,0x5
 924:	00000797          	auipc	a5,0x0
 928:	24c7b783          	ld	a5,588(a5) # b70 <uthread_self+0x16>
 92c:	02f70733          	mul	a4,a4,a5
 930:	0705                	addi	a4,a4,1
 932:	43f75793          	srai	a5,a4,0x3f
 936:	03e7d693          	srli	a3,a5,0x3e
 93a:	00d707b3          	add	a5,a4,a3
 93e:	8b8d                	andi	a5,a5,3
 940:	8f95                	sub	a5,a5,a3
 942:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 944:	00000597          	auipc	a1,0x0
 948:	6ec58593          	addi	a1,a1,1772 # 1030 <uthreads>
 94c:	6605                	lui	a2,0x1
 94e:	4805                	li	a6,1
 950:	a819                	j	966 <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 952:	2785                	addiw	a5,a5,1
 954:	41f7d71b          	sraiw	a4,a5,0x1f
 958:	01e7571b          	srliw	a4,a4,0x1e
 95c:	9fb9                	addw	a5,a5,a4
 95e:	8b8d                	andi	a5,a5,3
 960:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 962:	36fd                	addiw	a3,a3,-1
 964:	ce9d                	beqz	a3,9a2 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 966:	00779713          	slli	a4,a5,0x7
 96a:	973e                	add	a4,a4,a5
 96c:	0716                	slli	a4,a4,0x5
 96e:	972e                	add	a4,a4,a1
 970:	9732                	add	a4,a4,a2
 972:	fa072703          	lw	a4,-96(a4)
 976:	377d                	addiw	a4,a4,-1
 978:	fce86de3          	bltu	a6,a4,952 <find_next+0x48>
 97c:	00779713          	slli	a4,a5,0x7
 980:	973e                	add	a4,a4,a5
 982:	0716                	slli	a4,a4,0x5
 984:	972e                	add	a4,a4,a1
 986:	9732                	add	a4,a4,a2
 988:	4f18                	lw	a4,24(a4)
 98a:	fca714e3          	bne	a4,a0,952 <find_next+0x48>
      next = &uthreads[j];
 98e:	00779513          	slli	a0,a5,0x7
 992:	953e                	add	a0,a0,a5
 994:	0516                	slli	a0,a0,0x5
 996:	00000797          	auipc	a5,0x0
 99a:	69a78793          	addi	a5,a5,1690 # 1030 <uthreads>
 99e:	953e                	add	a0,a0,a5
      break;
 9a0:	a011                	j	9a4 <find_next+0x9a>
  struct uthread* next = 0;
 9a2:	4501                	li	a0,0
  }

  return next;
}
 9a4:	6422                	ld	s0,8(sp)
 9a6:	0141                	addi	sp,sp,16
 9a8:	8082                	ret

00000000000009aa <schedule>:
void schedule(){
 9aa:	1101                	addi	sp,sp,-32
 9ac:	ec06                	sd	ra,24(sp)
 9ae:	e822                	sd	s0,16(sp)
 9b0:	e426                	sd	s1,8(sp)
 9b2:	1000                	addi	s0,sp,32
  cur = currentThread;
 9b4:	00000497          	auipc	s1,0x0
 9b8:	65c4b483          	ld	s1,1628(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 9bc:	4509                	li	a0,2
 9be:	00000097          	auipc	ra,0x0
 9c2:	f4c080e7          	jalr	-180(ra) # 90a <find_next>
  if(next == 0)
 9c6:	c915                	beqz	a0,9fa <schedule+0x50>
  currentThread = next;
 9c8:	00000797          	auipc	a5,0x0
 9cc:	64a7b423          	sd	a0,1608(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 9d0:	6785                	lui	a5,0x1
 9d2:	00f50733          	add	a4,a0,a5
 9d6:	4685                	li	a3,1
 9d8:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 9dc:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x420>
 9e0:	00f505b3          	add	a1,a0,a5
 9e4:	00f48533          	add	a0,s1,a5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	de4080e7          	jalr	-540(ra) # 7cc <uswtch>
}
 9f0:	60e2                	ld	ra,24(sp)
 9f2:	6442                	ld	s0,16(sp)
 9f4:	64a2                	ld	s1,8(sp)
 9f6:	6105                	addi	sp,sp,32
 9f8:	8082                	ret
    next = find_next(MEDIUM);
 9fa:	4505                	li	a0,1
 9fc:	00000097          	auipc	ra,0x0
 a00:	f0e080e7          	jalr	-242(ra) # 90a <find_next>
  if(next == 0)
 a04:	f171                	bnez	a0,9c8 <schedule+0x1e>
    next = find_next(LOW);
 a06:	00000097          	auipc	ra,0x0
 a0a:	f04080e7          	jalr	-252(ra) # 90a <find_next>
  if(next == 0)
 a0e:	fd4d                	bnez	a0,9c8 <schedule+0x1e>
    exit(-1);
 a10:	557d                	li	a0,-1
 a12:	00000097          	auipc	ra,0x0
 a16:	8a0080e7          	jalr	-1888(ra) # 2b2 <exit>

0000000000000a1a <uthread_yield>:
{
 a1a:	1141                	addi	sp,sp,-16
 a1c:	e406                	sd	ra,8(sp)
 a1e:	e022                	sd	s0,0(sp)
 a20:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 a22:	00000797          	auipc	a5,0x0
 a26:	5ee7b783          	ld	a5,1518(a5) # 1010 <currentThread>
 a2a:	6705                	lui	a4,0x1
 a2c:	97ba                	add	a5,a5,a4
 a2e:	4709                	li	a4,2
 a30:	fae7a023          	sw	a4,-96(a5)
  schedule();
 a34:	00000097          	auipc	ra,0x0
 a38:	f76080e7          	jalr	-138(ra) # 9aa <schedule>
}
 a3c:	60a2                	ld	ra,8(sp)
 a3e:	6402                	ld	s0,0(sp)
 a40:	0141                	addi	sp,sp,16
 a42:	8082                	ret

0000000000000a44 <uthread_exit>:

void uthread_exit()
{
 a44:	1141                	addi	sp,sp,-16
 a46:	e406                	sd	ra,8(sp)
 a48:	e022                	sd	s0,0(sp)
 a4a:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 a4c:	00000797          	auipc	a5,0x0
 a50:	5c47b783          	ld	a5,1476(a5) # 1010 <currentThread>
 a54:	6705                	lui	a4,0x1
 a56:	97ba                	add	a5,a5,a4
 a58:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 a5c:	00001797          	auipc	a5,0x1
 a60:	57478793          	addi	a5,a5,1396 # 1fd0 <uthreads+0xfa0>
 a64:	00005597          	auipc	a1,0x5
 a68:	5ec58593          	addi	a1,a1,1516 # 6050 <uthreads+0x5020>
  int remainingThreads = 0;
 a6c:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 a6e:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 a70:	6685                	lui	a3,0x1
 a72:	02068693          	addi	a3,a3,32 # 1020 <base>
 a76:	a021                	j	a7e <uthread_exit+0x3a>
 a78:	97b6                	add	a5,a5,a3
 a7a:	00b78763          	beq	a5,a1,a88 <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 a7e:	4398                	lw	a4,0(a5)
 a80:	fec71ce3          	bne	a4,a2,a78 <uthread_exit+0x34>
      remainingThreads++;
 a84:	2505                	addiw	a0,a0,1
 a86:	bfcd                	j	a78 <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 a88:	c909                	beqz	a0,a9a <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 a8a:	00000097          	auipc	ra,0x0
 a8e:	f20080e7          	jalr	-224(ra) # 9aa <schedule>
  }
}
 a92:	60a2                	ld	ra,8(sp)
 a94:	6402                	ld	s0,0(sp)
 a96:	0141                	addi	sp,sp,16
 a98:	8082                	ret
    exit(0);
 a9a:	00000097          	auipc	ra,0x0
 a9e:	818080e7          	jalr	-2024(ra) # 2b2 <exit>

0000000000000aa2 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 aa2:	1141                	addi	sp,sp,-16
 aa4:	e422                	sd	s0,8(sp)
 aa6:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 aa8:	00000797          	auipc	a5,0x0
 aac:	5687b783          	ld	a5,1384(a5) # 1010 <currentThread>
 ab0:	6705                	lui	a4,0x1
 ab2:	97ba                	add	a5,a5,a4
 ab4:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 ab6:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 ab8:	853a                	mv	a0,a4
 aba:	6422                	ld	s0,8(sp)
 abc:	0141                	addi	sp,sp,16
 abe:	8082                	ret

0000000000000ac0 <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 ac0:	1141                	addi	sp,sp,-16
 ac2:	e422                	sd	s0,8(sp)
 ac4:	0800                	addi	s0,sp,16
    return currentThread->priority;
 ac6:	00000797          	auipc	a5,0x0
 aca:	54a7b783          	ld	a5,1354(a5) # 1010 <currentThread>
 ace:	6705                	lui	a4,0x1
 ad0:	97ba                	add	a5,a5,a4
}
 ad2:	4f88                	lw	a0,24(a5)
 ad4:	6422                	ld	s0,8(sp)
 ad6:	0141                	addi	sp,sp,16
 ad8:	8082                	ret

0000000000000ada <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 ada:	7175                	addi	sp,sp,-144
 adc:	e506                	sd	ra,136(sp)
 ade:	e122                	sd	s0,128(sp)
 ae0:	fca6                	sd	s1,120(sp)
 ae2:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 ae4:	00000497          	auipc	s1,0x0
 ae8:	5244a483          	lw	s1,1316(s1) # 1008 <uthreadStarted>
 aec:	e4ad                	bnez	s1,b56 <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 aee:	4785                	li	a5,1
 af0:	00000717          	auipc	a4,0x0
 af4:	50f72c23          	sw	a5,1304(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 af8:	4509                	li	a0,2
 afa:	00000097          	auipc	ra,0x0
 afe:	e10080e7          	jalr	-496(ra) # 90a <find_next>
  if(next == 0)
 b02:	c915                	beqz	a0,b36 <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 b04:	00000797          	auipc	a5,0x0
 b08:	50a7b623          	sd	a0,1292(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 b0c:	6585                	lui	a1,0x1
 b0e:	00b507b3          	add	a5,a0,a1
 b12:	4705                	li	a4,1
 b14:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 b18:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x420>
 b1c:	95aa                	add	a1,a1,a0
 b1e:	f7040513          	addi	a0,s0,-144
 b22:	00000097          	auipc	ra,0x0
 b26:	caa080e7          	jalr	-854(ra) # 7cc <uswtch>

  return 0;
}
 b2a:	8526                	mv	a0,s1
 b2c:	60aa                	ld	ra,136(sp)
 b2e:	640a                	ld	s0,128(sp)
 b30:	74e6                	ld	s1,120(sp)
 b32:	6149                	addi	sp,sp,144
 b34:	8082                	ret
    next = find_next(MEDIUM);
 b36:	4505                	li	a0,1
 b38:	00000097          	auipc	ra,0x0
 b3c:	dd2080e7          	jalr	-558(ra) # 90a <find_next>
  if(next == 0)
 b40:	f171                	bnez	a0,b04 <uthread_start_all+0x2a>
    next = find_next(LOW);
 b42:	00000097          	auipc	ra,0x0
 b46:	dc8080e7          	jalr	-568(ra) # 90a <find_next>
  if(next == 0)
 b4a:	fd4d                	bnez	a0,b04 <uthread_start_all+0x2a>
    exit(-1);
 b4c:	557d                	li	a0,-1
 b4e:	fffff097          	auipc	ra,0xfffff
 b52:	764080e7          	jalr	1892(ra) # 2b2 <exit>
    return -1;
 b56:	54fd                	li	s1,-1
 b58:	bfc9                	j	b2a <uthread_start_all+0x50>

0000000000000b5a <uthread_self>:


struct uthread *uthread_self()
{
 b5a:	1141                	addi	sp,sp,-16
 b5c:	e422                	sd	s0,8(sp)
 b5e:	0800                	addi	s0,sp,16
    return currentThread;
 b60:	00000517          	auipc	a0,0x0
 b64:	4b053503          	ld	a0,1200(a0) # 1010 <currentThread>
 b68:	6422                	ld	s0,8(sp)
 b6a:	0141                	addi	sp,sp,16
 b6c:	8082                	ret
