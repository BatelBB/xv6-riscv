
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	bb6a0a13          	addi	s4,s4,-1098 # be0 <uthread_self+0x2c>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0ae080e7          	jalr	174(ra) # e6 <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	2e4080e7          	jalr	740(ra) # 32c <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2d0080e7          	jalr	720(ra) # 32c <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	b8058593          	addi	a1,a1,-1152 # be8 <uthread_self+0x34>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	2ba080e7          	jalr	698(ra) # 32c <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	290080e7          	jalr	656(ra) # 30c <exit>

0000000000000084 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
  88:	e022                	sd	s0,0(sp)
  8a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  8c:	00000097          	auipc	ra,0x0
  90:	f74080e7          	jalr	-140(ra) # 0 <main>
  exit(0);
  94:	4501                	li	a0,0
  96:	00000097          	auipc	ra,0x0
  9a:	276080e7          	jalr	630(ra) # 30c <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	addi	sp,sp,-16
  a0:	e422                	sd	s0,8(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0585                	addi	a1,a1,1
  a8:	0785                	addi	a5,a5,1
  aa:	fff5c703          	lbu	a4,-1(a1)
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0x8>
    ;
  return os;
}
  b4:	6422                	ld	s0,8(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cb91                	beqz	a5,d8 <strcmp+0x1e>
  c6:	0005c703          	lbu	a4,0(a1)
  ca:	00f71763          	bne	a4,a5,d8 <strcmp+0x1e>
    p++, q++;
  ce:	0505                	addi	a0,a0,1
  d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	fbe5                	bnez	a5,c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  d8:	0005c503          	lbu	a0,0(a1)
}
  dc:	40a7853b          	subw	a0,a5,a0
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret

00000000000000e6 <strlen>:

uint
strlen(const char *s)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ec:	00054783          	lbu	a5,0(a0)
  f0:	cf91                	beqz	a5,10c <strlen+0x26>
  f2:	0505                	addi	a0,a0,1
  f4:	87aa                	mv	a5,a0
  f6:	4685                	li	a3,1
  f8:	9e89                	subw	a3,a3,a0
  fa:	00f6853b          	addw	a0,a3,a5
  fe:	0785                	addi	a5,a5,1
 100:	fff7c703          	lbu	a4,-1(a5)
 104:	fb7d                	bnez	a4,fa <strlen+0x14>
    ;
  return n;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret
  for(n = 0; s[n]; n++)
 10c:	4501                	li	a0,0
 10e:	bfe5                	j	106 <strlen+0x20>

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	1141                	addi	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 116:	ca19                	beqz	a2,12c <memset+0x1c>
 118:	87aa                	mv	a5,a0
 11a:	1602                	slli	a2,a2,0x20
 11c:	9201                	srli	a2,a2,0x20
 11e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 122:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 126:	0785                	addi	a5,a5,1
 128:	fee79de3          	bne	a5,a4,122 <memset+0x12>
  }
  return dst;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strchr>:

