
user/_test_uthread:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print_low>:
#include "uthread.h"
#include "user.h"

void print_low() {
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	4495                	li	s1,5
  for (int i = 0; i < 5; i++) {
    printf("Low priority thread\n");
   e:	00001917          	auipc	s2,0x1
  12:	c6290913          	addi	s2,s2,-926 # c70 <uthread_self+0x30>
  16:	854a                	mv	a0,s2
  18:	00000097          	auipc	ra,0x0
  1c:	6f8080e7          	jalr	1784(ra) # 710 <printf>
    uthread_yield();
  20:	00001097          	auipc	ra,0x1
  24:	ae0080e7          	jalr	-1312(ra) # b00 <uthread_yield>
  for (int i = 0; i < 5; i++) {
  28:	34fd                	addiw	s1,s1,-1
  2a:	f4f5                	bnez	s1,16 <print_low+0x16>
  }
  uthread_exit();
  2c:	00001097          	auipc	ra,0x1
  30:	afe080e7          	jalr	-1282(ra) # b2a <uthread_exit>
}
  34:	60e2                	ld	ra,24(sp)
  36:	6442                	ld	s0,16(sp)
  38:	64a2                	ld	s1,8(sp)
  3a:	6902                	ld	s2,0(sp)
  3c:	6105                	addi	sp,sp,32
  3e:	8082                	ret

0000000000000040 <print_medium>:

void print_medium() {
  40:	1101                	addi	sp,sp,-32
  42:	ec06                	sd	ra,24(sp)
  44:	e822                	sd	s0,16(sp)
  46:	e426                	sd	s1,8(sp)
  48:	e04a                	sd	s2,0(sp)
  4a:	1000                	addi	s0,sp,32
  4c:	4495                	li	s1,5
  for (int i = 0; i < 5; i++) {
    printf("Medium priority thread\n");
  4e:	00001917          	auipc	s2,0x1
  52:	c3a90913          	addi	s2,s2,-966 # c88 <uthread_self+0x48>
  56:	854a                	mv	a0,s2
  58:	00000097          	auipc	ra,0x0
  5c:	6b8080e7          	jalr	1720(ra) # 710 <printf>
    uthread_yield();
  60:	00001097          	auipc	ra,0x1
  64:	aa0080e7          	jalr	-1376(ra) # b00 <uthread_yield>
  for (int i = 0; i < 5; i++) {
  68:	34fd                	addiw	s1,s1,-1
  6a:	f4f5                	bnez	s1,56 <print_medium+0x16>
  }
  uthread_exit();
  6c:	00001097          	auipc	ra,0x1
  70:	abe080e7          	jalr	-1346(ra) # b2a <uthread_exit>
}
  74:	60e2                	ld	ra,24(sp)
  76:	6442                	ld	s0,16(sp)
  78:	64a2                	ld	s1,8(sp)
  7a:	6902                	ld	s2,0(sp)
  7c:	6105                	addi	sp,sp,32
  7e:	8082                	ret

0000000000000080 <print_high>:

void print_high() {
  80:	1101                	addi	sp,sp,-32
  82:	ec06                	sd	ra,24(sp)
  84:	e822                	sd	s0,16(sp)
  86:	e426                	sd	s1,8(sp)
  88:	e04a                	sd	s2,0(sp)
  8a:	1000                	addi	s0,sp,32
  8c:	4495                	li	s1,5
  for (int i = 0; i < 5; i++) {
    printf("High priority thread\n");
  8e:	00001917          	auipc	s2,0x1
  92:	c1290913          	addi	s2,s2,-1006 # ca0 <uthread_self+0x60>
  96:	854a                	mv	a0,s2
  98:	00000097          	auipc	ra,0x0
  9c:	678080e7          	jalr	1656(ra) # 710 <printf>
    uthread_yield();
  a0:	00001097          	auipc	ra,0x1
  a4:	a60080e7          	jalr	-1440(ra) # b00 <uthread_yield>
  for (int i = 0; i < 5; i++) {
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <print_high+0x16>
  }
  uthread_exit();
  ac:	00001097          	auipc	ra,0x1
  b0:	a7e080e7          	jalr	-1410(ra) # b2a <uthread_exit>
}
  b4:	60e2                	ld	ra,24(sp)
  b6:	6442                	ld	s0,16(sp)
  b8:	64a2                	ld	s1,8(sp)
  ba:	6902                	ld	s2,0(sp)
  bc:	6105                	addi	sp,sp,32
  be:	8082                	ret

00000000000000c0 <main>:

int main() {
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
  uthread_create(print_low, LOW);
  c8:	4581                	li	a1,0
  ca:	00000517          	auipc	a0,0x0
  ce:	f3650513          	addi	a0,a0,-202 # 0 <print_low>
  d2:	00001097          	auipc	ra,0x1
  d6:	84a080e7          	jalr	-1974(ra) # 91c <uthread_create>
  uthread_create(print_medium, MEDIUM);
  da:	4585                	li	a1,1
  dc:	00000517          	auipc	a0,0x0
  e0:	f6450513          	addi	a0,a0,-156 # 40 <print_medium>
  e4:	00001097          	auipc	ra,0x1
  e8:	838080e7          	jalr	-1992(ra) # 91c <uthread_create>
  uthread_create(print_high, HIGH);
  ec:	4589                	li	a1,2
  ee:	00000517          	auipc	a0,0x0
  f2:	f9250513          	addi	a0,a0,-110 # 80 <print_high>
  f6:	00001097          	auipc	ra,0x1
  fa:	826080e7          	jalr	-2010(ra) # 91c <uthread_create>

  uthread_start_all();
  fe:	00001097          	auipc	ra,0x1
 102:	ac2080e7          	jalr	-1342(ra) # bc0 <uthread_start_all>

  // This point should never be reached
  return 0;
}
 106:	4501                	li	a0,0
 108:	60a2                	ld	ra,8(sp)
 10a:	6402                	ld	s0,0(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 110:	1141                	addi	sp,sp,-16
 112:	e406                	sd	ra,8(sp)
 114:	e022                	sd	s0,0(sp)
 116:	0800                	addi	s0,sp,16
  extern int main();
  main();
 118:	00000097          	auipc	ra,0x0
 11c:	fa8080e7          	jalr	-88(ra) # c0 <main>
  exit(0);
 120:	4501                	li	a0,0
 122:	00000097          	auipc	ra,0x0
 126:	276080e7          	jalr	630(ra) # 398 <exit>

000000000000012a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 12a:	1141                	addi	sp,sp,-16
 12c:	e422                	sd	s0,8(sp)
 12e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 130:	87aa                	mv	a5,a0
 132:	0585                	addi	a1,a1,1
 134:	0785                	addi	a5,a5,1
 136:	fff5c703          	lbu	a4,-1(a1)
 13a:	fee78fa3          	sb	a4,-1(a5)
 13e:	fb75                	bnez	a4,132 <strcpy+0x8>
    ;
  return os;
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret

0000000000000146 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 14c:	00054783          	lbu	a5,0(a0)
 150:	cb91                	beqz	a5,164 <strcmp+0x1e>
 152:	0005c703          	lbu	a4,0(a1)
 156:	00f71763          	bne	a4,a5,164 <strcmp+0x1e>
    p++, q++;
 15a:	0505                	addi	a0,a0,1
 15c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 15e:	00054783          	lbu	a5,0(a0)
 162:	fbe5                	bnez	a5,152 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 164:	0005c503          	lbu	a0,0(a1)
}
 168:	40a7853b          	subw	a0,a5,a0
 16c:	6422                	ld	s0,8(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret

0000000000000172 <strlen>:

uint
strlen(const char *s)
{
 172:	1141                	addi	sp,sp,-16
 174:	e422                	sd	s0,8(sp)
 176:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 178:	00054783          	lbu	a5,0(a0)
 17c:	cf91                	beqz	a5,198 <strlen+0x26>
 17e:	0505                	addi	a0,a0,1
 180:	87aa                	mv	a5,a0
 182:	4685                	li	a3,1
 184:	9e89                	subw	a3,a3,a0
 186:	00f6853b          	addw	a0,a3,a5
 18a:	0785                	addi	a5,a5,1
 18c:	fff7c703          	lbu	a4,-1(a5)
 190:	fb7d                	bnez	a4,186 <strlen+0x14>
    ;
  return n;
}
 192:	6422                	ld	s0,8(sp)
 194:	0141                	addi	sp,sp,16
 196:	8082                	ret
  for(n = 0; s[n]; n++)
 198:	4501                	li	a0,0
 19a:	bfe5                	j	192 <strlen+0x20>

000000000000019c <memset>:

void*
memset(void *dst, int c, uint n)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a2:	ca19                	beqz	a2,1b8 <memset+0x1c>
 1a4:	87aa                	mv	a5,a0
 1a6:	1602                	slli	a2,a2,0x20
 1a8:	9201                	srli	a2,a2,0x20
 1aa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ae:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b2:	0785                	addi	a5,a5,1
 1b4:	fee79de3          	bne	a5,a4,1ae <memset+0x12>
  }
  return dst;
}
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strchr>:

char*
strchr(const char *s, char c)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	cb99                	beqz	a5,1de <strchr+0x20>
    if(*s == c)
 1ca:	00f58763          	beq	a1,a5,1d8 <strchr+0x1a>
  for(; *s; s++)
 1ce:	0505                	addi	a0,a0,1
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	fbfd                	bnez	a5,1ca <strchr+0xc>
      return (char*)s;
  return 0;
 1d6:	4501                	li	a0,0
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret
  return 0;
 1de:	4501                	li	a0,0
 1e0:	bfe5                	j	1d8 <strchr+0x1a>

00000000000001e2 <gets>:

char*
gets(char *buf, int max)
{
 1e2:	711d                	addi	sp,sp,-96
 1e4:	ec86                	sd	ra,88(sp)
 1e6:	e8a2                	sd	s0,80(sp)
 1e8:	e4a6                	sd	s1,72(sp)
 1ea:	e0ca                	sd	s2,64(sp)
 1ec:	fc4e                	sd	s3,56(sp)
 1ee:	f852                	sd	s4,48(sp)
 1f0:	f456                	sd	s5,40(sp)
 1f2:	f05a                	sd	s6,32(sp)
 1f4:	ec5e                	sd	s7,24(sp)
 1f6:	1080                	addi	s0,sp,96
 1f8:	8baa                	mv	s7,a0
 1fa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fc:	892a                	mv	s2,a0
 1fe:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 200:	4aa9                	li	s5,10
 202:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 204:	89a6                	mv	s3,s1
 206:	2485                	addiw	s1,s1,1
 208:	0344d863          	bge	s1,s4,238 <gets+0x56>
    cc = read(0, &c, 1);
 20c:	4605                	li	a2,1
 20e:	faf40593          	addi	a1,s0,-81
 212:	4501                	li	a0,0
 214:	00000097          	auipc	ra,0x0
 218:	19c080e7          	jalr	412(ra) # 3b0 <read>
    if(cc < 1)
 21c:	00a05e63          	blez	a0,238 <gets+0x56>
    buf[i++] = c;
 220:	faf44783          	lbu	a5,-81(s0)
 224:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 228:	01578763          	beq	a5,s5,236 <gets+0x54>
 22c:	0905                	addi	s2,s2,1
 22e:	fd679be3          	bne	a5,s6,204 <gets+0x22>
  for(i=0; i+1 < max; ){
 232:	89a6                	mv	s3,s1
 234:	a011                	j	238 <gets+0x56>
 236:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 238:	99de                	add	s3,s3,s7
 23a:	00098023          	sb	zero,0(s3)
  return buf;
}
 23e:	855e                	mv	a0,s7
 240:	60e6                	ld	ra,88(sp)
 242:	6446                	ld	s0,80(sp)
 244:	64a6                	ld	s1,72(sp)
 246:	6906                	ld	s2,64(sp)
 248:	79e2                	ld	s3,56(sp)
 24a:	7a42                	ld	s4,48(sp)
 24c:	7aa2                	ld	s5,40(sp)
 24e:	7b02                	ld	s6,32(sp)
 250:	6be2                	ld	s7,24(sp)
 252:	6125                	addi	sp,sp,96
 254:	8082                	ret

0000000000000256 <stat>:

int
stat(const char *n, struct stat *st)
{
 256:	1101                	addi	sp,sp,-32
 258:	ec06                	sd	ra,24(sp)
 25a:	e822                	sd	s0,16(sp)
 25c:	e426                	sd	s1,8(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	1000                	addi	s0,sp,32
 262:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 264:	4581                	li	a1,0
 266:	00000097          	auipc	ra,0x0
 26a:	172080e7          	jalr	370(ra) # 3d8 <open>
  if(fd < 0)
 26e:	02054563          	bltz	a0,298 <stat+0x42>
 272:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 274:	85ca                	mv	a1,s2
 276:	00000097          	auipc	ra,0x0
 27a:	17a080e7          	jalr	378(ra) # 3f0 <fstat>
 27e:	892a                	mv	s2,a0
  close(fd);
 280:	8526                	mv	a0,s1
 282:	00000097          	auipc	ra,0x0
 286:	13e080e7          	jalr	318(ra) # 3c0 <close>
  return r;
}
 28a:	854a                	mv	a0,s2
 28c:	60e2                	ld	ra,24(sp)
 28e:	6442                	ld	s0,16(sp)
 290:	64a2                	ld	s1,8(sp)
 292:	6902                	ld	s2,0(sp)
 294:	6105                	addi	sp,sp,32
 296:	8082                	ret
    return -1;
 298:	597d                	li	s2,-1
 29a:	bfc5                	j	28a <stat+0x34>

000000000000029c <atoi>:

int
atoi(const char *s)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a2:	00054603          	lbu	a2,0(a0)
 2a6:	fd06079b          	addiw	a5,a2,-48
 2aa:	0ff7f793          	andi	a5,a5,255
 2ae:	4725                	li	a4,9
 2b0:	02f76963          	bltu	a4,a5,2e2 <atoi+0x46>
 2b4:	86aa                	mv	a3,a0
  n = 0;
 2b6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2ba:	0685                	addi	a3,a3,1
 2bc:	0025179b          	slliw	a5,a0,0x2
 2c0:	9fa9                	addw	a5,a5,a0
 2c2:	0017979b          	slliw	a5,a5,0x1
 2c6:	9fb1                	addw	a5,a5,a2
 2c8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2cc:	0006c603          	lbu	a2,0(a3)
 2d0:	fd06071b          	addiw	a4,a2,-48
 2d4:	0ff77713          	andi	a4,a4,255
 2d8:	fee5f1e3          	bgeu	a1,a4,2ba <atoi+0x1e>
  return n;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret
  n = 0;
 2e2:	4501                	li	a0,0
 2e4:	bfe5                	j	2dc <atoi+0x40>

00000000000002e6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ec:	02b57463          	bgeu	a0,a1,314 <memmove+0x2e>
    while(n-- > 0)
 2f0:	00c05f63          	blez	a2,30e <memmove+0x28>
 2f4:	1602                	slli	a2,a2,0x20
 2f6:	9201                	srli	a2,a2,0x20
 2f8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fe:	0585                	addi	a1,a1,1
 300:	0705                	addi	a4,a4,1
 302:	fff5c683          	lbu	a3,-1(a1)
 306:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 30a:	fee79ae3          	bne	a5,a4,2fe <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret
    dst += n;
 314:	00c50733          	add	a4,a0,a2
    src += n;
 318:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 31a:	fec05ae3          	blez	a2,30e <memmove+0x28>
 31e:	fff6079b          	addiw	a5,a2,-1
 322:	1782                	slli	a5,a5,0x20
 324:	9381                	srli	a5,a5,0x20
 326:	fff7c793          	not	a5,a5
 32a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32c:	15fd                	addi	a1,a1,-1
 32e:	177d                	addi	a4,a4,-1
 330:	0005c683          	lbu	a3,0(a1)
 334:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 338:	fee79ae3          	bne	a5,a4,32c <memmove+0x46>
 33c:	bfc9                	j	30e <memmove+0x28>

000000000000033e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 344:	ca05                	beqz	a2,374 <memcmp+0x36>
 346:	fff6069b          	addiw	a3,a2,-1
 34a:	1682                	slli	a3,a3,0x20
 34c:	9281                	srli	a3,a3,0x20
 34e:	0685                	addi	a3,a3,1
 350:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 352:	00054783          	lbu	a5,0(a0)
 356:	0005c703          	lbu	a4,0(a1)
 35a:	00e79863          	bne	a5,a4,36a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35e:	0505                	addi	a0,a0,1
    p2++;
 360:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 362:	fed518e3          	bne	a0,a3,352 <memcmp+0x14>
  }
  return 0;
 366:	4501                	li	a0,0
 368:	a019                	j	36e <memcmp+0x30>
      return *p1 - *p2;
 36a:	40e7853b          	subw	a0,a5,a4
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <memcmp+0x30>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	00000097          	auipc	ra,0x0
 384:	f66080e7          	jalr	-154(ra) # 2e6 <memmove>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 390:	4885                	li	a7,1
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <exit>:
.global exit
exit:
 li a7, SYS_exit
 398:	4889                	li	a7,2
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a0:	488d                	li	a7,3
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a8:	4891                	li	a7,4
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <read>:
.global read
read:
 li a7, SYS_read
 3b0:	4895                	li	a7,5
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <write>:
.global write
write:
 li a7, SYS_write
 3b8:	48c1                	li	a7,16
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <close>:
.global close
close:
 li a7, SYS_close
 3c0:	48d5                	li	a7,21
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c8:	4899                	li	a7,6
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d0:	489d                	li	a7,7
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <open>:
.global open
open:
 li a7, SYS_open
 3d8:	48bd                	li	a7,15
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e0:	48c5                	li	a7,17
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e8:	48c9                	li	a7,18
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f0:	48a1                	li	a7,8
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <link>:
.global link
link:
 li a7, SYS_link
 3f8:	48cd                	li	a7,19
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 400:	48d1                	li	a7,20
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 408:	48a5                	li	a7,9
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <dup>:
.global dup
dup:
 li a7, SYS_dup
 410:	48a9                	li	a7,10
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 418:	48ad                	li	a7,11
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 420:	48b1                	li	a7,12
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 428:	48b5                	li	a7,13
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 430:	48b9                	li	a7,14
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 438:	1101                	addi	sp,sp,-32
 43a:	ec06                	sd	ra,24(sp)
 43c:	e822                	sd	s0,16(sp)
 43e:	1000                	addi	s0,sp,32
 440:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 444:	4605                	li	a2,1
 446:	fef40593          	addi	a1,s0,-17
 44a:	00000097          	auipc	ra,0x0
 44e:	f6e080e7          	jalr	-146(ra) # 3b8 <write>
}
 452:	60e2                	ld	ra,24(sp)
 454:	6442                	ld	s0,16(sp)
 456:	6105                	addi	sp,sp,32
 458:	8082                	ret

000000000000045a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 45a:	7139                	addi	sp,sp,-64
 45c:	fc06                	sd	ra,56(sp)
 45e:	f822                	sd	s0,48(sp)
 460:	f426                	sd	s1,40(sp)
 462:	f04a                	sd	s2,32(sp)
 464:	ec4e                	sd	s3,24(sp)
 466:	0080                	addi	s0,sp,64
 468:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46a:	c299                	beqz	a3,470 <printint+0x16>
 46c:	0805c863          	bltz	a1,4fc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 470:	2581                	sext.w	a1,a1
  neg = 0;
 472:	4881                	li	a7,0
 474:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 478:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 47a:	2601                	sext.w	a2,a2
 47c:	00001517          	auipc	a0,0x1
 480:	84450513          	addi	a0,a0,-1980 # cc0 <digits>
 484:	883a                	mv	a6,a4
 486:	2705                	addiw	a4,a4,1
 488:	02c5f7bb          	remuw	a5,a1,a2
 48c:	1782                	slli	a5,a5,0x20
 48e:	9381                	srli	a5,a5,0x20
 490:	97aa                	add	a5,a5,a0
 492:	0007c783          	lbu	a5,0(a5)
 496:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 49a:	0005879b          	sext.w	a5,a1
 49e:	02c5d5bb          	divuw	a1,a1,a2
 4a2:	0685                	addi	a3,a3,1
 4a4:	fec7f0e3          	bgeu	a5,a2,484 <printint+0x2a>
  if(neg)
 4a8:	00088b63          	beqz	a7,4be <printint+0x64>
    buf[i++] = '-';
 4ac:	fd040793          	addi	a5,s0,-48
 4b0:	973e                	add	a4,a4,a5
 4b2:	02d00793          	li	a5,45
 4b6:	fef70823          	sb	a5,-16(a4)
 4ba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4be:	02e05863          	blez	a4,4ee <printint+0x94>
 4c2:	fc040793          	addi	a5,s0,-64
 4c6:	00e78933          	add	s2,a5,a4
 4ca:	fff78993          	addi	s3,a5,-1
 4ce:	99ba                	add	s3,s3,a4
 4d0:	377d                	addiw	a4,a4,-1
 4d2:	1702                	slli	a4,a4,0x20
 4d4:	9301                	srli	a4,a4,0x20
 4d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4da:	fff94583          	lbu	a1,-1(s2)
 4de:	8526                	mv	a0,s1
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f58080e7          	jalr	-168(ra) # 438 <putc>
  while(--i >= 0)
 4e8:	197d                	addi	s2,s2,-1
 4ea:	ff3918e3          	bne	s2,s3,4da <printint+0x80>
}
 4ee:	70e2                	ld	ra,56(sp)
 4f0:	7442                	ld	s0,48(sp)
 4f2:	74a2                	ld	s1,40(sp)
 4f4:	7902                	ld	s2,32(sp)
 4f6:	69e2                	ld	s3,24(sp)
 4f8:	6121                	addi	sp,sp,64
 4fa:	8082                	ret
    x = -xx;
 4fc:	40b005bb          	negw	a1,a1
    neg = 1;
 500:	4885                	li	a7,1
    x = -xx;
 502:	bf8d                	j	474 <printint+0x1a>

0000000000000504 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 504:	7119                	addi	sp,sp,-128
 506:	fc86                	sd	ra,120(sp)
 508:	f8a2                	sd	s0,112(sp)
 50a:	f4a6                	sd	s1,104(sp)
 50c:	f0ca                	sd	s2,96(sp)
 50e:	ecce                	sd	s3,88(sp)
 510:	e8d2                	sd	s4,80(sp)
 512:	e4d6                	sd	s5,72(sp)
 514:	e0da                	sd	s6,64(sp)
 516:	fc5e                	sd	s7,56(sp)
 518:	f862                	sd	s8,48(sp)
 51a:	f466                	sd	s9,40(sp)
 51c:	f06a                	sd	s10,32(sp)
 51e:	ec6e                	sd	s11,24(sp)
 520:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 522:	0005c903          	lbu	s2,0(a1)
 526:	18090f63          	beqz	s2,6c4 <vprintf+0x1c0>
 52a:	8aaa                	mv	s5,a0
 52c:	8b32                	mv	s6,a2
 52e:	00158493          	addi	s1,a1,1
  state = 0;
 532:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 534:	02500a13          	li	s4,37
      if(c == 'd'){
 538:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 53c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 540:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 544:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 548:	00000b97          	auipc	s7,0x0
 54c:	778b8b93          	addi	s7,s7,1912 # cc0 <digits>
 550:	a839                	j	56e <vprintf+0x6a>
        putc(fd, c);
 552:	85ca                	mv	a1,s2
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	ee2080e7          	jalr	-286(ra) # 438 <putc>
 55e:	a019                	j	564 <vprintf+0x60>
    } else if(state == '%'){
 560:	01498f63          	beq	s3,s4,57e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 564:	0485                	addi	s1,s1,1
 566:	fff4c903          	lbu	s2,-1(s1)
 56a:	14090d63          	beqz	s2,6c4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 572:	fe0997e3          	bnez	s3,560 <vprintf+0x5c>
      if(c == '%'){
 576:	fd479ee3          	bne	a5,s4,552 <vprintf+0x4e>
        state = '%';
 57a:	89be                	mv	s3,a5
 57c:	b7e5                	j	564 <vprintf+0x60>
      if(c == 'd'){
 57e:	05878063          	beq	a5,s8,5be <vprintf+0xba>
      } else if(c == 'l') {
 582:	05978c63          	beq	a5,s9,5da <vprintf+0xd6>
      } else if(c == 'x') {
 586:	07a78863          	beq	a5,s10,5f6 <vprintf+0xf2>
      } else if(c == 'p') {
 58a:	09b78463          	beq	a5,s11,612 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 58e:	07300713          	li	a4,115
 592:	0ce78663          	beq	a5,a4,65e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 596:	06300713          	li	a4,99
 59a:	0ee78e63          	beq	a5,a4,696 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 59e:	11478863          	beq	a5,s4,6ae <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a2:	85d2                	mv	a1,s4
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e92080e7          	jalr	-366(ra) # 438 <putc>
        putc(fd, c);
 5ae:	85ca                	mv	a1,s2
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e86080e7          	jalr	-378(ra) # 438 <putc>
      }
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	b765                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5be:	008b0913          	addi	s2,s6,8
 5c2:	4685                	li	a3,1
 5c4:	4629                	li	a2,10
 5c6:	000b2583          	lw	a1,0(s6)
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e8e080e7          	jalr	-370(ra) # 45a <printint>
 5d4:	8b4a                	mv	s6,s2
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b771                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5da:	008b0913          	addi	s2,s6,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000b2583          	lw	a1,0(s6)
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e72080e7          	jalr	-398(ra) # 45a <printint>
 5f0:	8b4a                	mv	s6,s2
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	bf85                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f6:	008b0913          	addi	s2,s6,8
 5fa:	4681                	li	a3,0
 5fc:	4641                	li	a2,16
 5fe:	000b2583          	lw	a1,0(s6)
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	e56080e7          	jalr	-426(ra) # 45a <printint>
 60c:	8b4a                	mv	s6,s2
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf91                	j	564 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 612:	008b0793          	addi	a5,s6,8
 616:	f8f43423          	sd	a5,-120(s0)
 61a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61e:	03000593          	li	a1,48
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e14080e7          	jalr	-492(ra) # 438 <putc>
  putc(fd, 'x');
 62c:	85ea                	mv	a1,s10
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	e08080e7          	jalr	-504(ra) # 438 <putc>
 638:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 63a:	03c9d793          	srli	a5,s3,0x3c
 63e:	97de                	add	a5,a5,s7
 640:	0007c583          	lbu	a1,0(a5)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	df2080e7          	jalr	-526(ra) # 438 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64e:	0992                	slli	s3,s3,0x4
 650:	397d                	addiw	s2,s2,-1
 652:	fe0914e3          	bnez	s2,63a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 656:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 65a:	4981                	li	s3,0
 65c:	b721                	j	564 <vprintf+0x60>
        s = va_arg(ap, char*);
 65e:	008b0993          	addi	s3,s6,8
 662:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 666:	02090163          	beqz	s2,688 <vprintf+0x184>
        while(*s != 0){
 66a:	00094583          	lbu	a1,0(s2)
 66e:	c9a1                	beqz	a1,6be <vprintf+0x1ba>
          putc(fd, *s);
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	dc6080e7          	jalr	-570(ra) # 438 <putc>
          s++;
 67a:	0905                	addi	s2,s2,1
        while(*s != 0){
 67c:	00094583          	lbu	a1,0(s2)
 680:	f9e5                	bnez	a1,670 <vprintf+0x16c>
        s = va_arg(ap, char*);
 682:	8b4e                	mv	s6,s3
      state = 0;
 684:	4981                	li	s3,0
 686:	bdf9                	j	564 <vprintf+0x60>
          s = "(null)";
 688:	00000917          	auipc	s2,0x0
 68c:	63090913          	addi	s2,s2,1584 # cb8 <uthread_self+0x78>
        while(*s != 0){
 690:	02800593          	li	a1,40
 694:	bff1                	j	670 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 696:	008b0913          	addi	s2,s6,8
 69a:	000b4583          	lbu	a1,0(s6)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	d98080e7          	jalr	-616(ra) # 438 <putc>
 6a8:	8b4a                	mv	s6,s2
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bd65                	j	564 <vprintf+0x60>
        putc(fd, c);
 6ae:	85d2                	mv	a1,s4
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	d86080e7          	jalr	-634(ra) # 438 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b565                	j	564 <vprintf+0x60>
        s = va_arg(ap, char*);
 6be:	8b4e                	mv	s6,s3
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	b54d                	j	564 <vprintf+0x60>
    }
  }
}
 6c4:	70e6                	ld	ra,120(sp)
 6c6:	7446                	ld	s0,112(sp)
 6c8:	74a6                	ld	s1,104(sp)
 6ca:	7906                	ld	s2,96(sp)
 6cc:	69e6                	ld	s3,88(sp)
 6ce:	6a46                	ld	s4,80(sp)
 6d0:	6aa6                	ld	s5,72(sp)
 6d2:	6b06                	ld	s6,64(sp)
 6d4:	7be2                	ld	s7,56(sp)
 6d6:	7c42                	ld	s8,48(sp)
 6d8:	7ca2                	ld	s9,40(sp)
 6da:	7d02                	ld	s10,32(sp)
 6dc:	6de2                	ld	s11,24(sp)
 6de:	6109                	addi	sp,sp,128
 6e0:	8082                	ret

00000000000006e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e2:	715d                	addi	sp,sp,-80
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e010                	sd	a2,0(s0)
 6ec:	e414                	sd	a3,8(s0)
 6ee:	e818                	sd	a4,16(s0)
 6f0:	ec1c                	sd	a5,24(s0)
 6f2:	03043023          	sd	a6,32(s0)
 6f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6fa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fe:	8622                	mv	a2,s0
 700:	00000097          	auipc	ra,0x0
 704:	e04080e7          	jalr	-508(ra) # 504 <vprintf>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6161                	addi	sp,sp,80
 70e:	8082                	ret

0000000000000710 <printf>:

void
printf(const char *fmt, ...)
{
 710:	711d                	addi	sp,sp,-96
 712:	ec06                	sd	ra,24(sp)
 714:	e822                	sd	s0,16(sp)
 716:	1000                	addi	s0,sp,32
 718:	e40c                	sd	a1,8(s0)
 71a:	e810                	sd	a2,16(s0)
 71c:	ec14                	sd	a3,24(s0)
 71e:	f018                	sd	a4,32(s0)
 720:	f41c                	sd	a5,40(s0)
 722:	03043823          	sd	a6,48(s0)
 726:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 72a:	00840613          	addi	a2,s0,8
 72e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 732:	85aa                	mv	a1,a0
 734:	4505                	li	a0,1
 736:	00000097          	auipc	ra,0x0
 73a:	dce080e7          	jalr	-562(ra) # 504 <vprintf>
}
 73e:	60e2                	ld	ra,24(sp)
 740:	6442                	ld	s0,16(sp)
 742:	6125                	addi	sp,sp,96
 744:	8082                	ret

0000000000000746 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 746:	1141                	addi	sp,sp,-16
 748:	e422                	sd	s0,8(sp)
 74a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 750:	00001797          	auipc	a5,0x1
 754:	8b07b783          	ld	a5,-1872(a5) # 1000 <freep>
 758:	a805                	j	788 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 75a:	4618                	lw	a4,8(a2)
 75c:	9db9                	addw	a1,a1,a4
 75e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 762:	6398                	ld	a4,0(a5)
 764:	6318                	ld	a4,0(a4)
 766:	fee53823          	sd	a4,-16(a0)
 76a:	a091                	j	7ae <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 76c:	ff852703          	lw	a4,-8(a0)
 770:	9e39                	addw	a2,a2,a4
 772:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 774:	ff053703          	ld	a4,-16(a0)
 778:	e398                	sd	a4,0(a5)
 77a:	a099                	j	7c0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	6398                	ld	a4,0(a5)
 77e:	00e7e463          	bltu	a5,a4,786 <free+0x40>
 782:	00e6ea63          	bltu	a3,a4,796 <free+0x50>
{
 786:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 788:	fed7fae3          	bgeu	a5,a3,77c <free+0x36>
 78c:	6398                	ld	a4,0(a5)
 78e:	00e6e463          	bltu	a3,a4,796 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	fee7eae3          	bltu	a5,a4,786 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 796:	ff852583          	lw	a1,-8(a0)
 79a:	6390                	ld	a2,0(a5)
 79c:	02059713          	slli	a4,a1,0x20
 7a0:	9301                	srli	a4,a4,0x20
 7a2:	0712                	slli	a4,a4,0x4
 7a4:	9736                	add	a4,a4,a3
 7a6:	fae60ae3          	beq	a2,a4,75a <free+0x14>
    bp->s.ptr = p->s.ptr;
 7aa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ae:	4790                	lw	a2,8(a5)
 7b0:	02061713          	slli	a4,a2,0x20
 7b4:	9301                	srli	a4,a4,0x20
 7b6:	0712                	slli	a4,a4,0x4
 7b8:	973e                	add	a4,a4,a5
 7ba:	fae689e3          	beq	a3,a4,76c <free+0x26>
  } else
    p->s.ptr = bp;
 7be:	e394                	sd	a3,0(a5)
  freep = p;
 7c0:	00001717          	auipc	a4,0x1
 7c4:	84f73023          	sd	a5,-1984(a4) # 1000 <freep>
}
 7c8:	6422                	ld	s0,8(sp)
 7ca:	0141                	addi	sp,sp,16
 7cc:	8082                	ret

00000000000007ce <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ce:	7139                	addi	sp,sp,-64
 7d0:	fc06                	sd	ra,56(sp)
 7d2:	f822                	sd	s0,48(sp)
 7d4:	f426                	sd	s1,40(sp)
 7d6:	f04a                	sd	s2,32(sp)
 7d8:	ec4e                	sd	s3,24(sp)
 7da:	e852                	sd	s4,16(sp)
 7dc:	e456                	sd	s5,8(sp)
 7de:	e05a                	sd	s6,0(sp)
 7e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	02051493          	slli	s1,a0,0x20
 7e6:	9081                	srli	s1,s1,0x20
 7e8:	04bd                	addi	s1,s1,15
 7ea:	8091                	srli	s1,s1,0x4
 7ec:	0014899b          	addiw	s3,s1,1
 7f0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7f2:	00001517          	auipc	a0,0x1
 7f6:	80e53503          	ld	a0,-2034(a0) # 1000 <freep>
 7fa:	c515                	beqz	a0,826 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fe:	4798                	lw	a4,8(a5)
 800:	02977f63          	bgeu	a4,s1,83e <malloc+0x70>
 804:	8a4e                	mv	s4,s3
 806:	0009871b          	sext.w	a4,s3
 80a:	6685                	lui	a3,0x1
 80c:	00d77363          	bgeu	a4,a3,812 <malloc+0x44>
 810:	6a05                	lui	s4,0x1
 812:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 816:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81a:	00000917          	auipc	s2,0x0
 81e:	7e690913          	addi	s2,s2,2022 # 1000 <freep>
  if(p == (char*)-1)
 822:	5afd                	li	s5,-1
 824:	a88d                	j	896 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 826:	00000797          	auipc	a5,0x0
 82a:	7fa78793          	addi	a5,a5,2042 # 1020 <base>
 82e:	00000717          	auipc	a4,0x0
 832:	7cf73923          	sd	a5,2002(a4) # 1000 <freep>
 836:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 838:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 83c:	b7e1                	j	804 <malloc+0x36>
      if(p->s.size == nunits)
 83e:	02e48b63          	beq	s1,a4,874 <malloc+0xa6>
        p->s.size -= nunits;
 842:	4137073b          	subw	a4,a4,s3
 846:	c798                	sw	a4,8(a5)
        p += p->s.size;
 848:	1702                	slli	a4,a4,0x20
 84a:	9301                	srli	a4,a4,0x20
 84c:	0712                	slli	a4,a4,0x4
 84e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 850:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 854:	00000717          	auipc	a4,0x0
 858:	7aa73623          	sd	a0,1964(a4) # 1000 <freep>
      return (void*)(p + 1);
 85c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 860:	70e2                	ld	ra,56(sp)
 862:	7442                	ld	s0,48(sp)
 864:	74a2                	ld	s1,40(sp)
 866:	7902                	ld	s2,32(sp)
 868:	69e2                	ld	s3,24(sp)
 86a:	6a42                	ld	s4,16(sp)
 86c:	6aa2                	ld	s5,8(sp)
 86e:	6b02                	ld	s6,0(sp)
 870:	6121                	addi	sp,sp,64
 872:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 874:	6398                	ld	a4,0(a5)
 876:	e118                	sd	a4,0(a0)
 878:	bff1                	j	854 <malloc+0x86>
  hp->s.size = nu;
 87a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87e:	0541                	addi	a0,a0,16
 880:	00000097          	auipc	ra,0x0
 884:	ec6080e7          	jalr	-314(ra) # 746 <free>
  return freep;
 888:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 88c:	d971                	beqz	a0,860 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 890:	4798                	lw	a4,8(a5)
 892:	fa9776e3          	bgeu	a4,s1,83e <malloc+0x70>
    if(p == freep)
 896:	00093703          	ld	a4,0(s2)
 89a:	853e                	mv	a0,a5
 89c:	fef719e3          	bne	a4,a5,88e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8a0:	8552                	mv	a0,s4
 8a2:	00000097          	auipc	ra,0x0
 8a6:	b7e080e7          	jalr	-1154(ra) # 420 <sbrk>
  if(p == (char*)-1)
 8aa:	fd5518e3          	bne	a0,s5,87a <malloc+0xac>
        return 0;
 8ae:	4501                	li	a0,0
 8b0:	bf45                	j	860 <malloc+0x92>

00000000000008b2 <uswtch>:
 8b2:	00153023          	sd	ra,0(a0)
 8b6:	00253423          	sd	sp,8(a0)
 8ba:	e900                	sd	s0,16(a0)
 8bc:	ed04                	sd	s1,24(a0)
 8be:	03253023          	sd	s2,32(a0)
 8c2:	03353423          	sd	s3,40(a0)
 8c6:	03453823          	sd	s4,48(a0)
 8ca:	03553c23          	sd	s5,56(a0)
 8ce:	05653023          	sd	s6,64(a0)
 8d2:	05753423          	sd	s7,72(a0)
 8d6:	05853823          	sd	s8,80(a0)
 8da:	05953c23          	sd	s9,88(a0)
 8de:	07a53023          	sd	s10,96(a0)
 8e2:	07b53423          	sd	s11,104(a0)
 8e6:	0005b083          	ld	ra,0(a1)
 8ea:	0085b103          	ld	sp,8(a1)
 8ee:	6980                	ld	s0,16(a1)
 8f0:	6d84                	ld	s1,24(a1)
 8f2:	0205b903          	ld	s2,32(a1)
 8f6:	0285b983          	ld	s3,40(a1)
 8fa:	0305ba03          	ld	s4,48(a1)
 8fe:	0385ba83          	ld	s5,56(a1)
 902:	0405bb03          	ld	s6,64(a1)
 906:	0485bb83          	ld	s7,72(a1)
 90a:	0505bc03          	ld	s8,80(a1)
 90e:	0585bc83          	ld	s9,88(a1)
 912:	0605bd03          	ld	s10,96(a1)
 916:	0685bd83          	ld	s11,104(a1)
 91a:	8082                	ret

000000000000091c <uthread_create>:
struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

int uthread_create(void (*start_func)(), enum sched_priority priority)
{
 91c:	1141                	addi	sp,sp,-16
 91e:	e422                	sd	s0,8(sp)
 920:	0800                	addi	s0,sp,16
    int i;
    ids ++;
 922:	00000797          	auipc	a5,0x0
 926:	6ea78793          	addi	a5,a5,1770 # 100c <ids>
 92a:	0007a303          	lw	t1,0(a5)
 92e:	2305                	addiw	t1,t1,1
 930:	0067a023          	sw	t1,0(a5)

    for (i = 0; i < MAX_UTHREADS; i++)
 934:	00001717          	auipc	a4,0x1
 938:	69c70713          	addi	a4,a4,1692 # 1fd0 <uthreads+0xfa0>
 93c:	4781                	li	a5,0
 93e:	6605                	lui	a2,0x1
 940:	02060613          	addi	a2,a2,32 # 1020 <base>
 944:	4811                	li	a6,4
    {
        if (uthreads[i].state == FREE)
 946:	4314                	lw	a3,0(a4)
 948:	c699                	beqz	a3,956 <uthread_create+0x3a>
    for (i = 0; i < MAX_UTHREADS; i++)
 94a:	2785                	addiw	a5,a5,1
 94c:	9732                	add	a4,a4,a2
 94e:	ff079ce3          	bne	a5,a6,946 <uthread_create+0x2a>
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;
 952:	557d                	li	a0,-1
 954:	a889                	j	9a6 <uthread_create+0x8a>
    if (i == MAX_UTHREADS)
 956:	4711                	li	a4,4
 958:	04e78a63          	beq	a5,a4,9ac <uthread_create+0x90>

    uthreads[i].context.ra = (uint64)start_func;
 95c:	00000897          	auipc	a7,0x0
 960:	6d488893          	addi	a7,a7,1748 # 1030 <uthreads>
 964:	00779693          	slli	a3,a5,0x7
 968:	00f68633          	add	a2,a3,a5
 96c:	0616                	slli	a2,a2,0x5
 96e:	9646                	add	a2,a2,a7
 970:	6805                	lui	a6,0x1
 972:	00c80e33          	add	t3,a6,a2
 976:	faae3423          	sd	a0,-88(t3)
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
 97a:	00f68733          	add	a4,a3,a5
 97e:	0716                	slli	a4,a4,0x5
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
 980:	fa080513          	addi	a0,a6,-96 # fa0 <digits+0x2e0>
 984:	972a                	add	a4,a4,a0
 986:	9746                	add	a4,a4,a7
    uthreads[i].context.sp += sizeof(uint64);
 988:	0721                	addi	a4,a4,8
 98a:	faee3823          	sd	a4,-80(t3)
    uthreads[i].state = RUNNABLE;
 98e:	4709                	li	a4,2
 990:	faee2023          	sw	a4,-96(t3)
    uthreads[i].priority = priority;
 994:	00be2c23          	sw	a1,24(t3)
    currentThread = &uthreads[i];
 998:	00000717          	auipc	a4,0x0
 99c:	66c73c23          	sd	a2,1656(a4) # 1010 <currentThread>

    currentThread->pid = ids;
 9a0:	006e2e23          	sw	t1,28(t3)

    return 0;
 9a4:	4501                	li	a0,0
}
 9a6:	6422                	ld	s0,8(sp)
 9a8:	0141                	addi	sp,sp,16
 9aa:	8082                	ret
        return -1;
 9ac:	557d                	li	a0,-1
 9ae:	bfe5                	j	9a6 <uthread_create+0x8a>

00000000000009b0 <get_state>:
  currentThread->state = RUNNABLE;
  schedule();
}


char* get_state(enum tstate s){
 9b0:	1141                	addi	sp,sp,-16
 9b2:	e422                	sd	s0,8(sp)
 9b4:	0800                	addi	s0,sp,16
  switch (s)
 9b6:	4705                	li	a4,1
 9b8:	02e50763          	beq	a0,a4,9e6 <get_state+0x36>
 9bc:	87aa                	mv	a5,a0
 9be:	4709                	li	a4,2
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
 9c0:	00000517          	auipc	a0,0x0
 9c4:	32050513          	addi	a0,a0,800 # ce0 <digits+0x20>
  switch (s)
 9c8:	00e78763          	beq	a5,a4,9d6 <get_state+0x26>
  }

  return "ERROR";
 9cc:	00000517          	auipc	a0,0x0
 9d0:	30c50513          	addi	a0,a0,780 # cd8 <digits+0x18>
  switch (s)
 9d4:	c781                	beqz	a5,9dc <get_state+0x2c>
}
 9d6:	6422                	ld	s0,8(sp)
 9d8:	0141                	addi	sp,sp,16
 9da:	8082                	ret
    return "FREE";
 9dc:	00000517          	auipc	a0,0x0
 9e0:	31c50513          	addi	a0,a0,796 # cf8 <digits+0x38>
 9e4:	bfcd                	j	9d6 <get_state+0x26>
  switch (s)
 9e6:	00000517          	auipc	a0,0x0
 9ea:	30a50513          	addi	a0,a0,778 # cf0 <digits+0x30>
 9ee:	b7e5                	j	9d6 <get_state+0x26>

00000000000009f0 <find_next>:
  uswtch(&cur->context, &next->context);
  
}