char*
strchr(const char *s, char c)
{
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  for(; *s; s++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cb99                	beqz	a5,152 <strchr+0x20>
    if(*s == c)
 13e:	00f58763          	beq	a1,a5,14c <strchr+0x1a>
  for(; *s; s++)
 142:	0505                	addi	a0,a0,1
 144:	00054783          	lbu	a5,0(a0)
 148:	fbfd                	bnez	a5,13e <strchr+0xc>
      return (char*)s;
  return 0;
 14a:	4501                	li	a0,0
}
 14c:	6422                	ld	s0,8(sp)
 14e:	0141                	addi	sp,sp,16
 150:	8082                	ret
  return 0;
 152:	4501                	li	a0,0
 154:	bfe5                	j	14c <strchr+0x1a>

0000000000000156 <gets>:

char*
gets(char *buf, int max)
{
 156:	711d                	addi	sp,sp,-96
 158:	ec86                	sd	ra,88(sp)
 15a:	e8a2                	sd	s0,80(sp)
 15c:	e4a6                	sd	s1,72(sp)
 15e:	e0ca                	sd	s2,64(sp)
 160:	fc4e                	sd	s3,56(sp)
 162:	f852                	sd	s4,48(sp)
 164:	f456                	sd	s5,40(sp)
 166:	f05a                	sd	s6,32(sp)
 168:	ec5e                	sd	s7,24(sp)
 16a:	1080                	addi	s0,sp,96
 16c:	8baa                	mv	s7,a0
 16e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	892a                	mv	s2,a0
 172:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 174:	4aa9                	li	s5,10
 176:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 178:	89a6                	mv	s3,s1
 17a:	2485                	addiw	s1,s1,1
 17c:	0344d863          	bge	s1,s4,1ac <gets+0x56>
    cc = read(0, &c, 1);
 180:	4605                	li	a2,1
 182:	faf40593          	addi	a1,s0,-81
 186:	4501                	li	a0,0
 188:	00000097          	auipc	ra,0x0
 18c:	19c080e7          	jalr	412(ra) # 324 <read>
    if(cc < 1)
 190:	00a05e63          	blez	a0,1ac <gets+0x56>
    buf[i++] = c;
 194:	faf44783          	lbu	a5,-81(s0)
 198:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 19c:	01578763          	beq	a5,s5,1aa <gets+0x54>
 1a0:	0905                	addi	s2,s2,1
 1a2:	fd679be3          	bne	a5,s6,178 <gets+0x22>
  for(i=0; i+1 < max; ){
 1a6:	89a6                	mv	s3,s1
 1a8:	a011                	j	1ac <gets+0x56>
 1aa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1ac:	99de                	add	s3,s3,s7
 1ae:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b2:	855e                	mv	a0,s7
 1b4:	60e6                	ld	ra,88(sp)
 1b6:	6446                	ld	s0,80(sp)
 1b8:	64a6                	ld	s1,72(sp)
 1ba:	6906                	ld	s2,64(sp)
 1bc:	79e2                	ld	s3,56(sp)
 1be:	7a42                	ld	s4,48(sp)
 1c0:	7aa2                	ld	s5,40(sp)
 1c2:	7b02                	ld	s6,32(sp)
 1c4:	6be2                	ld	s7,24(sp)
 1c6:	6125                	addi	sp,sp,96
 1c8:	8082                	ret

00000000000001ca <stat>:

int
stat(const char *n, struct stat *st)
{
 1ca:	1101                	addi	sp,sp,-32
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e822                	sd	s0,16(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	e04a                	sd	s2,0(sp)
 1d4:	1000                	addi	s0,sp,32
 1d6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d8:	4581                	li	a1,0
 1da:	00000097          	auipc	ra,0x0
 1de:	172080e7          	jalr	370(ra) # 34c <open>
  if(fd < 0)
 1e2:	02054563          	bltz	a0,20c <stat+0x42>
 1e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e8:	85ca                	mv	a1,s2
 1ea:	00000097          	auipc	ra,0x0
 1ee:	17a080e7          	jalr	378(ra) # 364 <fstat>
 1f2:	892a                	mv	s2,a0
  close(fd);
 1f4:	8526                	mv	a0,s1
 1f6:	00000097          	auipc	ra,0x0
 1fa:	13e080e7          	jalr	318(ra) # 334 <close>
  return r;
}
 1fe:	854a                	mv	a0,s2
 200:	60e2                	ld	ra,24(sp)
 202:	6442                	ld	s0,16(sp)
 204:	64a2                	ld	s1,8(sp)
 206:	6902                	ld	s2,0(sp)
 208:	6105                	addi	sp,sp,32
 20a:	8082                	ret
    return -1;
 20c:	597d                	li	s2,-1
 20e:	bfc5                	j	1fe <stat+0x34>

0000000000000210 <atoi>:

int
atoi(const char *s)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 216:	00054603          	lbu	a2,0(a0)
 21a:	fd06079b          	addiw	a5,a2,-48
 21e:	0ff7f793          	andi	a5,a5,255
 222:	4725                	li	a4,9
 224:	02f76963          	bltu	a4,a5,256 <atoi+0x46>
 228:	86aa                	mv	a3,a0
  n = 0;
 22a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 22c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 22e:	0685                	addi	a3,a3,1
 230:	0025179b          	slliw	a5,a0,0x2
 234:	9fa9                	addw	a5,a5,a0
 236:	0017979b          	slliw	a5,a5,0x1
 23a:	9fb1                	addw	a5,a5,a2
 23c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 240:	0006c603          	lbu	a2,0(a3)
 244:	fd06071b          	addiw	a4,a2,-48
 248:	0ff77713          	andi	a4,a4,255
 24c:	fee5f1e3          	bgeu	a1,a4,22e <atoi+0x1e>
  return n;
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret
  n = 0;
 256:	4501                	li	a0,0
 258:	bfe5                	j	250 <atoi+0x40>

000000000000025a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 260:	02b57463          	bgeu	a0,a1,288 <memmove+0x2e>
    while(n-- > 0)
 264:	00c05f63          	blez	a2,282 <memmove+0x28>
 268:	1602                	slli	a2,a2,0x20
 26a:	9201                	srli	a2,a2,0x20
 26c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 270:	872a                	mv	a4,a0
      *dst++ = *src++;
 272:	0585                	addi	a1,a1,1
 274:	0705                	addi	a4,a4,1
 276:	fff5c683          	lbu	a3,-1(a1)
 27a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 27e:	fee79ae3          	bne	a5,a4,272 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
    dst += n;
 288:	00c50733          	add	a4,a0,a2
    src += n;
 28c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 28e:	fec05ae3          	blez	a2,282 <memmove+0x28>
 292:	fff6079b          	addiw	a5,a2,-1
 296:	1782                	slli	a5,a5,0x20
 298:	9381                	srli	a5,a5,0x20
 29a:	fff7c793          	not	a5,a5
 29e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a0:	15fd                	addi	a1,a1,-1
 2a2:	177d                	addi	a4,a4,-1
 2a4:	0005c683          	lbu	a3,0(a1)
 2a8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ac:	fee79ae3          	bne	a5,a4,2a0 <memmove+0x46>
 2b0:	bfc9                	j	282 <memmove+0x28>

00000000000002b2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2b8:	ca05                	beqz	a2,2e8 <memcmp+0x36>
 2ba:	fff6069b          	addiw	a3,a2,-1
 2be:	1682                	slli	a3,a3,0x20
 2c0:	9281                	srli	a3,a3,0x20
 2c2:	0685                	addi	a3,a3,1
 2c4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	0005c703          	lbu	a4,0(a1)
 2ce:	00e79863          	bne	a5,a4,2de <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2d2:	0505                	addi	a0,a0,1
    p2++;
 2d4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2d6:	fed518e3          	bne	a0,a3,2c6 <memcmp+0x14>
  }
  return 0;
 2da:	4501                	li	a0,0
 2dc:	a019                	j	2e2 <memcmp+0x30>
      return *p1 - *p2;
 2de:	40e7853b          	subw	a0,a5,a4
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  return 0;
 2e8:	4501                	li	a0,0
 2ea:	bfe5                	j	2e2 <memcmp+0x30>

00000000000002ec <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e406                	sd	ra,8(sp)
 2f0:	e022                	sd	s0,0(sp)
 2f2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2f4:	00000097          	auipc	ra,0x0
 2f8:	f66080e7          	jalr	-154(ra) # 25a <memmove>
}
 2fc:	60a2                	ld	ra,8(sp)
 2fe:	6402                	ld	s0,0(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret

0000000000000304 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 304:	4885                	li	a7,1
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <exit>:
.global exit
exit:
 li a7, SYS_exit
 30c:	4889                	li	a7,2
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <wait>:
.global wait
wait:
 li a7, SYS_wait
 314:	488d                	li	a7,3
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 31c:	4891                	li	a7,4
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <read>:
.global read
read:
 li a7, SYS_read
 324:	4895                	li	a7,5
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <write>:
.global write
write:
 li a7, SYS_write
 32c:	48c1                	li	a7,16
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <close>:
.global close
close:
 li a7, SYS_close
 334:	48d5                	li	a7,21
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <kill>:
.global kill
kill:
 li a7, SYS_kill
 33c:	4899                	li	a7,6
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <exec>:
.global exec
exec:
 li a7, SYS_exec
 344:	489d                	li	a7,7
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <open>:
.global open
open:
 li a7, SYS_open
 34c:	48bd                	li	a7,15
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 354:	48c5                	li	a7,17
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 35c:	48c9                	li	a7,18
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 364:	48a1                	li	a7,8
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <link>:
.global link
link:
 li a7, SYS_link
 36c:	48cd                	li	a7,19
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 374:	48d1                	li	a7,20
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 37c:	48a5                	li	a7,9
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <dup>:
.global dup
dup:
 li a7, SYS_dup
 384:	48a9                	li	a7,10
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 38c:	48ad                	li	a7,11
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 394:	48b1                	li	a7,12
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 39c:	48b5                	li	a7,13
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a4:	48b9                	li	a7,14
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3ac:	1101                	addi	sp,sp,-32
 3ae:	ec06                	sd	ra,24(sp)
 3b0:	e822                	sd	s0,16(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b8:	4605                	li	a2,1
 3ba:	fef40593          	addi	a1,s0,-17
 3be:	00000097          	auipc	ra,0x0
 3c2:	f6e080e7          	jalr	-146(ra) # 32c <write>
}
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	6105                	addi	sp,sp,32
 3cc:	8082                	ret

00000000000003ce <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ce:	7139                	addi	sp,sp,-64
 3d0:	fc06                	sd	ra,56(sp)
 3d2:	f822                	sd	s0,48(sp)
 3d4:	f426                	sd	s1,40(sp)
 3d6:	f04a                	sd	s2,32(sp)
 3d8:	ec4e                	sd	s3,24(sp)
 3da:	0080                	addi	s0,sp,64
 3dc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3de:	c299                	beqz	a3,3e4 <printint+0x16>
 3e0:	0805c863          	bltz	a1,470 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e4:	2581                	sext.w	a1,a1
  neg = 0;
 3e6:	4881                	li	a7,0
 3e8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3ec:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3ee:	2601                	sext.w	a2,a2
 3f0:	00001517          	auipc	a0,0x1
 3f4:	80850513          	addi	a0,a0,-2040 # bf8 <digits>
 3f8:	883a                	mv	a6,a4
 3fa:	2705                	addiw	a4,a4,1
 3fc:	02c5f7bb          	remuw	a5,a1,a2
 400:	1782                	slli	a5,a5,0x20
 402:	9381                	srli	a5,a5,0x20
 404:	97aa                	add	a5,a5,a0
 406:	0007c783          	lbu	a5,0(a5)
 40a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 40e:	0005879b          	sext.w	a5,a1
 412:	02c5d5bb          	divuw	a1,a1,a2
 416:	0685                	addi	a3,a3,1
 418:	fec7f0e3          	bgeu	a5,a2,3f8 <printint+0x2a>
  if(neg)
 41c:	00088b63          	beqz	a7,432 <printint+0x64>
    buf[i++] = '-';
 420:	fd040793          	addi	a5,s0,-48
 424:	973e                	add	a4,a4,a5
 426:	02d00793          	li	a5,45
 42a:	fef70823          	sb	a5,-16(a4)
 42e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 432:	02e05863          	blez	a4,462 <printint+0x94>
 436:	fc040793          	addi	a5,s0,-64
 43a:	00e78933          	add	s2,a5,a4
 43e:	fff78993          	addi	s3,a5,-1
 442:	99ba                	add	s3,s3,a4
 444:	377d                	addiw	a4,a4,-1
 446:	1702                	slli	a4,a4,0x20
 448:	9301                	srli	a4,a4,0x20
 44a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 44e:	fff94583          	lbu	a1,-1(s2)
 452:	8526                	mv	a0,s1
 454:	00000097          	auipc	ra,0x0
 458:	f58080e7          	jalr	-168(ra) # 3ac <putc>
  while(--i >= 0)
 45c:	197d                	addi	s2,s2,-1
 45e:	ff3918e3          	bne	s2,s3,44e <printint+0x80>
}
 462:	70e2                	ld	ra,56(sp)
 464:	7442                	ld	s0,48(sp)
 466:	74a2                	ld	s1,40(sp)
 468:	7902                	ld	s2,32(sp)
 46a:	69e2                	ld	s3,24(sp)
 46c:	6121                	addi	sp,sp,64
 46e:	8082                	ret
    x = -xx;
 470:	40b005bb          	negw	a1,a1
    neg = 1;
 474:	4885                	li	a7,1
    x = -xx;
 476:	bf8d                	j	3e8 <printint+0x1a>

0000000000000478 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 478:	7119                	addi	sp,sp,-128
 47a:	fc86                	sd	ra,120(sp)
 47c:	f8a2                	sd	s0,112(sp)
 47e:	f4a6                	sd	s1,104(sp)
 480:	f0ca                	sd	s2,96(sp)
 482:	ecce                	sd	s3,88(sp)
 484:	e8d2                	sd	s4,80(sp)
 486:	e4d6                	sd	s5,72(sp)
 488:	e0da                	sd	s6,64(sp)
 48a:	fc5e                	sd	s7,56(sp)
 48c:	f862                	sd	s8,48(sp)
 48e:	f466                	sd	s9,40(sp)
 490:	f06a                	sd	s10,32(sp)
 492:	ec6e                	sd	s11,24(sp)
 494:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 496:	0005c903          	lbu	s2,0(a1)
 49a:	18090f63          	beqz	s2,638 <vprintf+0x1c0>
 49e:	8aaa                	mv	s5,a0
 4a0:	8b32                	mv	s6,a2
 4a2:	00158493          	addi	s1,a1,1
  state = 0;
 4a6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4a8:	02500a13          	li	s4,37
      if(c == 'd'){
 4ac:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4b0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4b4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4b8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4bc:	00000b97          	auipc	s7,0x0
 4c0:	73cb8b93          	addi	s7,s7,1852 # bf8 <digits>
 4c4:	a839                	j	4e2 <vprintf+0x6a>
        putc(fd, c);
 4c6:	85ca                	mv	a1,s2
 4c8:	8556                	mv	a0,s5
 4ca:	00000097          	auipc	ra,0x0
 4ce:	ee2080e7          	jalr	-286(ra) # 3ac <putc>
 4d2:	a019                	j	4d8 <vprintf+0x60>
    } else if(state == '%'){
 4d4:	01498f63          	beq	s3,s4,4f2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4d8:	0485                	addi	s1,s1,1
 4da:	fff4c903          	lbu	s2,-1(s1)
 4de:	14090d63          	beqz	s2,638 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4e2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4e6:	fe0997e3          	bnez	s3,4d4 <vprintf+0x5c>
      if(c == '%'){
 4ea:	fd479ee3          	bne	a5,s4,4c6 <vprintf+0x4e>
        state = '%';
 4ee:	89be                	mv	s3,a5
 4f0:	b7e5                	j	4d8 <vprintf+0x60>
      if(c == 'd'){
 4f2:	05878063          	beq	a5,s8,532 <vprintf+0xba>
      } else if(c == 'l') {
 4f6:	05978c63          	beq	a5,s9,54e <vprintf+0xd6>
      } else if(c == 'x') {
 4fa:	07a78863          	beq	a5,s10,56a <vprintf+0xf2>
      } else if(c == 'p') {
 4fe:	09b78463          	beq	a5,s11,586 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 502:	07300713          	li	a4,115
 506:	0ce78663          	beq	a5,a4,5d2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50a:	06300713          	li	a4,99
 50e:	0ee78e63          	beq	a5,a4,60a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 512:	11478863          	beq	a5,s4,622 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 516:	85d2                	mv	a1,s4
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	e92080e7          	jalr	-366(ra) # 3ac <putc>
        putc(fd, c);
 522:	85ca                	mv	a1,s2
 524:	8556                	mv	a0,s5
 526:	00000097          	auipc	ra,0x0
 52a:	e86080e7          	jalr	-378(ra) # 3ac <putc>
      }
      state = 0;
 52e:	4981                	li	s3,0
 530:	b765                	j	4d8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 532:	008b0913          	addi	s2,s6,8
 536:	4685                	li	a3,1
 538:	4629                	li	a2,10
 53a:	000b2583          	lw	a1,0(s6)
 53e:	8556                	mv	a0,s5
 540:	00000097          	auipc	ra,0x0
 544:	e8e080e7          	jalr	-370(ra) # 3ce <printint>
 548:	8b4a                	mv	s6,s2
      state = 0;
 54a:	4981                	li	s3,0
 54c:	b771                	j	4d8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 54e:	008b0913          	addi	s2,s6,8
 552:	4681                	li	a3,0
 554:	4629                	li	a2,10
 556:	000b2583          	lw	a1,0(s6)
 55a:	8556                	mv	a0,s5
 55c:	00000097          	auipc	ra,0x0
 560:	e72080e7          	jalr	-398(ra) # 3ce <printint>
 564:	8b4a                	mv	s6,s2
      state = 0;
 566:	4981                	li	s3,0
 568:	bf85                	j	4d8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 56a:	008b0913          	addi	s2,s6,8
 56e:	4681                	li	a3,0
 570:	4641                	li	a2,16
 572:	000b2583          	lw	a1,0(s6)
 576:	8556                	mv	a0,s5
 578:	00000097          	auipc	ra,0x0
 57c:	e56080e7          	jalr	-426(ra) # 3ce <printint>
 580:	8b4a                	mv	s6,s2
      state = 0;
 582:	4981                	li	s3,0
 584:	bf91                	j	4d8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 586:	008b0793          	addi	a5,s6,8
 58a:	f8f43423          	sd	a5,-120(s0)
 58e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 592:	03000593          	li	a1,48
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	e14080e7          	jalr	-492(ra) # 3ac <putc>
  putc(fd, 'x');
 5a0:	85ea                	mv	a1,s10
 5a2:	8556                	mv	a0,s5
 5a4:	00000097          	auipc	ra,0x0
 5a8:	e08080e7          	jalr	-504(ra) # 3ac <putc>
 5ac:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ae:	03c9d793          	srli	a5,s3,0x3c
 5b2:	97de                	add	a5,a5,s7
 5b4:	0007c583          	lbu	a1,0(a5)
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	df2080e7          	jalr	-526(ra) # 3ac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5c2:	0992                	slli	s3,s3,0x4
 5c4:	397d                	addiw	s2,s2,-1
 5c6:	fe0914e3          	bnez	s2,5ae <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5ca:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5ce:	4981                	li	s3,0
 5d0:	b721                	j	4d8 <vprintf+0x60>
        s = va_arg(ap, char*);
 5d2:	008b0993          	addi	s3,s6,8
 5d6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5da:	02090163          	beqz	s2,5fc <vprintf+0x184>
        while(*s != 0){
 5de:	00094583          	lbu	a1,0(s2)
 5e2:	c9a1                	beqz	a1,632 <vprintf+0x1ba>
          putc(fd, *s);
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	dc6080e7          	jalr	-570(ra) # 3ac <putc>
          s++;
 5ee:	0905                	addi	s2,s2,1
        while(*s != 0){
 5f0:	00094583          	lbu	a1,0(s2)
 5f4:	f9e5                	bnez	a1,5e4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 5f6:	8b4e                	mv	s6,s3
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bdf9                	j	4d8 <vprintf+0x60>
          s = "(null)";
 5fc:	00000917          	auipc	s2,0x0
 600:	5f490913          	addi	s2,s2,1524 # bf0 <uthread_self+0x3c>
        while(*s != 0){
 604:	02800593          	li	a1,40
 608:	bff1                	j	5e4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 60a:	008b0913          	addi	s2,s6,8
 60e:	000b4583          	lbu	a1,0(s6)
 612:	8556                	mv	a0,s5
 614:	00000097          	auipc	ra,0x0
 618:	d98080e7          	jalr	-616(ra) # 3ac <putc>
 61c:	8b4a                	mv	s6,s2
      state = 0;
 61e:	4981                	li	s3,0
 620:	bd65                	j	4d8 <vprintf+0x60>
        putc(fd, c);
 622:	85d2                	mv	a1,s4
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	d86080e7          	jalr	-634(ra) # 3ac <putc>
      state = 0;
 62e:	4981                	li	s3,0
 630:	b565                	j	4d8 <vprintf+0x60>
        s = va_arg(ap, char*);
 632:	8b4e                	mv	s6,s3
      state = 0;
 634:	4981                	li	s3,0
 636:	b54d                	j	4d8 <vprintf+0x60>
    }
  }
}
 638:	70e6                	ld	ra,120(sp)
 63a:	7446                	ld	s0,112(sp)
 63c:	74a6                	ld	s1,104(sp)
 63e:	7906                	ld	s2,96(sp)
 640:	69e6                	ld	s3,88(sp)
 642:	6a46                	ld	s4,80(sp)
 644:	6aa6                	ld	s5,72(sp)
 646:	6b06                	ld	s6,64(sp)
 648:	7be2                	ld	s7,56(sp)
 64a:	7c42                	ld	s8,48(sp)
 64c:	7ca2                	ld	s9,40(sp)
 64e:	7d02                	ld	s10,32(sp)
 650:	6de2                	ld	s11,24(sp)
 652:	6109                	addi	sp,sp,128
 654:	8082                	ret

0000000000000656 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 656:	715d                	addi	sp,sp,-80
 658:	ec06                	sd	ra,24(sp)
 65a:	e822                	sd	s0,16(sp)
 65c:	1000                	addi	s0,sp,32
 65e:	e010                	sd	a2,0(s0)
 660:	e414                	sd	a3,8(s0)
 662:	e818                	sd	a4,16(s0)
 664:	ec1c                	sd	a5,24(s0)
 666:	03043023          	sd	a6,32(s0)
 66a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 66e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 672:	8622                	mv	a2,s0
 674:	00000097          	auipc	ra,0x0
 678:	e04080e7          	jalr	-508(ra) # 478 <vprintf>
}
 67c:	60e2                	ld	ra,24(sp)
 67e:	6442                	ld	s0,16(sp)
 680:	6161                	addi	sp,sp,80
 682:	8082                	ret

0000000000000684 <printf>:

void
printf(const char *fmt, ...)
{
 684:	711d                	addi	sp,sp,-96
 686:	ec06                	sd	ra,24(sp)
 688:	e822                	sd	s0,16(sp)
 68a:	1000                	addi	s0,sp,32
 68c:	e40c                	sd	a1,8(s0)
 68e:	e810                	sd	a2,16(s0)
 690:	ec14                	sd	a3,24(s0)
 692:	f018                	sd	a4,32(s0)
 694:	f41c                	sd	a5,40(s0)
 696:	03043823          	sd	a6,48(s0)
 69a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 69e:	00840613          	addi	a2,s0,8
 6a2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6a6:	85aa                	mv	a1,a0
 6a8:	4505                	li	a0,1
 6aa:	00000097          	auipc	ra,0x0
 6ae:	dce080e7          	jalr	-562(ra) # 478 <vprintf>
}
 6b2:	60e2                	ld	ra,24(sp)
 6b4:	6442                	ld	s0,16(sp)
 6b6:	6125                	addi	sp,sp,96
 6b8:	8082                	ret

00000000000006ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ba:	1141                	addi	sp,sp,-16
 6bc:	e422                	sd	s0,8(sp)
 6be:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	00001797          	auipc	a5,0x1
 6c8:	93c7b783          	ld	a5,-1732(a5) # 1000 <freep>
 6cc:	a805                	j	6fc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ce:	4618                	lw	a4,8(a2)
 6d0:	9db9                	addw	a1,a1,a4
 6d2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	6398                	ld	a4,0(a5)
 6d8:	6318                	ld	a4,0(a4)
 6da:	fee53823          	sd	a4,-16(a0)
 6de:	a091                	j	722 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e0:	ff852703          	lw	a4,-8(a0)
 6e4:	9e39                	addw	a2,a2,a4
 6e6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6e8:	ff053703          	ld	a4,-16(a0)
 6ec:	e398                	sd	a4,0(a5)
 6ee:	a099                	j	734 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	6398                	ld	a4,0(a5)
 6f2:	00e7e463          	bltu	a5,a4,6fa <free+0x40>
 6f6:	00e6ea63          	bltu	a3,a4,70a <free+0x50>
{
 6fa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fc:	fed7fae3          	bgeu	a5,a3,6f0 <free+0x36>
 700:	6398                	ld	a4,0(a5)
 702:	00e6e463          	bltu	a3,a4,70a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 706:	fee7eae3          	bltu	a5,a4,6fa <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 70a:	ff852583          	lw	a1,-8(a0)
 70e:	6390                	ld	a2,0(a5)
 710:	02059713          	slli	a4,a1,0x20
 714:	9301                	srli	a4,a4,0x20
 716:	0712                	slli	a4,a4,0x4
 718:	9736                	add	a4,a4,a3
 71a:	fae60ae3          	beq	a2,a4,6ce <free+0x14>
    bp->s.ptr = p->s.ptr;
 71e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 722:	4790                	lw	a2,8(a5)
 724:	02061713          	slli	a4,a2,0x20
 728:	9301                	srli	a4,a4,0x20
 72a:	0712                	slli	a4,a4,0x4
 72c:	973e                	add	a4,a4,a5
 72e:	fae689e3          	beq	a3,a4,6e0 <free+0x26>
  } else
    p->s.ptr = bp;
 732:	e394                	sd	a3,0(a5)
  freep = p;
 734:	00001717          	auipc	a4,0x1
 738:	8cf73623          	sd	a5,-1844(a4) # 1000 <freep>
}
 73c:	6422                	ld	s0,8(sp)
 73e:	0141                	addi	sp,sp,16
 740:	8082                	ret

0000000000000742 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 742:	7139                	addi	sp,sp,-64
 744:	fc06                	sd	ra,56(sp)
 746:	f822                	sd	s0,48(sp)
 748:	f426                	sd	s1,40(sp)
 74a:	f04a                	sd	s2,32(sp)
 74c:	ec4e                	sd	s3,24(sp)
 74e:	e852                	sd	s4,16(sp)
 750:	e456                	sd	s5,8(sp)
 752:	e05a                	sd	s6,0(sp)
 754:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 756:	02051493          	slli	s1,a0,0x20
 75a:	9081                	srli	s1,s1,0x20
 75c:	04bd                	addi	s1,s1,15
 75e:	8091                	srli	s1,s1,0x4
 760:	0014899b          	addiw	s3,s1,1
 764:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 766:	00001517          	auipc	a0,0x1
 76a:	89a53503          	ld	a0,-1894(a0) # 1000 <freep>
 76e:	c515                	beqz	a0,79a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 772:	4798                	lw	a4,8(a5)
 774:	02977f63          	bgeu	a4,s1,7b2 <malloc+0x70>
 778:	8a4e                	mv	s4,s3
 77a:	0009871b          	sext.w	a4,s3
 77e:	6685                	lui	a3,0x1
 780:	00d77363          	bgeu	a4,a3,786 <malloc+0x44>
 784:	6a05                	lui	s4,0x1
 786:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 78a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 78e:	00001917          	auipc	s2,0x1
 792:	87290913          	addi	s2,s2,-1934 # 1000 <freep>
  if(p == (char*)-1)
 796:	5afd                	li	s5,-1
 798:	a88d                	j	80a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 79a:	00001797          	auipc	a5,0x1
 79e:	88678793          	addi	a5,a5,-1914 # 1020 <base>
 7a2:	00001717          	auipc	a4,0x1
 7a6:	84f73f23          	sd	a5,-1954(a4) # 1000 <freep>
 7aa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7b0:	b7e1                	j	778 <malloc+0x36>
      if(p->s.size == nunits)
 7b2:	02e48b63          	beq	s1,a4,7e8 <malloc+0xa6>
        p->s.size -= nunits;
 7b6:	4137073b          	subw	a4,a4,s3
 7ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7bc:	1702                	slli	a4,a4,0x20
 7be:	9301                	srli	a4,a4,0x20
 7c0:	0712                	slli	a4,a4,0x4
 7c2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7c4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7c8:	00001717          	auipc	a4,0x1
 7cc:	82a73c23          	sd	a0,-1992(a4) # 1000 <freep>
      return (void*)(p + 1);
 7d0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7d4:	70e2                	ld	ra,56(sp)
 7d6:	7442                	ld	s0,48(sp)
 7d8:	74a2                	ld	s1,40(sp)
 7da:	7902                	ld	s2,32(sp)
 7dc:	69e2                	ld	s3,24(sp)
 7de:	6a42                	ld	s4,16(sp)
 7e0:	6aa2                	ld	s5,8(sp)
 7e2:	6b02                	ld	s6,0(sp)
 7e4:	6121                	addi	sp,sp,64
 7e6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7e8:	6398                	ld	a4,0(a5)
 7ea:	e118                	sd	a4,0(a0)
 7ec:	bff1                	j	7c8 <malloc+0x86>
  hp->s.size = nu;
 7ee:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7f2:	0541                	addi	a0,a0,16
 7f4:	00000097          	auipc	ra,0x0
 7f8:	ec6080e7          	jalr	-314(ra) # 6ba <free>
  return freep;
 7fc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 800:	d971                	beqz	a0,7d4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 802:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 804:	4798                	lw	a4,8(a5)
 806:	fa9776e3          	bgeu	a4,s1,7b2 <malloc+0x70>
    if(p == freep)
 80a:	00093703          	ld	a4,0(s2)
 80e:	853e                	mv	a0,a5
 810:	fef719e3          	bne	a4,a5,802 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 814:	8552                	mv	a0,s4
 816:	00000097          	auipc	ra,0x0
 81a:	b7e080e7          	jalr	-1154(ra) # 394 <sbrk>
  if(p == (char*)-1)
 81e:	fd5518e3          	bne	a0,s5,7ee <malloc+0xac>
        return 0;
 822:	4501                	li	a0,0
 824:	bf45                	j	7d4 <malloc+0x92>

0000000000000826 <uswtch>:
 826:	00153023          	sd	ra,0(a0)
 82a:	00253423          	sd	sp,8(a0)
 82e:	e900                	sd	s0,16(a0)
 830:	ed04                	sd	s1,24(a0)
 832:	03253023          	sd	s2,32(a0)
 836:	03353423          	sd	s3,40(a0)
 83a:	03453823          	sd	s4,48(a0)
 83e:	03553c23          	sd	s5,56(a0)
 842:	05653023          	sd	s6,64(a0)
 846:	05753423          	sd	s7,72(a0)
 84a:	05853823          	sd	s8,80(a0)
 84e:	05953c23          	sd	s9,88(a0)
 852:	07a53023          	sd	s10,96(a0)
 856:	07b53423          	sd	s11,104(a0)
 85a:	0005b083          	ld	ra,0(a1)
 85e:	0085b103          	ld	sp,8(a1)
 862:	6980                	ld	s0,16(a1)
 864:	6d84                	ld	s1,24(a1)
 866:	0205b903          	ld	s2,32(a1)
 86a:	0285b983          	ld	s3,40(a1)
 86e:	0305ba03          	ld	s4,48(a1)
 872:	0385ba83          	ld	s5,56(a1)
 876:	0405bb03          	ld	s6,64(a1)
 87a:	0485bb83          	ld	s7,72(a1)
 87e:	0505bc03          	ld	s8,80(a1)
 882:	0585bc83          	ld	s9,88(a1)
 886:	0605bd03          	ld	s10,96(a1)
 88a:	0685bd83          	ld	s11,104(a1)
 88e:	8082                	ret

0000000000000890 <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 890:	1141                	addi	sp,sp,-16
 892:	e422                	sd	s0,8(sp)
 894:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 896:	00000797          	auipc	a5,0x0
 89a:	77678793          	addi	a5,a5,1910 # 100c <ids>
 89e:	0007a303          	lw	t1,0(a5)
 8a2:	2305                	addiw	t1,t1,1
 8a4:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 8a8:	00001717          	auipc	a4,0x1
 8ac:	72870713          	addi	a4,a4,1832 # 1fd0 <uthreads+0xfa0>
 8b0:	4781                	li	a5,0
 8b2:	6605                	lui	a2,0x1
 8b4:	02060613          	addi	a2,a2,32 # 1020 <base>
 8b8:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 8ba:	4314                	lw	a3,0(a4)
 8bc:	c699                	beqz	a3,8ca <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 8be:	2785                	addiw	a5,a5,1
 8c0:	9732                	add	a4,a4,a2
 8c2:	ff079ce3          	bne	a5,a6,8ba <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 8c6:	557d                	li	a0,-1
 8c8:	a889                	j	91a <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 8ca:	4711                	li	a4,4
 8cc:	04e78a63          	beq	a5,a4,920 <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 8d0:	00000897          	auipc	a7,0x0
 8d4:	76088893          	addi	a7,a7,1888 # 1030 <uthreads>
 8d8:	00779693          	slli	a3,a5,0x7
 8dc:	00f68633          	add	a2,a3,a5
 8e0:	0616                	slli	a2,a2,0x5
 8e2:	9646                	add	a2,a2,a7
 8e4:	6805                	lui	a6,0x1
 8e6:	00c80e33          	add	t3,a6,a2
 8ea:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 8ee:	00f68733          	add	a4,a3,a5
 8f2:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 8f4:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x3a8>
 8f8:	972a                	add	a4,a4,a0
 8fa:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 8fc:	0721                	addi	a4,a4,8
 8fe:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 902:	4709                	li	a4,2
 904:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 908:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 90c:	00000717          	auipc	a4,0x0
 910:	70c73223          	sd	a2,1796(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 914:	006e2e23          	sw	t1,28(t3)

    return 0;
 918:	4501                	li	a0,0
}
 91a:	6422                	ld	s0,8(sp)
 91c:	0141                	addi	sp,sp,16
 91e:	8082                	ret
        return -1;
 920:	557d                	li	a0,-1
 922:	bfe5                	j	91a <uthread_create+0x8a>

0000000000000924 <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 924:	1141                	addi	sp,sp,-16
 926:	e422                	sd	s0,8(sp)
 928:	0800                	addi	s0,sp,16
  switch (s)
 92a:	4705                	li	a4,1
 92c:	02e50763          	beq	a0,a4,95a <get_state+0x36>
 930:	87aa                	mv	a5,a0
 932:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 934:	00000517          	auipc	a0,0x0
 938:	2e450513          	addi	a0,a0,740 # c18 <digits+0x20>
  switch (s)
 93c:	00e78763          	beq	a5,a4,94a <get_state+0x26>
  }

  return "ERROR";
 940:	00000517          	auipc	a0,0x0
 944:	2d050513          	addi	a0,a0,720 # c10 <digits+0x18>
  switch (s)
 948:	c781                	beqz	a5,950 <get_state+0x2c>
}
 94a:	6422                	ld	s0,8(sp)
 94c:	0141                	addi	sp,sp,16
 94e:	8082                	ret
    return "FREE";
 950:	00000517          	auipc	a0,0x0
 954:	2e050513          	addi	a0,a0,736 # c30 <digits+0x38>
 958:	bfcd                	j	94a <get_state+0x26>
  switch (s)
 95a:	00000517          	auipc	a0,0x0
 95e:	2ce50513          	addi	a0,a0,718 # c28 <digits+0x30>
 962:	b7e5                	j	94a <get_state+0x26>

0000000000000964 <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 964:	1141                	addi	sp,sp,-16
 966:	e422                	sd	s0,8(sp)
 968:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 96a:	00000717          	auipc	a4,0x0
 96e:	6a673703          	ld	a4,1702(a4) # 1010 <currentThread>
 972:	00000797          	auipc	a5,0x0
 976:	6be78793          	addi	a5,a5,1726 # 1030 <uthreads>
 97a:	8f1d                	sub	a4,a4,a5
 97c:	8715                	srai	a4,a4,0x5
 97e:	00000797          	auipc	a5,0x0
 982:	2527b783          	ld	a5,594(a5) # bd0 <uthread_self+0x1c>
 986:	02f70733          	mul	a4,a4,a5
 98a:	0705                	addi	a4,a4,1
 98c:	43f75793          	srai	a5,a4,0x3f
 990:	03e7d693          	srli	a3,a5,0x3e
 994:	00d707b3          	add	a5,a4,a3
 998:	8b8d                	andi	a5,a5,3
 99a:	8f95                	sub	a5,a5,a3
 99c:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 99e:	00000597          	auipc	a1,0x0
 9a2:	69258593          	addi	a1,a1,1682 # 1030 <uthreads>
 9a6:	6605                	lui	a2,0x1
 9a8:	4805                	li	a6,1
 9aa:	a819                	j	9c0 <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 9ac:	2785                	addiw	a5,a5,1
 9ae:	41f7d71b          	sraiw	a4,a5,0x1f
 9b2:	01e7571b          	srliw	a4,a4,0x1e
 9b6:	9fb9                	addw	a5,a5,a4
 9b8:	8b8d                	andi	a5,a5,3
 9ba:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 9bc:	36fd                	addiw	a3,a3,-1
 9be:	ce9d                	beqz	a3,9fc <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 9c0:	00779713          	slli	a4,a5,0x7
 9c4:	973e                	add	a4,a4,a5
 9c6:	0716                	slli	a4,a4,0x5
 9c8:	972e                	add	a4,a4,a1
 9ca:	9732                	add	a4,a4,a2
 9cc:	fa072703          	lw	a4,-96(a4)
 9d0:	377d                	addiw	a4,a4,-1
 9d2:	fce86de3          	bltu	a6,a4,9ac <find_next+0x48>
 9d6:	00779713          	slli	a4,a5,0x7
 9da:	973e                	add	a4,a4,a5
 9dc:	0716                	slli	a4,a4,0x5
 9de:	972e                	add	a4,a4,a1
 9e0:	9732                	add	a4,a4,a2
 9e2:	4f18                	lw	a4,24(a4)
 9e4:	fca714e3          	bne	a4,a0,9ac <find_next+0x48>
      next = &uthreads[j];
 9e8:	00779513          	slli	a0,a5,0x7
 9ec:	953e                	add	a0,a0,a5
 9ee:	0516                	slli	a0,a0,0x5
 9f0:	00000797          	auipc	a5,0x0
 9f4:	64078793          	addi	a5,a5,1600 # 1030 <uthreads>
 9f8:	953e                	add	a0,a0,a5
      break;
 9fa:	a011                	j	9fe <find_next+0x9a>
  struct uthread* next = 0;
 9fc:	4501                	li	a0,0
  }

  return next;
}
 9fe:	6422                	ld	s0,8(sp)
 a00:	0141                	addi	sp,sp,16
 a02:	8082                	ret