struct uthread *find_next(enum sched_priority priority){
 9f0:	1141                	addi	sp,sp,-16
 9f2:	e422                	sd	s0,8(sp)
 9f4:	0800                	addi	s0,sp,16
  
  struct uthread* next = 0;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
 9f6:	00000717          	auipc	a4,0x0
 9fa:	61a73703          	ld	a4,1562(a4) # 1010 <currentThread>
 9fe:	00000797          	auipc	a5,0x0
 a02:	63278793          	addi	a5,a5,1586 # 1030 <uthreads>
 a06:	8f1d                	sub	a4,a4,a5
 a08:	8715                	srai	a4,a4,0x5
 a0a:	00000797          	auipc	a5,0x0
 a0e:	2567b783          	ld	a5,598(a5) # c60 <uthread_self+0x20>
 a12:	02f70733          	mul	a4,a4,a5
 a16:	0705                	addi	a4,a4,1
 a18:	43f75793          	srai	a5,a4,0x3f
 a1c:	03e7d693          	srli	a3,a5,0x3e
 a20:	00d707b3          	add	a5,a4,a3
 a24:	8b8d                	andi	a5,a5,3
 a26:	8f95                	sub	a5,a5,a3
 a28:	4691                	li	a3,4

  for(i = 0; i < MAX_UTHREADS; i++){
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a2a:	00000597          	auipc	a1,0x0
 a2e:	60658593          	addi	a1,a1,1542 # 1030 <uthreads>
 a32:	6605                	lui	a2,0x1
 a34:	4805                	li	a6,1
 a36:	a819                	j	a4c <find_next+0x5c>
      next = &uthreads[j];
      break;
    }
    j = (j+1) % MAX_UTHREADS;    
 a38:	2785                	addiw	a5,a5,1
 a3a:	41f7d71b          	sraiw	a4,a5,0x1f
 a3e:	01e7571b          	srliw	a4,a4,0x1e
 a42:	9fb9                	addw	a5,a5,a4
 a44:	8b8d                	andi	a5,a5,3
 a46:	9f99                	subw	a5,a5,a4
  for(i = 0; i < MAX_UTHREADS; i++){
 a48:	36fd                	addiw	a3,a3,-1
 a4a:	ce9d                	beqz	a3,a88 <find_next+0x98>
    if((uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING) && uthreads[j].priority == priority){
 a4c:	00779713          	slli	a4,a5,0x7
 a50:	973e                	add	a4,a4,a5
 a52:	0716                	slli	a4,a4,0x5
 a54:	972e                	add	a4,a4,a1
 a56:	9732                	add	a4,a4,a2
 a58:	fa072703          	lw	a4,-96(a4)
 a5c:	377d                	addiw	a4,a4,-1
 a5e:	fce86de3          	bltu	a6,a4,a38 <find_next+0x48>
 a62:	00779713          	slli	a4,a5,0x7
 a66:	973e                	add	a4,a4,a5
 a68:	0716                	slli	a4,a4,0x5
 a6a:	972e                	add	a4,a4,a1
 a6c:	9732                	add	a4,a4,a2
 a6e:	4f18                	lw	a4,24(a4)
 a70:	fca714e3          	bne	a4,a0,a38 <find_next+0x48>
      next = &uthreads[j];
 a74:	00779513          	slli	a0,a5,0x7
 a78:	953e                	add	a0,a0,a5
 a7a:	0516                	slli	a0,a0,0x5
 a7c:	00000797          	auipc	a5,0x0
 a80:	5b478793          	addi	a5,a5,1460 # 1030 <uthreads>
 a84:	953e                	add	a0,a0,a5
      break;
 a86:	a011                	j	a8a <find_next+0x9a>
  struct uthread* next = 0;
 a88:	4501                	li	a0,0
  }

  return next;
}
 a8a:	6422                	ld	s0,8(sp)
 a8c:	0141                	addi	sp,sp,16
 a8e:	8082                	ret

0000000000000a90 <schedule>:
void schedule(){
 a90:	1101                	addi	sp,sp,-32
 a92:	ec06                	sd	ra,24(sp)
 a94:	e822                	sd	s0,16(sp)
 a96:	e426                	sd	s1,8(sp)
 a98:	1000                	addi	s0,sp,32
  cur = currentThread;
 a9a:	00000497          	auipc	s1,0x0
 a9e:	5764b483          	ld	s1,1398(s1) # 1010 <currentThread>
  next = find_next(HIGH);
 aa2:	4509                	li	a0,2
 aa4:	00000097          	auipc	ra,0x0
 aa8:	f4c080e7          	jalr	-180(ra) # 9f0 <find_next>
  if(next == 0)
 aac:	c915                	beqz	a0,ae0 <schedule+0x50>
  currentThread = next;
 aae:	00000797          	auipc	a5,0x0
 ab2:	56a7b123          	sd	a0,1378(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 ab6:	6785                	lui	a5,0x1
 ab8:	00f50733          	add	a4,a0,a5
 abc:	4685                	li	a3,1
 abe:	fad72023          	sw	a3,-96(a4)
  uswtch(&cur->context, &next->context);
 ac2:	fa878793          	addi	a5,a5,-88 # fa8 <digits+0x2e8>
 ac6:	00f505b3          	add	a1,a0,a5
 aca:	00f48533          	add	a0,s1,a5
 ace:	00000097          	auipc	ra,0x0
 ad2:	de4080e7          	jalr	-540(ra) # 8b2 <uswtch>
}
 ad6:	60e2                	ld	ra,24(sp)
 ad8:	6442                	ld	s0,16(sp)
 ada:	64a2                	ld	s1,8(sp)
 adc:	6105                	addi	sp,sp,32
 ade:	8082                	ret
    next = find_next(MEDIUM);
 ae0:	4505                	li	a0,1
 ae2:	00000097          	auipc	ra,0x0
 ae6:	f0e080e7          	jalr	-242(ra) # 9f0 <find_next>
  if(next == 0)
 aea:	f171                	bnez	a0,aae <schedule+0x1e>
    next = find_next(LOW);
 aec:	00000097          	auipc	ra,0x0
 af0:	f04080e7          	jalr	-252(ra) # 9f0 <find_next>
  if(next == 0)
 af4:	fd4d                	bnez	a0,aae <schedule+0x1e>
    exit(-1);
 af6:	557d                	li	a0,-1
 af8:	00000097          	auipc	ra,0x0
 afc:	8a0080e7          	jalr	-1888(ra) # 398 <exit>

0000000000000b00 <uthread_yield>:
{
 b00:	1141                	addi	sp,sp,-16
 b02:	e406                	sd	ra,8(sp)
 b04:	e022                	sd	s0,0(sp)
 b06:	0800                	addi	s0,sp,16
  currentThread->state = RUNNABLE;
 b08:	00000797          	auipc	a5,0x0
 b0c:	5087b783          	ld	a5,1288(a5) # 1010 <currentThread>
 b10:	6705                	lui	a4,0x1
 b12:	97ba                	add	a5,a5,a4
 b14:	4709                	li	a4,2
 b16:	fae7a023          	sw	a4,-96(a5)
  schedule();
 b1a:	00000097          	auipc	ra,0x0
 b1e:	f76080e7          	jalr	-138(ra) # a90 <schedule>
}
 b22:	60a2                	ld	ra,8(sp)
 b24:	6402                	ld	s0,0(sp)
 b26:	0141                	addi	sp,sp,16
 b28:	8082                	ret

0000000000000b2a <uthread_exit>:

void uthread_exit()
{
 b2a:	1141                	addi	sp,sp,-16
 b2c:	e406                	sd	ra,8(sp)
 b2e:	e022                	sd	s0,0(sp)
 b30:	0800                	addi	s0,sp,16
  currentThread->state = FREE;
 b32:	00000797          	auipc	a5,0x0
 b36:	4de7b783          	ld	a5,1246(a5) # 1010 <currentThread>
 b3a:	6705                	lui	a4,0x1
 b3c:	97ba                	add	a5,a5,a4
 b3e:	fa07a023          	sw	zero,-96(a5)
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b42:	00001797          	auipc	a5,0x1
 b46:	48e78793          	addi	a5,a5,1166 # 1fd0 <uthreads+0xfa0>
 b4a:	00005597          	auipc	a1,0x5
 b4e:	50658593          	addi	a1,a1,1286 # 6050 <uthreads+0x5020>
  int remainingThreads = 0;
 b52:	4501                	li	a0,0
    if (uthreads[i].state == RUNNABLE) 
 b54:	4609                	li	a2,2
  for (int i = 0; i < MAX_UTHREADS; i++) {
 b56:	6685                	lui	a3,0x1
 b58:	02068693          	addi	a3,a3,32 # 1020 <base>
 b5c:	a021                	j	b64 <uthread_exit+0x3a>
 b5e:	97b6                	add	a5,a5,a3
 b60:	00b78763          	beq	a5,a1,b6e <uthread_exit+0x44>
    if (uthreads[i].state == RUNNABLE) 
 b64:	4398                	lw	a4,0(a5)
 b66:	fec71ce3          	bne	a4,a2,b5e <uthread_exit+0x34>
      remainingThreads++;
 b6a:	2505                	addiw	a0,a0,1
 b6c:	bfcd                	j	b5e <uthread_exit+0x34>
  }

  if (remainingThreads == 0){
 b6e:	c909                	beqz	a0,b80 <uthread_exit+0x56>
    exit(0);
  }
  else 
  {
    schedule();
 b70:	00000097          	auipc	ra,0x0
 b74:	f20080e7          	jalr	-224(ra) # a90 <schedule>
  }
}
 b78:	60a2                	ld	ra,8(sp)
 b7a:	6402                	ld	s0,0(sp)
 b7c:	0141                	addi	sp,sp,16
 b7e:	8082                	ret
    exit(0);
 b80:	00000097          	auipc	ra,0x0
 b84:	818080e7          	jalr	-2024(ra) # 398 <exit>

0000000000000b88 <uthread_set_priority>:

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
 b88:	1141                	addi	sp,sp,-16
 b8a:	e422                	sd	s0,8(sp)
 b8c:	0800                	addi	s0,sp,16
  enum sched_priority prevPriority = currentThread->priority;
 b8e:	00000797          	auipc	a5,0x0
 b92:	4827b783          	ld	a5,1154(a5) # 1010 <currentThread>
 b96:	6705                	lui	a4,0x1
 b98:	97ba                	add	a5,a5,a4
 b9a:	4f98                	lw	a4,24(a5)
  currentThread->priority = priority;
 b9c:	cf88                	sw	a0,24(a5)
  return prevPriority;
}
 b9e:	853a                	mv	a0,a4
 ba0:	6422                	ld	s0,8(sp)
 ba2:	0141                	addi	sp,sp,16
 ba4:	8082                	ret

0000000000000ba6 <uthread_get_priority>:

enum sched_priority uthread_get_priority()
{
 ba6:	1141                	addi	sp,sp,-16
 ba8:	e422                	sd	s0,8(sp)
 baa:	0800                	addi	s0,sp,16
    return currentThread->priority;
 bac:	00000797          	auipc	a5,0x0
 bb0:	4647b783          	ld	a5,1124(a5) # 1010 <currentThread>
 bb4:	6705                	lui	a4,0x1
 bb6:	97ba                	add	a5,a5,a4
}
 bb8:	4f88                	lw	a0,24(a5)
 bba:	6422                	ld	s0,8(sp)
 bbc:	0141                	addi	sp,sp,16
 bbe:	8082                	ret

0000000000000bc0 <uthread_start_all>:

int uthreadStarted = 0;

int uthread_start_all() {
 bc0:	7175                	addi	sp,sp,-144
 bc2:	e506                	sd	ra,136(sp)
 bc4:	e122                	sd	s0,128(sp)
 bc6:	fca6                	sd	s1,120(sp)
 bc8:	0900                	addi	s0,sp,144
  if (uthreadStarted) {
 bca:	00000497          	auipc	s1,0x0
 bce:	43e4a483          	lw	s1,1086(s1) # 1008 <uthreadStarted>
 bd2:	e4ad                	bnez	s1,c3c <uthread_start_all+0x7c>
    return -1;
  }
  uthreadStarted = 1;
 bd4:	4785                	li	a5,1
 bd6:	00000717          	auipc	a4,0x0
 bda:	42f72923          	sw	a5,1074(a4) # 1008 <uthreadStarted>

  struct context dummyContext;
  struct uthread *next; 

  next = find_next(HIGH);
 bde:	4509                	li	a0,2
 be0:	00000097          	auipc	ra,0x0
 be4:	e10080e7          	jalr	-496(ra) # 9f0 <find_next>
  if(next == 0)
 be8:	c915                	beqz	a0,c1c <uthread_start_all+0x5c>
  if(next == 0)
    next = find_next(LOW);
  if(next == 0)
    exit(-1);

  currentThread = next;
 bea:	00000797          	auipc	a5,0x0
 bee:	42a7b323          	sd	a0,1062(a5) # 1010 <currentThread>
  currentThread->state = RUNNING;
 bf2:	6585                	lui	a1,0x1
 bf4:	00b507b3          	add	a5,a0,a1
 bf8:	4705                	li	a4,1
 bfa:	fae7a023          	sw	a4,-96(a5)

  uswtch(&dummyContext, &currentThread->context);
 bfe:	fa858593          	addi	a1,a1,-88 # fa8 <digits+0x2e8>
 c02:	95aa                	add	a1,a1,a0
 c04:	f7040513          	addi	a0,s0,-144
 c08:	00000097          	auipc	ra,0x0
 c0c:	caa080e7          	jalr	-854(ra) # 8b2 <uswtch>

  return 0;
}
 c10:	8526                	mv	a0,s1
 c12:	60aa                	ld	ra,136(sp)
 c14:	640a                	ld	s0,128(sp)
 c16:	74e6                	ld	s1,120(sp)
 c18:	6149                	addi	sp,sp,144
 c1a:	8082                	ret
    next = find_next(MEDIUM);
 c1c:	4505                	li	a0,1
 c1e:	00000097          	auipc	ra,0x0
 c22:	dd2080e7          	jalr	-558(ra) # 9f0 <find_next>
  if(next == 0)
 c26:	f171                	bnez	a0,bea <uthread_start_all+0x2a>
    next = find_next(LOW);
 c28:	00000097          	auipc	ra,0x0
 c2c:	dc8080e7          	jalr	-568(ra) # 9f0 <find_next>
  if(next == 0)
 c30:	fd4d                	bnez	a0,bea <uthread_start_all+0x2a>
    exit(-1);
 c32:	557d                	li	a0,-1
 c34:	fffff097          	auipc	ra,0xfffff
 c38:	764080e7          	jalr	1892(ra) # 398 <exit>
    return -1;
 c3c:	54fd                	li	s1,-1
 c3e:	bfc9                	j	c10 <uthread_start_all+0x50>

0000000000000c40 <uthread_self>:


struct uthread *uthread_self()
{
 c40:	1141                	addi	sp,sp,-16
 c42:	e422                	sd	s0,8(sp)
 c44:	0800                	addi	s0,sp,16
    return currentThread;
 c46:	00000517          	auipc	a0,0x0
 c4a:	3ca53503          	ld	a0,970(a0) # 1010 <currentThread>
 c4e:	6422                	ld	s0,8(sp)
 c50:	0141                	addi	sp,sp,16
 c52:	8082                	ret