0000000000000a04 <schedule>:
void schedule(){
 a04:	1101                	addi	sp,sp,-32
 a06:	ec06                	sd	ra,24(sp)
 a08:	e822                	sd	s0,16(sp)
 a0a:	e426                	sd	s1,8(sp)
 a0c:	1000                	addi	s0,sp,32
  cur = currentThread;
 a0e:	00000497          	auipc	s1,0x0
 a12:	6024b483          	ld	s1,1538(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 a16:	4509                	li	a0,2
 a18:	00000097          	auipc	ra,0x0
 a1c:	f4c080e7          	jalr	-180(ra) # 964 <find_next>
  if(next == 0)
 a20:	c915                	beqz	a0,a54 <schedule+0x50>
  currentThread = next;
 a22:	00000797          	auipc	a5,0x0
 a26:	5ea7b723          	sd	a0,1518(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 a2a:	6785                	lui	a5,0x1
 a2c:	00f50733          	add	a4,a0,a5
 a30:	4685                	li	a3,1
 a32:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 a36:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x3b0>
 a3a:	00f505b3          	add	a1,a0,a5
 a3e:	00f48533          	add	a0,s1,a5
 a42:	00000097          	auipc	ra,0x0
 a46:	de4080e7          	jalr	-540(ra) # 826 <uswtch>
}
 a4a:	60e2                	ld	ra,24(sp)
 a4c:	6442                	ld	s0,16(sp)
 a4e:	64a2                	ld	s1,8(sp)
 a50:	6105                	addi	sp,sp,32
 a52:	8082                	ret
    next = find_next(MEDIUM);
 a54:	4505                	li	a0,1
 a56:	00000097          	auipc	ra,0x0
 a5a:	f0e080e7          	jalr	-242(ra) # 964 <find_next>
  if(next == 0)
 a5e:	f171                	bnez	a0,a22 <schedule+0x1e>
    next = find_next(LOW);
 a60:	00000097          	auipc	ra,0x0
 a64:	f04080e7          	jalr	-252(ra) # 964 <find_next>
  if(next == 0)
 a68:	fd4d                	bnez	a0,a22 <schedule+0x1e>
    exit(-1);
 a6a:	557d                	li	a0,-1
 a6c:	00000097          	auipc	ra,0x0
 a70:	8a0080e7          	jalr	-1888(ra) # 30c <exit>

0000000000000a74 <uthread_yield>:
{
 a74:	1141                	addi	sp,sp,-16
 a76:	e406                	sd	ra,8(sp)
 a78:	e022                	sd	s0,0(sp)
 a7a:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 a7c:	00000797          	auipc	a5,0x0
 a80:	5947b783          	ld	a5,1428(a5) # 1010 <currentThread>
 a84:	6705                	lui	a4,0x1
 a86:	97ba                	add	a5,a5,a4
 a88:	4709                	li	a4,2
 a8a:	fae7a023          	sw	a4,-96(a5)
  schedule();
 a8e:	00000097          	auipc	ra,0x0
 a92:	f76080e7          	jalr	-138(ra) # a04 <schedule>
}
 a96:	60a2                	ld	ra,8(sp)
 a98:	6402                	ld	s0,0(sp)
 a9a:	0141                	addi	sp,sp,16
 a9c:	8082                	ret

0000000000000a9e <uthread_exit>:

void uthread_exit()
{
 a9e:	1141                	addi	sp,sp,-16
 aa0:	e406                	sd	ra,8(sp)
 aa2:	e022                	sd	s0,0(sp)
 aa4:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 aa6:	00000797          	auipc	a5,0x0
 aaa:	56a7b783          	ld	a5,1386(a5) # 1010 <currentThread>
 aae:	6705                	lui	a4,0x1
 ab0:	97ba                	add	a5,a5,a4
 ab2:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 ab6:	00001797          	auipc	a5,0x1
 aba:	51a78793          	addi	a5,a5,1306 # 1fd0 <uthreads+0xfa0>
 abe:	00005597          	auipc	a1,0x5
 ac2:	59258593          	addi	a1,a1,1426 # 6050 <uthreads+0x5020>
  int remainingThreads = 0;
 ac6:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 ac8:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 aca:	6685                	lui	a3,0x1
 acc:	02068693          	addi	a3,a3,32 # 1020 <base>
 ad0:	a021                	j	ad8 <uthread_exit+0x3a>
 ad2:	97b6                	add	a5,a5,a3
 ad4:	00b78763          	beq	a5,a1,ae2 <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 ad8:	4398                	lw	a4,0(a5)
 ada:	fec71ce3          	bne	a4,a2,ad2 <uthread_exit+0x34>
      remainingThreads++;
 ade:	2505                	addiw	a0,a0,1
 ae0:	bfcd                	j	ad2 <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 ae2:	c909                	beqz	a0,af4 <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 ae4:	00000097          	auipc	ra,0x0
 ae8:	f20080e7          	jalr	-224(ra) # a04 <schedule>
  }
}
 aec:	60a2                	ld	ra,8(sp)
 aee:	6402                	ld	s0,0(sp)
 af0:	0141                	addi	sp,sp,16
 af2:	8082                	ret
    exit(0);
 af4:	00000097          	auipc	ra,0x0
 af8:	818080e7          	jalr	-2024(ra) # 30c <exit>

0000000000000afc <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 afc:	1141                	addi	sp,sp,-16
 afe:	e422                	sd	s0,8(sp)
 b00:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 b02:	00000797          	auipc	a5,0x0
 b06:	50e7b783          	ld	a5,1294(a5) # 1010 <currentThread>
 b0a:	6705                	lui	a4,0x1
 b0c:	97ba                	add	a5,a5,a4
 b0e:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 b10:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 b12:	853a                	mv	a0,a4
 b14:	6422                	ld	s0,8(sp)
 b16:	0141                	addi	sp,sp,16
 b18:	8082                	ret

0000000000000b1a <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 b1a:	1141                	addi	sp,sp,-16
 b1c:	e422                	sd	s0,8(sp)
 b1e:	0800                	addi	s0,sp,16
    return currentThread->priority;
 b20:	00000797          	auipc	a5,0x0
 b24:	4f07b783          	ld	a5,1264(a5) # 1010 <currentThread>
 b28:	6705                	lui	a4,0x1
 b2a:	97ba                	add	a5,a5,a4
}
 b2c:	4f88                	lw	a0,24(a5)
 b2e:	6422                	ld	s0,8(sp)
 b30:	0141                	addi	sp,sp,16
 b32:	8082                	ret

0000000000000b34 <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 b34:	7175                	addi	sp,sp,-144
 b36:	e506                	sd	ra,136(sp)
 b38:	e122                	sd	s0,128(sp)
 b3a:	fca6                	sd	s1,120(sp)
 b3c:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 b3e:	00000497          	auipc	s1,0x0
 b42:	4ca4a483          	lw	s1,1226(s1) # 1008 <uthreadStarted>
 b46:	e4ad                	bnez	s1,bb0 <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 b48:	4785                	li	a5,1
 b4a:	00000717          	auipc	a4,0x0
 b4e:	4af72f23          	sw	a5,1214(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 b52:	4509                	li	a0,2
 b54:	00000097          	auipc	ra,0x0
 b58:	e10080e7          	jalr	-496(ra) # 964 <find_next>
  if(next == 0)
 b5c:	c915                	beqz	a0,b90 <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 b5e:	00000797          	auipc	a5,0x0
 b62:	4aa7b923          	sd	a0,1202(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 b66:	6585                	lui	a1,0x1
 b68:	00b507b3          	add	a5,a0,a1
 b6c:	4705                	li	a4,1
 b6e:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 b72:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x3b0>
 b76:	95aa                	add	a1,a1,a0
 b78:	f7040513          	addi	a0,s0,-144
 b7c:	00000097          	auipc	ra,0x0
 b80:	caa080e7          	jalr	-854(ra) # 826 <uswtch>

  return 0;
}
 b84:	8526                	mv	a0,s1
 b86:	60aa                	ld	ra,136(sp)
 b88:	640a                	ld	s0,128(sp)
 b8a:	74e6                	ld	s1,120(sp)
 b8c:	6149                	addi	sp,sp,144
 b8e:	8082                	ret
    next = find_next(MEDIUM);
 b90:	4505                	li	a0,1
 b92:	00000097          	auipc	ra,0x0
 b96:	dd2080e7          	jalr	-558(ra) # 964 <find_next>
  if(next == 0)
 b9a:	f171                	bnez	a0,b5e <uthread_start_all+0x2a>
    next = find_next(LOW);
 b9c:	00000097          	auipc	ra,0x0
 ba0:	dc8080e7          	jalr	-568(ra) # 964 <find_next>
  if(next == 0)
 ba4:	fd4d                	bnez	a0,b5e <uthread_start_all+0x2a>
    exit(-1);
 ba6:	557d                	li	a0,-1
 ba8:	fffff097          	auipc	ra,0xfffff
 bac:	764080e7          	jalr	1892(ra) # 30c <exit>
    return -1;
 bb0:	54fd                	li	s1,-1
 bb2:	bfc9                	j	b84 <uthread_start_all+0x50>

0000000000000bb4 <uthread_self>:


struct uthread *uthread_self()
{
 bb4:	1141                	addi	sp,sp,-16
 bb6:	e422                	sd	s0,8(sp)
 bb8:	0800                	addi	s0,sp,16
    return currentThread;
 bba:	00000517          	auipc	a0,0x0
 bbe:	45653503          	ld	a0,1110(a0) # 1010 <currentThread>
 bc2:	6422                	ld	s0,8(sp)
 bc4:	0141                	addi	sp,sp,16
 bc6:	8082                	ret
